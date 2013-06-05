SELECT     TOP (99.999999) PERCENT BM.item_no AS [PARENT ITEM NAME], NULL AS [PARENT QTY], BM.comp_item_no AS [COMPONENT ITEM NAME], NULL 
                      AS [QTY PER PAR], CAST(IM.qty_on_hand AS INT) AS [QOH], NULL AS [QTY], NULL AS [SHP OR RECV DT], NULL AS [ORD#], NULL AS [PO/SLS], NULL 
                      AS [VEND/CUS], NULL AS [ORD DT], NULL AS [CONTAINER], NULL AS [CONT. SHP TO], NULL AS [XFER TO], IM.prod_cat AS [PROD CAT], NULL 
                      AS [CUS NO], IM2.item_note_1 AS [CH], '' AS [STORE]
FROM         Z_IMINVLOC AS IM INNER JOIN
                      IMITMIDX_SQL AS IM2 ON IM2.item_no = IM.item_no LEFT OUTER JOIN
                      bmprdstr_sql AS BM ON BM.comp_item_no = IM.item_no
WHERE     IM.item_no IN
                          (SELECT     IM2.item_no
                            FROM          imitmidx_sql AS IM2
                            WHERE      (IM2.item_note_1 LIKE '%CH%') OR
                                                   (IM2.prod_cat = 'AP') OR
                                                   (IM2.pur_or_mfg = 'P' AND (item_no IN
                                                       (SELECT     item_no
                                                         FROM          oelinhst_sql
                                                         WHERE      ltrim(oelinhst_sql.cus_no) IN ('1575', '23033', '4227', '22056', '25166', '122523'))) AND activity_cd = 'A') OR
                                                   (IM2.pur_or_mfg = 'P' AND (item_no IN
                                                       (SELECT     item_no
                                                         FROM          oeordlin_sql
                                                         WHERE      ltrim(oeordlin_sql.cus_no) IN ('1575', '23033', '4227', '22056', '25166', '122523'))) AND activity_cd = 'A'))
UNION ALL
SELECT     TOP (99.999999) PERCENT PL.item_no AS [PARENT ITEM NAME], NULL AS [PARENT QTY], PL.item_no AS [ITEM NAME], NULL 
                      AS [QTY PER PAR], NULL AS [QOH], CAST(PL.qty_ordered AS int) AS [QTY], CASE WHEN NOT (PL.user_def_fld_2 IS NULL) 
                      THEN PL.user_def_fld_2 WHEN PL.user_def_fld_2 IS NULL AND NOT (PL.extra_8 IS NULL) THEN CONVERT(varchar(10), DATEADD(day, 30, 
                      PL.extra_8), 101) ELSE CONVERT(varchar(10), DATEADD(DAY, 90, PH.ord_dt), 101) END AS [SHP/RECV DT]/*Dallas ETA*/ , 
                      CAST(LTRIM(SUBSTRING(PL.ord_no, 1, 6)) AS INT) AS [ORDER], 'PO' AS [PO/SLS], AP.vend_name AS [VEND/CUS], CONVERT(varchar(10), PH.ord_dt, 
                      101) AS [ORDER DATE], PL.user_def_fld_1 AS [CONTAINER INFO], PL.user_def_fld_3 AS [Container Ship To], PS.ship_to_desc AS [TRANSFER TO], 
                      IM.prod_cat AS [PROD CAT], NULL AS [CUS NO], IM2.item_note_1 AS [CH], '' AS [STORE]
FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.Z_IMINVLOC AS IM ON IM.item_no = PL.item_no INNER JOIN
                      dbo.imitmidx_sql AS IM2 ON IM2.item_no = PL.item_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
WHERE     (PL.qty_received <= PL.qty_ordered) AND (PL.qty_ordered <> PL.qty_received) AND ((LTRIM(PL.vend_no) IN ('1697', '8830', '9516', '1648', '91202', 
                      '8859', '9523', '9533', '1620', '1613', '23077', '50', '1717', '9703')) OR
                      ((IM2.item_note_1 LIKE '%CH%') OR
                      (IM2.prod_cat = 'AP') OR
                      (IM2.pur_or_mfg = 'P' AND IM2.item_no IN
                          (SELECT     item_no
                            FROM          oelinhst_sql
                            WHERE      ltrim(oelinhst_sql.cus_no) IN ('1575', '23033', '4227', '22056', '25166', '122523'))) OR
                      (IM2.pur_or_mfg = 'P' AND IM2.item_no IN
                          (SELECT     item_no
                            FROM          oeordlin_sql
                            WHERE      ltrim(oeordlin_sql.cus_no) IN ('1575', '23033', '4227', '22056', '25166', '122523')))) AND activity_cd = 'A') AND 
                      PH.ord_dt > '04/01/2010'
UNION ALL
SELECT     TOP (99.999999) PERCENT OL.item_no AS [PARENT ITEM NAME], OL.qty_ordered AS [PARENT QTY], BM.comp_item_no AS [COMPONENT ITEM NAME],
                       BM.qty_per_par AS [QTY PER PAR], NULL AS [QOH], (CAST(OL.qty_ordered AS INT) * BM.qty_per_par * - 1) AS [QTY], CONVERT(varchar(10), 
                      OH.shipping_dt, 101) AS [SHP/RECV DT], RTRIM(LTRIM(OH.ord_no)) AS [ORDER], 'SALE' AS [PO/SLS], OH.ship_to_name AS [VEND/CUS], 
                      (CONVERT(varchar(10), OH.entered_dt, 101)) AS [ORDER DATE], NULL AS [CONTAINER INFO], NULL AS [Container Ship To], NULL AS [TRANSFER TO], 
                      OL.prod_cat AS [PROD CAT], OH.cus_no AS [CUS NO], IM2.item_note_1 AS [CH], OH.cus_alt_adr_cd AS [STORE]
FROM         OEORDHDR_SQL AS OH INNER JOIN
                      OEORDLIN_SQL AS OL ON 
                      OL.ord_no = OH.ord_no /*LEFT OUTER JOIN
                      dbo.ARSHTTBL ON LTRIM(OL.ord_no) = CAST(dbo.ARSHTTBL.ord_no AS int) AND OL.item_no = dbo.ARSHTTBL.filler_0001 AND 
                      dbo.ARSHTTBL.void_fg IS NULL */ INNER
                       JOIN
                      IMITMIDX_SQL AS IM2 ON IM2.item_no = OL.item_no LEFT OUTER JOIN
                      bmprdstr_sql AS BM ON BM.item_no = OL.item_no
WHERE     OL.item_no IN
                          (SELECT     IM2.item_no
                            FROM          imitmidx_sql AS IM2
                            WHERE      (IM2.item_note_1 LIKE '%CH%') OR
                                                   (IM2.prod_cat = 'AP') OR
                                                   (IM2.pur_or_mfg = 'P' AND (item_no IN
                                                       (SELECT     item_no
                                                         FROM          oelinhst_sql
                                                         WHERE      ltrim(oelinhst_sql.cus_no) IN ('1575', '23033', '4227', '22056', '25166', '122523'))) AND activity_cd = 'A') OR
                                                   (IM2.pur_or_mfg = 'P' AND (item_no IN
                                                       (SELECT     item_no
                                                         FROM          oeordlin_sql
                                                         WHERE      ltrim(oeordlin_sql.cus_no) IN ('1575', '23033', '4227', '22056', '25166', '122523'))) AND activity_cd = 'A')) OR
                      (IM2.prod_cat = 'AP') AND OH.ord_type = 'O'
                      
UNION ALL

SELECT     TOP (99.999999) PERCENT OL.item_no AS [ITEM NAME], OL.qty_ordered AS [PARENT QTY], 'PARENT' AS [COMPONENT ITEM NAME], NULL AS [QTY PER PAR], NULL AS [QOH], (CAST(OL.qty_ordered AS INT) * - 1) AS [QTY], 
                      CONVERT(varchar(10), OH.shipping_dt, 101) AS [SHP/RECV DT], RTRIM(LTRIM(OH.ord_no)) AS [ORDER], 'SALE' AS [PO/SLS], 
                      OH.ship_to_name AS [VEND/CUS], (CONVERT(varchar(10), OH.entered_dt, 101)) AS [ORDER DATE], NULL AS [CONTAINER INFO], NULL 
                      AS [Container Ship To], NULL AS [TRANSFER TO], OL.prod_cat AS [PROD CAT], OH.cus_no AS [CUS NO], IM2.item_note_1 AS [CH], OH.cus_alt_adr_cd AS [STORE]
FROM         OEORDHDR_SQL AS OH INNER JOIN
                      OEORDLIN_SQL AS OL ON 
                      OL.ord_no = OH.ord_no /*LEFT OUTER JOIN
                      dbo.ARSHTTBL ON LTRIM(OL.ord_no) = CAST(dbo.ARSHTTBL.ord_no AS int) AND OL.item_no = dbo.ARSHTTBL.filler_0001 AND 
                      dbo.ARSHTTBL.void_fg IS NULL */ INNER
                       JOIN
                      IMITMIDX_SQL AS IM2 ON IM2.item_no = OL.item_no
WHERE     OL.item_no IN
                          (SELECT     IM2.item_no
                            FROM          imitmidx_sql AS IM2
                            WHERE      (IM2.item_note_1 LIKE '%CH%') OR
                                                   (IM2.prod_cat = 'AP') OR
                                                   (IM2.pur_or_mfg = 'P' AND (item_no IN
                                                       (SELECT     item_no
                                                         FROM          oelinhst_sql
                                                         WHERE      ltrim(oelinhst_sql.cus_no) IN ('1575', '23033', '4227', '22056', '25166', '122523'))) AND activity_cd = 'A') OR
                                                   (IM2.pur_or_mfg = 'P' AND (item_no IN
                                                       (SELECT     item_no
                                                         FROM          oeordlin_sql
                                                         WHERE      ltrim(oeordlin_sql.cus_no) IN ('1575', '23033', '4227', '22056', '25166', '122523'))) AND activity_cd = 'A')) 
                      /*AND 
                                                   (ARSHTTBL.ord_no IS NULL) AND NOT OH.ord_no IN
                                                       ((SELECT     OL.ord_no
                                                           FROM         OEORDLIN_SQL AS OL
                                                           WHERE     OL.user_def_fld_2 = 'SHIPPED'))) */ AND
                       OH.ord_type = 'O'