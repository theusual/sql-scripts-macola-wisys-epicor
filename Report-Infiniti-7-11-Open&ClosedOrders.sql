USE [020]

GO

ALTER VIEW BG_711_OpenAndClosed_Schedule AS 

--Created:	09/25/12  By:	BG
--Last Updated:	  	  By:	BG
--Purpose: View for Inf 7-11 Open&Closed Schedule		
--Last Change: --

SELECT LTRIM(OH.ord_no) AS Ord#, 'OPEN' AS STATUS, OH.oe_po_no, OH.ship_to_addr_2, CONVERT(VARCHAR, OH.ord_dt, 101) AS [Ord Date], 
               CONVERT(VARCHAR, OH.shipping_dt, 101) AS [Rqst'd Ship Date], 'N/A' AS [Actual Ship Date], 'N/A' [Carrier], 'N/A' [Tracking], OL.item_no, OL.cus_item_no, 
               OL.qty_to_ship AS Qty, OL.uom, 
               OL.item_desc_1, OL.item_desc_2, OH.ship_to_addr_1, OH.ship_to_city, OH.ship_to_state, OH.ship_to_zip
FROM  oeordhdr_sql OH JOIN
               oeordlin_sql OL ON OH.ord_no = OL.ord_no
WHERE OH.oe_po_no LIKE 'TK%' AND OH.ord_type = 'O'
UNION ALL
SELECT  LTRIM(OH.ord_no) AS Ord#, 'CLOSED' AS STATUS, OH.oe_po_no, OH.ship_to_addr_2 AS Str, CONVERT(VARCHAR, OH.ord_dt, 101) 
               AS [Ord Date], CONVERT(VARCHAR, OH.shipping_dt, 101) AS [Rqst'd Ship Date], OL.user_def_fld_3 AS [Actual Ship Date], 
			substring(OL.user_def_fld_4, 1, (charindex(',', OL.user_def_fld_4) - 1)) AS [Carrier], 
			substring(OL.user_def_fld_4, (charindex(',', OL.user_def_fld_4)+1), LEN(OL.user_Def_Fld_4)) AS [Tracking#], 
               OL.item_no, 
               OL.cus_item_no, OL.qty_to_ship AS Qty, OL.uom, OL.item_desc_1, OL.item_desc_2, OH.ship_to_addr_1, OH.ship_to_city, OH.ship_to_state, OH.ship_to_zip
FROM  oehdrhst_sql OH JOIN
               oelinhst_sql OL ON OH.inv_no = OL.inv_no
WHERE OH.oe_po_no LIKE 'TK%' AND OH.orig_ord_type = 'O'