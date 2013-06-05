SELECT   TOP (99.999999) PERCENT IM.item_no AS [ITEM],  IM2.item_desc_1 AS [DESCR], CAST(IM.qty_on_hand AS INT)AS [QOH],  NULL AS [QTY], NULL AS [SHP OR RECV DT], 
		NULL AS [ORD#], NULL AS [PO/SLS],
      
	       NULL AS [VEND/CUS],  
                      NULL AS [ORD DT], 
                       NULL AS [CONTAINER], 
                      NULL AS [CONT. SHP TO], NULL AS [XFER TO], IM.prod_cat AS [PROD CAT]
                      
FROM Z_IMINVLOC AS IM INNER JOIN IMITMIDX_SQL AS IM2 ON IM2.item_no = IM.item_no
WHERE  IM.item_no IN 
(SELECT IM2.item_no
FROM   imitmidx_sql AS IM2
WHERE IM2.item_note_1 LIKE '%CH%' AND activity_cd = 'A'
)

UNION ALL

SELECT    TOP (99.999999) PERCENT PL.item_no AS [ITEM NAME], '' AS [ITEM DESCRIPTION],  NULL AS [QOH],  CAST(PL.qty_ordered as int) AS [QTY], CASE WHEN PL.user_def_fld_2 is null THEN (convert(varchar(10),DATEADD(day,60,PH.ord_dt),101)) ELSE PL.user_def_fld_2 END  AS [SHP/RECV DT] /*Dallas ETA*/,
						 CAST(LTRIM(SUBSTRING(PL.ord_no, 1, 6)) AS INT) 
                      AS [ORDER], 'PO' AS [PO/SLS],
                      
					  AP.vend_name AS [VEND/CUS],  
					 convert(varchar(10), PH.ord_dt,101) AS [ORDER DATE], 
                       PL.user_def_fld_1 AS [CONTAINER INFO], 
                      PL.user_def_fld_3 AS [Container Ship To], PS.ship_to_desc AS [TRANSFER TO], IM.prod_cat AS [PROD CAT]
FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.Z_IMINVLOC AS IM ON IM.item_no = PL.item_no INNER JOIN
                      dbo.imitmidx_sql AS IM2 ON IM2.item_no = PL.item_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
WHERE     (PL.qty_received <= PL.qty_ordered) AND (PL.qty_ordered <> PL.qty_received) AND ((LTRIM(PL.vend_no) IN ('1697', '8830', '9516', '1648', '91202', 
                      '8859', '9523', '9533', '1620', '1613', '23077', '50', '1717')) OR IM2.item_note_1 LIKE '%CH%') AND PH.ord_dt > '04/01/2010'  

UNION ALL 

SELECT  TOP (99.999999) PERCENT OL.item_no AS [ITEM NAME],  '' AS [ITEM_DESCRIPTION], NULL AS [QOH],  (CAST(OL.qty_ordered AS INT) * -1) AS [QTY], convert(varchar(10),OH.shipping_dt,101) AS [SHP/RECV DT], 
		RTRIM(LTRIM(OH.ord_no)) AS [ORDER], 'SALE' AS [PO/SLS],
      
					  OH.ship_to_name AS [VEND/CUS],  
                      (convert(varchar(10),OH.entered_dt,101)) AS [ORDER DATE], 
                       NULL AS [CONTAINER INFO], 
                      NULL AS [Container Ship To], NULL AS [TRANSFER TO], OL.prod_cat AS [PROD CAT]
                      
FROM   OEORDHDR_SQL AS OH INNER JOIN OEORDLIN_SQL AS OL ON OL.ord_no = OH.ord_no INNER JOIN 
		IMITMIDX_SQL AS IM2 ON IM2.item_no = OL.item_no
WHERE  OL.item_no IN 
(SELECT IM2.item_no
FROM   imitmidx_sql AS IM2
WHERE IM2.item_note_1 LIKE '%CH%' AND activity_cd = 'A'
)

