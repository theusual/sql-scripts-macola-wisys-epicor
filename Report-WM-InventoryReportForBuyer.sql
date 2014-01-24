--ALTER VIEW BG_WM_INVENTORY_REPORT_FOR_BUYER AS

--Parents
select DISTINCT top 100 percent IL.item_no [Parent], 
		IL.item_no,
		CASE WHEN BM.comp_item_no is null 
				THEN 'N'
				ELSE 'Y'
		END AS [Components?],
		IM.item_desc_1 +' '+ IM.item_desc_2  AS  Description,
		EDI.edi_item_num AS SAP#,
		CASE WHEN QALL.qty_allocated is null
			 THEN IL.qty_on_hand
			 WHEN PROJ.qty_proj is null 
			 THEN IL.qty_on_hand - QALL.qty_allocated
			 ELSE IL.qty_on_hand - (QALL.qty_allocated - PROJ.qty_proj)
		END AS [Current Inv (UnAllocated)],
		qty_on_hand AS QOH,
		CASE WHEN QALL.qty_allocated IS NULL
		     THEN 0
			 ELSE QALL.qty_allocated
		END AS [TOT All.],
		CASE WHEN MNTH_ALL.MONTHLY_ALL IS NULL	
		     THEN 0
			 ELSE MNTH_ALL.MONTHLY_ALL
		END AS [MTD All.],
		PROJ.qty_proj AS QPROJ,
		PROJ_MO.QTY_PROJ_MO,
		CASE 
			 WHEN PROJ_MO.MONTH is null and MONTH(GETDATE()) IN ('10','11','12')
			 THEN 3
			 WHEN PROJ_MO.MONTH is null and MONTH(GETDATE()) NOT IN ('10','11','12')
			 THEN MONTH(GETDATE()) + 2
			 WHEN PROJ_MO.MONTH = 12
			 THEN 1
			 ELSE (PROJ_MO.MONTH + 1) 
		END AS MONTH,
		IL.qty_on_ord AS [IN PRODUCTION],
		CASE WHEN Forecast.[Feb 2014] IS NULL THEN 0
			 ELSE Forecast.[Feb 2014] 
		END AS [Feb 2014],
		CASE WHEN Forecast.[Mar 2014] IS NULL THEN 0
			 ELSE Forecast.[Mar 2014] 
		END AS [Mar 2014],
		CASE WHEN Forecast.[Apr 2014] IS NULL THEN 0
			 ELSE Forecast.[Apr 2014] 
		END AS [Apr 2014],
		CASE WHEN Forecast.[May 2014] IS NULL THEN 0
			 ELSE Forecast.[May 2014] 
		END AS [May 2014],
		CASE WHEN PO_DT.[SHP/RECV DT] is null THEN 'N/A'
			 ELSE PO_DT.[SHP/RECV DT] 
		END AS [PROD COMPL DT]
