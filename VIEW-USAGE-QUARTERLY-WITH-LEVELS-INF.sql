--CREATE VIEW Z_IMINVLOC_USAGE_QUARTERLY_WITH_LEVELS AS

--Created:	2/15/13			 By:	BG
--Last Updated:	02/15/13	 By:	BG
--Purpose:	View for Usage With Levels
--Last changes: 1) 

SELECT [Parent Item] AS [item_no], SUM(qty_to_ship) AS [usage_ytd], 'PARENT' AS [Level], 
               [Parent Item] AS [Parent Item]
FROM  (SELECT ol.item_no AS [Parent Item], (OL.qty_to_ship - OL.qty_return_to_stk) AS qty_to_ship
               FROM   oelinhst_sql ol JOIN
                              oehdrhst_sql oh ON oh.inv_no = ol.inv_no
               WHERE YEAR(OH.inv_dt) = YEAR(GETDATE()) AND orig_ord_type IN ('O', 'I', 'C')
               UNION ALL
               SELECT ol.item_no AS [Parent Item], (qty_to_ship)
               FROM  oeordlin_sql ol 
               WHERE (OL.user_def_fld_3 IS NOT NULL)) AS LVL_USG
GROUP BY [Parent Item]
UNION ALL
SELECT [Comp Lvl 1] AS [item_no], SUM([Comp Lvl 1 Qty To Ship]) AS [Usage], 'LVL 1' AS [Level], [Parent Item] AS [Parent Item]
FROM  (SELECT ol.item_no AS [Parent Item], BM.comp_item_no[Comp Lvl 1], BM.qty_per_par[Comp Lvl 1 Per Par], (BM.qty_per_par * (ol.qty_to_ship - qty_return_to_stk)) 
                              AS [Comp Lvl 1 Qty To Ship]
               FROM   oelinhst_sql ol JOIN
                              bmprdstr_sql BM ON BM.item_no = ol.item_no JOIN
                              oehdrhst_sql oh ON oh.inv_no = ol.inv_no
               WHERE YEAR(OH.inv_dt) = YEAR(GETDATE()) AND ol.loc NOT IN ('CAN', 'IN', 'BR') AND orig_ord_type IN ('O', 'I', 'C')
               UNION ALL
               SELECT ol.item_no AS [Parent Item], BM.comp_item_no[Comp Lvl 1], BM.qty_per_par[Comp Lvl 1 Per Par], (BM.qty_per_par * (ol.qty_to_ship - qty_return_to_stk)) 
                              AS [Comp Lvl 1 Qty To Ship]
               FROM  oeordlin_sql ol  JOIN
                              bmprdstr_sql BM ON BM.item_no = ol.item_no
               WHERE (OL.user_def_fld_3 IS NOT NULL)) AS [LVL_USG]
GROUP BY [Comp Lvl 1], [Parent Item]