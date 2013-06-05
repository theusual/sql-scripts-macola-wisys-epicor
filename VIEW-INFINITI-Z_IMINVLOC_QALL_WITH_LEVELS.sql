-- CREATED:  7/13/12      BY: BG
-- UPDATED:  7/13/12      BY: BG
-- Purpose: Infiniti QALL
	
CREATE VIEW [dbo].[Z_IMINVLOC_QALL_WITH_LEVELS]
AS
SELECT [Parent Item] AS [item_no], SUM(qty_to_ship) AS [qty_allocated], 'PARENT' AS [Level], [Parent Item] AS [Parent Item]
FROM  (SELECT ol.item_no AS [Parent Item], qty_to_ship
               FROM   oeordlin_sql ol 
					--LEFT OUTER JOIN wspikpak pp ON pp.ord_no = ol.ord_no AND pp.line_no = ol.line_no
               WHERE --(shipped = 'N' OR shipped IS NULL) AND 
						--ol.loc NOT IN ('CAN', 'IN') AND 
						ord_type IN ('O')) AS LVL_ALL
GROUP BY [Parent Item]
UNION ALL
SELECT [Comp Lvl 1] AS [item_no], SUM([Comp Lvl 1 Qty To Ship]) AS [qty_allocated], 'LVL 1' AS [Level], [Parent Item] AS [Parent Item]
FROM  (SELECT ol.item_no AS [Parent Item], OL.qty_to_ship, BM.comp_item_no[Comp Lvl 1], BM.qty_per_par[Comp Lvl 1 Per Par], 
                              BM.qty_per_par * ol.qty_to_ship AS [Comp Lvl 1 Qty To Ship]
               FROM   oeordlin_sql ol JOIN
                              dbo.bmprdstr_sql AS BM ON BM.item_no = ol.item_no 
                              --LEFT OUTER JOIN  wspikpak pp ON pp.ord_no = ol.ord_no AND pp.line_no = ol.line_no
               WHERE --(shipped = 'N' OR  shipped IS NULL) AND ol.loc NOT IN ('CAN', 'IN') AND 
                  ord_type IN ('O')) AS LVL_ALL
GROUP BY [Comp Lvl 1], [Parent Item]
/*

UNION ALL
SELECT [Comp Lvl 2] AS [item_no], SUM([Comp Lvl 2 Qty To Ship]) AS [qty_allocated], 'LVL 2' AS [Level], [Parent Item] AS [Parent Item]
FROM  (SELECT ol.item_no AS [Parent Item], OL.qty_to_ship, BM.comp_item_no[Comp Lvl 1], BM.qty_per_par[Comp Lvl 1 Per Par], 
                              BM.qty_per_par * ol.qty_to_ship AS [Comp Lvl 1 Qty To Ship], BM2.comp_item_no[Comp Lvl 2], BM2.qty_per_par[Comp Lvl 2 Per Par], 
                              BM2.qty_per_par * BM.qty_per_par * ol.qty_to_ship AS [Comp Lvl 2 Qty To Ship]
               FROM   oeordlin_sql ol JOIN
                              bmprdstr_sql BM ON BM.item_no = ol.item_no JOIN
                              bmprdstr_sql BM2 ON BM2.item_no = BM.comp_item_no LEFT OUTER JOIN
                              wspikpak pp ON pp.ord_no = ol.ord_no AND pp.line_no = ol.line_no
               WHERE (shipped = 'N' OR
                              shipped IS NULL) AND ol.loc NOT IN ('CAN', 'IN') AND ord_type IN ('O')) AS LVL_QALL
GROUP BY [Comp Lvl 2], [Parent Item]
UNION ALL
SELECT [Comp Lvl 3] AS [item_no], SUM([Comp Lvl 3 Qty To Ship]) AS [qty_allocated], 'LVL 3' AS [Level], [Parent Item] AS [Parent Item]
FROM  (SELECT ol.item_no AS [Parent Item], BM3.comp_item_no[Comp Lvl 3], BM3.qty_per_par[Comp Lvl 3 Per Par], 
                              BM3.qty_per_par * BM2.qty_per_par * ol.qty_to_ship AS [Comp Lvl 3 Qty To Ship]
               FROM   oeordlin_sql ol JOIN
                              bmprdstr_sql BM ON BM.item_no = ol.item_no JOIN
                              bmprdstr_sql BM2 ON BM2.item_no = BM.comp_item_no JOIN
                              bmprdstr_sql BM3 ON BM3.item_no = BM2.comp_item_no LEFT OUTER JOIN
                              wspikpak pp ON pp.ord_no = ol.ord_no AND pp.line_no = ol.line_no
               WHERE (shipped = 'N' OR
                              shipped IS NULL) AND ol.loc NOT IN ('CAN', 'IN') AND ord_type IN ('O')) AS LVL_QALL
GROUP BY [Comp Lvl 3], [Parent Item]
UNION ALL
SELECT [Comp Lvl 4] AS [item_no], SUM([Comp Lvl 4 Qty To Ship]) AS [qty_allocated], 'LVL 4' AS [Level], [Parent Item] AS [Parent Item]
FROM  (SELECT ol.item_no AS [Parent Item], BM4.comp_item_no[Comp Lvl 4], 
                              BM4.qty_per_par * BM3.qty_per_par * BM2.qty_per_par * BM.qty_per_par * ol.qty_to_ship AS [Comp Lvl 4 Qty To Ship]
               FROM   oeordlin_sql ol JOIN
                              bmprdstr_sql BM ON BM.item_no = ol.item_no JOIN
                              bmprdstr_sql BM2 ON BM2.item_no = BM.comp_item_no JOIN
                              bmprdstr_sql BM3 ON BM3.item_no = BM2.comp_item_no JOIN
                              bmprdstr_sql BM4 ON BM4.item_no = BM3.comp_item_no LEFT OUTER JOIN
                              wspikpak pp ON pp.ord_no = ol.ord_no AND pp.line_no = ol.line_no
               WHERE (shipped = 'N' OR
                              shipped IS NULL) AND ol.loc NOT IN ('CAN', 'IN') AND ord_type IN ('O')) AS LVL_QALL
GROUP BY [Comp Lvl 4], [Parent Item] */

