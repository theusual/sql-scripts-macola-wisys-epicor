SELECT TOP (100) PERCENT dbo.iminvtrx_sql.ord_no AS [Transf. #], CONVERT(varchar(10), dbo.iminvtrx_sql.trx_dt, 101) AS [Transf. Dt.], CONVERT(varchar(10), 
               RIGHT(dbo.iminvtrx_sql.trx_tm, 8), 101) AS [Transf. Tm], dbo.iminvloc_sql.item_no AS Item, dbo.iminvtrx_sql.doc_ord_no AS [Ord #], 
               dbo.iminvtrx_sql.quantity AS [Trx Quantity], dbo.iminvtrx_sql.user_name, dbo.iminvtrx_sql.comment AS [To Loc], dbo.iminvtrx_sql.comment_2 AS [Comment 2], 
               dbo.iminvloc_sql.qty_on_hand AS QIT
FROM  dbo.iminvtrx_sql INNER JOIN
               dbo.iminvloc_sql ON dbo.iminvloc_sql.item_no = dbo.iminvtrx_sql.item_no AND dbo.iminvloc_sql.loc = 'IT'
WHERE (dbo.iminvtrx_sql.lev_no = '1') AND (dbo.iminvtrx_sql.loc = 'IT') AND (dbo.iminvtrx_sql.trx_dt > DATEADD(day, - 15, GETDATE())) AND 
               (NOT (dbo.iminvtrx_sql.doc_ord_no IS NULL)) AND (dbo.iminvtrx_sql.item_no IN
                   (SELECT item_no
                    FROM   dbo.iminvloc_sql AS iminvloc_sql_1
                    WHERE (loc = 'IT') AND (qty_on_hand <> 0))) AND ((dbo.iminvtrx_sql.doc_ord_no + dbo.iminvtrx_sql.item_no + CAST(dbo.iminvtrx_sql.quantity AS varchar(15)) 
               + LTRIM(RTRIM(dbo.iminvtrx_sql.comment))) NOT IN
                   (SELECT doc_ord_no + item_no + CAST(quantity AS varchar(15)) + loc AS Expr1
                    FROM   dbo.iminvtrx_sql AS iminvtrx_sql_1
                    WHERE (lev_no = '1') AND (loc <> 'IT') AND (trx_dt > DATEADD(day, - 15, GETDATE())) AND (NOT (doc_ord_no IS NULL))))
ORDER BY dbo.iminvtrx_sql.item_no