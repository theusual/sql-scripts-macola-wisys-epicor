ALTER Proc [dbo].[BG_Brysys_POP_CloseStockOrderItem] (@LineNo smallint, @OrdNo varchar(8),
@ParentQty AS DECIMAL(8,2), @UserName AS VARCHAR(30), @Comment1 AS VARCHAR(30) = NULL, @CloseDt AS DATETIME = NULL, @RESULT AS VARCHAR(MAX) OUTPUT) AS

--Created:	4/23/13	 By:	BG
--Last Updated:	5/3/13	 By:	BG
--Purpose:	For use with Wisys and Brysys.  Close a stock order item using the following steps: 1)Issue components of the stock order item, if any.   2) Receive in the given quantity of the stock order item.   3) Delete the line item from the stock order.  4) If no more lines on stock order, delete the stock order header as well.  5) Log any deletions with enough detail to undo any deletions
--Last changes: --

-------------------------------------------------------------------------------------------------------
--NOTES: 
--1)Use comment1 for sending which program evoked the object.  i.e.-"WISYS AGILITY-APPNAME", "WISYS GUN-APPNAME", "BRYSYS INTRANET WEBSITE-APPNAME"  
--2)Close date is optional, if not given then defaults to current date/time
--3)Qty_to_ship is updated but qty_ordered is left alone.  The qty_ordered is used to reflect the original stock order qty.                                                                                                                                            
--------------------------------------------------------------------------------------------------------
Begin Try

DECLARE @error VARCHAR(500)

-----------------------------
--Object variables
-----------------------------
DECLARE @ParentItem AS VARCHAR(30)
DECLARE @ConvertedParentItem AS VARCHAR(30)
DECLARE @Comment2 AS VARCHAR(30)
DECLARE @LineQty AS DECIMAL(8,2)
DECLARE @NewQty AS DECIMAL(8,2)
DECLARE @InvLoc varchar(3)
DECLARE @Action VARCHAR(MAX)

-----------------------------------------
--Preliminary validation
-----------------------------------------
--Verify order and line exist
IF NOT EXISTS(SELECT ord_no FROM dbo.oeordlin_sql WITH (NOLOCK) WHERE LTRIM(line_no) = LTRIM(@LineNo) AND ord_no = @OrdNo)
	BEGIN
	SET @error = 'ERROR: Line #' + CAST(@LineNo AS VARCHAR) + ' does not exist on order ' + @OrdNo + '.  No action taken.'
		RAISERROR (@error, -- Message text.
           10, -- Severity,
           1) -- State
           GOTO write_log
	END
	
--Verify parent qty given is a positive number
IF @ParentQty <= 0
	BEGIN
	SET @error = 'ERROR: Negative quantities not accepted.  To add quantity to an order, use Macola to edit the order line.'
		RAISERROR (@error, -- Message text.
           10, -- Severity,
           1) -- State
           GOTO write_log
	END
	
------------------------------------------
--Set Object Variables	
------------------------------------------
SELECT @LineQty = qty_to_ship, @InvLoc = loc, @ParentItem = item_no FROM dbo.oeordlin_sql WHERE line_no = @LineNo AND ord_no = @OrdNo
SET @NewQty = (@LineQty - @ParentQty)
SET @Comment2 = ('From stock order #'+@OrdNo)

--If no build date given, then default to today's date
IF (@CloseDt IS NULL)
	SET @CloseDt = GETDATE()

--Convert to non dot item if item is a dot item
IF @ParentItem LIKE ('%.')
	SET @ConvertedParentItem = REPLACE(@ParentItem, '.','')
ELSE
	SET @ConvertedParentItem = @ParentItem


PRINT 'OBJECT VARIABLES SET ' + @Comment2
PRINT '...'

--------------------
--Exception handling
--------------------
--Verify dot item exists
IF NOT EXISTS(SELECT item_no FROM dbo.imitmidx_sql WITH (NOLOCK)WHERE REPLACE(@ParentItem, '.','') = item_no)
	BEGIN
	SET @error = 'ERROR: Dot item "' + @ParentItem + '" has no non-dot equivalent.  Please check that the dot item has a non-dot equivalent with an identical name.  No action taken.'
		RAISERROR (@error, -- Message text.
           10, -- Severity,
           1) -- State
           GOTO write_log
	END

--Verify item (including non dot converted item) exists at transaction location to be used for receipt
IF NOT EXISTS(SELECT item_no FROM dbo.iminvloc_sql WITH (NOLOCK) WHERE LTRIM(item_no) = LTRIM(@ConvertedParentItem) AND loc = @InvLoc)
	BEGIN
	SET @error = 'ERROR: Item ' + @ConvertedParentItem + ' does not exist at location ' + @InvLoc + '.  Please setup the item at the required location using the IM/Location screen in Macola.  No action taken.'
		RAISERROR (@error, -- Message text.
           10, -- Severity,
           1) -- State
           GOTO write_log
	END
	
