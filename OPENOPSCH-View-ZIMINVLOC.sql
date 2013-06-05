SELECT     CONVERT(varchar, OH.shipping_dt, 101) AS [SHIP DATE], LTRIM(OH.ord_no) AS [ORDER], LTRIM(OH.cus_no) AS CUST, OH.ship_to_name AS [SHIP TO], 
                      CASE WHEN BM.seq_no =
                          (SELECT     MIN(bm.seq_no)
                            FROM          IMITMIDX_SQL IM, BMPRDSTR_SQL BM
                            WHERE      IM.item_no = BM.item_no AND OL.item_no = IM.item_no) THEN OL.qty_ordered WHEN BM.seq_no IS NULL 
                      THEN OL.qty_ordered ELSE 0 END AS QTY, OL.item_no AS ITEM, IM.prod_cat AS CAT, OL.line_seq_no AS [LINE SEQ], IM.item_desc_1 AS DESC1, 
                      IM.item_desc_2 AS DESC2, BM.qty_per_par AS [QTY PER PARENT], OL.qty_ordered * BM.qty_per_par AS [COMPONENT QTY], 
                      BM.comp_item_no AS [COMPONENT ITEM],
                          (SELECT     prod_cat
                            FROM          dbo.imitmidx_sql AS IM
                            WHERE      (item_no = BM.comp_item_no)) AS [COMP CAT], BM.seq_no AS [BMP SEQ], OL.unit_price AS PRICE, OH.oe_po_no AS PO, 
                      IM.item_note_3 AS [ITEM NOTE], CONVERT(varchar, OL.picked_dt, 101) AS PICKED, OL.ord_type AS [ORDER TYPE], OH.slspsn_no AS SALES, 
                      MAX(SH.ship_dt) AS [LAST MALVERN SHIPPED DATE], IL.qty_on_hand AS QOH
FROM         dbo.oeordlin_sql AS OL INNER JOIN
                      dbo.oeordhdr_sql AS OH ON OH.ord_no = OL.ord_no INNER JOIN
                      dbo.imitmidx_sql AS IM ON OL.item_no = IM.item_no INNER JOIN
                      dbo.Z_IMINVLOC AS IL ON OL.item_no = IL.item_no LEFT OUTER JOIN
                      dbo.bmprdstr_sql AS BM ON IM.item_no = BM.item_no LEFT OUTER JOIN
                      dbo.ARSHTTBL AS SH ON LTRIM(OL.ord_no) = SH.ord_no AND OL.item_no = SH.filler_0001 AND SH.void_fg IS NULL
WHERE     (OH.user_def_fld_5 <> 'TEST' OR
                      OH.user_def_fld_5 IS NULL) AND (OH.ord_type = 'O') AND (IM.item_note_1 = 'ch' OR
                      IM.item_note_1 = 'Ch' OR
                      IM.item_note_1 = 'CH' OR
                      IM.item_note_1 = 'CHD') AND (NOT (OL.prod_cat = '036' OR
                      OL.prod_cat = '037' OR
                      OL.prod_cat = '336' OR
                      OL.prod_cat = 'AP'))
GROUP BY CONVERT(varchar, OH.shipping_dt, 101), LTRIM(OH.ord_no), LTRIM(OH.cus_no), OH.ship_to_name, OL.qty_ordered, OL.item_no, IM.prod_cat, 
                      OL.line_seq_no, IM.item_desc_1, IM.item_desc_2, BM.qty_per_par, OL.qty_ordered * BM.qty_per_par, BM.comp_item_no, BM.seq_no, OL.unit_price, 
                      OH.oe_po_no, IM.item_note_3, CONVERT(varchar, OL.picked_dt, 101), OL.ord_type, OH.slspsn_no, IL.qty_on_hand