--ALTER VIEW Z_OPEN_OPS_ToPrint AS  

--Created:	5/1/11	 By:	AA
--Last Updated:	5/9/12	 By:	BG
--Purpose:	View for Production Ordering Report
--Last Change:  Added Nolock hint to prevent query from applying locks, trying to reduce blocking from the schedule refreshes


SELECT DISTINCT 
             CASE WHEN AUD_DTS.aud_dt_min IS NULL THEN OH.entered_dt 
                    ELSE AUD_DTS.aud_dt_min END AS PRINTED
            ,AUD_DTS.aud_dt_max AS [LAST CHANGE]
            ,CASE WHEN AUD_LAST.aud_action = 'A' THEN 'ADD' 
                    WHEN AUD_LAST.aud_action = 'C' THEN 'UPD' 
                    ELSE NULL END AS [CHANGE TYPE]
            ,AUD_LAST.user_name AS [USER]
            ,OH.mfg_loc AS [ORDER LOC]
            ,OL.loc AS [ITEM LOC]
            ,OH.shipping_dt AS [SHIP DATE]
            ,YEAR(OH.shipping_dt) AS [SHIP YEAR]
            ,MONTH(OH.shipping_dt) AS [SHIP MONTH]
            ,LTRIM(OH.ord_no) AS [ORDER]
            ,LTRIM(OH.cus_no) AS CUST
            ,OH.ship_to_name AS [SHIP TO]
            ,OL.qty_ordered AS [PARENT QTY]
            ,OL.item_no AS [ITEM]
            ,CASE WHEN CMT.line_seq_no IS NULL THEN 'N/A' 
                    ELSE 'See Comments' END AS COMMENTS
            ,OH.ship_instruction_1 AS SHIP1
            ,OH.ship_instruction_2 AS SHIP2
            ,OL.prod_cat AS CAT
            ,OL.line_seq_no AS [LINE SEQ]
            ,OL.item_desc_1 AS DESC1
            ,OL.item_desc_2 AS DESC2
            ,CASE WHEN IM.drawing_revision_no IS NULL THEN rtrim(IM.drawing_release_no) 
                    ELSE rtrim(IM.drawing_release_no) + '-' + IM.drawing_revision_no END AS DRAWING
            --,CASE WHEN BM.qty_per_par IS NULL THEN 0 
            --      ELSE BM.qty_per_par END AS [QTY PER PARENT]
            --,CASE WHEN BM.qty_per_par IS NULL THEN 0 ELSE (OL.qty_ordered * BM.qty_per_par) END AS [COMP QTY]
            --,BM.comp_item_no AS [COMP ITEM]
            --,CASE WHEN 
            --                (SELECT IM.prod_cat
  --                     FROM IMITMIDX_SQL IM
  --                    WHERE IM.item_no = BM.comp_item_no) IS NULL THEN IM.prod_cat 
  --            ELSE    
            --                (SELECT IM.prod_cat
  --                     FROM IMITMIDX_SQL IM
  --                    WHERE IM.item_no = BM.comp_item_no) END AS [COMP CAT]
            --,BM.seq_no AS [BMP SEQ]
            ,OH.oe_po_no AS PO
            ,OH.slspsn_no AS SALES
            ,OH.ship_via_cd AS [SHIP VIA]
            