from z_iminvloc IL JOIN imitmidx_sql IM ON IM.item_no = IL.item_no
				   LEFT OUTER JOIN bmprdstr_sql AS BM on BM.item_no = IL.item_no
				   LEFT OUTER JOIN edcitmfl_sql AS EDI on EDI.mac_item_num = IL.item_no
				   LEFT OUTER JOIN Z_IMINVLOC_QALL QALL ON QALL.item_no = BM.item_no
				   LEFT OUTER JOIN BG_WM_Current_Projections AS PROJ on PROJ.item_no = IL.item_no
				   LEFT OUTER JOIN 
						(SELECT month(shipping_dt) AS [MONTH], SUM(OL.qty_to_ship) AS QTY_PROJ_MO, OL.item_no
						 FROM oeordhdr_Sql OH JOIN oeordlin_sql OL ON OH.ord_no = OL.ord_no
						 WHERE ltrim(OH.cus_no) = '23033'
						 GROUP BY month(shipping_dt), OL.item_no
						 UNION ALL
						 SELECT month(shipping_dt) AS [MONTH], SUM(OL.qty_to_ship*BM.qty_per_par) AS QTY_PROJ_MO, BM.comp_item_no
						 FROM oeordhdr_Sql OH JOIN oeordlin_sql OL ON OH.ord_no = OL.ord_no
											  JOIN bmprdstr_sql BM ON BM.item_no = OL.item_no
						 WHERE ltrim(OH.cus_no) = '23033'
						 GROUP BY month(shipping_dt), BM.comp_item_no) AS PROJ_MO ON PROJ_MO.item_no = IL.item_no 	
				   LEFT OUTER JOIN 
						(select item_no, SUM(qty_to_ship) AS MONTHLY_ALL
						from oeordhdr_Sql OH JOIN oeordlin_sql OL ON OL.orD_no = OH.ord_no
						WHERE month(OH.shipping_dt) = month(GETDATE()) AND ltrim(OH.cus_no) = '1575'
						GROUP BY item_no
						UNION ALL
						SELECT BM.comp_item_no, SUM(OL.qty_to_ship*BM.qty_per_par) AS QTY_PROJ_MO 
						FROM oeordhdr_Sql OH JOIN oeordlin_sql OL ON OH.ord_no = OL.ord_no
											  JOIN bmprdstr_sql BM ON BM.item_no = OL.item_no
						WHERE ltrim(OH.cus_no) = '1575'
						GROUP BY month(shipping_dt), BM.comp_item_no) AS MNTH_ALL ON MNTH_ALL.item_no = IL.item_no		
				  LEFT OUTER JOIN
						(SELECT        SUM([Feb 2014]) AS [Feb 2014],
									   SUM([Mar 2014]) AS [Mar 2014],
									   SUM([Apr 2014]) AS [Apr 2014], 
									   SUM([May 2014]) AS [May 2014], 
									   --SUM([Jun 2014]) AS [Jun 2014], 
									   --SUM([Jul 2014]) AS [Jul 2014], 
									   --SUM([Aug 2014]) AS [Aug 2014], 
									   --SUM([Sep 2013]) AS [Sep 2013], 
									   --SUM([Oct 2013]) AS [Oct 2013],
									   --SUM([Nov 2013]) AS [Nov 2013],
									   --SUM([Dec 2013]) AS [Dec 2013],
									   --SUM([Jan 2014]) AS [Jan 2014],
									   [Article], [Marco Item]
						FROM  dbo.WM_Forecast_2013 AS Forecast 
						GROUP BY [Article], [Marco Item]) AS Forecast ON Forecast.[Marco Item] = IL.item_no
					LEFT OUTER JOIN
							   (SELECT PL.item_no, x.[SHP/RECV DT] AS [SHP/RECV DT]
								FROM	poordlin_sql PL join poordhdr_sql PH ON PH.ord_no = PL.ord_no
								CROSS APPLY
									(SELECT TEMP2.[SHP/RECV DT] + '   '
									 FROM (SELECT PL.item_no, 
												CASE WHEN (MIN(PL.user_def_fld_2) IS NOT NULL AND LEN(MIN(PL.user_def_fld_2)) = 10)  
														THEN MIN(CONVERT(varchar(10),PL.user_def_fld_2,101))
														WHEN (MIN(PL.user_def_fld_2) IS NULL OR LEN(MIN(PL.user_def_fld_2)) != 10) AND (MIN(PL.extra_8) IS NOT NULL AND LEN(MIN(PL.extra_8)) = 10 )
														THEN MIN(CONVERT(varchar(10),DATEADD(day, 28, PL.extra_8),101))
														WHEN (MIN(PL.user_def_fld_2) IS NULL OR LEN(MIN(PL.user_def_fld_2)) != 10) AND (MIN(PL.extra_8) IS NULL OR LEN(MIN(PL.extra_8)) != 10) 
															AND LTRIM(PL.vend_no) IN  (SELECT vend_no
																						FROM   BG_CH_Vendors) 
														THEN MIN(CONVERT(varchar(10), DATEADD(DAY, 90, PH.ord_dt), 101))
														WHEN MIN(PL.promise_dt) IS NULL 
														THEN MIN(CONVERT(varchar(10), DATEADD(DAY, 14, PH.ord_dt), 101))
														ELSE MIN(CONVERT(varchar(10), PL.promise_dt, 101))
												END AS [SHP/RECV DT] 
												FROM poordlin_sql PL JOIN poordhdr_Sql PH ON PH.ord_no = PL.ord_no 
												WHERE receipt_dt is null AND ord_dt > '03/06/2013' and qty_ordered > 0
												GROUP BY PL.item_no, PH.ord_no, PL.vend_no) AS TEMP2
									 WHERE PL.item_no = temp2.item_no
									 ORDER BY [SHP/RECV DT] ASC
									 FOR XML PATH('')
								   ) x ([SHP/RECV DT])
								WHERE receipt_dt is null AND ord_dt > '07/06/2013' and qty_ordered > 0) AS PO_DT ON PO_DT.item_no = IL.item_no