--Verify build quantity matches the order 
IF @ParentQty > @LineQty
	BEGIN
	SET @error = 'ERROR: Build quantity given is greater than quantity on order.  There is only a quantity of ' + CAST(@LineQty AS VARCHAR) + ' on order #'+@OrdNo+' for line #' + CAST(@LineNo AS VARCHAR) +'.  No action taken.'
		RAISERROR (@error, -- Message text.
           10, -- Severity,
           1) -- State
           GOTO write_log
	END

PRINT 'VALIDATIONS PASSED: @ParentItem = ' + @ParentItem + ', @InvLoc = ' + @InvLoc + ', @OrdNo = ' + @OrdNo + ', @ParentQty = ' + CAST(@ParentQty AS VARCHAR)+ ', @UserName = ' + @UserName + ', @comment1 = ' + @Comment1
PRINT '...'
------------------------------------------
--Issue components of line item (if exist)
------------------------------------------
IF ((SELECT COUNT(*) FROM dbo.bmprdstr_sql WHERE item_no = @ParentItem) > 0)
	BEGIN
		--Send the true parent item (not converted) because the BOM structure of the dot item is needed 
		EXEC [dbo].[BG_Brysys_InvTrx_IssueBOM] @ParentItem = @ParentItem, @InvLoc = @InvLoc, @OrdNo = @OrdNo, @ParentQty = @ParentQty, @UserName = @UserName, @comment1 = @Comment1, @comment2 = @Comment2
	PRINT 'BOM ISSUED'
	PRINT '...'	
	END	
ELSE
	PRINT 'NO BOM FOR PARENT ITEM ' + RTRIM(@ParentItem) + '.  SKIPPING ISSUE STEP'
	PRINT '...'	


------------------------------------------------
--Receive in line item (converted)
------------------------------------------------

EXEC [dbo].[BG_Brysys_InvTrx_Receipt] @ParentItem = @ConvertedParentItem, @InvLoc = @InvLoc, @ParentQty = @ParentQty, @UserName = @UserName, @comment1 = @Comment1, @comment2 = @Comment2

PRINT 'LINE ITEM RECEIVED: ' + @ConvertedParentItem
PRINT '...'

--------------------------------------------------------------------------------------------------------------------------------------
--Delete line item from stock order IF ParentyQty >= Qty on order, else subtract the ParentQty from the line item qty and update the qty to ship 
--Leaves qty ordered alone
--------------------------------------------------------------------------------------------------------------------------------------
IF (@ParentQty < @LineQty)
	BEGIN
		EXEC [dbo].[BG_Brysys_OE_Line_UpdateQty] @LineNo = @LineNo, @OrdNo = @OrdNo, @QtyToShip = @NewQty, @UserName = @UserName, @comment1 = @comment1, @comment2 = @Comment2
		SET @Action = 'LINE UPDATED'
		PRINT 'LINE UPDATED'
		PRINT '...'
	END
IF (@ParentQty >= @LineQty)
	BEGIN
		EXEC [dbo].[BG_Brysys_OE_Line_Delete] @LineNo = @LineNo, @OrdNo = @OrdNo, @UserName = @UserName, @comment1 = @comment1, @comment2 = @Comment2
		SET @Action = 'LINE DELETED'
		PRINT 'LINE DELETED'
		PRINT '...'
	END
--NOTE: IF last line deleted then stock order header is deleted automatically by the delete line item object
IF ((SELECT COUNT(*) FROM dbo.oeordlin_sql WHERE ord_no = @OrdNo) = 0)
	BEGIN
		SET @Action = @Action + ', ORDER DELETED'
		PRINT 'ORDER DELETED'
		PRINT '...'
	END

--If no errors then go to write log and end object
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
INSERT INTO [JobOutputLogs].dbo.[Brysys_Log_001_POP_ClosedStockOrders]
(ord_no, line_no, item_no, loc, build_qty, user_name, comment1, comment2, close_dt, trx_dt, [action], error)
VALUES (@OrdNo,@LineNo,@ParentItem,@InvLoc,@ParentQty,@UserName,@Comment1, @Comment2,@CloseDt, GETDATE(),@Action,@ERROR)
	PRINT 'LOG WRITTEN'
	PRINT '...'
	
---------------------------------------
--Set output paramenters
---------------------------------------
IF (@ERROR IS NULL)
	SET @RESULT = 'ITEM(S) SUCCESSFULLY CLOSED ON ORDER #' + @OrdNo
ELSE
	SET @RESULT = @ERROR
	
PRINT 'OBJECT COMPLETE'



