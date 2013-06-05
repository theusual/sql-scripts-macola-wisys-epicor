/*Last Change: Excluded KPB orders to Infiniti*/ 
SELECT [Parent Item] AS [item_no], SUM(qty_to_ship) AS [usage_ytd], 'PARENT' AS [Level], 
               [Parent Item] AS [Parent Item]
FROM  (SELECT ol.item_no AS [Parent Item], (OL.qty_to_ship - OL.qty_return_to_stk) AS qty_to_ship
               FROM   oelinhst_sql ol 
                      JOIN oehdrhst_sql oh ON oh.inv_no = ol.inv_no
                      JOIN imitmidx_Sql IM ON IM.item_no = ol.item_no
               WHERE YEAR(OH.inv_dt) = YEAR(GETDATE()) 
               AND ol.loc NOT IN ('CAN', 'IN', 'BR') AND orig_ord_type IN ('O', 'I', 'C')
               --Exclude KPB items sold to Inf
               AND NOT (ltrim(oh.cus_no) = '22523' AND IM.item_note_3 = 'KPB')
               UNION ALL
               SELECT ol.item_no AS [Parent Item], (pp.qty)
               FROM  oeordlin_sql ol 
					 JOIN imitmidx_Sql IM ON IM.item_no = ol.item_no
					 JOIN oeordhdr_Sql oh ON oh.ord_no = ol.ord_no
					 JOIN wspikpak pp ON pp.ord_no = ol.ord_no AND pp.line_no = ol.line_no
               WHERE shipped = 'Y' AND ol.loc NOT IN ('CAN', 'IN', 'BR')
                     --Exclude KPB items sold to Inf
                     AND NOT (ltrim(oh.cus_no) = '22523' AND IM.item_note_3 = 'KPB') ) AS LVL_USG
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
               FROM  oeordlin_sql ol JOIN
                              wspikpak pp ON pp.ord_no = ol.ord_no AND pp.line_no = ol.line_no JOIN
                              bmprdstr_sql BM ON BM.item_no = ol.item_no
               WHERE shipped = 'Y' AND ol.loc NOT IN ('CAN', 'IN', 'BR')) 
               AS [LVL_USG]
/*Line below excludes any necessary items from component usage if they are doubling in usage due to BOM issues*/ WHERE [Comp Lvl 1] NOT IN ('')
GROUP BY [Comp Lvl 1], [Parent Item]