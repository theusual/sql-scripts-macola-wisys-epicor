CREATE VIEW Z_IMINVLOC_USAGE_WITH_LEVELS  AS

-- CREATED:  7/13/12
-- UPDATED:  7/13/12      BY: BG
-- PURPOSE:  Usage View


SELECT [Parent Item] AS [item_no], SUM(qty_to_ship) AS [usage_ytd], 'PARENT' AS [Level], [Parent Item] AS [Parent Item]
FROM  (SELECT ol.item_no AS [Parent Item], (OL.qty_to_ship - OL.qty_return_to_stk) AS qty_to_ship
               FROM   oelinhst_sql ol JOIN
                              oehdrhst_sql oh ON oh.inv_no = ol.inv_no
               WHERE OH.inv_dt > '01/01/2012' AND orig_ord_type IN ('O', 'I', 'C')
					--AND ol.loc NOT IN ('CAN', 'IN') 
               /*UNION ALL
               SELECT ol.item_no AS [Parent Item], (pp.qty)
               FROM  oeordlin_sql ol 
					JOIN wspikpak pp ON pp.ord_no = ol.ord_no AND pp.line_no = ol.line_no
               WHERE shipped = 'Y' AND ol.loc NOT IN ('CAN', 'IN')*/
               ) AS LVL_USG
GROUP BY [Parent Item]
UNION ALL
SELECT [Comp Lvl 1] AS [item_no], SUM([Comp Lvl 1 Qty To Ship]) AS [Usage], 'LVL 1' AS [Level], [Parent Item] AS [Parent Item]
FROM  (SELECT ol.item_no AS [Parent Item], BM.comp_item_no[Comp Lvl 1], BM.qty_per_par[Comp Lvl 1 Per Par], (BM.qty_per_par * (ol.qty_to_ship - qty_return_to_stk)) 
                              AS [Comp Lvl 1 Qty To Ship]
               FROM   oelinhst_sql ol JOIN
                              bmprdstr_sql BM ON BM.item_no = ol.item_no JOIN
                              oehdrhst_sql oh ON oh.inv_no = ol.inv_no
               WHERE OH.inv_dt > '01/01/2012' AND orig_ord_type IN ('O', 'I', 'C')
					--AND ol.loc NOT IN ('CAN', 'IN') 
               /*UNION ALL
               SELECT ol.item_no AS [Parent Item], BM.comp_item_no[Comp Lvl 1], BM.qty_per_par[Comp Lvl 1 Per Par], (BM.qty_per_par * (ol.qty_to_ship - qty_return_to_stk)) 
                              AS [Comp Lvl 1 Qty To Ship]
               FROM  oeordlin_sql ol JOIN
                              wspikpak pp ON pp.ord_no = ol.ord_no AND pp.line_no = ol.line_no JOIN
                              bmprdstr_sql BM ON BM.item_no = ol.item_no
               WHERE shipped = 'Y' AND ol.loc NOT IN ('CAN', 'IN')*/
               
               ) AS [LVL_USG]
GROUP BY [Comp Lvl 1], [Parent Item]

