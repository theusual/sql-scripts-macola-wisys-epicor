BEGIN TRAN; 

UPDATE [001].dbo.iminvloc_sql SET qty_on_hand = (qty_on_hand + temp.QTY)
FROM (SELECT quantity AS QTY, IM.item_no
		FROM [020].dbo.iminvtrx_sql TRX
			JOIN [001].dbo.IMITMIDX_SQL IM ON IM.item_no = TRX.item_no
		WHERE IM.item_note_3 = 'KPB' AND IM.item_note_1 = 'CH' 
			  AND doc_type IN ('R','Q')
			  AND TRX.trx_dt = CONVERT(varchar,GETDATE(),101)
			  AND (LTRIM(vend_no) NOT IN ('181','2666') OR vend_no IS NULL)
		GROUP BY IM.item_no, quantity) AS Temp
	 JOIN [001].dbo.iminvloc_Sql IM ON IM.item_no = Temp.item_no AND IM.loc = 'GD'
GO
--Job Output Log
INSERT INTO [JobOutputLogs].dbo.[Auto_Apply_Inf_KPB_CH_Item_Trx_To_Marco_QOH]
SELECT IM.item_no, QTY, CONVERT(varchar,GETDATE(),101) AS TODAY, doc_type, (IM.qty_on_hand - QTY), (IM.qty_on_hand + QTY) AS new_qoh
FROM (SELECT quantity AS QTY, IM.item_no, doc_type
		FROM [020].dbo.iminvtrx_sql TRX
			JOIN [001].dbo.IMITMIDX_SQL IM ON IM.item_no = TRX.item_no
		WHERE IM.item_note_3 = 'KPB' AND IM.item_note_1 = 'CH' 
			  AND doc_type IN ('R','Q')
			  AND TRX.trx_dt = CONVERT(varchar,GETDATE(),101)
			  AND (LTRIM(vend_no) NOT IN ('181','2666') OR vend_no IS NULL)
		GROUP BY IM.item_no, quantity, doc_type) AS Temp
	 JOIN [001].dbo.iminvloc_Sql IM ON IM.item_no = Temp.item_no AND IM.loc = 'GD'
	 
ROLLBACK TRAN;
