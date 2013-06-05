/*Calc. amount for sales orders only, net discount.  Not including credits, I-only's, freight, and tax.*/
SELECT     SUM(OL.sls_amt) - (SUM(OL.sls_amt*(.01*OL.discount_pct)))
FROM      dbo.oelinhst_sql  OL INNER JOIN oehdrhst_sql OH ON OH.inv_no = OL.inv_no
WHERE     (oh.ord_type IN ('O')) AND (YEAR(oh.entered_dt) = '2010')


/*Calc. DOCUMENT TOTAL amounts.  Not including freight and tax.*/
DECLARE @SALES AS money;
DECLARE @CREDITS AS money;

SET @SALES = (SELECT     SUM(OH.tot_sls_amt)
FROM      oehdrhst_sql OH
WHERE     (oh.orig_ord_type IN ('O','I')) AND (YEAR(oh.inv_dt) = '2010'))

SET @CREDITS = (SELECT     SUM(OH.tot_sls_amt)
FROM      oehdrhst_sql OH 
WHERE     (oh.orig_ord_type IN ('C')) AND (YEAR(oh.inv_dt) = '2010'))

SELECT @SALES, @CREDITS, (@SALES - @CREDITS)

