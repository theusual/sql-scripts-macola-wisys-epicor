SELECT  distinct dbo.funReturnAvgCostFromIMRECHST(item_no), item_no
FROM    poordlin_sql 
WHERE receipt_dt > '01/01/2010' AND item_no = 'veg-euro ps 5bv'

UPDATE iminvloc_sql
set avg_cost = dbo.funReturnAvgCostFromIMRECHST(iminvloc_sql.item_no), last_cost = dbo.funReturnAvgCostFromIMRECHST(iminvloc_sql.item_no)
FROM poordlin_sql JOIN iminvloc_sql ON iminvloc_sql.item_no = poordlin_sql.item_no
WHERE receipt_dt > '01/01/2010'
