--Created:	02/13/14	 By:	BG
--Last Updated:	--   	 By:	BG
--Purpose: Original China Ordering Report For DLC for EC location
--Last Change:  --

USE [001]
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[BG_Daily_CH_Order_Report_EC] AS
SELECT TOP (100) PERCENT '___' AS LN, 
		IL.prod_cat AS Cat,  
		IL.item_no, IM.item_desc_1, IM.item_desc_2, 
		CASE WHEN (IM.extra_1) IS NULL THEN '' ELSE IM.extra_1 END AS Parent,
		IM.extra_6 AS [CH-US],
        CAST(IL.qty_on_ord AS INT) AS QOO, 
        CAST(IL.qty_on_hand AS Int) AS QOH, 
        --(QC.[QOH CHECK] AS INT) AS [QOH CHK],
        IM.uom, 
        IM.item_note_3 AS QPS,
        '___' AS AQOH, 
        CAST(IL.frz_qty AS INT) AS FQTY, 
        QALL.qty_allocated AS QALL_ALL,         
		CASE WHEN proj.qty_proj > 0 THEN CAST((QALL.qty_allocated - Proj.qty_proj) AS Int) 
			 ELSE CAST(QALL.qty_allocated AS Int) 
        END AS QALL, 
        CASE WHEN proj.qty_proj > 0 THEN CAST(proj.qty_proj AS INT) 
			 ELSE '0' 
		END AS QPROJ, 
		
		IM.item_note_4 AS ESS, 
        dbo.fn_BG_WMProjection(IM.item_no) AS [WM Forecast],
		/*
        CASE WHEN NOT (IM.extra_1 = 'P') AND CAST(IL.qty_on_hand + IL.qty_on_ord AS INT) < dbo.fn_BG_WMProjection(IM.item_no)
             THEN 'NC WM'
			 ELSE ''
        END AS [WM Fore CHK],   
		*/
        CASE WHEN IL.prior_year_usage IS NULL THEN 0
             ELSE CAST(ROUND(IL.prior_year_usage / 12, 0) AS INT) 
        END AS PMNTH, 
        CASE WHEN QU.usage_ytd IS NULL THEN 0
			 ELSE CEILING(QU.usage_ytd / (DATEDIFF(day, CONVERT(datetime, 
               '01/01/2013', 103), GETDATE()) / 30.5)) 
        END AS CMNTH, 
        CASE WHEN QALL.qty_allocated IS NULL THEN CAST(IL.qty_on_hand + IL.qty_on_ord AS Int) 
		     ELSE CAST(IL.qty_on_hand + IL.qty_on_ord - QALL.qty_allocated AS Int)
		END AS [QOH+QOO-QALL], 
        CASE WHEN QU.usage_ytd > 0 
			 THEN CAST(((qty_on_hand + qty_on_ord) / CEILING((QU.usage_ytd / (DATEDIFF(day,CONVERT(datetime, '01/01/2013', 103), GETDATE()) / 30.5)))) AS money) 
		ELSE 0 END AS MOI,  
		/*
        CASE  WHEN (IM.extra_1 = 'P' AND IM.extra_6 != 'CH-US' AND IM.extra_1 IS NOT NULL)
				THEN ''
				--If there is a WM forecast and it is >= ESS and >= QPROJ then use the WM forecast
					WHEN  dbo.fn_BG_WMProjection(IM.item_no) >= 0
						 AND (dbo.fn_BG_WMProjection(IM.item_no) >= Proj.qty_proj) 
						 AND (dbo.fn_BG_WMProjection(IM.item_no) >= IM.item_note_4 OR IM.item_note_4 IS NULL)
						 AND (IL.qty_on_hand >= 0)
						 AND (ROUND(IL.qty_on_hand + IL.qty_on_ord - (z_iminvloc_qall.qty_allocated-Proj.qty_proj) - CAST(dbo.fn_BG_WMProjection(IM.item_no) AS INT), 0))  < 0
					THEN 'NC-WMF'
					WHEN  dbo.fn_BG_WMProjection(IM.item_no) >= 0
						 AND (dbo.fn_BG_WMProjection(IM.item_no) >= Proj.qty_proj) 
						 AND (dbo.fn_BG_WMProjection(IM.item_no) >= IM.item_note_4 OR IM.item_note_4 IS NULL)
						 AND (IL.qty_on_hand <= 0)	
						 AND (ROUND(IL.qty_on_ord - (z_iminvloc_qall.qty_allocated-Proj.qty_proj) - dbo.fn_BG_WMProjection(IM.item_no), 0))  < 0	
					THEN 'NC-WMF'
					--No projections section, required to avoid nulls in the calculation--				
					WHEN  dbo.fn_BG_WMProjection(IM.item_no) >= 0
						 AND (Proj.qty_proj IS null) 
						 AND (dbo.fn_BG_WMProjection(IM.item_no) >= IM.item_note_4 OR IM.item_note_4 IS NULL)
						 AND (IL.qty_on_hand >= 0)
						 AND (ROUND(IL.qty_on_hand + IL.qty_on_ord - (z_iminvloc_qall.qty_allocated) - dbo.fn_BG_WMProjection(IM.item_no), 0)) < 0
					THEN 'NC-WMF'
					WHEN  dbo.fn_BG_WMProjection(IM.item_no) > 0
						 AND (Proj.qty_proj IS null) 
						 AND (dbo.fn_BG_WMProjection(IM.item_no) >= IM.item_note_4 OR IM.item_note_4 IS NULL)
						 AND (IL.qty_on_hand <= 0)		
						 AND (ROUND(IL.qty_on_ord -(z_iminvloc_qall.qty_allocated) - dbo.fn_BG_WMProjection(IM.item_no), 0)) < 0
					THEN 'NC-WMF'							
				--If there is an ESS and it is >= WMForecast and >= QPROJ then use the ESS and allocations w/o projections
					WHEN IM.item_note_4 >= 0
						 AND (IM.item_note_4 >= Proj.qty_proj) 
						 AND (IM.item_note_4 >= dbo.fn_BG_WMProjection(IM.item_no) OR dbo.fn_BG_WMProjection(IM.item_no) IS NULL)
						 AND (IL.qty_on_hand > 0)
						 AND (ROUND(IL.qty_on_hand + IL.qty_on_ord - (z_iminvloc_qall.qty_allocated-Proj.qty_proj) - IM.item_note_4, 0)) < 0
					THEN 'NC-ESS'
					WHEN IM.item_note_4 >= 0
						 AND (IM.item_note_4 >= Proj.qty_proj) 
						 AND (IM.item_note_4 >= dbo.fn_BG_WMProjection(IM.item_no) OR dbo.fn_BG_WMProjection(IM.item_no) IS NULL)
						 AND (IL.qty_on_hand <= 0)	
						 AND (ROUND(IL.qty_on_ord - (z_iminvloc_qall.qty_allocated-Proj.qty_proj) - IM.item_note_4, 0)) < 0
					THEN 'NC-ESS'
					--No projections section, required to avoid nulls in the calculation--				
					WHEN IM.item_note_4 >= 0
						 AND (IM.item_note_4 >= Proj.qty_proj) 
						 AND (IM.item_note_4 >= dbo.fn_BG_WMProjection(IM.item_no) OR dbo.fn_BG_WMProjection(IM.item_no) IS NULL)
						 AND (IL.qty_on_hand >= 0)
						 AND (ROUND(IL.qty_on_hand + IL.qty_on_ord - (z_iminvloc_qall.qty_allocated-Proj.qty_proj) - dbo.fn_BG_WMProjection(IM.item_no), 0)) < 0
					THEN 'NC-ESS'
					WHEN IM.item_note_4 >= 0
						 AND (IM.item_note_4 >= Proj.qty_proj) 
						 AND (IM.item_note_4 >= dbo.fn_BG_WMProjection(IM.item_no) OR dbo.fn_BG_WMProjection(IM.item_no) IS NULL)
						 AND (IL.qty_on_hand <= 0)	
						 AND (ROUND(IL.qty_on_ord - (z_iminvloc_qall.qty_allocated-Proj.qty_proj) - dbo.fn_BG_WMProjection(IM.item_no), 0)) < 0
					THEN 'NC-ESS'				
				--If there is no forecast but a qty projected and an ESS and it is >= ESS or there is no ESS, then use allocations w/ projections
					WHEN (Proj.qty_proj >= 0) AND (IL.qty_on_hand > 0)
					      AND (Proj.qty_proj >= IM.item_note_4 OR IM.item_note_4 IS NULL)
					      AND (ROUND(IL.qty_on_hand + IL.qty_on_ord - z_iminvloc_qall.qty_allocated, 0)) < 0
					THEN 'NC-PROJ'
					WHEN (Proj.qty_proj >= 0) AND (IL.qty_on_hand <= 0) 
						  AND (Proj.qty_proj >= IM.item_note_4 OR IM.item_note_4 IS NULL) 
						  AND (ROUND(IL.qty_on_ord - z_iminvloc_qall.qty_allocated, 0)) < 0
					THEN 'NC-PROJ'
			   --If there is no forecast but a qty projected and an ESS and if qty projected is < then ESS, then use ESS and allocations w/o projections
					WHEN (NOT (IM.item_note_4 IS NULL)) AND (IL.qty_on_hand >= 0) AND Proj.qty_proj >= 0
						 AND Proj.qty_proj < IM.item_note_4
						 AND (ROUND(IL.qty_on_hand + IL.qty_on_ord - (z_iminvloc_qall.qty_allocated - Proj.qty_proj) - IM.item_note_4, 0)) < 0
				    THEN 'NC-ESS'
				    WHEN (NOT (IM.item_note_4 IS NULL)) AND (IL.qty_on_hand <= 0) AND Proj.qty_proj >= 0 
						 AND Proj.qty_proj < IM.item_note_4
						 AND (ROUND(IL.qty_on_ord - (z_iminvloc_qall.qty_allocated - Proj.qty_proj) - IM.item_note_4, 0)) < 0
				    THEN 'NC-ESS'
			   --If there is a forecast and a qty projected but no ess, and forecast > qty projected, then use allocations w/o projections
					WHEN IM.item_note_4 IS NULL AND Proj.qty_proj >= 0
						 AND dbo.fn_BG_WMProjection(IM.item_no) >= Proj.qty_proj
						 AND (IL.qty_on_hand >= 0)
						 AND (ROUND(IL.qty_on_hand + IL.qty_on_ord - (z_iminvloc_qall.qty_allocated - Proj.qty_proj) - dbo.fn_BG_WMProjection(IM.item_no), 0))  < 0
				    THEN 'NC-WMF'
				    WHEN (NOT (IM.item_note_4 IS NULL)) AND (IL.qty_on_hand <= 0) AND Proj.qty_proj >= 0 
						 AND Proj.qty_proj < IM.item_note_4
						 AND (ROUND(IL.qty_on_ord - (z_iminvloc_qall.qty_allocated - Proj.qty_proj) - dbo.fn_BG_WMProjection(IM.item_no), 0)) < 0
				    THEN 'NC-WMF'
               --If there is a forecast and an ess but no qty projected, and forecast > ess, then use WM forecast and normal allocations
					WHEN IM.item_note_4 IS NOT NULL AND Proj.qty_proj IS NULL
						 AND dbo.fn_BG_WMProjection(IM.item_no) >= IM.item_note_4
						 AND (IL.qty_on_hand >= 0)
						 AND (ROUND(IL.qty_on_hand + IL.qty_on_ord - (z_iminvloc_qall.qty_allocated) - dbo.fn_BG_WMProjection(IM.item_no), 0)) < 0
				    THEN 'NC-WMF'
				    WHEN (NOT (IM.item_note_4 IS NULL)) AND (IL.qty_on_hand <= 0) AND Proj.qty_proj >= 0 
						 AND Proj.qty_proj < IM.item_note_4
						 AND (ROUND(IL.qty_on_ord - (z_iminvloc_qall.qty_allocated) - dbo.fn_BG_WMProjection(IM.item_no), 0)) < 0
				    THEN 'NC-WMF'
			   --If there is no forecast and no qty projected but an ESS, then use ESS and normal allocations                                
				    WHEN (NOT (IM.item_note_4 IS NULL)) AND Proj.qty_proj IS NULL
						 AND (IL.qty_on_hand >= 0) 
						 AND (ROUND(IL.qty_on_hand + IL.qty_on_ord - z_iminvloc_qall.qty_allocated - IM.item_note_4, 0)) < 0
				    THEN 'NC-ESS'
				    WHEN (NOT (IM.item_note_4 IS NULL)) AND Proj.qty_proj IS NULL
						 AND (IL.qty_on_hand < 0) 
						 AND (ROUND(IL.qty_on_ord - z_iminvloc_qall.qty_allocated - IM.item_note_4, 0))  < 0
				    THEN 'NC-ESS'
			   --If there is no forecast and no ESS but an qty projected, then use allocations w/ projections
				   WHEN (IM.item_note_4 IS NULL) AND dbo.fn_BG_WMProjection(IM.item_no) IS NULL
						 AND Proj.qty_proj >= 0	 AND (IL.qty_on_hand >= 0)
						 AND (ROUND(IL.qty_on_hand + IL.qty_on_ord - (z_iminvloc_qall.qty_allocated), 0)) < 0  
				   THEN 'NC-PROJ'
				   WHEN (IM.item_note_4 IS NULL) AND dbo.fn_BG_WMProjection(IM.item_no) IS NULL
						AND Proj.qty_proj >= 0 AND (IL.qty_on_hand < 0)  
						AND (ROUND(IL.qty_on_ord - (z_iminvloc_qall.qty_allocated), 0))	 < 0 
				   THEN 'NC-PROJ'
			  --If there is no forecast and no ESS and no qty projected, then use none		
				   WHEN (IM.item_note_4 IS NULL) AND dbo.fn_BG_WMProjection(IM.item_no) IS NULL
						AND Proj.qty_proj IS NULL
						AND (IL.qty_on_hand >= 0) 
						AND (ROUND(IL.qty_on_hand + IL.qty_on_ord - z_iminvloc_qall.qty_allocated, 0)) < 0 
				   THEN 'NC'  
				   WHEN (IM.item_note_4 IS NULL) AND dbo.fn_BG_WMProjection(IM.item_no) IS NULL
						AND Proj.qty_proj IS NULL
						AND (IL.qty_on_hand < 0) 
						AND (ROUND(IL.qty_on_ord - z_iminvloc_qall.qty_allocated, 0)) < 0
				  THEN  'NC'	            
         ELSE '' END AS [CHECK],
               
          '_____' AS 'Order',   
                 
          CASE  --If there is a WM forecast and it is >= ESS and >= QPROJ then use the WM forecast
					WHEN  dbo.fn_BG_WMProjection(IM.item_no) >= 0
						 AND (dbo.fn_BG_WMProjection(IM.item_no) >= Proj.qty_proj) 
						 AND (dbo.fn_BG_WMProjection(IM.item_no) >= IM.item_note_4 OR IM.item_note_4 IS NULL)
						 AND (IL.qty_on_hand >= 0)
					THEN (ROUND(IL.qty_on_hand + IL.qty_on_ord - (z_iminvloc_qall.qty_allocated-Proj.qty_proj) - CAST(dbo.fn_BG_WMProjection(IM.item_no) AS INT), 0))   
					WHEN  dbo.fn_BG_WMProjection(IM.item_no) >= 0
						 AND (dbo.fn_BG_WMProjection(IM.item_no) >= Proj.qty_proj) 
						 AND (dbo.fn_BG_WMProjection(IM.item_no) >= IM.item_note_4 OR IM.item_note_4 IS NULL)
						 AND (IL.qty_on_hand <= 0)						 
					THEN (ROUND(IL.qty_on_ord - (z_iminvloc_qall.qty_allocated-Proj.qty_proj) - dbo.fn_BG_WMProjection(IM.item_no), 0))   
					--No projections section, required to avoid nulls in the calculation--				
					WHEN  dbo.fn_BG_WMProjection(IM.item_no) >= 0
						 AND (Proj.qty_proj IS null) 
						 AND (dbo.fn_BG_WMProjection(IM.item_no) >= IM.item_note_4 OR IM.item_note_4 IS NULL)
						 AND (IL.qty_on_hand >= 0)
					THEN (ROUND(IL.qty_on_hand + IL.qty_on_ord - (z_iminvloc_qall.qty_allocated) - dbo.fn_BG_WMProjection(IM.item_no), 0))
					WHEN  dbo.fn_BG_WMProjection(IM.item_no) > 0
						 AND (Proj.qty_proj IS null) 
						 AND (dbo.fn_BG_WMProjection(IM.item_no) >= IM.item_note_4 OR IM.item_note_4 IS NULL)
						 AND (IL.qty_on_hand <= 0)						 
					THEN (ROUND(IL.qty_on_ord - (z_iminvloc_qall.qty_allocated) - dbo.fn_BG_WMProjection(IM.item_no), 0))							
				--If there is an ESS and it is >= WMForecast and >= QPROJ then use the ESS
					WHEN IM.item_note_4 >= 0
						 AND (IM.item_note_4 >= Proj.qty_proj) 
						 AND (IM.item_note_4 >= dbo.fn_BG_WMProjection(IM.item_no) OR dbo.fn_BG_WMProjection(IM.item_no) IS NULL)
						 AND (IL.qty_on_hand > 0)
					THEN (ROUND(IL.qty_on_hand + IL.qty_on_ord - (z_iminvloc_qall.qty_allocated-Proj.qty_proj) - IM.item_note_4, 0))
					WHEN IM.item_note_4 >= 0
						 AND (IM.item_note_4 >= Proj.qty_proj) 
						 AND (IM.item_note_4 >= dbo.fn_BG_WMProjection(IM.item_no) OR dbo.fn_BG_WMProjection(IM.item_no) IS NULL)
						 AND (IL.qty_on_hand <= 0)					 
					THEN (ROUND(IL.qty_on_ord - (z_iminvloc_qall.qty_allocated-Proj.qty_proj) - IM.item_note_4, 0))	
					--No projections section, required to avoid nulls in the calculation--				
					WHEN IM.item_note_4 >= 0
						 AND (IM.item_note_4 >= Proj.qty_proj) 
						 AND (IM.item_note_4 >= dbo.fn_BG_WMProjection(IM.item_no) OR dbo.fn_BG_WMProjection(IM.item_no) IS NULL)
						 AND (IL.qty_on_hand >= 0)
					THEN (ROUND(IL.qty_on_hand + IL.qty_on_ord - (z_iminvloc_qall.qty_allocated) - dbo.fn_BG_WMProjection(IM.item_no), 0))
					WHEN IM.item_note_4 >= 0
						 AND (IM.item_note_4 >= Proj.qty_proj) 
						 AND (IM.item_note_4 >= dbo.fn_BG_WMProjection(IM.item_no) OR dbo.fn_BG_WMProjection(IM.item_no) IS NULL)
						 AND (IL.qty_on_hand <= 0)					 
					THEN (ROUND(IL.qty_on_ord - (z_iminvloc_qall.qty_allocated) - dbo.fn_BG_WMProjection(IM.item_no), 0))						
				--If there is no forecast but a qty projected and an ESS and it is >= ESS or there is no ESS, then use allocations w/ projections
					WHEN (Proj.qty_proj >= 0) AND (IL.qty_on_hand > 0)
					      AND (Proj.qty_proj >= IM.item_note_4 OR IM.item_note_4 IS NULL)
					THEN (ROUND(IL.qty_on_hand + IL.qty_on_ord - z_iminvloc_qall.qty_allocated, 0))
					WHEN (Proj.qty_proj >= 0) AND (IL.qty_on_hand <= 0) 
						  AND (Proj.qty_proj >= IM.item_note_4 OR IM.item_note_4 IS NULL) 
					THEN (ROUND(IL.qty_on_ord - z_iminvloc_qall.qty_allocated, 0))
			   --If there is no forecast but a qty projected and an ESS and if qty projected is < then ESS, then use allocations w/o projections
					WHEN (NOT (IM.item_note_4 IS NULL)) AND (IL.qty_on_hand >= 0) AND Proj.qty_proj >= 0
						 AND Proj.qty_proj < IM.item_note_4
				    THEN (ROUND(IL.qty_on_hand + IL.qty_on_ord - (z_iminvloc_qall.qty_allocated - Proj.qty_proj) - IM.item_note_4, 0)) 
				    WHEN (NOT (IM.item_note_4 IS NULL)) AND (IL.qty_on_hand <= 0) AND Proj.qty_proj >= 0 
						 AND Proj.qty_proj < IM.item_note_4
				    THEN (ROUND(IL.qty_on_ord - (z_iminvloc_qall.qty_allocated - Proj.qty_proj) - IM.item_note_4, 0)) 
			   --If there is a forecast and a qty projected but no ess, and forecast > qty projected, then use allocations w/o projections
					WHEN IM.item_note_4 IS NULL AND Proj.qty_proj >= 0
						 AND dbo.fn_BG_WMProjection(IM.item_no) >= Proj.qty_proj
						 AND (IL.qty_on_hand >= 0)
				    THEN 333--(ROUND(IL.qty_on_hand + IL.qty_on_ord - (z_iminvloc_qall.qty_allocated - Proj.qty_proj) - dbo.fn_BG_WMProjection(IM.item_no), 0)) 
				    WHEN (NOT (IM.item_note_4 IS NULL)) AND (IL.qty_on_hand <= 0) AND Proj.qty_proj >= 0 
						 AND Proj.qty_proj < IM.item_note_4
				    THEN (ROUND(IL.qty_on_ord - (z_iminvloc_qall.qty_allocated - Proj.qty_proj) - dbo.fn_BG_WMProjection(IM.item_no), 0)) 
               --If there is a forecast and ess but no qty projected, and forecast > qty projected, then use allocations w/ projections
					WHEN IM.item_note_4 IS NOT NULL AND Proj.qty_proj IS NULL
						 AND dbo.fn_BG_WMProjection(IM.item_no) >= IM.item_note_4
						 AND (IL.qty_on_hand >= 0)
				    THEN (ROUND(IL.qty_on_hand + IL.qty_on_ord - (z_iminvloc_qall.qty_allocated) - dbo.fn_BG_WMProjection(IM.item_no), 0)) 
				    WHEN (NOT (IM.item_note_4 IS NULL)) AND (IL.qty_on_hand <= 0) AND Proj.qty_proj >= 0 
						 AND Proj.qty_proj < IM.item_note_4
				    THEN (ROUND(IL.qty_on_ord - (z_iminvloc_qall.qty_allocated) - dbo.fn_BG_WMProjection(IM.item_no), 0)) 
			   --If there is no forecast and no qty projected but an ESS, then use ESS and normal allocations                                
				    WHEN (NOT (IM.item_note_4 IS NULL)) AND Proj.qty_proj IS NULL
						 AND (IL.qty_on_hand >= 0) 
				    THEN (ROUND(IL.qty_on_hand + IL.qty_on_ord - z_iminvloc_qall.qty_allocated - IM.item_note_4, 0)) 
				    WHEN (NOT (IM.item_note_4 IS NULL)) AND (IL.qty_on_hand <= 0) 
				    THEN (ROUND(IL.qty_on_ord - z_iminvloc_qall.qty_allocated - IM.item_note_4, 0)) 
			   --If there is no forecast and no ESS but an qty projected, then use qty projected and allocationed w/o projections
				   WHEN (IM.item_note_4 IS NULL) AND dbo.fn_BG_WMProjection(IM.item_no) IS NULL
						 AND Proj.qty_proj >= 0	 AND (IL.qty_on_hand >= 0) 
				   THEN (ROUND(IL.qty_on_hand + IL.qty_on_ord - (z_iminvloc_qall.qty_allocated - Proj.qty_proj) - Proj.qty_proj, 0))	
				   WHEN (IM.item_note_4 IS NULL) AND dbo.fn_BG_WMProjection(IM.item_no) IS NULL
						AND Proj.qty_proj >= 0 AND (IL.qty_on_hand < 0)  
				   THEN (ROUND(IL.qty_on_ord - (z_iminvloc_qall.qty_allocated - Proj.qty_proj) - Proj.qty_proj, 0))				
			  --If there is no forecast and no ESS and no qty projected, then use none		
				   WHEN (IM.item_note_4 IS NULL) AND dbo.fn_BG_WMProjection(IM.item_no) IS NULL
						AND Proj.qty_proj IS NULL
						AND (IL.qty_on_hand >= 0) 
				   THEN (ROUND(IL.qty_on_hand + IL.qty_on_ord - z_iminvloc_qall.qty_allocated, 0))     
				   WHEN (IM.item_note_4 IS NULL) AND dbo.fn_BG_WMProjection(IM.item_no) IS NULL
						AND Proj.qty_proj IS NULL
						AND (IL.qty_on_hand < 0) 
				   THEN (ROUND(IL.qty_on_ord - z_iminvloc_qall.qty_allocated, 0))	            
         ELSE 0 
         END AS [QOH+QOO-QOA-(ESS/WMF/QPROJ)], 
		 

            
       CASE WHEN (NOT (IM.extra_1 = 'P') OR IM.extra_1 IS NULL OR  IM.extra_6 = 'CH-US') 
				AND (IL.qty_on_hand <= 0) 
				AND ((ROUND(IL.qty_on_ord - (3 * CEILING(QU.usage_ytd / (DATEDIFF(day, CONVERT(datetime, '01/01/2013', 103), GETDATE()) / 30.5))), 0)) < 0) 
       THEN 'NC' 
       WHEN (NOT (IM.extra_1 = 'P') OR IM.extra_1 IS NULL OR IM.extra_6 = 'CH-US') 
			AND (IL.qty_on_hand > 0) 
			AND ((ROUND(IL.qty_on_ord - IL.qty_on_hand - (3 * CEILING(QU.usage_ytd / (DATEDIFF(day, CONVERT(datetime, '01/01/2013', 103), GETDATE()) / 30.5))), 0)) < 0) 
	   THEN 'NC' 
       ELSE '' END AS [CHECK 90], 
       */
       /*
       CASE WHEN (IL.qty_on_hand > 0) AND NOT (Z_IMINVLOC_USAGE.usage_ytd IS NULL)
			THEN (ROUND(IL.qty_on_ord + IL.qty_on_hand - (3 * CEILING(QU.usage_ytd / (DATEDIFF(day, CONVERT(datetime, '01/01/2013', 103), GETDATE()) / 30.5))), 0)) 
			WHEN (IL.qty_on_hand > 0) AND (Z_IMINVLOC_USAGE.usage_ytd IS NULL)
			THEN (ROUND(IL.qty_on_ord + IL.qty_on_hand, 3))	
			WHEN (IL.qty_on_hand <= 0) AND NOT (Z_IMINVLOC_USAGE.usage_ytd IS NULL)
			THEN (ROUND(IL.qty_on_ord - (3 * CEILING(QU.usage_ytd / (DATEDIFF(day, CONVERT(datetime, '01/01/2013', 103), GETDATE())/ 30.5))), 0)) 
			WHEN (IL.qty_on_hand <= 0) AND (Z_IMINVLOC_USAGE.usage_ytd IS NULL)
			THEN (ROUND(IL.qty_on_ord,3))
		ELSE '' END AS [QOH+QOO-90], 	
	   */
       IL.po_min AS MOQ, 
       --'_________' AS [ORDER], 
       IM.item_note_2 AS Supplier,  
       IM.item_note_5 AS [Misc Note (N5)],
       IM.p_and_ic_cd AS [Rec Loc],
       IL.prior_year_usage AS PYU, 
       QU.usage_ytd,     
       CAST(ROUND(IL.last_cost, 2, 0) AS DECIMAL(8, 2)) AS LC, 
       CAST(ROUND(IL.std_cost, 2, 0) AS DECIMAL(8, 2)) AS SC, 
       IM.drawing_release_no AS [Dwg #], 
       IM.drawing_revision_no AS [Dwg Rev]              
FROM  dbo.iminvloc_sql IL WITH (NOLOCK) INNER JOIN
               dbo.imitmidx_sql AS IM WITH (NOLOCK) ON IL.item_no = IM.item_no 
			   LEFT OUTER JOIN  dbo.Z_IMINVLOC_QALL_BY_LOC AS QALL WITH (NOLOCK)  ON QALL.item_no = IL.item_no AND QALL.loc = IL.loc
			   LEFT OUTER JOIN  dbo.Z_IMINVLOC_USAGE_BY_LOC AS QU WITH (NOLOCK)  ON  QU.item_no = IL.item_no  AND QU.loc = IL.loc
			   --LEFT OUTER JOIN dbo.Z_IMINVLOC_QOH_CHECK AS QC WITH (NOLOCK) ON QC.item_no = IL.item_no 
			   LEFT OUTER JOIN dbo.BG_WM_Current_Projections_Loc AS PROJ WITH (NOLOCK) ON PROJ.item_no = IM.item_no AND PROJ.loc = IL.loc
WHERE (IM.item_note_1 = 'CH') 
		AND IL.loc = 'EC' 
		--AND (NOT (IL.prod_cat = '036' OR IL.prod_cat = '037' OR IL.prod_cat = '336')) 
		AND ((QU.usage_ytd > 0) OR (IL.qty_on_ord > 0) OR (QALL.qty_allocated > 0) OR (IL.prior_year_usage > 0) OR (IL.qty_on_hand > 0) OR IM.activity_dt > CONVERT(datetime, '05/01/2013', 103)) 
		--Test
		--AND IM.item_no = '23" SPT BAR GB' 