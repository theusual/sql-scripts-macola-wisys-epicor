SELECT  ord_no, line_no, item_no, par_item_no AS [par_item_no], CAST(qty AS INT) AS Qty, loc, '' AS [PostError], getdate() AS [trx_dt]
FROM    imordbld_sql
where ord_no = '88888889'

SELECT  ord_no, line_no, item_no, '-' AS [par_item_no], CAST(qty_to_ship AS INT) AS Qty, loc, '' AS [PostError], getdate() AS [trx_dt]
FROM    dbo.oeordlin_sql 
where ord_no = '88888889'

SELECT * FROM dbo.imiNVLOC_SQL WHERE item_no IN ('test item pur', 'test item wisys', 'test item bom') AND loc = 'FW'