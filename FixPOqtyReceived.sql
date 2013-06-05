UPDATE imrechst_Sql 
SET qty_received_to_dt = 0
WHERE ctl_no = '30499300'

UPDATE dbo.poordlin_sql 
SET qty_received = 0, qty_remaining = 300
WHERE ord_no = '11843000'

SELECT * FROM imrechst_sql WHERE ord_no = '11843000'

SELECT * FROM dbo.poordlin_sql WHERE ord_no = '11843000'