WHERE IL.item_no IN ('58685-2 BK','BAK-618 OBV97','BAK-619 L ORS97','BAK-619 R ORS97','BAK-628 WMBK','BAK-629 WMBK','BAK-656 ORS97','BAK-695 OBV-097','BAK-697-4 OBV97','BAK-699 COBV-97','BAK-715 ORS97',
'BAK-955 BIN SET','BAK-HLDR 1 BK','BAK-HLDR 2 BK','BAK-SNEEZE SB','BAK-SPI 2OBV97','BAN-CART 01 RS','BHC-17 WMRS','BSC-16UNIV WMRS','CELL-KIT RS','DELI-77 BK',
'DIT-BN001-OBV97','DIT-BEAN 002 RS','DR-313 BK','DR-313 CD Z CL','DRY-EP 01 RS','DRY-SHF 03 RS','DRY-SHF 04 RS','DRY-SHF 05 RS','DRY-SHF 06 RS','DRY-SHF LOW01RS','DRY-SHF LOW01BV','DRY-SHF LOW02RS','DRY-SHF LOW02BV','DRY-SHF LOW03RS','DRY-SHF LOW04RS',
'DRY-SHF LOW04BV','DVD DUMPKIT1RS','DVD DUMP BIN2RS','ECKIT-4 OBV-097'
,'ECKIT-7 OBV-097','ECKIT-8 RS','ECKIT-9 RS','EZ-REV1412BKW-H','FG-177 6X8X47.5','FG-250 EC KIT3','FG-250 EC KIT4','FG-375 3X5X48','GRO-010 WM RS','GRO-012 WM RS','GRO-014 WM RS','GRO-WIRE BH RS',
'MD-0057 HP SB','MD-UNIV WIRE SB','MDWM-0001 SB','MDWM-0002 SB','MDWM-0003 SB','MDWM-0012 SB','MDWM-0014 SB','MDWM-0016 SB','MDWM-0025 SB','MDWM-0026 SB','MDWM-0027 SB','MDWM-0032 SB','MDWM-0033 SB',
'MET-27 RS','MET-435 C ORS97','MET-435EC ORS97','MET-HANG RL RSV','MET-HNG ARM RSV','MET-HNG KIT4RSV','MET-HNG KIT5RSV','METOBP-363633RS','MET-POT CART RS','MET-PRO 003 RS',
'MET-SIDEKICKRSV','MET-WR DVDR2RSV','OB-EC004 RS','OBKIT-3 OBV-097','OBP-BAGHLDR','OBP-BAN008ORS97','OBPFL06SETORS97','OBP-FL07 OBV-97',
'OB-TBL003 RS','OB-TBL004 RS','PBT-003 OBV-97','PBT-004 RS','PBU-14 WMRS','PIZ SHFK 17 SB','PIZ SHFK 3PC SB','SG-250 28X45',
'SH-280 BK','SH-57 ORS97','SH-GP BK','SH-PROD EC RS','SM-30 PK SCALE','SW00035','SW00042','SW00170RS','SW00207WH','SW00248NH','SW00753RS','SW10073LNR-2 CL',
'SW10073TAN','SW10073TAN COOK','SW10216RS','VEG-327 PS BK','VEG-39 B-BK','VEG-489 BK','WBH-004 WMRS','WH-DELI WM RS','WK-18X36X84 GY','WK-18X48X84 GY','WM-MOVIEDUMPBIN','WN-KIT PTMORS97',
'WN-KITC66OBV97','WN-KITLR66OBV97','SW00054','MDWM-0012 SB','MDWM-0014 SB',
'GRO-010 WMGB B','GRO-WIRE BH GB','PIZ SHFK3PC36SB','SH-57 OBV97','SW000170 GB','SH-PROD EC BSV','OB-TBL003 BV','WBH-004 BV',
'DR-321 BK','DR-321 CD CL','SH-PROD EC RS'
)
--Remove items flagged for ignore
AND (IM.extra_8 != 1 or IM.extra_8 is null)
ORDER BY IL.item_no

