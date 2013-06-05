--  USE ROLLBACK TRAN IF UPDATE IS BAD, USE COMMIT TRAN IF GOOD:
/*  BEGIN TRAN -- ROLLBACK TRAN -- COMMIT TRAN */  

/*  DESIGN THE SELECT STATEMENT BELOW FIRST, THEN RUN UPDATE STARTING WITH "BEGIN TRAN"*/
SELECT qty_on_hand = (qty_on_hand + temp.QTY)
--BEGIN TRAN; UPDATE iminvloc_sql SET qty_on_hand = (qty_on_hand + temp.QTY)
FROM (SELECT quantity AS QTY, IM.item_no
		FROM [020].dbo.iminvtrx_sql TRX
			JOIN [001].dbo.IMITMIDX_SQL IM ON IM.item_no = TRX.item_no
		WHERE IM.item_note_3 = 'KPB' AND IM.item_note_1 = 'CH' 
			  AND doc_type IN ('R','Q')
			  AND TRX.trx_dt = CONVERT(varchar,GETDATE(),101)
		GROUP BY IM.item_no, quantity) AS Temp
	 JOIN iminvloc_Sql IM ON IM.item_no = Temp.item_no AND IM.loc = 'GD'

SELECT 'Tran Info' as _X_, @@rowcount as Rows, @@trancount as TrnCnt, @@Identity as Id3ntity


/*AFTER UPDATE TRANSACTION STARTED, CHECK DATA BEFORE COMMIT, IF GOOD THEN RUN COMMIT IF BAD THEN RUN ROLLBACK*/
SELECT qty_on_hand FROM iminvloc_Sql WHERE item_no = 'HARDW-4044'