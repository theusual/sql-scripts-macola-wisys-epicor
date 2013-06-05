--SELECT * FROM dbo.poordlin_sql WHERE ord_no = '11999500' AND line_no = '3'

--Update PO Line to before receiving occurred
UPDATE dbo.poordlin_sql
SET qty_received = 0, qty_remaining = 65
WHERE ord_no = '11999500' AND line_no = '3'

--Delete trx from receiver history OR update to 0 (see below)
DELETE FROM dbo.imrechst_sql WHERE ord_no = '11999500' AND line_no = '3'

--Delete inventory trx OR update qty's to 0  (see below)
DELETE FROM dbo.iminvtrx_sql WHERE ord_no = '11999500' AND line_no = '3'

--Delete any landed costs that were recorded, so that the next receiving will write back a new landed cost (if this isn't deleted, the new landed cost will not be written back)
DELETE FROM dbo.popurcst_sql  WHERE ord_no = '11999500' AND line_no = '3'

-------------------------------------
--More detailed fixes below -- Per AA
-------------------------------------

/* REVIEW RECORDS */
--Review/verify necessary fields that will be updated in imrechst table*/
SELECT ord_no, line_no, rec_hst_dt, rec_hst_tm, item_no, ctl_no AS Receiver, vend_no, qty_ordered, qty_received, qty_received_to_dt, pack_no, batch_id, dollars_inv, qty_inv, vchr_dt, vchr_no, 
loc, system_dt, ID
FROM imrechst_sql WHERE LTRIM(ord_no) IN ('12290900') --AND line_no in (1) 
--ID IN ('350093', '350289', '350291', '350302', '350308', '350310', '350312', '350314', '350316', '350318', '350320', '350322')
ORDER BY ord_no, line_no, system_dt

--Review necessary fields to update in poordlin table*/
SELECT ord_no, line_no, vend_no, item_no, qty_ordered, qty_received, qty_remaining, act_unit_cost, qty_inv, dollars_inv, receipt_dt
FROM poordlin_sql WHERE LTRIM(ord_no) IN ('12290900') --AND line_no in (1)
--------------------------------------------------------------------------------------------------------

/* AP VOUCHER FIXES */
-- ***Update imrechst records with voucher errors after verifying the # does not appear on vendor card or G/L
UPDATE imrechst_sql SET batch_id = NULL WHERE LTRIM(ord_no) IN ('12290900') --AND line_no in (3)
UPDATE imrechst_sql SET dollars_inv = 0 WHERE LTRIM(ord_no) IN ('12290900') --AND line_no in (3)
UPDATE imrechst_sql SET qty_inv = 0 WHERE LTRIM(ord_no) IN ('12290900') --AND line_no in (3)
UPDATE imrechst_sql SET vchr_dt = NULL WHERE LTRIM(ord_no) IN ('12290900') --AND line_no in (3)
UPDATE imrechst_sql SET vchr_no = NULL WHERE LTRIM(ord_no) IN ('12290900') --AND line_no in (3)

--***Then update poordlin records to match above changes in imrechst table
UPDATE poordlin_sql SET qty_inv = 0 WHERE LTRIM(ord_no) IN ('12290900') --AND line_no in (3)
UPDATE poordlin_sql SET dollars_inv = 0 WHERE LTRIM(ord_no) IN ('12290900') --AND line_no in (3)
--------------------------------------------------------------------------------------------------------

/*PO RECEIPT FIXES*/
-- ***Update imrechst records with receiving errors (Better not to delete from table)
UPDATE imrechst_sql SET qty_received = 0 WHERE LTRIM(ord_no) IN ('1128500') AND line_no in (1) 
UPDATE imrechst_sql SET qty_received_to_dt = 0 WHERE LTRIM(ord_no) IN ('1128500') AND line_no in (1)  

-- ***UPDATE poordlin_sql LINES THAT HAVE BEEN RECEIVED WITH PROBLEMS, BUT ARE NOT VOUCHERED
UPDATE poordlin_sql SET qty_received = 0 WHERE LTRIM(ord_no) IN ('1128500') AND line_no in (1) 
UPDATE poordlin_sql SET qty_remaining = 96 WHERE LTRIM(ord_no) IN ('1128500') AND line_no in (1) 
UPDATE poordlin_sql SET act_unit_cost = 0 WHERE LTRIM(ord_no) IN ('1128500') AND line_no in (1) 
UPDATE poordlin_sql SET receipt_dt = NULL WHERE LTRIM(ord_no) IN ('1128500') AND line_no in (1)


