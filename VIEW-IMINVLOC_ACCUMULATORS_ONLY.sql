SELECT IM.item_no, INV.prod_cat, INV.loc, INV.qty_on_hand, INV.avg_cost, INV.last_cost, INV.std_cost, INV.prior_year_usage, IM.extra_1 AS [Par/Sub/Comp Flag]
FROM  dbo.iminvloc_sql AS INV INNER JOIN
               dbo.imitmidx_sql AS IM ON IM.item_no = INV.item_no
WHERE (INV.qty_on_hand <> 0) OR
               (INV.qty_allocated <> 0) OR
               (INV.qty_on_ord <> 0) OR
               (INV.usage_ytd <> 0) OR
               (INV.prior_year_usage <> 0)