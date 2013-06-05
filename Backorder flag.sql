SELECT * FROM oelinhst_sql WHERE ord_no = '  832674'
SELECT item_no, entered_Dt, bkord_fg, dbo.arcusfil_sql.cus_no, dbo.arcusfil_sql.cus_name FROM oeordhdr_Sql OH JOIN oeordlin_sql ON OH.ord_no = oeordlin_Sql.ord_no JOIN arcusfil_sql ON dbo.arcusfil_sql.cus_no = oeordlin_sql.cus_no WHERE OH.ord_type = 'O' AND bkord_fg is null
SELECT * FROM arcusfil_sql

UPDATE oeordlin_sql 
SET bkord_fg = 'Y'
WHERE bkord_fg IS null