FROM  dbo.oeordlin_sql AS OL WITH(NOLOCK) INNER JOIN
        dbo.oeordhdr_sql AS OH WITH(NOLOCK) ON OH.ord_no = OL.ord_no INNER JOIN
        dbo.imitmidx_sql AS IM WITH(NOLOCK) ON OL.item_no = IM.item_no LEFT OUTER JOIN
        --dbo.bmprdstr_sql AS BM ON OL.item_no = BM.item_no LEFT OUTER JOIN
                  (SELECT ord_no, line_seq_no
                     FROM  dbo.OELINCMT_SQL AS CMT WITH(NOLOCK)
              WHERE  (ord_type = 'O') AND (cmt NOT LIKE 'Shipment:%') AND (cmt NOT LIKE 'Shipment Date:%') AND (cmt NOT LIKE 'Shipment Type:%') AND (cmt NOT LIKE 'Trailer:%') AND (cmt NOT LIKE 'Pallet:%') 
                              AND (cmt NOT LIKE '%Tracking No:%') AND (cmt NOT LIKE 'End Shipment:%') AND (cmt NOT LIKE '%Carton:%') AND (cmt NOT LIKE 'Color Length%') AND (cmt NOT LIKE 'Height%') 
                              AND (cmt NOT LIKE 'FOOD  ORANGECol%') AND (cmt <> 'Delivery Day Within 10 Days') AND (cmt NOT LIKE 'ColorBLKGLS%') AND (cmt NOT LIKE '%Unit of Dim.IN%') AND (cmt NOT LIKE '%samsclub%') 
                              AND (cmt NOT LIKE '%uswalmart%') AND (cmt NOT LIKE '%us.wal%') AND (cmt NOT LIKE '%stores.us%') AND (cmt NOT LIKE '%@heb.com%') AND (cmt NOT LIKE '%ussam%') 
                              AND (cmt NOT LIKE '%.000%')) AS CMT ON CMT.ord_no = OH.ord_no LEFT OUTER JOIN
                  (SELECT ord_no, MAX(aud_dt) AS aud_dt_max, MIN(aud_dt) AS aud_dt_min
                     FROM dbo.oehdraud_sql AS AO WITH(NOLOCK)
                    WHERE (NOT (user_def_fld_5 IN ('', 'TEST'))) AND (aud_action IN ('A', 'C')) 
                    GROUP BY ord_no) AS AUD_DTS ON AUD_DTS.ord_no = OH.ord_no LEFT OUTER JOIN
            (SELECT ord_no, MAX(aud_action) AS aud_action, MAX(user_name) AS user_name, MAX(aud_dt) AS aud_Dt
                     FROM dbo.oehdraud_sql AS AO WITH(NOLOCK)
                    WHERE (NOT (user_def_fld_5 IN ('', 'TEST'))) AND (aud_action IN ('A', 'C'))
                    GROUP BY ord_no) AS AUD_LAST ON AUD_LAST.ord_no = OH.ord_no AND AUD_LAST.aud_dt = AUD_DTS.aud_dt_max LEFT OUTER JOIN
            dbo.wsPikPak AS PP WITH(NOLOCK) ON PP.Ord_no = OH.ord_no AND PP.Line_no = OL.line_no
            
WHERE     (OH.ord_type = 'O') AND (LTRIM(OH.cus_no) NOT IN ('23033', '24033', '32300', '32401')) AND (PP.Shipped <> 'Y' OR PP.Shipped IS NULL) AND (OL.shipped_dt IS NULL) 
            AND (NOT (OH.user_def_fld_5 IN ('', 'TEST'))) AND (NOT (OH.user_def_fld_5 IS NULL)) AND (OL.loc NOT IN ('CAN', 'IN', 'BR')) 
            --AND OH.ord_no = ' 2027168'
                      
GROUP BY OH.entered_dt, AUD_DTS.aud_dt_min, AUD_LAST.aud_dt, AUD_LAST.aud_action, AUD_LAST.user_name, AUD_DTS.aud_dt_max, OH.mfg_loc, OL.loc, 
                      OH.shipping_dt, OH.ord_no, OH.cus_no, OH.ship_to_name, OH.ship_to_addr_2, OH.ship_to_addr_4, OL.qty_ordered, OL.item_no, CMT.line_seq_no, 
                      OH.ship_instruction_1, OH.ship_instruction_2, OL.prod_cat, OL.line_seq_no, OL.item_desc_1, OL.item_desc_2, IM.drawing_release_no, IM.drawing_revision_no, 
                      OL.qty_ordered, OL.unit_price, OH.oe_po_no, IM.item_note_3, OH.ord_dt, OL.picked_dt, OL.ord_type, OH.slspsn_no, OH.ship_via_cd
                      --BM.qty_per_par, BM.comp_item_no, BM.seq_no


