USE [001]
GO

--Created: 1/20/2011	By: BG
--Created: 1/21/2014	By: BG
--Purpose: Calculate YTD usage of all items sold according to BOM
--Last Change: Updated to include orig_ord_type = 'Q'


--Clear Old
BEGIN TRAN
UPDATE iminvloc_Sql
SET prior_year_usage = 0
COMMIT TRAN

--Update new
BEGIN TRAN
UPDATE iminvloc_sql
SET prior_year_usage = temp2.usage_ytd
FROM  (
		SELECT SUM(usage_ytd) AS usage_ytd, item_no, loc
		FROM (
				/*Last Change: Excluded KPB orders to Infiniti*/ 
				SELECT [Parent Item] AS [item_no], SUM(qty_to_ship) AS [usage_ytd], 'PARENT' AS [Level], [Parent Item] AS [Parent Item], loc
				FROM         (SELECT     ol.item_no AS [Parent Item], (OL.qty_to_ship - OL.qty_return_to_stk) AS qty_to_ship, OL.loc
									   FROM          oelinhst_sql ol WITH(NOLOCK) JOIN
															  oehdrhst_sql oh WITH(NOLOCK) ON oh.inv_no = ol.inv_no JOIN
															  imitmidx_Sql IM WITH(NOLOCK) ON IM.item_no = ol.item_no
									   WHERE      YEAR(OH.inv_dt) = 2013 AND ol.loc NOT IN ('CAN', 'IN', 'BR') AND orig_ord_type IN ('O', 'I', 'C', 'Q') /*Exclude KPB items sold to Inf*/ AND 
															  NOT (ltrim(oh.cus_no) = '22523' AND IM.item_note_3 = 'KPB')
									   UNION ALL
									   SELECT     ol.item_no AS [Parent Item], (pp.qty), OL.loc
									   FROM         oeordlin_sql ol WITH(NOLOCK) JOIN
															 imitmidx_Sql IM WITH(NOLOCK) ON IM.item_no = ol.item_no JOIN
															 oeordhdr_Sql oh WITH(NOLOCK) ON oh.ord_no = ol.ord_no JOIN
															 wspikpak pp WITH(NOLOCK) ON pp.ord_no = ol.ord_no AND pp.line_no = ol.line_no
									   WHERE     YEAR(pp.ship_dt) = 2013 AND shipped = 'Y' AND ol.loc NOT IN ('CAN', 'IN', 'BR') 
														/*Exclude KPB items sold to Inf*/ AND NOT (ltrim(oh.cus_no) = '22523' AND IM.item_note_3 = 'KPB')) 
									  AS LVL_USG
				GROUP BY [Parent Item], loc
				UNION ALL
				SELECT     [Comp Lvl 1] AS [item_no], SUM([Comp Lvl 1 Qty To Ship]) AS [Usage], 'LVL 1' AS [Level], [Parent Item] AS [Parent Item], loc
				FROM         (SELECT     ol.item_no AS [Parent Item], BM.comp_item_no[Comp Lvl 1], BM.qty_per_par[Comp Lvl 1 Per Par], (BM.qty_per_par * (ol.qty_to_ship - qty_return_to_stk)) 
															  AS [Comp Lvl 1 Qty To Ship], OL.loc
									   FROM          oelinhst_sql ol WITH(NOLOCK) JOIN
															  bmprdstr_sql BM WITH(NOLOCK) ON BM.item_no = ol.item_no JOIN
															  oehdrhst_sql oh WITH(NOLOCK) ON oh.inv_no = ol.inv_no
									   WHERE      YEAR(OH.inv_dt) = 2013 AND ol.loc NOT IN ('CAN', 'IN', 'BR') AND orig_ord_type IN ('O', 'I', 'C', 'Q')
									   UNION ALL
									   SELECT     ol.item_no AS [Parent Item], BM.comp_item_no[Comp Lvl 1], BM.qty_per_par[Comp Lvl 1 Per Par], (BM.qty_per_par * (ol.qty_to_ship - qty_return_to_stk)) 
															 AS [Comp Lvl 1 Qty To Ship], OL.loc
									   FROM         oeordlin_sql ol WITH(NOLOCK) JOIN
															 wspikpak pp WITH(NOLOCK) ON pp.ord_no = ol.ord_no AND pp.line_no = ol.line_no JOIN
															 bmprdstr_sql BM WITH(NOLOCK) ON BM.item_no = ol.item_no
									   WHERE     YEAR(pp.ship_dt) = 2013 AND shipped = 'Y' AND ol.loc NOT IN ('CAN', 'IN', 'BR')) 
									  AS [LVL_USG]
				/*Line below excludes any necessary items from component usage if they are doubling in usage due to BOM issues*/ WHERE [Comp Lvl 1] NOT IN ('')
				GROUP BY [Comp Lvl 1], [Parent Item], loc
				)  AS TEMP 
		GROUP BY item_no, loc
	 ) AS TEMP2
WHERE  temp2.loc = iminvloc_sql.loc
      --Test one item
	  AND temp2.item_no = iminvloc_Sql.item_no
COMMIT TRAN
ROLLBACK TRAN


--Manually check usages
select SUM(qty_to_ship), sUM(OL.qty_return_to_stk), OL.item_no, OL.loc
from oelinhst_Sql OL JOIN oehdrhst_Sql OH ON OH.inv_no = OL.inv_no JOIN imitmidx_sql IM ON IM.item_no = OL.item_no
WHERE OL.item_no = 'WM-MOVIEDUMPBIN' AND YEAR(OH.inv_dt) = 2013 AND orig_ord_type IN ('O', 'I', 'C', 'Q') AND NOT (ltrim(oh.cus_no) = '22523' AND IM.item_note_3 = 'KPB') 
GROUP BY OL.item_no, OL.loc

--Check usages
SELECT prior_year_usage, *
FROM IMINVLOC_SQL
WHERE item_no = 'WM-MOVIEDUMPBIN'