/*
UNION ALL

--Components
SELECT DISTINCT
		BM.item_no AS [Parent],
		BM.comp_item_no, 
		CASE WHEN BM.comp_item_no is null 
				THEN 'N'
				ELSE 'Y'
		END AS [Components?],
		IM.item_desc_1 +' '+ IM.item_desc_2  AS  Description,
		EDI.edi_item_num AS SAP#,
		CASE WHEN QALL.qty_allocated is null
			 THEN IL.qty_on_hand
			 WHEN PROJ.qty_proj is null 
			 THEN IL.qty_on_hand - QALL.qty_allocated
			 ELSE IL.qty_on_hand - (QALL.qty_allocated - PROJ.qty_proj)
		END AS [Current Inv (UnAllocated)],
		qty_on_hand AS QOH,
		CASE WHEN QALL.qty_allocated IS NULL
		     THEN 0
			 ELSE QALL.qty_allocated
		END AS [TOT All.],
		CASE WHEN MNTH_ALL.MONTHLY_ALL IS NULL	
		     THEN 0
			 ELSE MNTH_ALL.MONTHLY_ALL
		END AS [MTD All.],
		PROJ.qty_proj AS QPROJ,
		PROJ_MO.QTY_PROJ_MO,
		CASE WHEN PROJ_MO.MONTH is null and MONTH(GETDATE()) IN ('10','11','12')
			 THEN 3
			 WHEN PROJ_MO.MONTH is null and MONTH(GETDATE()) NOT IN ('10','11','12')
			 THEN MONTH(GETDATE()) + 2
			 WHEN PROJ_MO.MONTH = 12
			 THEN 1
			 ELSE (PROJ_MO.MONTH + 1) 
		END AS MONTH,
		IL.qty_on_ord AS [IN PRODUCTION],
		CASE WHEN Forecast.[Jan 2014] IS NULL THEN 0
			 ELSE Forecast.[Jan 2014] 
		END AS [Jan 2014],
		CASE WHEN Forecast.[Feb 2014] IS NULL THEN 0
			 ELSE Forecast.[Feb 2014] 
		END AS [Feb 2014],
		CASE WHEN Forecast.[Mar 2014] IS NULL THEN 0
			 ELSE Forecast.[Mar 2014] 
		END AS [Mar 2014],
		CASE WHEN Forecast.[Apr 2014] IS NULL THEN 0
			 ELSE Forecast.[Apr 2014] 
		END AS [Apr 2014],
		CASE WHEN PO_DT.[SHP/RECV DT] is null THEN 'N/A'
			 ELSE PO_DT.[SHP/RECV DT]
		END AS [PROD COMPL DT]
from bmprdstr_sql AS BM 
				   JOIN imitmidx_sql IM ON IM.item_no = BM.item_no
				   JOIN z_iminvloc IL ON IL.item_no = BM.comp_item_no
				   LEFT OUTER JOIN edcitmfl_sql AS EDI on EDI.mac_item_num = BM.item_no
				   LEFT OUTER JOIN Z_IMINVLOC_QALL QALL ON QALL.item_no = BM.comp_item_no
				   LEFT OUTER JOIN BG_WM_Current_Projections AS PROJ on PROJ.item_no = BM.comp_item_no
				   LEFT OUTER JOIN 
						(SELECT month(shipping_dt) AS [MONTH], SUM(OL.qty_to_ship) AS QTY_PROJ_MO, OL.item_no
						 FROM oeordhdr_Sql OH JOIN oeordlin_sql OL ON OH.ord_no = OL.ord_no
						 WHERE ltrim(OH.cus_no) = '23033'
						 GROUP BY month(shipping_dt), OL.item_no) AS PROJ_MO ON PROJ_MO.item_no = BM.comp_item_no 	
				   LEFT OUTER JOIN 
						(select item_no, SUM(qty_to_ship) AS MONTHLY_ALL
						from oeordhdr_Sql OH JOIN oeordlin_sql OL ON OL.orD_no = OH.ord_no
						WHERE month(OH.shipping_dt) = month(GETDATE()) AND ltrim(OH.cus_no) = '1575'
						GROUP BY item_no) AS MNTH_ALL ON MNTH_ALL.item_no = BM.comp_item_no
				  LEFT OUTER JOIN
						(SELECT        SUM([Feb 2014]) AS [Feb 2014],
									   SUM([Mar 2014]) AS [Mar 2014],
									   SUM([Apr 2014]) AS [Apr 2014], 
									   --SUM([May 2014]) AS [May 2014], 
									   --SUM([Jun 2014]) AS [Jun 2014], 
									   --SUM([Jul 2014]) AS [Jul 2014], 
									   --SUM([Aug 2014]) AS [Aug 2014], 
									   --SUM([Sep 2013]) AS [Sep 2013], 
									   --SUM([Oct 2013]) AS [Oct 2013],
									   --SUM([Nov 2013]) AS [Nov 2013],
									   --SUM([Dec 2013]) AS [Dec 2013],
									   SUM([Jan 2014]) AS [Jan 2014],
									   [Article], [Marco Item]
						FROM  dbo.WM_Forecast_2013 AS Forecast 
						GROUP BY [Article], [Marco Item]) AS Forecast ON Forecast.[Marco Item] = BM.comp_item_no
					LEFT OUTER JOIN
							   (SELECT PL.item_no,  CONVERT(varchar,LEFT(x.[SHP/RECV DT],LEN(x.[SHP/RECV DT]))) AS [SHP/RECV DT]
								FROM	poordlin_sql PL join poordhdr_sql PH ON PH.ord_no = PL.ord_no
								CROSS APPLY
									(SELECT TEMP2.[SHP/RECV DT] + '   '
									 FROM (SELECT PL.item_no, 
												CASE WHEN (MIN(PL.user_def_fld_2) IS NOT NULL AND LEN(MIN(PL.user_def_fld_2)) = 10)  
														THEN MIN(CONVERT(varchar(10),PL.user_def_fld_2,101))
														WHEN (MIN(PL.user_def_fld_2) IS NULL OR LEN(MIN(PL.user_def_fld_2)) != 10) AND (MIN(PL.extra_8) IS NOT NULL AND LEN(MIN(PL.extra_8)) = 10 )
														THEN MIN(CONVERT(varchar(10),DATEADD(day, 28, PL.extra_8),101))
														WHEN (MIN(PL.user_def_fld_2) IS NULL OR LEN(MIN(PL.user_def_fld_2)) != 10) AND (MIN(PL.extra_8) IS NULL OR LEN(MIN(PL.extra_8)) != 10) 
															AND LTRIM(PL.vend_no) IN  (SELECT vend_no
																						FROM   BG_CH_Vendors) 
														THEN MIN(CONVERT(varchar(10), DATEADD(DAY, 90, PH.ord_dt), 101))
														WHEN MIN(PL.promise_dt) IS NULL 
														THEN MIN(CONVERT(varchar(10), DATEADD(DAY, 14, PH.ord_dt), 101))
														ELSE MIN(CONVERT(varchar(10), PL.promise_dt, 101))
												END AS [SHP/RECV DT] 
												FROM poordlin_sql PL JOIN poordhdr_Sql PH ON PH.ord_no = PL.ord_no 
												WHERE receipt_dt is null AND ord_dt > '3/06/2013' and qty_ordered > 0
												      AND LEN(PL.user_def_fld_2) = 10 AND LEN(PL.extra_8) = 10
													  AND PH.ord_status != 'X' AND PL.ord_status != 'X'
												GROUP BY PL.item_no, PH.ord_no, PL.vend_no) AS TEMP2
									 WHERE PL.item_no = temp2.item_no 
									 ORDER BY [SHP/RECV DT] ASC
									 FOR XML PATH('')
								   ) x ([SHP/RECV DT])
								WHERE receipt_dt is null AND ord_dt > '7/06/2013' and qty_ordered > 0) AS PO_DT ON PO_DT.item_no = BM.comp_item_no
WHERE BM.item_no IN ('58685-2 BK','BAK-618 OBV97','BAK-619 L ORS97','BAK-619 R ORS97','BAK-628 WMBK','BAK-629 WMBK','BAK-656 ORS97','BAK-695 OBV-097','BAK-697-4 OBV97','BAK-699 COBV-97','BAK-715 ORS97',
'BAK-955 BIN SET','BAK-HLDR 1 BK','BAK-HLDR 2 BK','BAK-SNEEZE SB','BAK-SPI 2OBV97','BAN-CART 01 RS','BHC-17 WMRS','BR-KIT 48 OBV97','BSC-16UNIV WMRS','CELL-KIT RS','DELI-77 BK',
'DIT-BN001-OBV97','DIT-BEAN 002 RS','DR-313 BK','DR-313 CD Z CL','DRY-EP 01 RS','DRY-SHF 03 RS','DRY-SHF 04 RS','DRY-SHF 05 RS','DRY-SHF 06 RS','DRY-SHF LOW01RS','DRY-SHF LOW01BV','DRY-SHF LOW02RS','DRY-SHF LOW02BV','DRY-SHF LOW03RS','DRY-SHF LOW04RS',
'DRY-SHF LOW04BV','DVD DUMPKIT1RS','DVD DUMP BIN2RS','ECKIT-4 OBV-097'
,'ECKIT-7 OBV-097','ECKIT-8 RS','ECKIT-9 RS','EZ-REV1412BKW-H','FG-177 6X8X47.5','FG-250 EC KIT3','FG-250 EC KIT4','FG-375 3X5X48','GRO-010 WM RS','GRO-012 WM RS','GRO-014 WM RS','GRO-WIRE BH RS',
'MD-0056 HP SB','MD-0057 HP SB','MD-UNIV WIRE SB','MDWM-0001 SB','MDWM-0002 SB','MDWM-0003 SB','MDWM-0012 SB','MDWM-0014 SB','MDWM-0016 SB','MDWM-0025 SB','MDWM-0026 SB','MDWM-0027 SB','MDWM-0032 SB','MDWM-0033 SB',
'MET-27 RS','MET-435 C ORS97','MET-435EC ORS97','MET-HANG RL RSV','MET-HNG ARM RSV','MET-HNG KIT4RSV','MET-HNG KIT5RSV','METOBP-363633RS','MET-POT CART RS','MET-PRO 003 RS','MET-RACK 01 RSV','MET-RACK 02 RSV',
'MET-SIDEKICKRSV','MET-WR DVDR2RSV','MET-WR RACK2RSV','OB-EC004 RS','OBKIT-3 OBV-097','OBP-BAGHLDR','OBP-BAN008ORS97','OBPFL06SETORS97','OBP-FL07 OBV-97',
'OB-TBL003 RS','OB-TBL004 RS','PBT-003 OBV-97','PBT-004 RS','PBU-14 WMRS','PIZ SHFK 17 SB','PIZ SHFK 18 SB','PIZ SHFK 20 SB','PIZ SHFK 3PC SB','SG-250 28X45',
'SH-280 BK','SH-57 ORS97','SH-GP BK','SH-PROD EC RS','SM-30 PK SCALE','SW00035','SW00042','SW00170RS','SW00207WH','SW00248NH','SW00753RS','SW10073LNR-2 CL',
'SW10073TAN','SW10073TAN COOK','SW10216RS','VEG-327 PS BK','VEG-39 B-BK','VEG-489 BK','WBH-004 WMRS','WH-DELI WM RS','WK-18X36X84 GY','WK-18X48X84 GY','WM-MOVIEDUMPBIN','WN-KIT PTMORS97',
'WN-KITC66OBV97','WN-KITLR66OBV97','SW00054','MDWM-0012 SB','MDWM-0014 SB',
'GRO-010 WMGB B','GRO-WIRE BH GB','PIZ SHFK3PC36SB','SH-57 OBV97','SW000170 GB','SH-PROD EC BSV')
--Remove items flagged for ignore
AND (IM.extra_8 != 1 or IM.extra_8 is null)

*/