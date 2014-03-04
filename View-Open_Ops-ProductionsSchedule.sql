--ALTER VIEW Z_OPEN_OPS AS
--Created:	8/23/12	 By:	BG
--Last Updated:	12/17/13	 By:	BG
--Purpose:	Ops Schedule
--Last changes: 1) Changed wspikpak lookup to only remove lines that have a total qty shipped >= total qty ordered

SELECT DISTINCT 
                      CASE WHEN AUD_DTS.aud_dt_min IS NULL THEN OH.entered_dt ELSE AUD_DTS.aud_dt_min END AS PRINTED, 
                      AUD_DTS.aud_dt_max AS [LAST CHANGE], 
                      CASE WHEN AUD_LAST.aud_action = 'A' THEN 'ADD' WHEN AUD_LAST.aud_action = 'C' THEN 'UPD' ELSE NULL END AS [CHANGE TYPE], 
                      AUD_LAST.user_name AS [USER], OH.mfg_loc AS [ORDER LOC], OL.loc AS [ITEM LOC], OH.shipping_dt AS [SHIP DATE], LTRIM(OH.ord_no) AS [ORDER], 
                      LTRIM(OH.cus_no) AS CUST, OH.ship_to_name AS [SHIP TO], OL.qty_ordered AS [PARENT QTY], OL.item_no AS ITEM, '' AS KIT, CASE WHEN CMT.line_seq_no IS NULL
                       THEN 'N/A' ELSE 'See Comments' END AS COMMENTS, OH.ship_instruction_1 AS SHIP1, OH.ship_instruction_2 AS SHIP2, IM.prod_cat AS CAT, 
                      OL.line_no AS [LINE SEQ], OL.item_desc_1 AS DESC1, OL.item_desc_2 AS DESC2, CASE WHEN IM.drawing_revision_no IS NULL THEN rtrim(IM.drawing_release_no) 
                      ELSE rtrim(IM.drawing_release_no) + '-' + IM.drawing_revision_no END AS DRAWING, CASE WHEN BM.qty_per_par IS NULL 
                      THEN 0 ELSE BM.qty_per_par END AS [QTY PER PARENT], CASE WHEN BM.qty_per_par IS NULL THEN 0 ELSE (OL.qty_ordered * BM.qty_per_par) 
                      END AS [COMP QTY], BM.comp_item_no AS [COMP ITEM], CASE WHEN
                          (SELECT     IM.prod_cat
                            FROM          IMITMIDX_SQL IM
                            WHERE      IM.item_no = BM.comp_item_no) IS NULL THEN IM.prod_cat ELSE
                          (SELECT     IM.prod_cat
                            FROM          IMITMIDX_SQL IM
                            WHERE      IM.item_no = BM.comp_item_no) END AS [COMP CAT], BM.seq_no AS [BMP SEQ], OH.oe_po_no AS PO, OL.ord_type AS [ORDER TYPE], 
                      OH.slspsn_no AS SALES, '' AS [LAST MALVERN SHIPPED DATE], OH.ship_via_cd AS [SHIP VIA], INVFW.qty_on_hand AS QOH, INVWS.qty_on_hand AS [QOH WS], 
                      INV.qty_on_hand AS QOH_ALL_LOC
FROM         dbo.oeordlin_sql AS OL WITH (NOLOCK) INNER JOIN
                      dbo.oeordhdr_sql AS OH WITH (NOLOCK) ON OH.ord_no = OL.ord_no INNER JOIN
                      dbo.imitmidx_sql AS IM WITH (NOLOCK) ON OL.item_no = IM.item_no INNER JOIN
                      dbo.Z_IMINVLOC AS INV WITH (NOLOCK) ON INV.item_no = IM.item_no INNER JOIN
                      dbo.Z_IMINVLOC_FW_LOCS AS INVFW WITH (NOLOCK) ON INVFW.item_no = IM.item_no INNER JOIN
                      dbo.iminvloc_sql AS INVWS WITH (NOLOCK) ON INVWS.item_no = IM.item_no LEFT OUTER JOIN
                      dbo.bmprdstr_sql AS BM WITH (NOLOCK) ON OL.item_no = BM.item_no LEFT OUTER JOIN
                      dbo.OELINCMT_SQL AS CMT WITH (NOLOCK) ON CMT.ord_no = OH.ord_no LEFT OUTER JOIN
                          (SELECT     ord_no, MAX(aud_dt) AS aud_dt_max, MIN(aud_dt) AS aud_dt_min
                            FROM          dbo.oehdraud_sql AS AO WITH (NOLOCK)
                            WHERE      (NOT (user_def_fld_5 IN ('', 'TEST'))) AND (aud_action IN ('A', 'C'))
                            GROUP BY ord_no) AS AUD_DTS ON AUD_DTS.ord_no = OH.ord_no LEFT OUTER JOIN
                          (SELECT     ord_no, MAX(aud_action) AS aud_action, MAX(user_name) AS user_name, MAX(aud_dt) AS aud_Dt
                            FROM          dbo.oehdraud_sql AS AO WITH (NOLOCK)
                            WHERE      (NOT (user_def_fld_5 IN ('', 'TEST'))) AND (aud_action IN ('A', 'C'))
                            GROUP BY ord_no) AS AUD_LAST ON AUD_LAST.ord_no = OH.ord_no AND AUD_LAST.aud_Dt = AUD_DTS.aud_dt_max 
                     LEFT OUTER JOIN (SELECT SUM(QTY) AS SumQty, ord_no, line_no	
							    FROM wspikpak WITH (NOLOCK)
								WHERE  shipped = 'Y'
								GROUP BY ord_no, line_no) AS PP ON PP.Line_no = OL.line_no AND pp.ord_no = OL.ord_no 
WHERE     (OH.ord_type = 'O') AND (LTRIM(OH.cus_no) NOT IN ('23033', '24033', '32300')) 
			AND (OL.shipped_dt IS NULL) 
			AND (NOT (OH.user_def_fld_5 IN ('', 'TEST'))) 
			AND (NOT (OH.user_def_fld_5 IS NULL)) 
			AND (OL.loc NOT IN ('CAN','IN', 'BR', 'IT')) AND (INVWS.loc = 'WS')
			--If no shipment record or if total qty shipped < total qty ordered (split shipped line)
			AND (pp.SumQty is null OR pp.SumQty < OL.tot_qty_ordered)
			--Test
			--AND OH.ord_no = ' 2034460'
GROUP BY OH.entered_dt, AUD_DTS.aud_dt_min, AUD_LAST.aud_Dt, AUD_LAST.aud_action, AUD_LAST.user_name, AUD_DTS.aud_dt_max, 
		OH.mfg_loc, OL.loc, OH.shipping_dt, OH.ord_no, OH.cus_no, OH.ship_to_name, OH.ship_to_addr_2, OH.ship_to_addr_4, 
		OL.qty_ordered, OL.item_no, CMT.line_seq_no, OH.ship_instruction_1, OH.ship_instruction_2, IM.prod_cat, OL.line_no, 
		OL.item_desc_1, OL.item_desc_2, IM.drawing_release_no, IM.drawing_revision_no, BM.qty_per_par, OL.qty_ordered, 
		BM.comp_item_no, BM.seq_no, OL.unit_price, OH.oe_po_no, IM.item_note_3, OH.ord_dt, OL.picked_dt, OL.ord_type, 
		OH.slspsn_no, OH.ship_via_cd, INV.qty_on_hand, INVWS.qty_on_hand, INVFW.qty_on_hand


--Add 5 more levels