SELECT act_unit_cost, receipt_dt, * FROM dbo.poordlin_sql AS PS JOIN poordhdr_Sql ph ON ph.ord_no = ps.ord_no
WHERE item_no = 'sw00278'