GO



--Old Script, prior to 10-20-2011

/*

SELECT [Parent Item] AS [item_no], SUM(qty_to_ship) AS [qty_allocated], 'PARENT' AS [Level], [Parent Item] AS [Parent Item]
FROM  (SELECT ol.item_no AS [Parent Item], OL.qty_to_ship
               FROM   oeordlin_sql ol) AS LVL_USG
GROUP BY [Parent Item]
UNION ALL
SELECT [Comp Lvl 1] AS [item_no], SUM([Comp Lvl 1 Qty To Ship]) AS [qty_allocated], 'LVL 1' AS [Level], [Parent Item] AS [Parent Item]
FROM  (SELECT ol.item_no AS [Parent Item], OL.qty_to_ship, BM.comp_item_no[Comp Lvl 1], BM.qty_per_par[Comp Lvl 1 Per Par], 
                              BM.qty_per_par * ol.qty_to_ship AS [Comp Lvl 1 Qty To Ship]
               FROM   oeordlin_sql ol JOIN
                              bmprdstr_sql BM ON BM.item_no = ol.item_no) AS LVL_QALL
GROUP BY [Comp Lvl 1], [Parent Item]
UNION ALL
SELECT [Comp Lvl 2] AS [item_no], SUM([Comp Lvl 2 Qty To Ship]) AS [qty_allocated], 'LVL 2' AS [Level], [Parent Item] AS [Parent Item]
FROM  (SELECT ol.item_no AS [Parent Item], OL.qty_to_ship, BM.comp_item_no[Comp Lvl 1], BM.qty_per_par[Comp Lvl 1 Per Par], 
                              BM.qty_per_par * ol.qty_to_ship AS [Comp Lvl 1 Qty To Ship], BM2.comp_item_no[Comp Lvl 2], BM2.qty_per_par[Comp Lvl 2 Per Par], 
                              BM2.qty_per_par * BM.qty_per_par * ol.qty_to_ship AS [Comp Lvl 2 Qty To Ship]
               FROM   oeordlin_sql ol JOIN
                              bmprdstr_sql BM ON BM.item_no = ol.item_no JOIN
                              bmprdstr_sql BM2 ON BM2.item_no = BM.comp_item_no) AS LVL_QALL
GROUP BY [Comp Lvl 2], [Parent Item]
UNION ALL
SELECT [Comp Lvl 3] AS [item_no], SUM([Comp Lvl 3 Qty To Ship]) AS [qty_allocated], 'LVL 3' AS [Level], [Parent Item] AS [Parent Item]
FROM  (SELECT ol.item_no AS [Parent Item], BM3.comp_item_no[Comp Lvl 3], BM3.qty_per_par[Comp Lvl 3 Per Par], 
                              BM3.qty_per_par * BM2.qty_per_par * ol.qty_to_ship AS [Comp Lvl 3 Qty To Ship]
               FROM   oeordlin_sql ol JOIN
                              bmprdstr_sql BM ON BM.item_no = ol.item_no JOIN
                              bmprdstr_sql BM2 ON BM2.item_no = BM.comp_item_no JOIN
                              bmprdstr_sql BM3 ON BM3.item_no = BM2.comp_item_no) AS LVL_QALL
GROUP BY [Comp Lvl 3], [Parent Item]
UNION ALL
SELECT [Comp Lvl 4] AS [item_no], SUM([Comp Lvl 4 Qty To Ship]) AS [qty_allocated], 'LVL 4' AS [Level], [Parent Item] AS [Parent Item]
FROM  (SELECT ol.item_no AS [Parent Item], BM4.comp_item_no[Comp Lvl 4], 
                              BM4.qty_per_par * BM3.qty_per_par * BM2.qty_per_par * BM.qty_per_par * ol.qty_to_ship AS [Comp Lvl 4 Qty To Ship]
               FROM   oeordlin_sql ol JOIN
                              bmprdstr_sql BM ON BM.item_no = ol.item_no JOIN
                              bmprdstr_sql BM2 ON BM2.item_no = BM.comp_item_no JOIN
                              bmprdstr_sql BM3 ON BM3.item_no = BM2.comp_item_no JOIN
                              bmprdstr_sql BM4 ON BM4.item_no = BM3.comp_item_no) AS LVL_QALL
GROUP BY [Comp Lvl 4], [Parent Item]
UNION ALL
SELECT [Comp Lvl 5] AS [item_no], SUM([Comp Lvl 5 Qty To Ship]) AS [qty_allocated], 'LVL 5' AS [Level], [Parent Item] AS [Parent Item]
FROM  (SELECT ol.item_no AS [Parent Item], BM5.comp_item_no[Comp Lvl 5], BM5.qty_per_par[Comp Lvl 5 Per Par], 
                              BM5.qty_per_par * BM4.qty_per_par * BM3.qty_per_par * BM2.qty_per_par * BM.qty_per_par * ol.qty_to_ship AS [Comp Lvl 5 Qty To Ship]
               FROM   oeordlin_sql ol JOIN
                              bmprdstr_sql BM ON BM.item_no = ol.item_no JOIN
                              bmprdstr_sql BM2 ON BM2.item_no = BM.comp_item_no JOIN
                              bmprdstr_sql BM3 ON BM3.item_no = BM2.comp_item_no JOIN
                              bmprdstr_sql BM4 ON BM4.item_no = BM3.comp_item_no JOIN
                              bmprdstr_sql BM5 ON BM5.item_no = BM4.comp_item_no) AS LVL_QALL
GROUP BY [Comp Lvl 5], [Parent Item]
UNION ALL
SELECT [Comp Lvl 6] AS [item_no], SUM([Comp Lvl 6 Qty To Ship]) AS [qty_allocated], 'LVL 6' AS [Level], [Parent Item] AS [Parent Item]
FROM  (SELECT ol.item_no AS [Parent Item], BM6.comp_item_no[Comp Lvl 6], BM4.qty_per_par[Comp Lvl 6 Per Par], 
                              BM6.qty_per_par * BM5.qty_per_par * BM4.qty_per_par * BM3.qty_per_par * BM2.qty_per_par * BM.qty_per_par * ol.qty_to_ship AS [Comp Lvl 6 Qty To Ship]
               FROM   oeordlin_sql ol JOIN
                              bmprdstr_sql BM ON BM.item_no = ol.item_no JOIN
                              bmprdstr_sql BM2 ON BM2.item_no = BM.comp_item_no JOIN
                              bmprdstr_sql BM3 ON BM3.item_no = BM2.comp_item_no JOIN
                              bmprdstr_sql BM4 ON BM4.item_no = BM3.comp_item_no JOIN
                              bmprdstr_sql BM5 ON BM5.item_no = BM4.comp_item_no JOIN
                              bmprdstr_sql BM6 ON BM6.item_no = BM5.comp_item_no) AS LVL_QALL
GROUP BY [Comp Lvl 6], [Parent Item]

*/