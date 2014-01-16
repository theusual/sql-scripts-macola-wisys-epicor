--Created:	01/10/12	 By:	BG
--Last Updated:	3/19/13	 By:	BG
--Purpose: Calculate prior yr usage for items and update iminvloc_Sql with the information
--Last Change: Fixed bug in calculation of 2nd and 3rd levels, commented out levels 2-4

--Create temp table
WITH PriorYrUsage (item_no, usage_qty, loc) AS 
	(
	/*Last Change: Excluded KPB orders to Infiniti*/ 
	SELECT [Parent Item] AS [item_no], SUM(qty_to_ship) AS [usage_qty], loc
	FROM  (SELECT ol.item_no AS [Parent Item], (OL.qty_to_ship - OL.qty_return_to_stk) AS qty_to_ship, OL.loc
				   FROM   oelinhst_sql ol JOIN
								  oehdrhst_sql oh ON oh.inv_no = ol.inv_no JOIN
								  imitmidx_Sql IM ON IM.item_no = ol.item_no
				   WHERE YEAR(OH.inv_dt) = '2013' AND ol.loc NOT IN ('CAN', 'IN', 'BR') AND orig_ord_type IN ('O', 'I', 'C') 
				   /*Exclude KPB items sold to Inf*/ 
						AND NOT (ltrim(oh.cus_no) = '22523' AND IM.item_note_3 = 'KPB')
				   UNION ALL
				   SELECT ol.item_no AS [Parent Item], (pp.qty), OL.loc
				   FROM  oeordlin_sql ol JOIN
								  imitmidx_Sql IM ON IM.item_no = ol.item_no JOIN
								  oeordhdr_Sql oh ON oh.ord_no = ol.ord_no JOIN
								  wspikpak pp ON pp.ord_no = ol.ord_no AND pp.line_no = ol.line_no
				   WHERE YEAR(PP.ship_dt) = '2013' AND shipped = 'Y' AND ol.loc NOT IN ('CAN', 'IN', 'BR') 
				   /*Exclude KPB items sold to Inf*/ 
							AND NOT (ltrim(oh.cus_no) = '22523' AND IM.item_note_3 = 'KPB')) 
				   AS LVL_USG
	GROUP BY [Parent Item], LVL_USG.loc
	UNION ALL
	SELECT [Comp Lvl 1] AS [item_no], SUM([Comp Lvl 1 Qty To Ship]) AS [Usage_qty], loc
	FROM		  (SELECT ol.item_no AS [Parent Item], BM.comp_item_no[Comp Lvl 1], (BM.qty_per_par * (ol.qty_to_ship - qty_return_to_stk)) 
								  AS [Comp Lvl 1 Qty To Ship], OL.loc
				   FROM   oelinhst_sql ol JOIN
								  bmprdstr_sql BM ON BM.item_no = ol.item_no JOIN
								  oehdrhst_sql oh ON oh.inv_no = ol.inv_no
				   WHERE YEAR(OH.inv_dt) = '2013' AND ol.loc NOT IN ('CAN', 'IN', 'BR') AND orig_ord_type IN ('O', 'I', 'C')
				   UNION ALL
				   SELECT ol.item_no AS [Parent Item], BM.comp_item_no[Comp Lvl 1], (BM.qty_per_par * (ol.qty_to_ship - qty_return_to_stk)) 
								  AS [Comp Lvl 1 Qty To Ship], OL.loc
				   FROM  oeordlin_sql ol JOIN
								  wspikpak pp ON pp.ord_no = ol.ord_no AND pp.line_no = ol.line_no JOIN
								  bmprdstr_sql BM ON BM.item_no = ol.item_no
				   WHERE shipped = 'Y' AND ol.loc NOT IN ('CAN', 'IN', 'BR')) 
				   AS [LVL_USG]
	WHERE [Comp Lvl 1] = 'RAIL-06 GA 90'
	GROUP BY  LVL_USG.[Comp Lvl 1], LVL_USG.loc
	)
	

SELECT  *--im.item_no, usg.item_no, prior_year_usage, usage_qty, IM.loc, USG.loc
FROM    PriorYrUsage USG --JOIN IMINVLOC_SQL AS IM ON IM.item_no = USG.item_no AND USG.loc = IM.loc
WHERE item_no = 'RAIL-06 GA 90'

UPDATE dbo.iminvloc_sql
SET prior_year_usage = usage_qty
FROM Usage2011 USG, dbo.iminvloc_sql IM
WHERE USG.item_no = IM.item_no AND IM.loc = USG.loc 

SELECT prior_year_usage, * FROM dbo.iminvloc_sql AS [IM] WHERE IM.item_no = 'PC-RAL8028'

UPDATE IMINVLOC_SQL 
SET prior_year_usage = 0


select * 
from bmprdstr_sql 
WHERE comp_item_no = 'RAIL-06 GA 90'

select qty_to_ship*qty_per_par
FROM oelinhst_sql OL JOIN bmprdstr_sql BM ON BM.item_no = OL.item_no
WHERE comp_item_no = 'RAIL-06 GA 90'
      AND ol.loc NOT IN ('CAN', 'IN', 'BR') 
              
4380
