--ALTER VIEW BG_Inventory_Projections_CR_Only AS

SELECT DISTINCT TOP 100 PERCENT  Item, ItemDesc1, ItemDesc2, [PO/SLS], 
		CAST([SHP OR RECV DT] AS DATETIME) AS [SHP OR RECV DT], 
		[QTY (QOH/QTY SLS/QTY REC)], [PROJ QOH], 
		IM.item_note_3 AS QPS, ORD#, [VEND/CUS], [ORD DT], 
		CONTAINER, [CONT. SHP TO], [XFER TO], [PROD CAT], [CUS#/VEND#], 
		CH, STORE, [PARENT ITEM (ONLY ON SALES)], OrdType2, 
		CASE WHEN ESS IS NULL THEN 0 
			WHEN ISNUMERIC(ESS) = 0 THEN 0 
			ELSE ESS 
		END AS ESS, 
		dbo.fn_BG_WMProjection(IM.item_no) AS [WM Forecast], 
		usage_ytd, 
		[ParentFlag] AS [P/S/C Fg],
		'' AS [NC], IM.item_note_5 AS n5,
		CASE WHEN OH.ship_instruction_1 IS NULL THEN 'N/A'
			 ELSE OH.ship_instruction_1
		END AS [WM GO/Ship Instr 1]
FROM  dbo.imitmidx_sql IM JOIN
	(
	-----------------
	--QOH Parents 
	-----------------
	SELECT IM2.item_no AS Item, IM2.item_desc_1 AS ItemDesc1, IM2.item_desc_2 AS ItemDesc2, 'QOH' AS [PO/SLS], 
	CONVERT(varchar(10), GETDATE(), 101) AS [SHP OR RECV DT], IM.qty_on_hand AS [QTY (QOH/QTY SLS/QTY REC)], '' AS [PROJ QOH], 
	'QOH' AS ORD#, 'QOH' AS [VEND/CUS], 'QOH' AS [ORD DT],'QOH' AS CONTAINER, 'QOH' AS [CONT. SHP TO], 'QOH' AS [XFER TO], 
	IM.prod_cat AS [PROD CAT], NULL AS [CUS#/VEND#], IM2.item_note_1 AS CH,'QOH' AS STORE, 'QOH' AS [PARENT ITEM (ONLY ON SALES)], 
	IM2.item_note_4 AS ESS, IM2.extra_10 AS usage_ytd, 
	'' AS [OrdType2], IM2.extra_1 AS 'ParentFlag', IM2.item_note_5
	FROM   dbo.Z_IMINVLOC AS IM 
			INNER JOIN  dbo.imitmidx_sql AS IM2 ON IM2.item_no = IM.item_no 
			LEFT OUTER JOIN
					  (SELECT PL.item_no
					   FROM   dbo.poordlin_sql AS PL 
							JOIN dbo.poordhdr_sql AS PH ON PH.ord_no = PL.ord_no
					   WHERE (PH.ord_dt > DATEADD(DAY, - 365, GETDATE())) AND (PH.ord_status <> 'X')) AS PURCH_LAST_YR ON 
				  PURCH_LAST_YR.item_no = IM2.item_no
			--LEFT OUTER JOIN Z_IMINVLOC_USAGE USG ON USG.item_no = IM.item_no
	WHERE (IM2.prod_cat IN ('036', '037', '111', '336', '102')) 
		  --AND IM2.item_no = 'Interior Label'
		  
	UNION ALL

	-----------------
	--QOH Components
	-----------------
	SELECT  BMIM.item_no AS Item, BMIM.item_desc_1 AS ItemDesc1, BMIM.item_desc_2 AS ItemDesc2, 'QOH' AS [PO/SLS], 
			CONVERT(varchar(10), GETDATE(), 101) AS [SHP OR RECV DT], BMINV.qty_on_hand AS [QTY (QOH/QTY SLS/QTY REC)], '' AS [PROJ QOH], 
			'QOH' AS ORD#, 'QOH' AS [VEND/CUS], 'QOH' AS [ORD DT],'QOH' AS CONTAINER, 'QOH' AS [CONT. SHP TO], 'QOH' AS [XFER TO], BMIM.prod_cat AS [PROD CAT], 
			NULL AS [CUS#/VEND#], BMIM.item_note_1 AS CH,'QOH' AS STORE, 'QOH' AS [PARENT ITEM (ONLY ON SALES)], BMIM.item_note_4 AS ESS, 
			BMIM.extra_10 AS usage_ytd, '' AS [OrdType2], BMIM.extra_1 AS 'ParentFlag', BMIM.item_note_5
	FROM  dbo.oeordhdr_sql AS OH INNER JOIN
				  dbo.oeordlin_sql AS OL ON OL.ord_no = OH.ord_no INNER JOIN
				  dbo.imitmidx_sql AS IM ON IM.item_no = OL.item_no JOIN
				  dbo.bmprdstr_sql AS BM ON BM.item_no = OL.item_no 
				  LEFT OUTER JOIN Z_IMINVLOC BMINV ON BMINV.item_no = BM.comp_item_no
				  LEFT OUTER JOIN dbo.imitmidx_sql AS BMIM ON BMIM.item_no = BM.comp_item_no
				  --LEFT OUTER JOIN Z_IMINVLOC_USAGE USG ON USG.item_no = BM.comp_item_no
	WHERE (OH.ord_type = 'O')  
			AND ((CAST(LTRIM(OL.ord_no) AS VARCHAR) + BMIM.item_no + CAST(CAST(OL.qty_to_ship AS INT) AS VARCHAR)) NOT IN
					  (SELECT CAST(LTRIM(Ord_no) AS VARCHAR) + item_no + CAST(SUM(Qty) AS VARCHAR) AS Expr1
					   FROM   dbo.wsPikPak
					   WHERE (Shipped = 'Y')
					   GROUP BY Ord_no, Item_no))
		   --All CR Items
		   AND (IM.prod_cat IN ('111', '036', '336', '102', '037'))
		   AND BMIM.prod_cat NOT IN ('038')
		   --Test
		   --AND BMIM.item_no = 'Interior Label'

	UNION ALL

	-----------------
	--PO All
	-----------------
	SELECT PL.item_no AS ITEM, IM2.item_desc_1 AS ItemDesc1, IM2.item_desc_2 AS ItemDesc2, 'PO' AS [PO/SLS], 
		CASE WHEN (PL.user_def_fld_2 IS NOT NULL AND LEN(PL.user_def_fld_2) = 10)  
			 THEN PL.user_def_fld_2 
			 WHEN (PL.user_def_fld_2 IS NULL OR LEN(PL.user_def_fld_2) != 10) AND (PL.extra_8 IS NOT NULL AND LEN(PL.extra_8) = 10 )
			 THEN CONVERT(varchar(10), DATEADD(day, 28, PL.extra_8), 101) 
			 WHEN (PL.user_Def_fld_2 IS NULL OR LEN(PL.user_def_fld_2) != 10) AND (PL.extra_8 IS NULL OR LEN(PL.extra_8) != 10) 
					AND LTRIM(PL.vend_no) IN  (SELECT vend_no
												FROM   BG_CH_Vendors) 
			 THEN CONVERT(varchar(10), DATEADD(DAY, 90, PH.ord_dt), 101)
			 WHEN PL.promise_dt IS NULL 
			 THEN CONVERT(varchar(10), DATEADD(DAY, 14, PH.ord_dt), 101)
			 ELSE CONVERT(varchar(10), PL.promise_dt, 101) 
		END AS [SHP/RECV DT], 
	CAST(PL.qty_remaining AS int) AS QTY, '' AS [PROJ QOH], CAST(LTRIM(SUBSTRING(PL.ord_no, 1, 6)) AS VARCHAR) 
				  AS [ORDER], AP.vend_name AS [VEND/CUS], CONVERT(varchar(10), PH.ord_dt, 101) AS [ORDER DATE], PL.user_def_fld_1 AS [CONTAINER INFO], PL.user_def_fld_3 AS [Container Ship To], PS.ship_to_desc AS [TRANSFER TO], IM2.prod_cat AS [PROD CAT], LTRIM(PH.vend_no) AS [CUS NO], IM2.item_note_1 AS CH, '' AS STORE, '' AS [PARENT ITEM], IM2.item_note_4 AS ESS, IM2.extra_10 AS usage_ytd, 
	'', IM2.extra_1 AS 'ParentFlag', IM2.item_note_5
	FROM  dbo.apvenfil_sql AS AP INNER JOIN
				  dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
				  dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
				  dbo.imitmidx_sql AS IM2 ON IM2.item_no = PL.item_no INNER JOIN
					  (SELECT DISTINCT PL.item_no
					   FROM   dbo.poordlin_sql AS PL INNER JOIN
									  dbo.poordhdr_sql AS PH ON PH.ord_no = PL.ord_no
							  LEFT OUTER JOIN dbo.Z_IMINVLOC_QALL QALL ON QALL.item_no = PL.item_no
					   WHERE (PH.ord_dt > DATEADD(DAY, - 365, GETDATE())) OR QALL.qty_allocated > 0) AS PURCH_LAST_YR 
					   ON PURCH_LAST_YR.item_no = IM2.item_no INNER JOIN
				  dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
				  dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
				  --LEFT OUTER JOIN Z_IMINVLOC_USAGE USG ON USG.item_no = IM2.item_no
	WHERE   (PL.qty_received < PL.qty_ordered AND PL.qty_released < PL.qty_ordered)
			AND PH.ord_status != 'X' AND PL.ord_status != 'X' 
			--All CR parents
			AND (IM2.prod_cat IN ('036', '037', '111', '336', '102'))
			--TEST
			--AND LTRIM(PH.ord_no) = '12589400'
	UNION ALL

	-----------------
	--OE Parents
	-----------------
	SELECT OL.item_no AS ITEM, IM2.item_desc_1 AS ItemDesc1, IM2.item_desc_2 AS ItemDesc2, 
				  CASE WHEN ltrim(OH.cus_no) = '999999' THEN 'STOCK'
				       ELSE 'SALE' 
				  END AS [PO/SLS], --CASE WHEN CONVERT(varchar(10), 
				  --OH.shipping_dt, 101) < GETDATE() THEN CONVERT(VARCHAR(10), DATEADD(day, 0, GETDATE()), 101) ELSE 
				  CONVERT(varchar(10),OH.shipping_dt, 101) --END 
				  AS [SHP/RECV DT], 
				  CASE WHEN ltrim(OH.cus_no) = '999999' THEN OL.qty_to_ship  
					   ELSE OL.qty_to_ship * - 1 
				  END AS QTY, 
				  '' AS [PROJ QOH], 
				  CAST(RTRIM(LTRIM(OH.ord_no)) AS VARCHAR) AS [ORDER], OH.ship_to_name AS [VEND/CUS], 
				  CONVERT(varchar(10), OH.entered_dt, 101) AS [ORDER DATE], NULL AS [CONTAINER INFO], NULL 
				  AS [Container Ship To], NULL AS [TRANSFER TO], OL.prod_cat AS [PROD CAT], LTRIM(OH.cus_no) AS [CUS NO], 
				  IM2.item_note_1 AS CH, OH.cus_alt_adr_cd AS STORE, OL.item_no AS [PARENT ITEM ON SALES ORD], IM2.item_note_4 AS ESS, 
				  IM2.extra_10 AS usage_ytd,
				  OH.user_def_fld_3, IM2.extra_1 AS 'ParentFlag', IM2.item_note_5
	FROM  dbo.oeordhdr_sql AS OH INNER JOIN
				  dbo.oeordlin_sql AS OL ON OL.ord_no = OH.ord_no INNER JOIN
				  dbo.imitmidx_sql AS IM2 ON IM2.item_no = OL.item_no LEFT OUTER JOIN
					  (SELECT DISTINCT PL.item_no
					   FROM   dbo.poordlin_sql AS PL INNER JOIN
									  dbo.poordhdr_sql AS PH ON PH.ord_no = PL.ord_no
					   WHERE (PH.ord_dt > DATEADD(DAY, - 365, GETDATE()))) AS PURCH_LAST_YR ON PURCH_LAST_YR.item_no = IM2.item_no
				  --LEFT OUTER JOIN Z_IMINVLOC_USAGE USG ON USG.item_no = IM2.item_no
	WHERE (OH.ord_type = 'O') 
					AND ((CAST(LTRIM(OL.ord_no) AS VARCHAR) + IM2.item_no + CAST(CAST(OL.qty_to_ship AS INT) AS VARCHAR)) NOT IN
					  (SELECT CAST(LTRIM(Ord_no) AS VARCHAR) + item_no + CAST(SUM(Qty) AS VARCHAR) AS Expr1
					   FROM   dbo.wsPikPak
					   WHERE (Shipped = 'Y')
					   GROUP BY Ord_no, Item_no))
					--Test
					--AND IM2.item_no = 'AB060 0300X9600'
					--All CR parents
					AND IM2.prod_cat IN ('036', '037', '111', '336', '102')

	UNION ALL

	-----------------
	--OE Components
	-----------------
	SELECT BM.comp_item_no AS ITEM, BMIM.item_desc_1 AS ItemDesc1, BMIM.item_desc_2 AS ItemDesc2, 
		  CASE WHEN ltrim(OH.cus_no) = '999999' THEN 'STOCK'
			   ELSE 'SALE' 
		   END AS [PO/SLS],  
		--CASE WHEN CONVERT(varchar(10), OH.shipping_dt, 101) < GETDATE() THEN CONVERT(VARCHAR(10), DATEADD(day, 0, GETDATE()), 101) 
			 --ELSE 
			 CONVERT(varchar(10), OH.shipping_dt, 101) --END 
			 AS [SHP/RECV DT], 
			 CASE WHEN ltrim(OH.cus_no) = '999999' THEN OL.qty_to_ship * BM.qty_per_par  
				  ELSE OL.qty_to_ship * BM.qty_per_par * - 1.00 
			 END AS QTY,
		'' AS [PROJ QOH], CAST(RTRIM(LTRIM(OH.ord_no)) AS VARCHAR) AS [ORDER], OH.ship_to_name AS [VEND/CUS], CONVERT(varchar(10), OH.entered_dt, 101) AS [ORDER DATE], NULL AS [CONTAINER INFO], 
	NULL  AS [Container Ship To], NULL AS [TRANSFER TO], BMIM.prod_cat AS [PROD CAT], LTRIM(OH.cus_no) AS [CUS NO], BMIM.item_note_1 AS CH, 
	 OH.cus_alt_adr_cd AS STORE, OL.item_no AS [PARENT ITEM ON SALES ORD], BMIM.item_note_4 AS ESS, 
	 BMIM.extra_10 AS usage_ytd, 
	 OH.user_def_Fld_3, BMIM.extra_1 AS 'ParentFlag', BMIM.item_note_5
	FROM  dbo.oeordhdr_sql AS OH INNER JOIN
				  dbo.oeordlin_sql AS OL ON OL.ord_no = OH.ord_no INNER JOIN
				  dbo.imitmidx_sql AS IM2 ON IM2.item_no = OL.item_no INNER JOIN
				  dbo.bmprdstr_sql AS BM ON BM.item_no = OL.item_no LEFT OUTER JOIN
					  (SELECT DISTINCT PL.item_no
					   FROM   dbo.poordlin_sql AS PL INNER JOIN
									  dbo.poordhdr_sql AS PH ON PH.ord_no = PL.ord_no
					   WHERE (PH.ord_dt > DATEADD(DAY, - 365, GETDATE()))) AS PURCH_LAST_YR ON PURCH_LAST_YR.item_no = BM.comp_item_no 
				  LEFT OUTER JOIN dbo.imitmidx_sql AS BMIM ON BMIM.item_no = BM.comp_item_no
				  --LEFT OUTER JOIN Z_IMINVLOC_USAGE USG ON USG.item_no = BMIM.item_no
	WHERE (OH.ord_type = 'O') 
			AND ((CAST(LTRIM(OL.ord_no) AS VARCHAR) + IM2.item_no + CAST(CAST(OL.qty_to_ship AS INT) AS VARCHAR)) NOT IN
					  (SELECT CAST(LTRIM(Ord_no) AS VARCHAR) + item_no + CAST(SUM(Qty) AS VARCHAR) AS Expr1
					   FROM   dbo.wsPikPak
					   WHERE (Shipped = 'Y')
					   GROUP BY Ord_no, Item_no))
		   --All CR parents
			AND IM2.prod_cat IN ('036', '037', '111', '336', '102')
			AND BMIM.prod_cat NOT IN ('038')
		   --Test
		    --AND BMIM.item_no = 'Interior Label'
	                   
	) AS HolyGrail ON IM.item_no = HolyGrail.Item
	LEFT OUTER JOIN oeordhdr_sql OH ON ltrim(OH.ord_no) = HolyGrail.[Ord#]
--WHERE   Item = 'Interior Label'
		--ltrim(OH.ord_no) not like '7%' OR OH.ord_no is null
ORDER BY Item, [SHP OR RECV DT]

/*  Old version replaced on 1/8/14:

SELECT TOP (100) PERCENT Item, ItemDesc1, ItemDesc2, [PO/SLS], [SHP OR RECV DT], [QTY (QOH/QTY SLS/QTY REC)], [PROJ QOH], ORD#, [VEND/CUS], [ORD DT], 
               CONTAINER, [CONT. SHP TO], [XFER TO], [PROD CAT], [CUS#/VEND#], CH, STORE, [PARENT ITEM (ONLY ON SALES)], CASE WHEN ESS IS NULL 
               THEN 0 WHEN ISNUMERIC(ESS) = 0 THEN 0 ELSE ESS END AS ESS, usage_ytd
FROM  (SELECT DISTINCT 
                              IM2.item_no AS Item, IM2.item_desc_1 AS ItemDesc1, IM2.item_desc_2 AS ItemDesc2, 'QOH' AS [PO/SLS], CONVERT(varchar(10), GETDATE(), 101) 
                              AS [SHP OR RECV DT], IM.qty_on_hand AS [QTY (QOH/QTY SLS/QTY REC)], '' AS [PROJ QOH], 'QOH' AS ORD#, 'QOH' AS [VEND/CUS], 'QOH' AS [ORD DT], 
                              'QOH' AS CONTAINER, 'QOH' AS [CONT. SHP TO], 'QOH' AS [XFER TO], IM.prod_cat AS [PROD CAT], NULL AS [CUS#/VEND#], IM2.item_note_1 AS CH, 
                              'QOH' AS STORE, 'QOH' AS [PARENT ITEM (ONLY ON SALES)], IM2.item_note_4 AS ESS, USG.usage_ytd
               FROM   dbo.Z_IMINVLOC AS IM 
						INNER JOIN dbo.imitmidx_sql AS IM2 ON IM2.item_no = IM.item_no
						INNER JOIN (SELECT PL.item_no
                                   FROM   dbo.poordlin_sql AS PL INNER JOIN
                                                  dbo.poordhdr_sql AS PH ON PH.ord_no = PL.ord_no
                                   WHERE (PH.ord_dt > DATEADD(DAY, - 365, GETDATE())) AND (PL.ord_status <> 'X')) AS PURCH_LAST_YR ON PURCH_LAST_YR.item_no = IM2.item_no
                        JOIN Z_IMINVLOC_USAGE USG ON USG.item_no = IM.item_no
               WHERE (IM2.prod_cat IN ('036', '037', '111', '336', '102')) 
               UNION ALL
               SELECT PL.item_no AS ITEM, IM2.item_desc_1 AS ItemDesc1, IM2.item_desc_2 AS ItemDesc2, 'PO' AS [PO/SLS], 
						CASE WHEN NOT (PL.user_def_fld_2 IS NULL) THEN PL.user_def_fld_2 
							 WHEN PL.user_def_fld_2 IS NULL AND NOT (PL.extra_8 IS NULL) AND LEN(PL.extra_8) = 10 THEN CONVERT(varchar(10), DATEADD(day, 28, PL.extra_8), 101) 
                             WHEN PL.user_Def_fld_2 IS NULL AND (PL.extra_8 IS NULL OR LEN(PL.extra_8) != 10) AND LTRIM(PL.vend_no) IN  (SELECT vend_no FROM   BG_CH_Vendors) THEN CONVERT(varchar(10), DATEADD(DAY, 90, PH.ord_dt), 101) 
                             ELSE CONVERT(varchar(10), DATEADD(DAY, 7, PH.ord_dt), 101) 
                        END AS [SHP/RECV DT], CAST(PL.qty_ordered AS int) AS QTY, '' AS [PROJ QOH], CAST(LTRIM(SUBSTRING(PL.ord_no, 1, 6)) AS VARCHAR)  
                              AS [ORDER], AP.vend_name AS [VEND/CUS], CONVERT(varchar(10), PH.ord_dt, 101) AS [ORDER DATE], PL.user_def_fld_1 AS [CONTAINER INFO], 
                              PL.user_def_fld_3 AS [Container Ship To], PS.ship_to_desc AS [TRANSFER TO], IM2.prod_cat AS [PROD CAT], LTRIM(PH.vend_no) AS [CUS NO], 
                              IM2.item_note_1 AS CH, '' AS STORE, '' AS [PARENT ITEM], IM2.item_note_4 AS ESS, USG.usage_ytd
               FROM  dbo.apvenfil_sql AS AP 
							INNER JOIN  dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no 
                            INNER JOIN dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no 
                            INNER JOIN dbo.imitmidx_sql AS IM2 ON IM2.item_no = PL.item_no 
                            INNER JOIN (SELECT DISTINCT PL.item_no
												 FROM   dbo.poordlin_sql AS PL INNER JOIN
													  dbo.poordhdr_sql AS PH ON PH.ord_no = PL.ord_no
												 WHERE (PH.ord_dt > DATEADD(DAY, - 1200, GETDATE()))) AS PURCH_LAST_YR ON PURCH_LAST_YR.item_no = IM2.item_no
                            INNER JOIN dbo.humres AS HR ON PL.byr_plnr = HR.res_id 
                            LEFT OUTER JOIN dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
                            JOIN Z_IMINVLOC_USAGE USG ON USG.item_no = IM2.item_no
               WHERE (PL.qty_received < PL.qty_ordered AND PL.qty_released < PL.qty_ordered)
		  AND PH.ord_status != 'X' AND PL.ord_status != 'X' AND (IM2.prod_cat IN ('036', '037', '111', '336', '102')) AND PL.stk_loc NOT IN ('BR', 'IN', 'CAN')
               UNION ALL
                SELECT BM.comp_item_no AS ITEM, BMIM.item_desc_1 AS ItemDesc1, BMIM.item_desc_2 AS ItemDesc2, 'SALE' AS [PO/SLS], CASE WHEN CONVERT(varchar(10), 
                              OH.shipping_dt, 101) < GETDATE() THEN CONVERT(VARCHAR(10), DATEADD(day, 1, GETDATE()), 101) ELSE CONVERT(varchar(10), OH.shipping_dt, 101) 
                              END AS [SHP/RECV DT], CAST(OL.qty_to_ship AS INT) * BM.qty_per_par * - 1 AS QTY, '' AS [PROJ QOH], CAST(RTRIM(LTRIM(OH.ord_no)) AS VARCHAR) 
                              AS [ORDER], OH.ship_to_name AS [VEND/CUS], CONVERT(varchar(10), OH.entered_dt, 101) AS [ORDER DATE], NULL AS [CONTAINER INFO], NULL 
                              AS [Container Ship To], NULL AS [TRANSFER TO], BMIM.prod_cat AS [PROD CAT], LTRIM(OH.cus_no) AS [CUS NO], IM2.item_note_1 AS CH, 
                              OH.cus_alt_adr_cd AS STORE, OL.item_no AS [PARENT ITEM ON SALES ORD], BMIM.item_note_4 AS ESS, USG.usage_ytd
               FROM  dbo.oeordhdr_sql AS OH 
							  INNER JOIN dbo.oeordlin_sql AS OL ON OL.ord_no = OH.ord_no 
                              INNER JOIN dbo.imitmidx_sql AS IM2 ON IM2.item_no = OL.item_no 
                              INNER JOIN  dbo.bmprdstr_sql AS BM ON BM.item_no = OL.item_no 
                              INNER JOIN (SELECT DISTINCT PL.item_no
												 FROM   dbo.poordlin_sql AS PL INNER JOIN
													  dbo.poordhdr_sql AS PH ON PH.ord_no = PL.ord_no
												 WHERE (PH.ord_dt > DATEADD(DAY, - 365, GETDATE()))) AS PURCH_LAST_YR ON PURCH_LAST_YR.item_no = BM.comp_item_no
                              LEFT OUTER JOIN  dbo.imitmidx_sql AS BMIM ON BMIM.item_no = BM.comp_item_no
                              JOIN Z_IMINVLOC_USAGE USG ON USG.item_no = BMIM.item_no                              
               WHERE (OH.ord_type = 'O') AND (IM2.prod_cat IN ('036', '037', '111', '336', '102')) AND OL.loc NOT IN ('BR', 'IN', 'CAN')
								AND ((CAST(LTRIM(OL.ord_no) AS VARCHAR) + CAST(CAST(OL.qty_to_ship AS INT) AS VARCHAR)) NOT IN
                                          (SELECT CAST(LTRIM(Ord_no) AS VARCHAR) + CAST(SUM(Qty) AS VARCHAR) AS Expr1
										   FROM   dbo.wsPikPak 
										   WHERE (Shipped = 'Y')
										   GROUP BY Ord_no, Item_no))
                                  
               UNION ALL
               SELECT OL.item_no AS ITEM, IM2.item_desc_1 AS ItemDesc1, IM2.item_desc_2 AS ItemDesc2, 'SALE' AS [PO/SLS], CASE WHEN CONVERT(varchar(10), 
                              OH.shipping_dt, 101) < GETDATE() THEN CONVERT(VARCHAR(10), DATEADD(day, 1, GETDATE()), 101) ELSE CONVERT(varchar(10), OH.shipping_dt, 101) 
                              END AS [SHP/RECV DT], OL.qty_to_ship * - 1 AS QTY, '' AS [PROJ QOH], CAST(RTRIM(LTRIM(OH.ord_no)) AS VARCHAR) AS [ORDER], 
                              OH.ship_to_name AS [VEND/CUS], CONVERT(varchar(10), OH.entered_dt, 101) AS [ORDER DATE], NULL AS [CONTAINER INFO], NULL 
                              AS [Container Ship To], NULL AS [TRANSFER TO], OL.prod_cat AS [PROD CAT], LTRIM(OH.cus_no) AS [CUS NO], IM2.item_note_1 AS CH, 
                              OH.cus_alt_adr_cd AS STORE, OL.item_no AS [PARENT ITEM ON SALES ORD], IM2.item_note_4 AS ESS, USG.usage_ytd
               FROM  dbo.oeordhdr_sql AS OH 
							  INNER JOIN dbo.oeordlin_sql AS OL ON OL.ord_no = OH.ord_no 
                              INNER JOIN dbo.imitmidx_sql AS IM2 ON IM2.item_no = OL.item_no
                              INNER JOIN (SELECT DISTINCT PL.item_no
												 FROM   dbo.poordlin_sql AS PL INNER JOIN
													  dbo.poordhdr_sql AS PH ON PH.ord_no = PL.ord_no
												 WHERE (PH.ord_dt > DATEADD(DAY, - 365, GETDATE()))) AS PURCH_LAST_YR ON PURCH_LAST_YR.item_no = IM2.item_no
							 JOIN Z_IMINVLOC_USAGE USG ON USG.item_no = IM2.item_no
               WHERE (OH.ord_type = 'O') AND (IM2.prod_cat IN ('036', '037', '111', '336', '102')) AND OL.loc NOT IN ('BR', 'IN', 'CAN')
						AND ((CAST(LTRIM(OL.ord_no) AS VARCHAR) + CAST(CAST(OL.qty_to_ship AS INT) AS VARCHAR)) NOT IN
                                  (SELECT CAST(LTRIM(Ord_no) AS VARCHAR) + CAST(SUM(Qty) AS VARCHAR) AS Expr1
                                   FROM   dbo.wsPikPak AS wsPikPak_1
                                   WHERE (Shipped = 'Y')
                                   GROUP BY Ord_no, Item_no))) AS HolyGrail
ORDER BY Item, [SHP OR RECV DT]
*/