--ALTER VIEW BG_ORDERS_MISSING_INITIALS AS 

--Created:	6/19/12	 By:	BG
--Last Updated:	6/19/12	 By:	BG
--Purpose:	View for showing orders missing initials

SELECT TOP (100) PERCENT OEORDHDR_SQL.ord_no, LTRIM(OEORDHDR_SQL.cus_no) AS CUS#, OEORDHDR_SQL.bill_to_name, OEORDLIN_SQL.qty_ordered, 
               Z_IMINVLOC.qty_on_hand, OEORDLIN_SQL.item_no, imitmidx_sql.item_desc_1, imitmidx_sql.item_note_1, OEORDHDR_SQL.ord_dt, OEORDHDR_SQL.shipping_dt, 
               Z_IMINVLOC.prod_cat, OEORDHDR_SQL.oe_po_no, OEORDHDR_SQL.user_def_fld_5 AS INTIALS
FROM  dbo.oeordhdr_sql AS OEORDHDR_SQL 
			   INNER JOIN dbo.oeordlin_sql AS OEORDLIN_SQL ON OEORDHDR_SQL.ord_type = OEORDLIN_SQL.ord_type AND OEORDHDR_SQL.ord_no = OEORDLIN_SQL.ord_no 
               INNER JOIN dbo.Z_IMINVLOC AS Z_IMINVLOC ON OEORDLIN_SQL.item_no = Z_IMINVLOC.item_no 
               INNER JOIN dbo.imitmidx_sql AS imitmidx_sql ON OEORDLIN_SQL.item_no = imitmidx_sql.item_no
WHERE (Z_IMINVLOC.qty_allocated > 0) 
	  AND OEORDHDR_SQL.user_def_fld_5 IS NULL
	  AND OEORDHDR_SQL.ord_type = 'O'
	  AND NOT(OEORDLIN_SQL.item_no LIKE '%TEST%')
	  AND NOT(LTRIM(OEORDHDR_SQL.cus_no) = '123')
ORDER BY OEORDHDR_SQL.shipping_dt, OEORDLIN_SQL.ord_no, OEORDLIN_SQL.item_no