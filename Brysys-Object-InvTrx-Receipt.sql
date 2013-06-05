ALTER Proc [dbo].[BG_Brysys_InvTrx_Receipt] (@ParentItem varchar(30), @InvLoc varchar(3), @ParentQty AS DECIMAL(8,2), @UserName AS VARCHAR(30), @Comment1 AS VARCHAR(30) = null, @Comment2 AS VARCHAR(30) = NULL, @OrdNo char(8) = null) AS

--Created:	4/22/13	 By:	BG
--Last Updated:	5/15/13	 By:	BG
--Purpose:	For use with Wisys and Brysys.  Receive an item using inventory transactions.
--Last changes: Changed input parameter order to put optional paramters at end

-------------------------------------------------------------------------------------------------------
--NOTES: 
--Macola and Wisys use Maclocks table for a higher level lock on the resource to prevent dirty writes (2 users actively processing transactions on same item at same time).  To use that table, first check it for presence of a matching server/DB/table/RowID and if it exists then give the user an error.  If does not exist, then write that data into the Maclocks table to create a lock.  Delete the data when done to release the lock.
--Example:    INSERT INTO MACLOCKS(SessionID, ServerName, DBName, TableName, RowID)VALUES(@SessionID, @ServerName, @DBName, @TableName, @RowID)',N'@SessionID int,@ServerName char(50),@DBName char(50),@TableName char(50),@RowID char(255)',@SessionID=122,@ServerName='hqsql                                             ',@DBName='001                                               ',@TableName='IMITMIDX_SQL                                      ',@RowID='BOM TEST 2                                                                                                                                                                                                                                                     '
--------------------------------------------------------------------------------------------------------

BEGIN TRY

DECLARE @error VARCHAR(500)

--------------------
--Exception handling
--------------------
--Verify item exists at transaction location given
IF NOT EXISTS(SELECT item_no FROM dbo.iminvloc_sql WITH (NOLOCK) WHERE LTRIM(item_no) = LTRIM(@ParentItem) AND loc = @InvLoc)
	BEGIN
	SET @error = 'ERROR: Item "' + @ParentItem + '" does not exist at location "' + @InvLoc + '".  Please setup the item at the required location using the IM/Location screen in Macola.  No action taken.'
		RAISERROR (@error, -- Message text.
           10, -- Severity,
           1) -- State
        Goto write_log        
	END

-------------------
--IMINVTRX Insert
-------------------

--Declare all necessary variables for insert to IMINVTRX
DECLARE @source char(1),@ord_no CHAR(8), @line_no smallint,@lev_no smallint,@seq_no smallint,@from_source char(1),@from_ord_no char(8),@from_line_no smallint,@from_lev_no smallint,@from_seq_no smallint,@loc VARCHAR(3),@doc_type char(1),@doc_ord_no char(8),@doc_source char(1),@prod_type char(1),@quantity decimal(1,0),@old_quantity decimal(1,0),@unit_cost decimal(1,0),@old_unit_cost decimal(1,0),@new_unit_cost decimal(1,0),@price decimal(1,0),@build_qty decimal(1,0),@build_qty_per decimal(1,0),@amt decimal(1,0),@landed_cost decimal(1,0),@ctl_no char(8),@from_ctl_no char(8),@item_no char(30),@par_item_no char(30),@trx_dt datetime,@trx_tm datetime,@doc_dt datetime,@cus_no char(20),@vend_no char(20),@receipt_ord_no char(50),@jnl char(10),@user_name char(20),@promise_dt datetime,@comment_2 char(30),@transfer_code char(3),@issue_type char(1),@status char(2),@batch_id char(10),@id_no char(50),@comment char(30),@filler_0003 char(30),@trx_qty_bkord decimal(1,0),@rev_no char(8),@deall_amt decimal(1,0),@filler_0004 char(149)

--Assign static insert variables for IMINVTRX
SELECT 
	@source='I', @line_no=0,@lev_no=0,@seq_no=0,@from_source=NULL,
	@from_ord_no=@OrdNo,@from_line_no=0,
	@from_lev_no=0,	@from_seq_no=0,@loc=@InvLoc,@doc_type='R',
	@doc_ord_no=NULL,@doc_source=NULL,@prod_type=NULL,
	@price=0,
	@build_qty_per=0,	
	@ctl_no='        ',@from_ctl_no='        ',	
	@par_item_no=null, @trx_dt=CONVERT(DATE,GETDATE()),@trx_tm=CONVERT(TIME,GETDATE()),
	@doc_dt=CONVERT(DATE,GETDATE()), @cus_no=NULL,
	@vend_no=NULL,@receipt_ord_no=NULL,@jnl='          ',@user_name = @UserName,
	@promise_dt=CONVERT(DATE,GETDATE()),
	@item_no = @ParentItem,
	@transfer_code=NULL,@issue_type=NULL,@status=NULL,
	@batch_id='          ',
	@comment=@Comment1,	@comment_2=@Comment2, @filler_0003=NULL,@trx_qty_bkord=0,@rev_no=NULL,
	@deall_amt=0,@filler_0004=NULL
	
