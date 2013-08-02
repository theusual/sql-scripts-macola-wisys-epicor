--Created by:  AA
--Updated by:  BG
--Purpose: Report for WM customer service that checks for Pulse errors. (AltAddr, PromiseDt, ShippingDt, Missing Cust Item #)
--Last Update:  Fixed promise_dt issue

SELECT 'Store' AS Error, OH.ord_dt, OH.ord_no, OH.oe_po_no, OH.cus_alt_adr_cd, ED.mac_location AS AltAddr, 'n/a' AS MarcoItem, 
		'n/a' AS CustItem, '' AS Promise_Dt, OH.shipping_dt, 'n/a' AS LOR_Cmt, '0' AS Ord_Qty, '0' AS Ship_Qty
FROM  oeordhdr_sql OH LEFT OUTER JOIN
               edcshtfl_sql ED ON OH.cus_alt_adr_cd = ED.location
WHERE LTRIM(OH.cus_no) = '1575' AND OH.slspsn_no <> '20' AND OH.oe_po_no LIKE '3%' AND ((OH.cus_alt_adr_cd IS NULL OR
               OH.cus_alt_adr_cd LIKE '007%') OR
               OH.shipping_dt IS NULL OR
               OH.ship_to_addr_2 LIKE 'PO BOX%')
UNION ALL
SELECT CASE WHEN ED.tp_item_num IS NULL THEN 'Item' WHEN OL.promise_dt < GETDATE() THEN 'PromiseDate' END AS Error, 
		OH.ord_dt, OH.ord_no, OH.oe_po_no, 
        OH.cus_alt_adr_cd, 'n/a' AS AltAddr, OL.item_no, ED.tp_item_num, OL.promise_dt, OH.shipping_dt, 
        OL.user_def_fld_1 AS LOR_Cmt, OL.qty_ordered AS Ord_Qty, OL.qty_to_ship AS Ship_Qty
FROM  oeordhdr_sql OH JOIN
               oeordlin_sql OL ON OH.ord_no = OL.ord_no LEFT OUTER JOIN
               edcitmfl_sql ED ON ED.mac_item_num = OL.item_no
WHERE LTRIM(OH.cus_no) = '1575' AND OH.slspsn_no <> '20' 
		AND OH.oe_po_no NOT IN ('31952646', '31960093', '31960095', '31960096', '31960097', '31960098', '31960099', 
               '31961662', '31961663', '31961664', '31961665', '31961668', '31961669', '31961860', '31961861', '31961867', 
               '31961912', '31961915', '31961917', '31961919', '31962091', '31962096', '31962098', '31962122', '31962124', 
               '31962126', '31962128', '31962210', '31962213', '31962217', '31962218', '31962241', '31962242', '31962244', '31962245', 
               '31962249', '31986745', '31986746', '32055310', '32055312', '32072274') 
               AND OL.shipped_dt IS NULL AND (OL.promise_dt < GETDATE() OR  ED.edi_item_num IS NULL OR OL.item_no = '*EDI-ITEM')