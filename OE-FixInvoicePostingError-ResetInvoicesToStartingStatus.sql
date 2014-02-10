--Queries for fixing hung up invoices that will not post or print
-----------------------------------------------------------------

SELECT inv_batch_id, selection_cd, inv_dt, inv_no, status, * FROM oeordhdr_SQL OH WHERE inv_no = '  530903'
SELECT inv_batch_id, selection_cd, inv_dt, inv_no, status, * FROM oeordhdr_SQL OH WHERE ord_no = '  379429'

--Compare the hung up invoices with a new invoice to see which fields need to be reset to starting status
SELECT orig_ord_type, [status], inv_batch_id, selection_cd, inv_Dt, inv_no, * 
FROM oeordhdr_Sql OH LEFT OUTER JOIN oeordlin_Sql OL ON OH.ord_no = OL.ord_no
WHERE OH.inv_batch_id = '01/31 DD'

--Check if invoice is in power inquiry tables, if it is remove the entries with an invoice # (entries w/o invoice # are normal open order entries)
SELECT * FROM oepdshdr_sql WHERE ord_no IN (SELECT ord_no FROM oeordhdr_SQL OH WHERE OH.inv_batch_id IN ('01/31 DD')) AND invoice_no != ''

BEGIN TRAN
DELETE FROM oepdshdr_sql WHERE ord_no IN (SELECT ord_no FROM oeordhdr_SQL OH WHERE OH.inv_batch_id = '01/31 DD') AND invoice_no != ''
COMMIT TRAN

--Reset the order header fields related to posting back to the starting status
--FOR I-ONLY:
UPDATE dbo.oeordhdr_sql
SET inv_batch_id = 'BRYAN', selection_cd = 'S', inv_dt = NULL, inv_no = '', status = 1
WHERE inv_batch_id IN ('01/31 DD')
--FOR REGULAR INVOICES:
UPDATE dbo.oeordhdr_sql
SET inv_batch_id = 'BRYAN', selection_cd = 'S', inv_dt = NULL, inv_no = '', status = 8
WHERE ORD_NO IN (SELECT ord_no FROM oeordhdr_SQL OH WHERE OH.inv_batch_id = ('01/31 DD'))
--FOR CREDITS:
UPDATE dbo.oeordhdr_sql
SET inv_batch_id = 'DOUG', selection_cd = 'S', inv_dt = NULL, inv_no = '', status = 1
WHERE LTRIM(ord_no) IN ('131377','131378','131379','131380','131401', '131402', '689359')

--Check to see if other invoices are affected by searching for selection_cd = N ??
SELECT * FROM oeordhdr_Sql OH JOIN oeordlin_Sql OL ON OH.ord_no = OL.ord_no WHERE selection_cd = 'N'

SELECT * FROM dbo.oehdraud_sql WHERE inv_batch_id = 'VL 9/5' AND inv_no != '' --AND ord_no = '  372933'

SELECT inv_no, inv_batch_id, status, selection_cd, * FROM oeordhdr_sql WHERE ord_no = '  379360'

