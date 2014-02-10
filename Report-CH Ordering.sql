--Created:	02/01/11	 By:	BG
--Last Updated:	9/4/13	 By:	BG
--Purpose: Original China Ordering Report For DLC
--Last Change:  Added logic of using the greater of ESS, WM-Forecast, and Projections.

USE [001]
GO

SET QUOTED_IDENTIFIER ON
GO

--ALTER VIEW [dbo].[BG_Daily_CH_Order_Report] AS
SELECT TOP (100) PERCENT '___' AS LN, 
		Z_IMINVLOC.prod_cat AS Cat,  
		Z_IMINVLOC.item_no, IMITMIDX_SQL.item_desc_1, IMITMIDX_SQL.item_desc_2, 
		CASE WHEN (IMITMIDX_SQL.extra_1) IS NULL THEN '' ELSE IMITMIDX_SQL.extra_1 END AS Parent,
		IMITMIDX_SQL.extra_6 AS [CH-US],
        CAST(Z_IMINVLOC.qty_on_ord AS INT) AS QOO, 
        CAST(Z_IMINVLOC.qty_on_hand AS Int) AS QOH, 
        CAST(QC.[QOH CHECK] AS INT) AS [QOH CHK],
        IMITMIDX_SQL.uom, 
        IMITMIDX_SQL.item_note_3 AS QPS,
        '___' AS AQOH, 
        CAST(Z_IMINVLOC.frz_qty AS INT) AS FQTY, 
        --dbo.Z_IMINVLOC_QALL.qty_allocated AS QALL_ALL, 
        
		CASE WHEN proj.qty_proj > 0 THEN CAST((dbo.Z_IMINVLOC_QALL.qty_allocated - Proj.qty_proj) AS Int) 
			 ELSE CAST(Z_IMINVLOC_QALL.qty_allocated AS Int) 
        END AS QALL, 
        CASE WHEN proj.qty_proj > 0 THEN CAST(proj.qty_proj AS INT) 
			 ELSE '0' 
		END AS QPROJ, 
		
		IMITMIDX_SQL.item_note_4 AS ESS, 
        dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) AS [WM Forecast],
        CASE WHEN NOT (imitmidx_sql.extra_1 = 'P') AND CAST(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord AS INT) < dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no)
             THEN 'NC WM'
			 ELSE ''
        END AS [WM Fore CHK],   
        CASE WHEN Z_IMINVLOC.prior_year_usage IS NULL THEN 0
             ELSE CAST(ROUND(Z_IMINVLOC.prior_year_usage / 12, 0) AS INT) 
        END AS PMNTH, 
        CASE WHEN Z_IMINVLOC_USAGE.usage_ytd IS NULL THEN 0
			 ELSE CEILING(dbo.Z_IMINVLOC_USAGE.usage_ytd / (DATEDIFF(day, CONVERT(datetime, 
               '01/01/2013', 103), GETDATE()) / 30.5)) 
        END AS CMNTH, 
        --CAST(Z_IMINVLOC.qty_on_hand - dbo.Z_IMINVLOC_QALL.qty_allocated AS Int) AS [QOH-QOA], 
        CASE WHEN z_iminvloc_usage.usage_ytd > 0 
			 THEN CAST(((qty_on_hand + qty_on_ord) / CEILING((z_iminvloc_usage.usage_ytd / (DATEDIFF(day,CONVERT(datetime, '01/01/2013', 103), GETDATE()) / 30.5)))) AS money) 
		ELSE 0 END AS MOI,  
        CASE  WHEN (imitmidx_sql.extra_1 = 'P' AND imitmidx_sql.extra_6 != 'CH-US' AND imitmidx_sql.extra_1 IS NOT NULL)
				THEN ''
				--If there is a WM forecast and it is >= ESS and >= QPROJ then use the WM forecast
					WHEN  dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) >= 0
						 AND (dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) >= Proj.qty_proj) 
						 AND (dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) >= imitmidx_Sql.item_note_4 OR imitmidx_Sql.item_note_4 IS NULL)
						 AND (Z_IMINVLOC.qty_on_hand >= 0)
						 AND (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - (z_iminvloc_qall.qty_allocated-Proj.qty_proj) - CAST(dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) AS INT), 0))  < 0
					THEN 'NC-WMF'
					WHEN  dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) >= 0
						 AND (dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) >= Proj.qty_proj) 
						 AND (dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) >= imitmidx_Sql.item_note_4 OR imitmidx_Sql.item_note_4 IS NULL)
						 AND (Z_IMINVLOC.qty_on_hand <= 0)	
						 AND (ROUND(Z_IMINVLOC.qty_on_ord - (z_iminvloc_qall.qty_allocated-Proj.qty_proj) - dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no), 0))  < 0	
					THEN 'NC-WMF'
					--No projections section, required to avoid nulls in the calculation--				
					WHEN  dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) >= 0
						 AND (Proj.qty_proj IS null) 
						 AND (dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) >= imitmidx_Sql.item_note_4 OR imitmidx_Sql.item_note_4 IS NULL)
						 AND (Z_IMINVLOC.qty_on_hand >= 0)
						 AND (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - (z_iminvloc_qall.qty_allocated) - dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no), 0)) < 0
					THEN 'NC-WMF'
					WHEN  dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) > 0
						 AND (Proj.qty_proj IS null) 
						 AND (dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) >= imitmidx_Sql.item_note_4 OR imitmidx_Sql.item_note_4 IS NULL)
						 AND (Z_IMINVLOC.qty_on_hand <= 0)		
						 AND (ROUND(Z_IMINVLOC.qty_on_ord -(z_iminvloc_qall.qty_allocated) - dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no), 0)) < 0
					THEN 'NC-WMF'							
				--If there is an ESS and it is >= WMForecast and >= QPROJ then use the ESS and allocations w/o projections
					WHEN imitmidx_Sql.item_note_4 >= 0
						 AND (imitmidx_Sql.item_note_4 >= Proj.qty_proj) 
						 AND (imitmidx_Sql.item_note_4 >= dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) OR dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) IS NULL)
						 AND (Z_IMINVLOC.qty_on_hand > 0)
						 AND (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - (z_iminvloc_qall.qty_allocated-Proj.qty_proj) - imitmidx_Sql.item_note_4, 0)) < 0
					THEN 'NC-ESS'
					WHEN imitmidx_Sql.item_note_4 >= 0
						 AND (imitmidx_Sql.item_note_4 >= Proj.qty_proj) 
						 AND (imitmidx_Sql.item_note_4 >= dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) OR dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) IS NULL)
						 AND (Z_IMINVLOC.qty_on_hand <= 0)	
						 AND (ROUND(Z_IMINVLOC.qty_on_ord - (z_iminvloc_qall.qty_allocated-Proj.qty_proj) - imitmidx_Sql.item_note_4, 0)) < 0
					THEN 'NC-ESS'
					--No projections section, required to avoid nulls in the calculation--				
					WHEN imitmidx_Sql.item_note_4 >= 0
						 AND (imitmidx_Sql.item_note_4 >= Proj.qty_proj) 
						 AND (imitmidx_Sql.item_note_4 >= dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) OR dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) IS NULL)
						 AND (Z_IMINVLOC.qty_on_hand >= 0)
						 AND (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - (z_iminvloc_qall.qty_allocated-Proj.qty_proj) - dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no), 0)) < 0
					THEN 'NC-ESS'
					WHEN imitmidx_Sql.item_note_4 >= 0
						 AND (imitmidx_Sql.item_note_4 >= Proj.qty_proj) 
						 AND (imitmidx_Sql.item_note_4 >= dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) OR dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) IS NULL)
						 AND (Z_IMINVLOC.qty_on_hand <= 0)	
						 AND (ROUND(Z_IMINVLOC.qty_on_ord - (z_iminvloc_qall.qty_allocated-Proj.qty_proj) - dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no), 0)) < 0
					THEN 'NC-ESS'				
				--If there is no forecast but a qty projected and an ESS and it is >= ESS or there is no ESS, then use allocations w/ projections
					WHEN (Proj.qty_proj >= 0) AND (Z_IMINVLOC.qty_on_hand > 0)
					      AND (Proj.qty_proj >= imitmidx_Sql.item_note_4 OR imitmidx_Sql.item_note_4 IS NULL)
					      AND (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated, 0)) < 0
					THEN 'NC-PROJ'
					WHEN (Proj.qty_proj >= 0) AND (Z_IMINVLOC.qty_on_hand <= 0) 
						  AND (Proj.qty_proj >= imitmidx_Sql.item_note_4 OR imitmidx_Sql.item_note_4 IS NULL) 
						  AND (ROUND(Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated, 0)) < 0
					THEN 'NC-PROJ'
			   --If there is no forecast but a qty projected and an ESS and if qty projected is < then ESS, then use ESS and allocations w/o projections
					WHEN (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (Z_IMINVLOC.qty_on_hand >= 0) AND Proj.qty_proj >= 0
						 AND Proj.qty_proj < imitmidx_Sql.item_note_4
						 AND (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - (z_iminvloc_qall.qty_allocated - Proj.qty_proj) - IMITMIDX_SQL.item_note_4, 0)) < 0
				    THEN 'NC-ESS'
				    WHEN (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (Z_IMINVLOC.qty_on_hand <= 0) AND Proj.qty_proj >= 0 
						 AND Proj.qty_proj < imitmidx_Sql.item_note_4
						 AND (ROUND(Z_IMINVLOC.qty_on_ord - (z_iminvloc_qall.qty_allocated - Proj.qty_proj) - IMITMIDX_SQL.item_note_4, 0)) < 0
				    THEN 'NC-ESS'
			   --If there is a forecast and a qty projected but no ess, and forecast > qty projected, then use allocations w/o projections
					WHEN IMITMIDX_SQL.item_note_4 IS NULL AND Proj.qty_proj >= 0
						 AND dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) >= Proj.qty_proj
						 AND (Z_IMINVLOC.qty_on_hand >= 0)
						 AND (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - (z_iminvloc_qall.qty_allocated - Proj.qty_proj) - dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no), 0))  < 0
				    THEN 'NC-WMF'
				    WHEN (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (Z_IMINVLOC.qty_on_hand <= 0) AND Proj.qty_proj >= 0 
						 AND Proj.qty_proj < imitmidx_Sql.item_note_4
						 AND (ROUND(Z_IMINVLOC.qty_on_ord - (z_iminvloc_qall.qty_allocated - Proj.qty_proj) - dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no), 0)) < 0
				    THEN 'NC-WMF'
               --If there is a forecast and an ess but no qty projected, and forecast > ess, then use WM forecast and normal allocations
					WHEN IMITMIDX_SQL.item_note_4 IS NOT NULL AND Proj.qty_proj IS NULL
						 AND dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) >= IMITMIDX_SQL.item_note_4
						 AND (Z_IMINVLOC.qty_on_hand >= 0)
						 AND (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - (z_iminvloc_qall.qty_allocated) - dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no), 0)) < 0
				    THEN 'NC-WMF'
				    WHEN (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (Z_IMINVLOC.qty_on_hand <= 0) AND Proj.qty_proj >= 0 
						 AND Proj.qty_proj < imitmidx_Sql.item_note_4
						 AND (ROUND(Z_IMINVLOC.qty_on_ord - (z_iminvloc_qall.qty_allocated) - dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no), 0)) < 0
				    THEN 'NC-WMF'
			   --If there is no forecast and no qty projected but an ESS, then use ESS and normal allocations                                
				    WHEN (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND Proj.qty_proj IS NULL
						 AND (Z_IMINVLOC.qty_on_hand >= 0) 
						 AND (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated - IMITMIDX_SQL.item_note_4, 0)) < 0
				    THEN 'NC-ESS'
				    WHEN (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND Proj.qty_proj IS NULL
						 AND (Z_IMINVLOC.qty_on_hand < 0) 
						 AND (ROUND(Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated - IMITMIDX_SQL.item_note_4, 0))  < 0
				    THEN 'NC-ESS'
			   --If there is no forecast and no ESS but an qty projected, then use allocations w/ projections
				   WHEN (IMITMIDX_SQL.item_note_4 IS NULL) AND dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) IS NULL
						 AND Proj.qty_proj >= 0	 AND (Z_IMINVLOC.qty_on_hand >= 0)
						 AND (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - (z_iminvloc_qall.qty_allocated), 0)) < 0  
				   THEN 'NC-PROJ'
				   WHEN (IMITMIDX_SQL.item_note_4 IS NULL) AND dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) IS NULL
						AND Proj.qty_proj >= 0 AND (Z_IMINVLOC.qty_on_hand < 0)  
						AND (ROUND(Z_IMINVLOC.qty_on_ord - (z_iminvloc_qall.qty_allocated), 0))	 < 0 
				   THEN 'NC-PROJ'
			  --If there is no forecast and no ESS and no qty projected, then use none		
				   WHEN (IMITMIDX_SQL.item_note_4 IS NULL) AND dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) IS NULL
						AND Proj.qty_proj IS NULL
						AND (Z_IMINVLOC.qty_on_hand >= 0) 
						AND (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated, 0)) < 0 
				   THEN 'NC'  
				   WHEN (IMITMIDX_SQL.item_note_4 IS NULL) AND dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) IS NULL
						AND Proj.qty_proj IS NULL
						AND (Z_IMINVLOC.qty_on_hand < 0) 
						AND (ROUND(Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated, 0)) < 0
				  THEN  'NC'	            
         ELSE '' END AS [CHECK],
               
          '_____' AS 'Order',   
                
          CASE  --If there is a WM forecast and it is >= ESS and >= QPROJ then use the WM forecast
					WHEN  dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) >= 0
						 AND (dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) >= Proj.qty_proj) 
						 AND (dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) >= imitmidx_Sql.item_note_4 OR imitmidx_Sql.item_note_4 IS NULL)
						 AND (Z_IMINVLOC.qty_on_hand >= 0)
					THEN (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - (z_iminvloc_qall.qty_allocated-Proj.qty_proj) - CAST(dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) AS INT), 0))   
					WHEN  dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) >= 0
						 AND (dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) >= Proj.qty_proj) 
						 AND (dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) >= imitmidx_Sql.item_note_4 OR imitmidx_Sql.item_note_4 IS NULL)
						 AND (Z_IMINVLOC.qty_on_hand <= 0)						 
					THEN (ROUND(Z_IMINVLOC.qty_on_ord - (z_iminvloc_qall.qty_allocated-Proj.qty_proj) - dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no), 0))   
					--No projections section, required to avoid nulls in the calculation--				
					WHEN  dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) >= 0
						 AND (Proj.qty_proj IS null) 
						 AND (dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) >= imitmidx_Sql.item_note_4 OR imitmidx_Sql.item_note_4 IS NULL)
						 AND (Z_IMINVLOC.qty_on_hand >= 0)
					THEN (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - (z_iminvloc_qall.qty_allocated) - dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no), 0))
					WHEN  dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) > 0
						 AND (Proj.qty_proj IS null) 
						 AND (dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) >= imitmidx_Sql.item_note_4 OR imitmidx_Sql.item_note_4 IS NULL)
						 AND (Z_IMINVLOC.qty_on_hand <= 0)						 
					THEN (ROUND(Z_IMINVLOC.qty_on_ord - (z_iminvloc_qall.qty_allocated) - dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no), 0))							
				--If there is an ESS and it is >= WMForecast and >= QPROJ then use the ESS
					WHEN imitmidx_Sql.item_note_4 >= 0
						 AND (imitmidx_Sql.item_note_4 >= Proj.qty_proj) 
						 AND (imitmidx_Sql.item_note_4 >= dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) OR dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) IS NULL)
						 AND (Z_IMINVLOC.qty_on_hand > 0)
					THEN (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - (z_iminvloc_qall.qty_allocated-Proj.qty_proj) - imitmidx_Sql.item_note_4, 0))
					WHEN imitmidx_Sql.item_note_4 >= 0
						 AND (imitmidx_Sql.item_note_4 >= Proj.qty_proj) 
						 AND (imitmidx_Sql.item_note_4 >= dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) OR dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) IS NULL)
						 AND (Z_IMINVLOC.qty_on_hand <= 0)					 
					THEN (ROUND(Z_IMINVLOC.qty_on_ord - (z_iminvloc_qall.qty_allocated-Proj.qty_proj) - imitmidx_Sql.item_note_4, 0))	
					--No projections section, required to avoid nulls in the calculation--				
					WHEN imitmidx_Sql.item_note_4 >= 0
						 AND (imitmidx_Sql.item_note_4 >= Proj.qty_proj) 
						 AND (imitmidx_Sql.item_note_4 >= dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) OR dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) IS NULL)
						 AND (Z_IMINVLOC.qty_on_hand >= 0)
					THEN (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - (z_iminvloc_qall.qty_allocated) - dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no), 0))
					WHEN imitmidx_Sql.item_note_4 >= 0
						 AND (imitmidx_Sql.item_note_4 >= Proj.qty_proj) 
						 AND (imitmidx_Sql.item_note_4 >= dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) OR dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) IS NULL)
						 AND (Z_IMINVLOC.qty_on_hand <= 0)					 
					THEN (ROUND(Z_IMINVLOC.qty_on_ord - (z_iminvloc_qall.qty_allocated) - dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no), 0))						
				--If there is no forecast but a qty projected and an ESS and it is >= ESS or there is no ESS, then use allocations w/ projections
					WHEN (Proj.qty_proj >= 0) AND (Z_IMINVLOC.qty_on_hand > 0)
					      AND (Proj.qty_proj >= imitmidx_Sql.item_note_4 OR imitmidx_Sql.item_note_4 IS NULL)
					THEN (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated, 0))
					WHEN (Proj.qty_proj >= 0) AND (Z_IMINVLOC.qty_on_hand <= 0) 
						  AND (Proj.qty_proj >= imitmidx_Sql.item_note_4 OR imitmidx_Sql.item_note_4 IS NULL) 
					THEN (ROUND(Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated, 0))
			   --If there is no forecast but a qty projected and an ESS and if qty projected is < then ESS, then use allocations w/o projections
					WHEN (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (Z_IMINVLOC.qty_on_hand >= 0) AND Proj.qty_proj >= 0
						 AND Proj.qty_proj < imitmidx_Sql.item_note_4
				    THEN (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - (z_iminvloc_qall.qty_allocated - Proj.qty_proj) - IMITMIDX_SQL.item_note_4, 0)) 
				    WHEN (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (Z_IMINVLOC.qty_on_hand <= 0) AND Proj.qty_proj >= 0 
						 AND Proj.qty_proj < imitmidx_Sql.item_note_4
				    THEN (ROUND(Z_IMINVLOC.qty_on_ord - (z_iminvloc_qall.qty_allocated - Proj.qty_proj) - IMITMIDX_SQL.item_note_4, 0)) 
			   --If there is a forecast and a qty projected but no ess, and forecast > qty projected, then use allocations w/o projections
					WHEN IMITMIDX_SQL.item_note_4 IS NULL AND Proj.qty_proj >= 0
						 AND dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) >= Proj.qty_proj
						 AND (Z_IMINVLOC.qty_on_hand >= 0)
				    THEN 333--(ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - (z_iminvloc_qall.qty_allocated - Proj.qty_proj) - dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no), 0)) 
				    WHEN (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (Z_IMINVLOC.qty_on_hand <= 0) AND Proj.qty_proj >= 0 
						 AND Proj.qty_proj < imitmidx_Sql.item_note_4
				    THEN (ROUND(Z_IMINVLOC.qty_on_ord - (z_iminvloc_qall.qty_allocated - Proj.qty_proj) - dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no), 0)) 
               --If there is a forecast and ess but no qty projected, and forecast > qty projected, then use allocations w/ projections
					WHEN IMITMIDX_SQL.item_note_4 IS NOT NULL AND Proj.qty_proj IS NULL
						 AND dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) >= IMITMIDX_SQL.item_note_4
						 AND (Z_IMINVLOC.qty_on_hand >= 0)
				    THEN (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - (z_iminvloc_qall.qty_allocated) - dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no), 0)) 
				    WHEN (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (Z_IMINVLOC.qty_on_hand <= 0) AND Proj.qty_proj >= 0 
						 AND Proj.qty_proj < imitmidx_Sql.item_note_4
				    THEN (ROUND(Z_IMINVLOC.qty_on_ord - (z_iminvloc_qall.qty_allocated) - dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no), 0)) 
			   --If there is no forecast and no qty projected but an ESS, then use ESS and normal allocations                                
				    WHEN (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND Proj.qty_proj IS NULL
						 AND (Z_IMINVLOC.qty_on_hand >= 0) 
				    THEN (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated - IMITMIDX_SQL.item_note_4, 0)) 
				    WHEN (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (Z_IMINVLOC.qty_on_hand <= 0) 
				    THEN (ROUND(Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated - IMITMIDX_SQL.item_note_4, 0)) 
			   --If there is no forecast and no ESS but an qty projected, then use qty projected and allocationed w/o projections
				   WHEN (IMITMIDX_SQL.item_note_4 IS NULL) AND dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) IS NULL
						 AND Proj.qty_proj >= 0	 AND (Z_IMINVLOC.qty_on_hand >= 0) 
				   THEN (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - (z_iminvloc_qall.qty_allocated - Proj.qty_proj) - Proj.qty_proj, 0))	
				   WHEN (IMITMIDX_SQL.item_note_4 IS NULL) AND dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) IS NULL
						AND Proj.qty_proj >= 0 AND (Z_IMINVLOC.qty_on_hand < 0)  
				   THEN (ROUND(Z_IMINVLOC.qty_on_ord - (z_iminvloc_qall.qty_allocated - Proj.qty_proj) - Proj.qty_proj, 0))				
			  --If there is no forecast and no ESS and no qty projected, then use none		
				   WHEN (IMITMIDX_SQL.item_note_4 IS NULL) AND dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) IS NULL
						AND Proj.qty_proj IS NULL
						AND (Z_IMINVLOC.qty_on_hand >= 0) 
				   THEN (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated, 0))     
				   WHEN (IMITMIDX_SQL.item_note_4 IS NULL) AND dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) IS NULL
						AND Proj.qty_proj IS NULL
						AND (Z_IMINVLOC.qty_on_hand < 0) 
				   THEN (ROUND(Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated, 0))	            
         ELSE 0 
         END AS [QOH+QOO-QOA-(ESS/WMF/QPROJ)], 
		 

        /*     
       CASE WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR imitmidx_sql.extra_1 IS NULL OR  imitmidx_sql.extra_6 = 'CH-US') 
				AND (Z_IMINVLOC.qty_on_hand <= 0) 
				AND ((ROUND(Z_IMINVLOC.qty_on_ord - (3 * CEILING(dbo.Z_IMINVLOC_USAGE.usage_ytd / (DATEDIFF(day, CONVERT(datetime, '01/01/2013', 103), GETDATE()) / 30.5))), 0)) < 0) 
       THEN 'NC' 
       WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR imitmidx_sql.extra_1 IS NULL OR imitmidx_sql.extra_6 = 'CH-US') 
			AND (Z_IMINVLOC.qty_on_hand > 0) 
			AND ((ROUND(Z_IMINVLOC.qty_on_ord - Z_IMINVLOC.qty_on_hand - (3 * CEILING(dbo.Z_IMINVLOC_USAGE.usage_ytd / (DATEDIFF(day, CONVERT(datetime, '01/01/2013', 103), GETDATE()) / 30.5))), 0)) < 0) 
	   THEN 'NC' 
       ELSE '' END AS [CHECK 90], 
       */
       /*
       CASE WHEN (Z_IMINVLOC.qty_on_hand > 0) AND NOT (Z_IMINVLOC_USAGE.usage_ytd IS NULL)
			THEN (ROUND(Z_IMINVLOC.qty_on_ord + Z_IMINVLOC.qty_on_hand - (3 * CEILING(dbo.Z_IMINVLOC_USAGE.usage_ytd / (DATEDIFF(day, CONVERT(datetime, '01/01/2013', 103), GETDATE()) / 30.5))), 0)) 
			WHEN (Z_IMINVLOC.qty_on_hand > 0) AND (Z_IMINVLOC_USAGE.usage_ytd IS NULL)
			THEN (ROUND(Z_IMINVLOC.qty_on_ord + Z_IMINVLOC.qty_on_hand, 3))	
			WHEN (Z_IMINVLOC.qty_on_hand <= 0) AND NOT (Z_IMINVLOC_USAGE.usage_ytd IS NULL)
			THEN (ROUND(Z_IMINVLOC.qty_on_ord - (3 * CEILING(dbo.Z_IMINVLOC_USAGE.usage_ytd / (DATEDIFF(day, CONVERT(datetime, '01/01/2013', 103), GETDATE())/ 30.5))), 0)) 
			WHEN (Z_IMINVLOC.qty_on_hand <= 0) AND (Z_IMINVLOC_USAGE.usage_ytd IS NULL)
			THEN (ROUND(Z_IMINVLOC.qty_on_ord,3))
		ELSE '' END AS [QOH+QOO-90], 	
	   */
       Z_IMINVLOC.po_min AS MOQ, 
       --'_________' AS [ORDER], 
       IMITMIDX_SQL.item_note_2 AS Supplier,  
       IMITMIDX_SQL.item_note_5 AS [Misc Note (N5)],
       IMITMIDX_SQL.p_and_ic_cd AS [Rec Loc],
       Z_IMINVLOC.prior_year_usage AS PYU, 
       dbo.Z_IMINVLOC_USAGE.usage_ytd,     
       CAST(ROUND(Z_IMINVLOC.last_cost, 2, 0) AS DECIMAL(8, 2)) AS LC, 
       CAST(ROUND(Z_IMINVLOC.std_cost, 2, 0) AS DECIMAL(8, 2)) AS SC, 
       IMITMIDX_SQL.drawing_release_no AS [Dwg #], 
       IMITMIDX_SQL.drawing_revision_no AS [Dwg Rev]              
FROM  dbo.Z_IMINVLOC AS Z_IMINVLOC WITH (NOLOCK) INNER JOIN
               dbo.imitmidx_sql AS IMITMIDX_SQL WITH (NOLOCK) ON Z_IMINVLOC.item_no = IMITMIDX_SQL.item_no LEFT OUTER JOIN
               dbo.Z_IMINVLOC_QALL WITH (NOLOCK) ON dbo.Z_IMINVLOC_QALL.item_no = Z_IMINVLOC.item_no LEFT OUTER JOIN
               dbo.Z_IMINVLOC_USAGE WITH (NOLOCK) ON dbo.Z_IMINVLOC_USAGE.item_no = Z_IMINVLOC.item_no LEFT OUTER JOIN
               dbo.Z_IMINVLOC_QOH_CHECK AS QC WITH (NOLOCK) ON QC.item_no = Z_IMINVLOC.item_no 
			   LEFT OUTER JOIN
               dbo.BG_WM_Current_Projections AS PROJ WITH (NOLOCK) ON PROJ.item_no = IMITMIDX_SQL.item_no 
WHERE (IMITMIDX_SQL.item_note_1 = 'CH') 
		AND (NOT (Z_IMINVLOC.prod_cat = '036' OR Z_IMINVLOC.prod_cat = '037' OR Z_IMINVLOC.prod_cat = '336')) 
		AND ((dbo.Z_IMINVLOC_USAGE.usage_ytd > 0) OR (Z_IMINVLOC.qty_on_ord > 0) OR (dbo.Z_IMINVLOC_QALL.qty_allocated > 0) 
				OR (Z_IMINVLOC.prior_year_usage > 0) OR (Z_IMINVLOC.qty_on_hand > 0) OR IMITMIDX_SQL.activity_dt > CONVERT(datetime, '05/01/2013', 103)) 
		--Test
		--AND IMITMIDX_SQL.item_no = '23" SPT BAR GB' 