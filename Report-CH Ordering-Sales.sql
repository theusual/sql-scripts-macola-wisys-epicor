--Created:	10/29/12	 By:	BG
--Last Updated:	10/29/12	 By:	BG
--Purpose: CH Ordering Report for Weekly Sales Email 

USE [001]
GO

SET QUOTED_IDENTIFIER ON
GO

--ALTER VIEW [dbo].[BG_Daily_CH_Order_Report_SalesEmail] AS
SELECT     TOP (100) PERCENT 
					--'___' AS LN, 
					CAST(Z_IMINVLOC.prod_cat AS VARCHAR(3)) AS ProdCat, 
					CASE WHEN (IMITMIDX_SQL.extra_1) IS NULL THEN '' ELSE IMITMIDX_SQL.extra_1 END AS Parent, 
                    CAST(Z_IMINVLOC.item_no AS VARCHAR(30)) AS item_no, 
                    CAST(IMITMIDX_SQL.item_desc_1 AS VARCHAR(60)) AS item_desc_1,
                    CAST(IMITMIDX_SQL.item_desc_2 AS VARCHAR(60)) AS item_desc_2, 
                    CAST(Z_IMINVLOC.qty_on_ord AS INT) AS QOO, 
                    CAST(Z_IMINVLOC.qty_on_hand AS Int) AS QOH, 
                    --CAST(QC.[QOH CHECK] AS INT) AS [QOH CHK],
                    --CAST(Z_IMINVLOC.frz_qty AS INT) AS FQTY, 
                    --IMITMIDX_SQL.extra_6 AS [CH-US], 
                    CAST(Z_IMINVLOC_QALL.qty_allocated AS INT) AS [QALL], 
                    /*CASE WHEN proj.qty_proj > 0 THEN CAST((dbo.Z_IMINVLOC_QALL.qty_allocated - Proj.qty_proj) AS Int) 
                      ELSE CAST(Z_IMINVLOC_QALL.qty_allocated AS Int) END AS QALL, */
                    --CASE WHEN proj.qty_proj > 0 THEN CAST(proj.qty_proj AS INT) ELSE '0' END AS QPROJ, 
                    /*IMITMIDX_SQL.item_note_4 AS ESS, CAST(ROUND(Z_IMINVLOC.prior_year_usage / 12, 0) AS INT) AS PMNTH, 
                    CEILING(dbo.Z_IMINVLOC_USAGE.usage_ytd / (DATEDIFF(day, CONVERT(datetime, '01/01/2012', 103), GETDATE()) / 30.5)) AS CMNTH,*/ 
                    CAST(Z_IMINVLOC.qty_on_hand - dbo.Z_IMINVLOC_QALL.qty_allocated AS Int) AS [QOH-QOA], 
					/*CASE WHEN z_iminvloc_usage.usage_ytd > 0 THEN CAST(((qty_on_hand + qty_on_ord) / CEILING((z_iminvloc_usage.usage_ytd / (DATEDIFF(day, CONVERT(datetime, 
						  '01/01/2012', 103), GETDATE()) / 30.5)))) AS money) ELSE 0 END AS MOI, CASE WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR
						  imitmidx_sql.extra_1 IS NULL OR
						  imitmidx_sql.extra_6 = 'CH-US') AND (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (Z_IMINVLOC.qty_on_hand < 0) AND 
						  ((ROUND(Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated - IMITMIDX_SQL.item_note_4, 0)) < 0) THEN 'NC' WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR
						  imitmidx_sql.extra_1 IS NULL OR
						  imitmidx_sql.extra_6 = 'CH-US') AND ((NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (Z_IMINVLOC.qty_on_hand > 0) AND 
						  ((ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated - IMITMIDX_SQL.item_note_4, 0)) < 0)) 
						  THEN 'NC' WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR
						  imitmidx_sql.extra_1 IS NULL OR
						  imitmidx_sql.extra_6 = 'CH-US') AND ((NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (Z_IMINVLOC.qty_on_hand = 0) AND 
						  ((ROUND(Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated - IMITMIDX_SQL.item_note_4, 0)) < 0)) THEN 'NC' WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR
						  imitmidx_sql.extra_1 IS NULL OR
						  imitmidx_sql.extra_6 = 'CH-US') AND ((IMITMIDX_SQL.item_note_4 IS NULL) AND (Z_IMINVLOC.qty_on_hand > 0) AND 
						  (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated, 0) < 0)) THEN 'NC' WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR
						  imitmidx_sql.extra_1 IS NULL OR
						  imitmidx_sql.extra_6 = 'CH-US') AND ((IMITMIDX_SQL.item_note_4 IS NULL) AND (Z_IMINVLOC.qty_on_hand < 0) AND 
						  (ROUND(Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated, 0) < 0)) THEN 'NC' WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR
						  imitmidx_sql.extra_1 IS NULL OR
						  imitmidx_sql.extra_6 = 'CH-US') AND ((IMITMIDX_SQL.item_note_4 IS NULL) AND (Z_IMINVLOC.qty_on_hand > 0) AND 
						  (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated, 0) < 0)) THEN 'NC' WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR
						  imitmidx_sql.extra_1 IS NULL OR
						  imitmidx_sql.extra_6 = 'CH-US') AND ((IMITMIDX_SQL.item_note_4 IS NULL) AND (Z_IMINVLOC.qty_on_hand = 0) AND 
						  (ROUND(Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated, 0) < 0)) THEN 'NC' ELSE '' END AS [CHECK], */
                      /*CASE WHEN (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (Z_IMINVLOC.qty_on_hand > 0) 
						  THEN (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated - IMITMIDX_SQL.item_note_4, 0)) 
						  WHEN (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (Z_IMINVLOC.qty_on_hand < 0) 
						  THEN (ROUND(Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated - IMITMIDX_SQL.item_note_4, 0)) WHEN (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND 
						  (Z_IMINVLOC.qty_on_hand = 0) THEN (ROUND(Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated - IMITMIDX_SQL.item_note_4, 0)) 
						  WHEN (IMITMIDX_SQL.item_note_4 IS NULL) AND (Z_IMINVLOC.qty_on_hand > 0) 
						  THEN (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated, 0)) WHEN (IMITMIDX_SQL.item_note_4 IS NULL) AND 
						  (Z_IMINVLOC.qty_on_hand < 0) THEN (ROUND(Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated, 0)) WHEN (IMITMIDX_SQL.item_note_4 IS NULL) AND 
						  (Z_IMINVLOC.qty_on_hand = 0) THEN (ROUND(Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated, 0)) ELSE '' END AS [QOH+QOO-QOA-SS], */
					  IMITMIDX_SQL.uom AS UOM, 
                      /*CASE WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR
						  imitmidx_sql.extra_1 IS NULL OR
						  imitmidx_sql.extra_6 = 'CH-US') AND (Z_IMINVLOC.qty_on_hand < 1) AND 
						  ((ROUND(Z_IMINVLOC.qty_on_ord - (3 * CEILING(dbo.Z_IMINVLOC_USAGE.usage_ytd / (DATEDIFF(day, CONVERT(datetime, '01/01/2012', 103), GETDATE()) / 30.5))), 0)) 
						  < 0) THEN 'NC' WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR
						  imitmidx_sql.extra_1 IS NULL OR
						  imitmidx_sql.extra_6 = 'CH-US') 
						  AND (Z_IMINVLOC.qty_on_hand > 0) 
						  AND ((ROUND(Z_IMINVLOC.qty_on_ord - Z_IMINVLOC.qty_on_hand - (3 * CEILING(dbo.Z_IMINVLOC_USAGE.usage_ytd / (DATEDIFF(day, CONVERT(datetime, '01/01/2012', 
						  103), GETDATE()) / 30.5))), 0)) < 0) THEN 'NC' ELSE '' END AS [CHECK 90], */
                      /*CASE WHEN (Z_IMINVLOC.qty_on_hand > 0) 
						  THEN (ROUND(Z_IMINVLOC.qty_on_ord + Z_IMINVLOC.qty_on_hand - (3 * CEILING(dbo.Z_IMINVLOC_USAGE.usage_ytd / (DATEDIFF(day, CONVERT(datetime, 
						  '01/01/2012', 103), GETDATE()) / 30.5))), 0)) WHEN (Z_IMINVLOC.qty_on_hand < 1) 
						  THEN (ROUND(Z_IMINVLOC.qty_on_ord - (3 * CEILING(dbo.Z_IMINVLOC_USAGE.usage_ytd / (DATEDIFF(day, CONVERT(datetime, '01/01/2012', 103), GETDATE()) 
						  / 30.5))), 0)) ELSE '' END AS [QOH+QOO-90], 
                      Z_IMINVLOC.po_min AS MOQ, '_________' AS [ORDER], 
                      IMITMIDX_SQL.item_note_2 AS Supplier, 
                      IMITMIDX_SQL.item_note_3 AS [Critical Item], 
                      IMITMIDX_SQL.item_note_5 AS [Misc Note (N5)], 
                      IMITMIDX_SQL.p_and_ic_cd AS [Rec Loc], */
                      Z_IMINVLOC.prior_year_usage AS UsageLastYr, 
                      dbo.Z_IMINVLOC_USAGE.usage_ytd AS UsageYTD, 
                      /*CAST(ROUND(Z_IMINVLOC.last_cost, 2, 0) AS DECIMAL(8, 2)) AS LC, 
                      CAST(ROUND(Z_IMINVLOC.std_cost, 2, 0) AS DECIMAL(8, 2)) AS SC, 
                      */
                      IMITMIDX_SQL.drawing_release_no AS [Dwg #], 
                      IMITMIDX_SQL.drawing_revision_no AS [Dwg Rev]
                      
FROM         dbo.Z_IMINVLOC AS Z_IMINVLOC WITH (NOLOCK) INNER JOIN
                      dbo.imitmidx_sql AS IMITMIDX_SQL WITH (NOLOCK) ON Z_IMINVLOC.item_no = IMITMIDX_SQL.item_no LEFT OUTER JOIN
                      dbo.Z_IMINVLOC_QALL WITH (NOLOCK) ON dbo.Z_IMINVLOC_QALL.item_no = Z_IMINVLOC.item_no LEFT OUTER JOIN
                      dbo.Z_IMINVLOC_USAGE WITH (NOLOCK) ON dbo.Z_IMINVLOC_USAGE.item_no = Z_IMINVLOC.item_no  
WHERE     (IMITMIDX_SQL.item_note_1 = 'CH') AND (NOT (Z_IMINVLOC.prod_cat = '036' OR
                      Z_IMINVLOC.prod_cat = '037' OR
                      Z_IMINVLOC.prod_cat = '336')) AND ((Z_IMINVLOC.qty_on_ord > 0) OR (Z_IMINVLOC.qty_on_hand > 0) OR (Z_IMINVLOC_QALL.qty_allocated > 0))
ORDER BY Z_IMINVLOC.item_no
GO


