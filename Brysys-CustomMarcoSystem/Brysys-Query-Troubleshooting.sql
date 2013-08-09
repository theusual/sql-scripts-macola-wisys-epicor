-------------------------------------------------------
--For general troubleshooting of Brysys apps/objects
-------------------------------------------------------

SELECT line_no, * FROM dbo.oeordlin_sql WHERE ord_no = '  741274'
SELECT * FROM dbo.iminvloc_sql WHERE item_no LIKE 'WMCHL-014 SBKB%'

------------------------------------
--Logs
------------------------------------
SELECT * FROM [JobOutputLogs].dbo.[Brysys_Log_001_POP_ClosedStockOrders] WHERE trx_dt > '06/17/2013'
SELECT * FROM [JobOutputLogs].dbo.[Brysys_Log_001_OE_DeletedLines] WHERE trx_dt > '06/17/2013'
SELECT * FROM [JobOutputLogs].dbo.[Brysys_Log_001_OE_ChangedLines] WHERE trx_dt > '06/17/2013'
SELECT * FROM [JobOutputLogs].dbo.[Auto_Transfer_In_GD] WHERE trx_dt > '06/17/2013'

------------------------------------
--SP's
------------------------------------
DECLARE @RESULT AS VARCHAR(MAX)

--SP for closing stock orders:
--Parameters: @LineNo smallint, @OrdNo  varchar(8), @ParentQty decimal, @UserName varchar(30), @Comment1 varchar(30), @CloseDt datetime, @RESULT VARCHAR
EXEC dbo.BG_Brysys_POP_CloseStockOrderItem @LineNo = 1, @OrdNo = '741274', @ParentQty = 1, @UserName = 'BGREGORY', @Comment1 = 'CLOSING THROUGH SP', @CloseDt = '2013-06-12', @RESULT = NULL

    

