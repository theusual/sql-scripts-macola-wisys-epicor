SELECT item_no, item_desc_1, qty_ordered, receipt_dt, act_unit_cost, vend_no 
FROM dbo.poordlin_sql 
WHERE LTRIM(vend_no) IN ('995', '9797') AND receipt_dt > '01/01/2012'