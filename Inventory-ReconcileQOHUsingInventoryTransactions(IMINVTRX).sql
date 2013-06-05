--STOP!  MAKE SURE TO UPDATE ALL DOC_DT'S TO THE CURRENT DATE BEFORE RUNNING ANYTHING (USE A FIND AND REPLACE TO NOT MISS ANYTHING!)

--Generic script for pulling different transaction types, helps identify what transactions occurred
SELECT TOP (100) PERCENT doc_type AS [Trx Type], CONVERT(varchar(10), trx_dt, 101) AS TrxDt, RIGHT(trx_tm, 8) AS [Trx Time], loc, item_no AS [Item #], CAST(quantity AS int) AS [Kit Qty], user_name AS [Kit By], doc_ord_no AS [Ord No], comment
FROM  dbo.iminvtrx_sql
WHERE (doc_dt = '04/01/2013') AND (doc_type IN ('I'))
ORDER BY trx_dt DESC, trx_tm DESC

--Test the script using select statement before running update
SELECT trx.item_no, trx.loc, qty_on_hand, frz_qty, (frz_qty + qty), (qty_on_hand + qty) AS [NewQOH]
FROM dbo.iminvloc_sql IM JOIN 
		(SELECT loc, item_no, SUM(CAST(quantity AS int)) AS [qty]
		FROM  dbo.iminvtrx_sql
		WHERE (doc_dt = '04/01/2013') AND (doc_type IN ( 'R'))
		GROUP BY loc, item_no) AS TRX ON TRX.item_no = IM.item_no AND TRX.loc = IM.loc

--Update QOH by subtracting out qty's for issue transactions		
UPDATE dbo.iminvloc_sql
SET qty_on_hand = (qty_on_hand - qty)
FROM dbo.iminvloc_sql IM JOIN 
		(SELECT loc, item_no, SUM(CAST(quantity AS int)) AS [qty]
		FROM  dbo.iminvtrx_sql
		WHERE (doc_dt = '04/01/2013') AND (doc_type IN ( 'I'))
		GROUP BY loc, item_no) AS TRX ON TRX.item_no = IM.item_no AND TRX.loc = IM.loc

--Update QOH by adding in qty's for receipt transactions		
UPDATE dbo.iminvloc_sql
SET qty_on_hand = (qty_on_hand + qty)
FROM dbo.iminvloc_sql IM JOIN 
		(SELECT loc, item_no, SUM(CAST(quantity AS int)) AS [qty]
		FROM  dbo.iminvtrx_sql
		WHERE (doc_dt = '04/01/2013') AND (doc_type IN ( 'R'))
		GROUP BY loc, item_no) AS TRX ON TRX.item_no = IM.item_no AND TRX.loc = IM.loc

--Check a few sample items
SELECT frz_Qty, qty_on_hand, * FROM iminvloc_Sql WHERE item_no = 'BAK-619 DOORSBL               '                 

SELECT loc, trx_dt, doc_dt, doc_Type, * FROM iminvtrx_sql WHERE item_no = 'BAK-619 DOORSBL               ' AND doc_dt = '04/01/2013'


--GOOD JOB, NOW RE-ENABLE THOSE FUCKING TRIGGERS BEFORE YOU FORGET YOU SLEEPY SON OF ABITCH!  SLEEP CAN WAIT, INVENTORY TRIGGERS CANNOT!  FUCK FUCK FUCK!
		