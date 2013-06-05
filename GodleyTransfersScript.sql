SELECT TOP (100) PERCENT dbo.iminvtrx_sql.ord_no AS [Transfer], dbo.iminvtrx_sql.item_no AS Item, dbo.iminvtrx_sql.doc_ord_no AS [Order], 
               CAST(dbo.iminvtrx_sql.quantity AS INT) AS [Qty], GETDATE() AS [trx_dt], N'' AS [PostError]
FROM  dbo.iminvtrx_sql --INNER JOIN dbo.iminvloc_sql ON dbo.iminvloc_sql.item_no = dbo.iminvtrx_sql.item_no AND dbo.iminvloc_sql.loc = 'IT'
WHERE trx_dt > DATEADD(day,-1,GETDATE()) AND doc_type = 'T' AND LTRIM(comment) = 'GD' and lev_no = 0
                 
SELECT TOP (100) PERCENT dbo.iminvtrx_sql.ord_no AS [Transfer], dbo.iminvtrx_sql.item_no AS Item, dbo.iminvtrx_sql.doc_ord_no AS [Order], 
               CAST(dbo.iminvtrx_sql.quantity AS INT) AS [Qty], GETDATE() AS [trx_dt], N'' AS [PostError]
FROM  dbo.iminvtrx_sql --INNER JOIN dbo.iminvloc_sql ON dbo.iminvloc_sql.item_no = dbo.iminvtrx_sql.item_no AND dbo.iminvloc_sql.loc = 'IT'
WHERE trx_dt > DATEADD(day,-3,GETDATE()) AND doc_type = 'T' AND LTRIM(comment) = 'GD' and lev_no = 0 and item_no = '17543 CLR FG'                 
                 