ALTER Proc [dbo].[BG_Brysys_OE_Line_Delete] (@LineNo smallint, @OrdNo char(8), @UserName AS VARCHAR(30), @Comment1 AS VARCHAR(30), @OrdType AS CHAR(1) = 'O',  @Comment2 AS VARCHAR(30) = 'OE-LineDelete') AS

--Created:	4/25/13	 By:	BG
--Last Updated:	5/3/13	 By:	BG
--Purpose:	For use with Wisys and Brysys.  Delete an item from a sales order. Affects the following tables:  1) Delete from iminvtrx_Sql  2) Delete from imordbld_sql  3) Delete from oeordlin_sql
--Last changes: --

-------------------------------------------------------------------------------------------------------
--NOTES: 
--While this object is called the delete line item object, it also functions as the delete order header object.  That is because this object deletes the order header if no order lines are left on order.

--TODO: Add support for deleting lines from I-only's Or Credits
--------------------------------------------------------------------------------------------------------


BEGIN TRY

-----------------------------
--Object variables
-----------------------------

DECLARE @error VARCHAR(500)
DECLARE @Item AS VARCHAR(30)

SET @Item = (SELECT item_no FROM dbo.oeordlin_sql WITH (NOLOCK) WHERE LTRIM(line_no) = LTRIM(@LineNo) AND ord_no = @OrdNo)

--------------------
--Exception handling
--------------------
--Verify order and line exist
IF NOT EXISTS(SELECT ord_no FROM dbo.oeordlin_sql WITH (NOLOCK) WHERE LTRIM(line_no) = LTRIM(@LineNo) AND ord_no = @OrdNo)
	BEGIN
	SET @error = 'ERROR: Line #' + CAST(@LineNo AS VARCHAR) + ' does not exist on order ' + @OrdNo + '.  No action taken.'
		RAISERROR (@error, -- Message text.
           10, -- Severity,
           1) -- State
        Goto write_log
	END

-------------------
--IMINVTRX Delete
-------------------

--Declare all necessary variables
DECLARE @SOURCE CHAR(1), @CTL_NO CHAR(8), @LINE_NO SMALLINT, @LEV_NO smallint, @SEQ_NO smallint

--Assign static insert variables 
SELECT @source = 'O', @ctl_no = '        ', @line_no = @LineNo, @lev_no = 1

--Write the transaction to the table using assigned variables
--NOTE: Delete all "A" entries associated with that line (all seq_no's and all lev_no = 1)
DELETE FROM IMINVTRX_SQL
WHERE [source] = @source AND ord_no = @OrdNo AND ctl_no = @CTL_NO AND line_no = @line_no AND lev_no = @lev_no

--------------------------------------
--IMORDBLD Delete --------------------
--------------------------------------
DELETE FROM IMORDBLD_SQL 
WHERE (ORD_TYPE = @OrdType AND ord_no = @OrdNo AND ctl_no = @CTL_NO AND line_no = @line_no)

--------------------------------------
--OEORDLIN Delete --------------------
--------------------------------------
DELETE FROM OEORDLIN_SQL 
WHERE ORD_TYPE = @OrdType AND ORD_NO = @OrdNo  AND LINE_NO = @LineNo

------------------------------------------------------------------------------------------------------------------
--Check if order is empty, if no then object trx is complete.  If yes, then proceed to delete order header.
------------------------------------------------------------------------------------------------------------------
DECLARE @LineCount AS SMALLINT

SET @LineCount = (SELECT COUNT(line_no) FROM dbo.oeordlin_sql WITH (NOLOCK) WHERE ord_no = @OrdNo AND ord_type = @OrdType)

IF(@LineCount > 0)
	BEGIN
		PRINT 'SKIPPING ORDER HEADER DELETION'
		GOTO write_log
	END
PRINT 'PROCEEDING WITH ORDER HEADER DELETION'
SET @Comment2 = @Comment2 + ', ORD HDR DELETED'
--------------------------------------------------------------------
--OEORDHDR Delete IF no lines left on order 
--------------------------------------------------------------------
DELETE FROM OEORDHDR_SQL
WHERE ORD_TYPE = @source AND ORD_NO = @OrdNo

--------------------------------------------------------------------
--OEPDSHDR Delete IF no lines left on order 
--------------------------------------------------------------------
DELETE FROM OEPDSHDR_SQL
WHERE ORD_TYPE = @source AND ORD_NO = @OrdNo

--------------------------------------------------------------------
--OEINQORD Delete IF no lines left on order 
--------------------------------------------------------------------
DELETE FROM OEINQORD_SQL
WHERE ORD_TYPE = @source AND ORD_NO = @OrdNo

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

INSERT INTO [JobOutputLogs].dbo.[Brysys_Log_001_OE_DeletedLines]
(ord_no, line_no, item_no, user_name, comment1, comment2,trx_dt,error)
VALUES (@OrdNo,@LineNo,@Item,@UserName,@Comment1,@Comment2,GETDATE(),@ERROR)