-------- Uncomment the below sections if POP is ever implemented or items start being BOMed more than 1 level deep
/*
UNION ALL
SELECT [Comp Lvl 2] AS [item_no], SUM([Comp Lvl 2 Qty To Ship]) AS [Usage], 'LVL 2' AS [Level], [Parent Item] AS [Parent Item]
FROM  (SELECT ol.item_no AS [Parent Item], BM2.comp_item_no[Comp Lvl 2], BM2.qty_per_par[Comp Lvl 2 Per Par],
                              (BM2.qty_per_par * BM.qty_per_par * (ol.qty_to_ship - qty_return_to_stk)) AS [Comp Lvl 2 Qty To Ship]
               FROM   oelinhst_sql ol JOIN
                              bmprdstr_sql BM ON BM.item_no = ol.item_no JOIN
                              bmprdstr_sql BM2 ON BM2.item_no = BM.comp_item_no JOIN
                              oehdrhst_sql oh ON oh.inv_no = ol.inv_no
               WHERE OH.inv_dt > '01/01/2012' AND ol.loc NOT IN ('CAN', 'IN') AND orig_ord_type IN ('O', 'I', 'C')
               UNION ALL
               SELECT ol.item_no AS [Parent Item], BM2.comp_item_no[Comp Lvl 1], BM2.qty_per_par[Comp Lvl 2 Per Par], (BM2.qty_per_par * (ol.qty_to_ship - qty_return_to_stk)) 
                              AS [Comp Lvl 2 Qty To Ship]
               FROM  oeordlin_sql ol JOIN
                              wspikpak pp ON pp.ord_no = ol.ord_no AND pp.line_no = ol.line_no JOIN
                              bmprdstr_sql BM ON BM.item_no = ol.item_no JOIN
                              bmprdstr_sql BM2 ON BM2.item_no = BM.comp_item_no
               WHERE shipped = 'Y' AND ol.loc NOT IN ('CAN', 'IN')) AS [LVL_USG]
GROUP BY [Comp Lvl 2], [Parent Item]
UNION ALL
SELECT [Comp Lvl 3] AS [item_no], SUM([Comp Lvl 3 Qty To Ship]) AS [Usage], 'LVL 3' AS [Level], [Parent Item] AS [Parent Item]
FROM  (SELECT ol.item_no AS [Parent Item], BM3.comp_item_no[Comp Lvl 3], BM3.qty_per_par[Comp Lvl 2 Per Par], 
                              (BM3.qty_per_par * BM2.qty_per_par * BM.qty_per_par * (ol.qty_to_ship - qty_return_to_stk)) AS [Comp Lvl 3 Qty To Ship]
               FROM   oelinhst_sql ol JOIN
                              bmprdstr_sql BM ON BM.item_no = ol.item_no JOIN
                              bmprdstr_sql BM2 ON BM2.item_no = BM.comp_item_no JOIN
                              bmprdstr_sql BM3 ON BM3.item_no = BM2.comp_item_no JOIN
                              oehdrhst_sql oh ON oh.inv_no = ol.inv_no
               WHERE OH.inv_dt > '01/01/2012' AND ol.loc NOT IN ('CAN', 'IN') AND orig_ord_type IN ('O', 'I', 'C')
               UNION ALL
               SELECT ol.item_no AS [Parent Item], BM3.comp_item_no[Comp Lvl 3], BM3.qty_per_par[Comp Lvl 3 Per Par], 
                              (BM3.qty_per_par * (ol.qty_to_ship - qty_return_to_stk)) AS [Comp Lvl 3 Qty To Ship]
               FROM  oeordlin_sql ol JOIN
                              wspikpak pp ON pp.ord_no = ol.ord_no AND pp.line_no = ol.line_no JOIN
                              bmprdstr_sql BM ON BM.item_no = ol.item_no JOIN
                              bmprdstr_sql BM2 ON BM2.item_no = BM.comp_item_no JOIN
                              bmprdstr_sql BM3 ON BM3.item_no = BM2.comp_item_no
               WHERE shipped = 'Y' AND ol.loc NOT IN ('CAN', 'IN')) AS [LVL_USG]
GROUP BY [Comp Lvl 3], [Parent Item]
UNION ALL
SELECT [Comp Lvl 4] AS [item_no], SUM([Comp Lvl 4 Qty To Ship]) AS [Usage], 'LVL 4' AS [Level], [Parent Item] AS [Parent Item]
FROM  (SELECT ol.item_no AS [Parent Item], BM4.comp_item_no[Comp Lvl 4], BM4.qty_per_par[Comp Lvl 2 Per Par], 
                              (BM4.qty_per_par * BM3.qty_per_par * BM2.qty_per_par * BM.qty_per_par * (ol.qty_to_ship - qty_return_to_stk)) AS [Comp Lvl 4 Qty To Ship]
               FROM   oelinhst_sql ol JOIN
                              bmprdstr_sql BM ON BM.item_no = ol.item_no JOIN
                              bmprdstr_sql BM2 ON BM2.item_no = BM.comp_item_no JOIN
                              bmprdstr_sql BM3 ON BM3.item_no = BM2.comp_item_no JOIN
                              bmprdstr_sql BM4 ON BM4.item_no = BM3.comp_item_no JOIN
                              oehdrhst_sql oh ON oh.inv_no = ol.inv_no
               WHERE OH.inv_dt > '01/01/2012' AND ol.loc NOT IN ('CAN', 'IN') AND orig_ord_type IN ('O', 'I', 'C')
               UNION ALL
               SELECT ol.item_no AS [Parent Item], BM4.comp_item_no[Comp Lvl 4], BM4.qty_per_par[Comp Lvl 4 Per Par], 
                              (BM4.qty_per_par * (ol.qty_to_ship - qty_return_to_stk)) AS [Comp Lvl 4 Qty To Ship]
               FROM  oeordlin_sql ol JOIN
                              wspikpak pp ON pp.ord_no = ol.ord_no AND pp.line_no = ol.line_no JOIN
                              bmprdstr_sql BM ON BM.item_no = ol.item_no JOIN
                              bmprdstr_sql BM2 ON BM2.item_no = BM.comp_item_no JOIN
                              bmprdstr_sql BM4 ON BM4.item_no = BM2.comp_item_no
               WHERE shipped = 'Y' AND ol.loc NOT IN ('CAN', 'IN')) AS [LVL_USG]
GROUP BY [Comp Lvl 4], [Parent Item]
*/
GO


