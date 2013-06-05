SELECT left(trx_dt,12) AS [Trx Date], right(trx_tm,8) AS [Trx Time], 
    CASE WHEN lev_no = 1 THEN '' ELSE loc END AS [Ship From], CASE WHEN lev_no = 1 THEN loc ELSE '' END AS [Ship To], item_no AS [Item #], CAST(quantity as int)AS [Trx Qty], user_name AS [Trx By], doc_ord_no AS [Ord No]
FROM iminvtrx_sql
WHERE trx_dt > '2011-02-15' AND doc_type = 'T'
ORDER BY trx_dt DESC, trx_tm DESC

SELECT *
FROM iminvtrx_sql
WHERE trx_dt > '2011-02-15' AND doc_type = 'T' AND user_name = 'bgregory'
ORDER BY trx_dt DESC, trx_tm DESC