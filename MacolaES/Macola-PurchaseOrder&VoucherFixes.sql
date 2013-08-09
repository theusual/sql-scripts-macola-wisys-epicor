--RUN THIS FIRST:
BEGIN TRANSACTION
--THEN EXECUTE THIS WHEN FINISHED WITH ALL UPDATES AND CERTAIN THAT UPDATES WERE DONE CORRECTLY
COMMIT TRANSACTION
--IF A MISTAKE IS MADE:
ROLLBACK TRANSACTION

--Review/verify necessary fields that will be updated in imrechst table*/
SELECT ord_no, line_no, rec_hst_dt, rec_hst_tm, item_no, ctl_no, vend_no, qty_ordered, qty_received, qty_received_to_dt, batch_id, dollars_inv, qty_inv, vchr_dt, vchr_no, system_dt, ID, actual_cost
FROM imrechst_sql 
WHERE  LTRIM(vchr_no) = '444419'
							--LTRIM(ord_no) IN ('8282100')  --AND line_no in (1)
ORDER BY ord_no, line_no, system_dt

--Review necessary fields to update in poordlin table*/
SELECT ord_no, line_no, vend_no, item_no, qty_ordered, qty_received, act_unit_cost, qty_inv, dollars_inv, receipt_dt
FROM poordlin_sql WHERE LTRIM(ord_no) IN ('8282100') --AND line_no in (2)

------------------------------------------------------------------------------------------------------------------------------------------
/* AP VOUCHER FIXES */
BEGIN TRAN
-- ***Update imrechst records with voucher errors after verifying the # does not appear on vendor card or G/L
UPDATE imrechst_sql
SET vchr_no = NULL, vchr_dt = NULL, qty_inv = 0, dollars_inv = 0, batch_id = NULL 
		--ONLY INCLUDE THESE IF RESETTING A RECEIPT, NOT JUST A VOUCHER ISSUES
		  --, qty_received_to_dt = 0, qty_received = 0
WHERE --LTRIM(ord_no) IN ('124158300') AND line_no in (1)
	   --use ctl_no for specific lines of receipts on the same line item
       ctl_no = '33617900'
COMMIT TRAN

--***Same script as above but using voucher no in place of order no (for resetting large vouchers spanning across multiple POs)
UPDATE imrechst_sql
SET vchr_no = NULL, vchr_dt = NULL, qty_inv = 0, dollars_inv = 0, batch_id = NULL 
		--ONLY INCLUDE THESE IF RESETTING A RECEIPT, NOT JUST A VOUCHER ISSUES
		  --, receipt_dt = 0, qty_received = 0
FROM dbo.poordlin_sql PL, dbo.imrechst_sql REC 
WHERE PL.ord_no = REC.ord_no AND PL.line_no = REC.line_no AND LTRIM(vchr_no) = '444419'

--IN THE RARE INSTANCE THAT A PO IS VOUCHERED BUT SHOULD HAVE BEEN CANCELLED AND PURCHASING/AP AGREE; EXECUTE THIS WITH THE ABOVE... */
--UPDATE imrechst_sql SET qty_ordered = 0 WHERE LTRIM(ord_no) = '862900' --AND ID = 22649

--***Update poordlin records to match above changes in imrechst table
UPDATE poordlin_sql SET qty_inv = 0 WHERE LTRIM(ord_no) IN ('12000600') AND line_no in (3)
UPDATE poordlin_sql SET dollars_inv = 0 WHERE LTRIM(ord_no) IN ('11870300') AND line_no in (6)

--***Same script as above but using voucher no in place of order no (for resetting large vouchers spanning across multiple POs)
UPDATE poordlin_sql
SET qty_inv = 0, dollars_inv = 0
FROM dbo.poordlin_sql PL, dbo.imrechst_sql REC 
WHERE PL.ord_no = REC.ord_no AND PL.line_no = REC.line_no AND vchr_no = '  438122'

BEGIN TRAN
DELETE FROM dbo.imrechst_sql WHERE ord_no = ' 8282100'
COMMIT TRAN





------------------------------------------------------------------------------------------------------------------------------------------
/*PO RECEIPT FIXES*/
-- ***Update imrechst records with receiving errors
UPDATE imrechst_sql SET qty_received = 0 WHERE LTRIM(ord_no) = '862900' --AND ID = 22649
UPDATE imrechst_sql SET qty_received_to_dt = 0 WHERE LTRIM(ord_no) = '862900' --AND ID = 22649

-- ***UPDATE PO LINES THAT HAVE BEEN RECEIVED WITH PROBLEMS, BUT ARE NOT VOUCHERED
UPDATE poordlin_sql SET qty_received = 0 WHERE LTRIM(ord_no) IN ('11992600') AND line_no in (18)
UPDATE poordlin_sql SET act_unit_cost = 0 WHERE LTRIM(ord_no) IN ('11992600') AND line_no in (18)
UPDATE poordlin_sql SET receipt_dt = NULL WHERE LTRIM(ord_no) IN ('11992600') AND line_no in (18)

