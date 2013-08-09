USE [001]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER Proc [dbo].[BG_Wisys_InventoryTransactionReconciliation] (@date varchar(10), @loc varchar(3))
As
Begin
	
Begin Transaction

DECLARE @error VARCHAR(500)

--Exception handling
--------------------
--Verify date is a legit date format
IF (SELECT ISDATE(@date)) != 1
	BEGIN
	SET @error = 'ERROR:  ' + @date + ' is not a valid date format. Use XX/XX/XXXX format.'
		RAISERROR (@error, -- Message text.
           10, -- Severity,
           1) -- State
		Rollback Transaction
        Goto on_error
	END
	
--Verify trx exist for that date and location
IF NOT EXISTS(SELECT ord_no FROM dbo.iminvtrx_sql WHERE @date = doc_dt AND @loc = loc)
	BEGIN
	SET @error = 'ERROR:  Location ' + @loc + ' has no transactions to reconcile for date ' + @date + '. No action taken.'
		RAISERROR (@error, -- Message text.
           10, -- Severity,
           1) -- State
		Rollback Transaction
        Goto on_error
	END
	
--------------------------------------------
--Perform updates if validations are passed
---------------------------------------------	

--Update QOH by subtracting out qty's for issue transactions
BEGIN	
  --TODO: Insert into a log table
UPDATE dbo.iminvloc_sql
SET qty_on_hand = (qty_on_hand - qty)
FROM dbo.iminvloc_sql IM JOIN 
		(SELECT loc, item_no, SUM(CAST(quantity AS int)) AS [qty]
		FROM  dbo.iminvtrx_sql
		WHERE (doc_dt = @date) AND (doc_type IN ( 'I')) AND loc = @loc
				--Test
				--AND item_no = 'TEST ITEM'
		GROUP BY loc, item_no) AS TRX ON TRX.item_no = IM.item_no AND TRX.loc = IM.loc
END

--Update QOH by adding in qty's for receipt transactions	
BEGIN	
  --TODO: Insert into a log table
UPDATE dbo.iminvloc_sql
SET qty_on_hand = (qty_on_hand + qty)
FROM dbo.iminvloc_sql IM JOIN 
		(SELECT loc, item_no, SUM(CAST(quantity AS int)) AS [qty]
		FROM  dbo.iminvtrx_sql
		WHERE (doc_dt = @date) AND (doc_type IN ( 'R')) AND loc = @loc
				--Test
				--AND item_no = 'TEST ITEM'
		GROUP BY loc, item_no) AS TRX ON TRX.item_no = IM.item_no AND TRX.loc = IM.loc
END

If @@error <> 0 Begin
  Rollback Transaction
  Goto on_error
End

End

COMMIT Transaction

on_error:
	PRINT @@ERROR
	RETURN @@ERROR
GO


