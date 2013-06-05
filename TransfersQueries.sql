SELECT CASE loc WHEN 'IT' THEN 'TRANSFER OUT'
                ELSE  'TRANSFER IN'
        END AS [TransType], ord_no AS [Transf. #], convert(varchar(10),trx_dt,101) AS [Transf. Dt.], convert(varchar(10), RIGHT(trx_tm, 8), 101) AS [Transf. Tm], item_no AS [Item], doc_ord_no AS [Ord #], quantity AS [Trx Quantity], user_name, comment AS [To Loc], comment_2 AS [Comment 2]
FROM    iminvtrx_sql
WHERE (item_no IN (
SELECT item_no
FROM  dbo.iminvloc_sql
WHERE (loc = 'IT') AND (qty_on_hand <> 0))) 
	AND trx_dt > (DATEADD(day, -7, GETDATE()))
    AND doc_type = 'T'
    AND lev_no = '1'
ORDER by item_no, trx_dt, doc_ord_no
   


SELECT  doc_ord_no,item_no
FROM    iminvtrx_sql
WHERE doc_ord_no+item_no IN (SELECT ord_no + item_no FROM wsPikPak where Shipped = 'Y')
       AND item_no IN (
			SELECT item_no
			FROM  dbo.iminvloc_sql
			WHERE (loc = 'IT') AND (qty_on_hand <> 0)) 
    AND doc_type = 'T'
    AND lev_no = '1'
    
    --Identify Transfers Left In IT
  SELECT  ord_no AS [Transf. #], convert(varchar(10),trx_dt,101) AS [Transf. Dt.], convert(varchar(10), RIGHT(trx_tm, 8), 101) AS [Transf. Tm], iminvloc_sql.item_no AS [Item], doc_ord_no AS [Ord #], quantity AS [Trx Quantity], user_name, comment AS [To Loc], comment_2 AS [Comment 2], iminvloc_sql.qty_on_hand AS [QIT]
  FROM iminvtrx_sql JOIN iminvloc_sql ON iminvloc_Sql.item_no = iminvtrx_sql.item_no AND iminvloc_sql.loc = 'IT'
  WHERE   doc_ord_no+iminvtrx_sql.item_no+cast(quantity AS varchar(15)) 
           NOT IN 
             (    --Transfers In
				  SELECT  doc_ord_no+item_no+cast(quantity AS varchar(15))
				  FROM    iminvtrx_sql
				  where lev_no = '1' AND loc != 'IT' AND trx_dt > (DATEADD(day, -5, GETDATE())) AND  not(doc_ord_no is null)
				  --ORDER BY item_no
			  )
		  AND lev_no = '1' AND iminvtrx_sql.loc = 'IT' AND trx_dt > (DATEADD(day, -5, GETDATE())) and not(doc_ord_no is null)
		  AND iminvtrx_sql.item_no IN (
			SELECT item_no
			FROM  dbo.iminvloc_sql
			WHERE (loc = 'IT') AND (qty_on_hand <> 0))
   ORDER BY iminvtrx_Sql.item_no
   
    --Transfers Out
    SELECT  doc_ord_no+item_no+cast(quantity AS varchar(10))
    FROM    iminvtrx_sql
    where lev_no = '1' AND loc = 'IT' AND trx_dt > (DATEADD(day, -7, GETDATE()))
    
    
    --Transfer In
    SELECT  doc_ord_no+item_no+cast(quantity AS varchar(10))
    FROM    iminvtrx_sql
    where lev_no = '1' AND loc != 'IT' AND trx_dt > (DATEADD(day, -7, GETDATE()))
    
    
    --Auto-transfer in transfers made to locations without Wisys
  SELECT  ord_no AS [Transf. #], convert(varchar(10),trx_dt,101) AS [Transf. Dt.], convert(varchar(10), RIGHT(trx_tm, 8), 101) AS [Transf. Tm], iminvloc_sql.item_no AS [Item], doc_ord_no AS [Ord #], quantity AS [Trx Quantity], user_name, comment AS [To Loc], comment_2 AS [Comment 2], iminvloc_sql.qty_on_hand AS [QIT]
  FROM iminvtrx_sql JOIN iminvloc_sql ON iminvloc_Sql.item_no = iminvtrx_sql.item_no AND iminvloc_sql.loc = 'IT'
  WHERE   lev_no = '1' AND iminvtrx_sql.loc = 'IT' AND trx_dt > (DATEADD(day, -7, GETDATE())) and not(doc_ord_no is null)
		  AND comment IN ('GD','WC','EC')
		  AND iminvtrx_sql.item_no IN (
			SELECT item_no
			FROM  dbo.iminvloc_sql
			WHERE (loc = 'IT') AND (qty_on_hand <> 0))
   ORDER BY iminvtrx_Sql.item_no