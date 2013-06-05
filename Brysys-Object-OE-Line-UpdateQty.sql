ALTER Proc [dbo].[BG_Brysys_OE_Line_UpdateQty] (@OrdType AS CHAR(1) = 'O', @LineNo smallint, @OrdNo VARCHAR(8),  @QtyOrdered DECIMAL(8,2) = null, @QtyToShip DECIMAL(8,2), @UserName AS VARCHAR(30), @Comment1 AS VARCHAR(30), @Comment2 AS VARCHAR(30) = 'OE-LineUpdate') AS

--Created:	4/29/13		 By:	BG
--Last Updated:	5/6/13	 By:	BG
--Purpose:	For use with Wisys and Brysys.  Update qty_ordered and qty_to_ship on the line item of a sales order. Affects the following tables:  1) Update 'A' entry in iminvtrx_Sql  2) Update line in imordbld_sql  3) Update oeordlin_sql 4) Update oeordhdr_sql order totals
--Last changes: --

-------------------------------------------------------------------------------------------------------
--NOTES: 
--If no @QtyOrdered is given (is null), then assume that qty ordered stays the same and is not changed

--Currently only works for zero dollar orders (stock orders), does not update oeordhdr totals

--TODO: Add support for updating order totals on oeordhdr.  Add support for I's and C's
-------------------------------------------------------------------------------------------------------

Begin Try
-----------------------------
--Declare object variables
-----------------------------

DECLARE @error VARCHAR(500)
DECLARE @Item AS VARCHAR(30)
DECLARE @loc AS VARCHAR(3)
DECLARE @OldQty AS DECIMAL(8,2)

----------------------
--Exception handling
----------------------
--Verify order exists
IF NOT EXISTS(SELECT ord_no FROM dbo.oeordhdr_sql WITH (NOLOCK) WHERE ord_no = @OrdNo)
	BEGIN
	SET @error = 'Validation Error: Order #' + @OrdNo + ' does not exist.  No action taken.'
		RAISERROR (
		   @error, -- Message text.
           10, -- Severity,
           1) -- State
           GOTO write_log
	END
	
--Verify line on order exists
IF NOT EXISTS(SELECT ord_no FROM dbo.oeordlin_sql WITH (NOLOCK) WHERE LTRIM(line_no) = LTRIM(@LineNo) AND ord_no = @OrdNo)
	BEGIN
	SET @error = 'Validation Error: Line #' + CAST(@LineNo AS VARCHAR) + ' does not exist on order ' + @OrdNo + '.  No action taken.'
		RAISERROR (
		   @error, -- Message text.
           10, -- Severity,
           1) -- State
           GOTO write_log
	END

-----------------------
--Set Object variables
-----------------------
SELECT @Item = item_no,  @OldQty=qty_ordered, @loc = loc
FROM dbo.oeordlin_sql WITH (NOLOCK)
WHERE LTRIM(line_no) = LTRIM(@LineNo) AND ord_no = @OrdNo

--If no QtyOrdered is given, then assume that qty ordered stays the same and is not changed
IF(@QtyOrdered IS NULL)
	SET @QtyOrdered = @OldQty

-------------------
--IMINVTRX Update
-------------------

--Declare all necessary variables
DECLARE @SOURCE CHAR(1), @CTL_NO CHAR(8), @LINE_NO SMALLINT, @LEV_NO smallint, @SEQ_NO smallint

--Assign static insert variables 
SELECT @source = 'O', @ctl_no = '        ', @line_no = @LineNo, @lev_no = 1, @SEQ_NO = 0

--NOTE: Update "A" entry associated with that line (lev_no = 1)
UPDATE [IMINVTRX_SQL] 
SET quantity = @QtyToShip, amt = (quantity * (SELECT unit_cost FROM dbo.iminvtrx_sql WHERE [source] = @source AND ord_no = @OrdNo AND ctl_no = @CTL_NO AND line_no = @line_no AND lev_no = @lev_no AND seq_no = @seq_no))
WHERE [source] = @source AND ord_no = @OrdNo AND ctl_no = @CTL_NO AND line_no = @line_no AND lev_no = @lev_no

--------------------------------------
--IMORDBLD Update --------------------
--------------------------------------
UPDATE IMORDBLD_SQL
SET qty=@QtyOrdered,qty_to_ship=@QtyToShip
WHERE (ORD_TYPE = @OrdType AND ord_no = @OrdNo AND ctl_no = @CTL_NO AND line_no = @line_no)

--------------------------------------
--OEORDLIN Update --------------------
--------------------------------------

UPDATE OEORDLIN_SQL
SET qty_ordered = @QtyOrdered, qty_to_ship = @QtyToShip, qty_allocated = @QtyToShip, tot_qty_ordered=@QtyOrdered
WHERE ORD_TYPE = @OrdType AND ORD_NO = @OrdNo  AND LINE_NO = @LineNo

--------------------------------------
--IMINVLOC Update --------------------
--------------------------------------

UPDATE dbo.iminvloc_sql 
SET qty_allocated = qty_allocated + (@QtyToShip - @OldQty)
WHERE loc = @loc AND item_no = @Item

--------------------------------------------------------------------
--OEORDHDR Update -------------------------------------------------- 
--------------------------------------------------------------------

--TODO:
/*
UPDATE OEORDHDR_SQL
SET accum_tot_sls_amt = 
WHERE ORD_TYPE = @source AND ORD_NO = @OrdNo
*/

--------------------------------------------------------------------
--OEPDSHDR Update
--------------------------------------------------------------------
--TODO:
/*
UPDATE OEPDSHDR_SQL
SET 
WHERE ORD_TYPE = @source AND ORD_NO = @OrdNo
*/

--------------------------------------------------------------------
--OEINQORD Update
--------------------------------------------------------------------
--TODO:
/*
DELETE FROM OEINQORD_SQL
WHERE ORD_TYPE = @source AND ORD_NO = @OrdNo
*/


GOTO write_log

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
INSERT INTO [JobOutputLogs].dbo.[Brysys_Log_001_OE_ChangedLines]
(ord_no, line_no, item_no, new_qty, old_qty, user_name, comment1, comment2,trx_dt, error)
VALUES (@OrdNo,@LineNo,@Item,@QtyToShip,@OldQty,@UserName,@Comment1,@Comment2,GETDATE(),@ERROR)
;
GO






