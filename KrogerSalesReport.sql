--	
SELECT IM.prod_cat, OH.entered_Dt, OH.ord_no, OH.inv_no, OH.oe_po_no, IM.item_no, IM.item_desc_1, IM.item_desc_2, unit_price, cus_alt_adr_cd, inv_dt, qty_to_ship  FROM dbo.oehdrhst_sql OH JOIN dbo.oelinhst_sql OL ON OL.inv_no = OH.inv_no
				JOIN IMITMIDX_SQL IM ON IM.item_no = OL.item_no 
WHERE OH.ord_no IN (SELECT ord_no FROM oelinhst_Sql OL JOIN dbo.imitmidx_sql IM ON IM.item_no = OL.item_no WHERE IM.prod_cat = '551')


SELECT OH.entered_Dt, OH.ord_no, OH.inv_no, OH.oe_po_no, IM.item_no, IM.item_desc_1, IM.item_desc_2, unit_price, cus_alt_adr_cd, inv_dt, qty_to_ship  
FROM dbo.oeordhdr_sql OH JOIN dbo.oeordlin_sql OL ON OL.ord_no = OH.ord_no
				JOIN IMITMIDX_SQL IM ON IM.item_no = OL.item_no
WHERE IM.prod_cat = '551'

