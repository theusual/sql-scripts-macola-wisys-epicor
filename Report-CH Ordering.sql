--Created:	02/01/11	 By:	BG
--Last Updated:	4/1/13	 By:	BG
--Purpose: Original China Ordering Report For DLC
--Last Change:  Added case when Qty Proj > 0 then do not use ESS in the calculation for [NC] and [QOH+QOO-QOA-ESS].  Update 2: Fixed Error

USE [001]
GO

SET QUOTED_IDENTIFIER ON
GO

--ALTER VIEW [dbo].[BG_Daily_CH_Order_Report] AS
SELECT TOP (100) PERCENT '___' AS LN, 
		Z_IMINVLOC.prod_cat AS Cat, 
		CASE WHEN (IMITMIDX_SQL.extra_1) IS NULL THEN '' ELSE IMITMIDX_SQL.extra_1 END AS Parent, 
		Z_IMINVLOC.item_no, IMITMIDX_SQL.item_desc_1, IMITMIDX_SQL.item_desc_2, 
        CAST(Z_IMINVLOC.qty_on_ord AS INT) AS QOO, 
        CAST(Z_IMINVLOC.qty_on_hand AS Int) AS QOH, 
        CAST(QC.[QOH CHECK] AS INT) AS [QOH CHK], '___' AS AQOH, 
        CAST(Z_IMINVLOC.frz_qty AS INT) AS FQTY, 
        IMITMIDX_SQL.extra_6 AS [CH-US], 
        dbo.Z_IMINVLOC_QALL.qty_allocated AS QALL_ALL, 
        CASE WHEN proj.qty_proj > 0 THEN CAST((dbo.Z_IMINVLOC_QALL.qty_allocated - Proj.qty_proj) AS Int) 
			 ELSE CAST(Z_IMINVLOC_QALL.qty_allocated AS Int) 
        END AS QALL, 
        CASE WHEN proj.qty_proj > 0 THEN CAST(proj.qty_proj AS INT) 
			 ELSE '0' 
		END AS QPROJ, 
		IMITMIDX_SQL.item_note_4 AS ESS, 
        CAST(ROUND(Z_IMINVLOC.prior_year_usage / 12, 0) AS INT) AS PMNTH, 
        CEILING(dbo.Z_IMINVLOC_USAGE.usage_ytd / (DATEDIFF(day, CONVERT(datetime, 
               '01/01/2013', 103), GETDATE()) / 30.5)) AS CMNTH, 
        CAST(Z_IMINVLOC.qty_on_hand - dbo.Z_IMINVLOC_QALL.qty_allocated AS Int) AS [QOH-QOA], 
        CASE WHEN z_iminvloc_usage.usage_ytd > 0 
			 THEN CAST(((qty_on_hand + qty_on_ord) / CEILING((z_iminvloc_usage.usage_ytd / (DATEDIFF(day,CONVERT(datetime, '01/01/2013', 103), GETDATE()) / 30.5)))) AS money) 
		ELSE 0 END AS MOI,   
		           
        CASE  --If there is a qty projected, then do not use ESS
					WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR imitmidx_sql.extra_1 IS NULL OR imitmidx_sql.extra_6 = 'CH-US') AND
                    (Proj.qty_proj > 0) AND (Z_IMINVLOC.qty_on_hand >= 0)
                    AND (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated, 0) < 0) THEN 'NC'
                    WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR imitmidx_sql.extra_1 IS NULL OR imitmidx_sql.extra_6 = 'CH-US') AND
                    (Proj.qty_proj > 0) AND (Z_IMINVLOC.qty_on_hand < 0) AND
                    ((ROUND(Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated, 0)) < 0) THEN 'NC'
               WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR imitmidx_sql.extra_1 IS NULL OR imitmidx_sql.extra_6 = 'CH-US') 
               AND NOT (IMITMIDX_SQL.item_note_4 IS NULL) AND (PROJ.qty_proj IS NULL OR PROJ.qty_proj <=0) AND (Z_IMINVLOC.qty_on_hand <= 0) AND 
               ((ROUND(Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated - IMITMIDX_SQL.item_note_4, 0)) < 0) THEN 'NC'  
               WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR imitmidx_sql.extra_1 IS NULL OR imitmidx_sql.extra_6 = 'CH-US') 
               AND NOT (IMITMIDX_SQL.item_note_4 IS NULL) AND (PROJ.qty_proj IS NULL OR PROJ.qty_proj <=0) AND (Z_IMINVLOC.qty_on_hand > 0) AND 
               ((ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated - IMITMIDX_SQL.item_note_4, 0)) < 0)  THEN 'NC'
               WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR  imitmidx_sql.extra_1 IS NULL OR imitmidx_sql.extra_6 = 'CH-US') 
               AND NOT (IMITMIDX_SQL.item_note_4 IS NULL) AND (PROJ.qty_proj IS NULL OR PROJ.qty_proj <=0) AND (Z_IMINVLOC.qty_on_hand <= 0) AND 
               ((ROUND(Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated - IMITMIDX_SQL.item_note_4, 0)) < 0)  THEN 'NC' 
               WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR imitmidx_sql.extra_1 IS NULL OR imitmidx_sql.extra_6 = 'CH-US') 
               AND ((IMITMIDX_SQL.item_note_4 IS NULL) AND (Z_IMINVLOC.qty_on_hand > 0) 
               AND (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated, 0) < 0)) THEN 'NC' 
               WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR imitmidx_sql.extra_1 IS NULL OR imitmidx_sql.extra_6 = 'CH-US') 
               AND ((IMITMIDX_SQL.item_note_4 IS NULL) AND (Z_IMINVLOC.qty_on_hand <= 0) AND 
               (ROUND(Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated, 0) < 0)) THEN 'NC' 
               WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR imitmidx_sql.extra_1 IS NULL OR imitmidx_sql.extra_6 = 'CH-US') 
               AND ((IMITMIDX_SQL.item_note_4 IS NULL) AND (Z_IMINVLOC.qty_on_hand > 0) AND 
               (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated, 0) < 0)) THEN 'NC' 
               ELSE '' END AS [CHECK], 
               
          CASE --If there is a qty projected, then do not use ESS
					WHEN (Proj.qty_proj > 0) AND (Z_IMINVLOC.qty_on_hand > 0)
					THEN (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated, 0))
					WHEN (Proj.qty_proj > 0) AND (Z_IMINVLOC.qty_on_hand <= 0)
					THEN (ROUND(Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated, 0))
               WHEN (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (Z_IMINVLOC.qty_on_hand > 0) 
               THEN (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated - IMITMIDX_SQL.item_note_4, 0)) 
               WHEN (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (Z_IMINVLOC.qty_on_hand <= 0) 
               THEN (ROUND(Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated - IMITMIDX_SQL.item_note_4, 0)) 
               WHEN (IMITMIDX_SQL.item_note_4 IS NULL) AND (Z_IMINVLOC.qty_on_hand > 0) 
               THEN (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated, 0)) 
               WHEN (IMITMIDX_SQL.item_note_4 IS NULL) AND (Z_IMINVLOC.qty_on_hand <= 0) 
               THEN (ROUND(Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated, 0))  
         ELSE '' END AS [QOH+QOO-QOA-SS],   
       IMITMIDX_SQL.uom, 
       
       CASE WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR imitmidx_sql.extra_1 IS NULL OR  imitmidx_sql.extra_6 = 'CH-US') 
				AND (Z_IMINVLOC.qty_on_hand < 1) 
				AND ((ROUND(Z_IMINVLOC.qty_on_ord - (3 * CEILING(dbo.Z_IMINVLOC_USAGE.usage_ytd / (DATEDIFF(day, CONVERT(datetime, '01/01/2013', 103), GETDATE()) / 30.5))), 0)) < 0) 
       THEN 'NC' 
       WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR imitmidx_sql.extra_1 IS NULL OR imitmidx_sql.extra_6 = 'CH-US') 
			AND (Z_IMINVLOC.qty_on_hand > 0) 
			AND ((ROUND(Z_IMINVLOC.qty_on_ord - Z_IMINVLOC.qty_on_hand - (3 * CEILING(dbo.Z_IMINVLOC_USAGE.usage_ytd / (DATEDIFF(day, CONVERT(datetime, '01/01/2013', 103), GETDATE()) / 30.5))), 0)) < 0) 
	   THEN 'NC' 
       ELSE '' END AS [CHECK 90], 
       CASE WHEN (Z_IMINVLOC.qty_on_hand > 0) 
			THEN (ROUND(Z_IMINVLOC.qty_on_ord + Z_IMINVLOC.qty_on_hand - (3 * CEILING(dbo.Z_IMINVLOC_USAGE.usage_ytd / (DATEDIFF(day, CONVERT(datetime, '01/01/2013', 103), GETDATE()) / 30.5))), 0)) 
			WHEN (Z_IMINVLOC.qty_on_hand < 1) 
			THEN (ROUND(Z_IMINVLOC.qty_on_ord - (3 * CEILING(dbo.Z_IMINVLOC_USAGE.usage_ytd / (DATEDIFF(day, CONVERT(datetime, '01/01/2013', 103), GETDATE())/ 30.5))), 0)) 
		ELSE '' END AS [QOH+QOO-90], 	
       Z_IMINVLOC.po_min AS MOQ, 
       '_________' AS [ORDER], 
       IMITMIDX_SQL.item_note_2 AS Supplier, 
       IMITMIDX_SQL.item_note_3 AS [Critical Item], 
       IMITMIDX_SQL.item_note_5 AS [Misc Note (N5)], 
       IMITMIDX_SQL.p_and_ic_cd AS [Rec Loc], 
       Z_IMINVLOC.prior_year_usage AS PYU, 
       dbo.Z_IMINVLOC_USAGE.usage_ytd,     
       CAST(ROUND(Z_IMINVLOC.last_cost, 2, 0) AS DECIMAL(8, 2)) AS LC, 
       CAST(ROUND(Z_IMINVLOC.std_cost, 2, 0) AS DECIMAL(8, 2)) AS SC, 
       IMITMIDX_SQL.drawing_release_no AS [Dwg #], 
       IMITMIDX_SQL.drawing_revision_no AS [Dwg Rev],
       dbo.fn_BG_WMProjection(IMITMIDX_SQL.item_no) AS [NewWMProj]                   
               
FROM  dbo.Z_IMINVLOC AS Z_IMINVLOC WITH (NOLOCK) INNER JOIN
               dbo.imitmidx_sql AS IMITMIDX_SQL WITH (NOLOCK) ON Z_IMINVLOC.item_no = IMITMIDX_SQL.item_no LEFT OUTER JOIN
               dbo.Z_IMINVLOC_QALL WITH (NOLOCK) ON dbo.Z_IMINVLOC_QALL.item_no = Z_IMINVLOC.item_no LEFT OUTER JOIN
               dbo.Z_IMINVLOC_USAGE WITH (NOLOCK) ON dbo.Z_IMINVLOC_USAGE.item_no = Z_IMINVLOC.item_no LEFT OUTER JOIN
               dbo.Z_IMINVLOC_QOH_CHECK AS QC WITH (NOLOCK) ON QC.item_no = Z_IMINVLOC.item_no LEFT OUTER JOIN
               dbo.BG_WM_Current_Projections AS PROJ WITH (NOLOCK) ON PROJ.item_no = IMITMIDX_SQL.item_no 
               
WHERE (IMITMIDX_SQL.item_note_1 = 'CH') 
		AND (NOT (Z_IMINVLOC.prod_cat = '036' OR Z_IMINVLOC.prod_cat = '037' OR Z_IMINVLOC.prod_cat = '336'))
		AND ((dbo.Z_IMINVLOC_USAGE.usage_ytd > 0) OR (Z_IMINVLOC.qty_on_ord > 0) OR (dbo.Z_IMINVLOC_QALL.qty_allocated > 0) 
				OR (Z_IMINVLOC.prior_year_usage > 0) OR (Z_IMINVLOC.qty_on_hand > 0))
		--Test
		--AND IMITMIDX_SQL.item_no LIKE 'BAK-697-2 O%' 
ORDER BY Z_IMINVLOC.item_no