--Pull last used IM control number for use in inserting the ord_no variable
SET @ord_no = (select next_doc_no from IMCTLFIL_SQL where im_ctl_key_1 = 1)

--Update IM control file with the next document number
UPDATE dbo.imctlfil_sql
SET  next_doc_no = (@ord_no + 1)
--OUTPUT DELETED.next_doc_no AS OldDockNo, INSERTED.next_doc_no AS NewDocNo
where im_ctl_key_1 = 1
      
--Write the transaction to the iminvtrx table using assigned variables
INSERT INTO [iminvtrx_sql]
([source], [ord_no], [ctl_no], [line_no], [lev_no], [seq_no], [from_source], [from_ord_no], [from_ctl_no], [from_line_no], [from_lev_no], [from_seq_no], [item_no], [par_item_no], [loc], [trx_dt], [trx_tm], [doc_dt], [doc_type], [doc_ord_no], [doc_source], [cus_no], [vend_no], [prod_type], [quantity], [old_quantity], [unit_cost], [old_unit_cost], [new_unit_cost], [price], [build_qty], [build_qty_per], [amt], [landed_cost], [receipt_ord_no], [status], [jnl], [batch_id], [user_name], [id_no], [comment], [filler_0003], [trx_qty_bkord], [promise_dt], [rev_no], [deall_amt], [extra_7], [extra_9], [extra_10], [extra_11], [extra_12], [extra_13], [extra_14], [extra_15], [Comment_2], [Transfer_code], [issue_type], [filler_0004])
SELECT @source, ' '+CAST(@ord_no AS VARCHAR), @ctl_no, @line_no, @lev_no, @seq_no, @from_source, @from_ord_no, 
	  @from_ctl_no, @from_line_no, @from_lev_no, @from_seq_no, @item_no, @par_item_no, @loc, 
	  @trx_dt, @trx_tm, @doc_dt, @doc_type, @doc_ord_no, @doc_source, @cus_no, @vend_no, 
	  @prod_type, @ParentQty, qty_on_hand, avg_cost, avg_cost, avg_cost, 
	  @price, @ParentQty, @build_qty_per, avg_cost * @ParentQty, @landed_cost, @receipt_ord_no, @status, 
	  @jnl, @batch_id, @user_name, 'I '+ CAST(@ord_no AS VARCHAR) +'        00000000000                      ', 
	  @comment, @filler_0003, @trx_qty_bkord, @promise_dt, 
	  @rev_no, @deall_amt, 'BRYSYS', 'IM-RECEIPT', 0,0,0,0,0,0, @Comment2, @Transfer_code, @issue_type, @filler_0004
FROM dbo.iminvloc_sql WITH (NOLOCK)
WHERE item_no = @item_no AND loc = @loc


--------------------------------------
--IMINVLOC Update --------------------
--------------------------------------

--Declare all necessary variables for update to IMINVLOC
--...none

--Update the iminvloc table with the updated accumulators
Update IMINVLOC_SQL 
SET Qty_on_hand = qty_on_hand +  @ParentQty,
	last_cost = avg_cost
WHERE LTRIM(item_no) = LTRIM(@ParentItem) and loc = @loc

END TRY

----------------------------------------------------
--Handle Errors
----------------------------------------------------
BEGIN CATCH
	--Print error
	SELECT
         ERROR_NUMBER() AS ErrorNumber
        ,ERROR_SEVERITY() AS ErrorSeverity
        ,ERROR_STATE() AS ErrorState
        ,ERROR_PROCEDURE() AS ErrorProcedure
        ,ERROR_LINE() AS ErrorLine
        ,ERROR_MESSAGE() AS ErrorMessage;  
        
	--write error to object log
	SET @error = 'SQL Error #'+CAST(ERROR_NUMBER() AS VARCHAR)+' occurred in procedure '+ERROR_PROCEDURE() + ' on line '+CAST(ERROR_LINE() AS VARCHAR) + '.  Message: '+ERROR_MESSAGE();	
	GOTO write_log
END CATCH

--------------------------------------
--Write to object log ----------------
--------------------------------------
write_log:

--NO log used for this object because all receipt transactions are logged in the iminvtrx table.  Any reports requiring a log of receipts performed using this object can simply join on the iminvtrx table and use extra_7 = 'BRYSYS' and extra_9 = 'IM-RECEIPT'





