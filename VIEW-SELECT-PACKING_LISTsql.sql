--ALTER VIEW BG_SELECT_PACKING_LIST AS

--Created:	11/19/12	 By:	BG
--Last Updated:		     By:	BG
--Purpose:	View for Select Packing Lists
--Last changes: 1) 10 items



SELECT DISTINCT 
               CONVERT(varchar, CAST(RTRIM(OH.entered_dt) AS datetime), 101) AS [ENTERED DT],
               CASE WHEN shipping_dt = 0 THEN 'N/A' ELSE CONVERT(varchar, CAST(RTRIM(OH.shipping_dt) AS datetime), 101) 
               END AS [SHIP DATE], 
               RIGHT(OH.ord_no, 5) AS [ORDER], 
               RIGHT(OH.cus_no, 3) AS CUST#, 
               OH.bill_to_name AS [CUST NAME], 
               OH.ship_to_name AS [SHIP TO], 
               CAST(OL.qty_ordered AS INT) AS [QTY ORDERED], OL.item_no AS ITEM1, 
               OL2.item_no AS [ITEM2],
               OL3.item_no AS [ITEM3],
               OL4.item_no AS [ITEM4],
               OL5.item_no AS [ITEM5],
               OL6.item_no AS [ITEM6],
               OL7.item_no AS [ITEM7],
               OL8.item_no AS [ITEM8],
               OL9.item_no AS [ITEM9],
               OL10.item_no AS [ITEM10],       
               OL.prod_cat AS [PROD CAT],
               OL.item_desc_1 AS ITEM1DESC1, OL.item_desc_2 AS ITEM1DESC2, 
               OL2.item_desc_1 AS ITEM2DESC1, OL2.item_desc_2 AS ITEM2DESC2, 
               OL3.item_desc_1 AS ITEM3DESC1, OL3.item_desc_2 AS ITEM3DESC2,  
               OL4.item_desc_1 AS ITEM4DESC1, OL4.item_desc_2 AS ITEM4DESC2, 
               OL5.item_desc_1 AS ITEM5DESC1, OL5.item_desc_2 AS ITEM5DESC2, 
               OL6.item_desc_1 AS ITEM6DESC1, OL6.item_desc_2 AS ITEM6DESC2, 
               OL7.item_desc_1 AS ITEM7DESC1, OL7.item_desc_2 AS ITEM7DESC2, 
               OL8.item_desc_1 AS ITEM8DESC1, OL8.item_desc_2 AS ITEM8DESC2, 
               OL9.item_desc_1 AS ITEM9DESC1, OL9.item_desc_2 AS ITEM9DESC2, 
               OL10.item_desc_1 AS ITEM10DESC1, OL10.item_desc_2 AS ITEM10DESC2, 
               OH.oe_po_no AS PO, 
               OH.slspsn_no AS [SALES PERSON], 
               OH.ship_via_cd AS [SHIP VIA],
               OH.ship_to_addr_1,
               OH.ship_to_addr_2,
               OH.ship_to_addr_3
FROM           dbo.oeordhdr_sql AS OH WITH (NOLOCK) JOIN
				(SELECT *  FROM dbo.OEORDLIN_SQL WHERE line_seq_no = 1) OL ON OL.ord_no = OH.ord_no
               LEFT OUTER JOIN dbo.IMITMIDX_SQL AS IM WITH (NOLOCK) ON OL.item_no = IM.item_no 
               LEFT OUTER JOIN (SELECT *  FROM dbo.OEORDLIN_SQL WHERE line_seq_no = 2) OL2 ON OL.ord_no = OL2.ord_no
               LEFT OUTER JOIN (SELECT *  FROM dbo.OEORDLIN_SQL WHERE line_seq_no = 3) OL3 ON OL.ord_no = OL3.ord_no
               LEFT OUTER JOIN (SELECT *  FROM dbo.OEORDLIN_SQL WHERE line_seq_no = 4) OL4 ON OL.ord_no = OL4.ord_no
               LEFT OUTER JOIN (SELECT *  FROM dbo.OEORDLIN_SQL WHERE line_seq_no = 5) OL5 ON OL.ord_no = OL5.ord_no
               LEFT OUTER JOIN (SELECT *  FROM dbo.OEORDLIN_SQL WHERE line_seq_no = 6) OL6 ON OL.ord_no = OL6.ord_no
               LEFT OUTER JOIN (SELECT *  FROM dbo.OEORDLIN_SQL WHERE line_seq_no = 7) OL7 ON OL.ord_no = OL7.ord_no
               LEFT OUTER JOIN (SELECT *  FROM dbo.OEORDLIN_SQL WHERE line_seq_no = 8) OL8 ON OL.ord_no = OL8.ord_no
               LEFT OUTER JOIN (SELECT *  FROM dbo.OEORDLIN_SQL WHERE line_seq_no = 9) OL9 ON OL.ord_no = OL9.ord_no
               LEFT OUTER JOIN (SELECT *  FROM dbo.OEORDLIN_SQL WHERE line_seq_no = 10) OL10 ON OL.ord_no = OL10.ord_no
WHERE (OH.ord_type = 'O') AND (OL.shipped_dt = 0)
GROUP BY OH.entered_dt, OH.mfg_loc, OL.loc, 
               OH.shipping_dt, OH.ord_no, OH.cus_no, OH.ship_to_name, OH.ship_to_addr_2, OL.qty_ordered, OL.item_no, OH.ship_instruction_1, OH.ship_instruction_2, 
               OL.prod_cat, OL.line_seq_no, OL.item_desc_1,OL.item_desc_2, IM.drawing_release_no, IM.drawing_revision_no, OL.qty_ordered, OH.bill_to_name, 
               OL.unit_price, OH.oe_po_no, OH.ord_dt, OL.picked_dt, OL.ord_type, OH.slspsn_no, OH.ship_via_cd, OL2.item_no,
               OL3.item_no, OL4.item_no, OL5.item_no, OL6.item_no, OL7.item_no, OL8.item_no, OL9.item_no, OL10.item_no,
               OL.item_desc_1, OL.item_desc_2,
               OL2.item_desc_1, OL2.item_desc_2,
               OL3.item_desc_1, OL3.item_desc_2,
               OL4.item_desc_1, OL4.item_desc_2,
               OL5.item_desc_1, OL5.item_desc_2,
               OL6.item_desc_1, OL6.item_desc_2,
               OL7.item_desc_1, OL7.item_desc_2,
               OL8.item_desc_1, OL8.item_desc_2,
               OL9.item_desc_1, OL9.item_desc_2,
               OL10.item_desc_1, OL10.item_desc_2,
               OH.ship_to_addr_1,
               OH.ship_to_addr_2,
               OH.ship_to_addr_3
               