DECLARE @item AS VARCHAR(30)
SET @item = 'MDWM-0025 SB'

SELECT 'OPEN PO' AS [Type], PL.ord_no, AP.vend_name AS [Cus/Vend Name], 'Est.QOH', qty_ordered AS [Qty Recv/Ord/Shp], request_dt AS [Entered/Requ Dt], PL.user_def_fld_2  AS [Recv/Ship/Inv Dt], qty_ordered AS [QtyOrd], item_no, item_desc_1, item_desc_2, PL.line_no
FROM poordlin_Sql PL JOIN dbo.apvenfil_sql AP ON AP.vend_no = PL.vend_no JOIN dbo.poordhdr_sql PH ON PH.ord_no = PL.ord_no 
WHERE item_no IN (@item) AND PH.ord_status != 'X' AND qty_received = 0 ORDER BY PL.receipt_Dt

SELECT 'RECV PO' AS [Type], PL.ord_no, AP.vend_name AS [Cus/Vend Name], 'Est.QOH', qty_ordered AS [Qty Recv/Ord/Shp], request_dt AS [Entered/Requ Dt], receipt_dt AS [Recv/Ship/Inv Dt], qty_ordered AS [QtyOrd], item_no, item_desc_1, item_desc_2, PL.line_no
FROM poordlin_Sql PL JOIN dbo.apvenfil_sql AP ON AP.vend_no = PL.vend_no JOIN dbo.poordhdr_sql PH ON PH.ord_no = PL.ord_no 
WHERE item_no IN (@item) AND PH.ord_status != 'X' AND qty_received > 0 ORDER BY PL.receipt_Dt 

SELECT 'OPEN SALES' AS [Type], OL.ord_no, OH.bill_to_name AS [Cus/Vend Name], 'Est.QOH', (qty_to_ship*-1) AS [Qty Recv/Ord/Shp], entered_dt AS [Entered/Requ Dt], inv_dt [Recv/Ship/Inv Dt],  (OL.qty_ordered*-1) AS [QtyOrd], OL.item_no, OL.item_desc_1, OL.item_desc_2, OL.line_no, unit_price
FROM oelinhst_Sql OL JOIN OEHDRHST_SQL OH ON OH.inv_no = OL.inv_no WHERE item_no IN (@item) AND inv_Dt > '1/1/2013'

SELECT 'INV SALES' AS [Type], OL.ord_no, OH.bill_to_name AS [Cus/Vend Name], 'Est.QOH', (qty_to_ship*-1) AS [Qty Recv/Ord/Shp], entered_dt AS [Entered/Requ Dt], shipping_dt [Recv/Ship/Inv Dt], (OL.qty_ordered*-1) AS [QtyOrd], OL.item_no, OL.item_desc_1, OL.item_desc_2 , OL.line_no,  unit_price
FROM oeordlin_Sql OL JOIN oeordhdr_SQL OH ON OH.ord_no = OL.ord_no WHERE item_no IN (@item) --AND inv_Dt > '1/1/2013'

SELECT 'QOH' AS [Type], frz_qty FROM dbo.Z_IMINVLOC WHERE item_no IN (@item)

