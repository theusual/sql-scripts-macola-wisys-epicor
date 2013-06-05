USE [020]

GO

--ALTER VIEW BG_711_Open_Schedule AS 

--Created:	09/25/12  By:	BG
--Last Updated:	  	  By:	BG
--Purpose: View for Inf 7-11 Schedule		
--Last Change: --

SELECT LTRIM(OH.ord_no) AS Ord#, 'OPEN' AS STATUS, OH.oe_po_no, OH.ship_to_addr_2 AS Str, CONVERT(VARCHAR, OH.ord_dt, 101) AS [Ord Date], 
               CONVERT(VARCHAR, OH.shipping_dt, 101) AS [Rqst'd Ship Date], '' AS [Actual Ship Date], OL.item_no, OL.cus_item_no, OL.qty_to_ship AS Qty, OL.uom, 
               OL.item_desc_1, OL.item_desc_2, OH.ship_to_addr_1, OH.ship_to_city, OH.ship_to_state, OH.ship_to_zip
FROM  oeordhdr_sql OH JOIN
               oeordlin_sql OL ON OH.ord_no = OL.ord_no
WHERE OH.oe_po_no LIKE 'TK%' AND OH.ord_type = 'O'
/*UNION ALL
SELECT 'Infiniti' AS WHSE, LTRIM(OH.ord_no) AS Ord#, 'CLOSED' AS STATUS, OH.oe_po_no, OH.ship_to_addr_2 AS Str, CONVERT(VARCHAR, OH.ord_dt, 101) 
               AS [Ord Date], CONVERT(VARCHAR, OH.shipping_dt, 101) AS [Rqst'd Ship Date], CONVERT(VARCHAR, OH.inv_dt, 101) AS [Actual Ship Date], OL.item_no, 
               OL.cus_item_no, OL.qty_to_ship AS Qty, OL.uom, OL.item_desc_1, OL.item_desc_2, OH.ship_to_addr_1, OH.ship_to_city, OH.ship_to_state, OH.ship_to_zip, 
               OH.cmt_1, OH.cmt_2, OH.cmt_3
FROM  oehdrhst_sql OH JOIN
               oelinhst_sql OL ON OH.inv_no = OL.inv_no
WHERE OH.oe_po_no LIKE 'TK%' AND OH.orig_ord_type = 'O'*/