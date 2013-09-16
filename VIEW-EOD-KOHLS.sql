--CREATE VIEW BG_EOD_KOHLS AS

--Created:	07/31/13     By:	BG
--Last Updated:	09/9/13 By:	BG
--Purpose: View for Fossil EOD
--Last Change: --

/*Shipments processed in WISYS, already invoiced, join with OH history to gather updated tracking and carrier if available*/ 
SELECT ltrim(oh.ord_no) AS Ord_No, 
               OH.cus_alt_adr_cd AS [Store], 
               cmt_1 AS [Carrier_Cd], 
               OL.loc AS loc, OH.cmt_3 AS [tracking_no], 
               'INVOICED' AS [zone],  
               OL.qty_to_ship AS Qty, 
               OL.shipped_Dt,
               OL.item_no,  
               'Y' AS Shipped
FROM  dbo.oelinhst_sql AS OL JOIN
				oehdrhst_sql OH ON OL.ord_no = OH.ord_no 
WHERE LTRIM(OH.oe_po_no) = 'PUR231275'
