SELECT     TOP (100) PERCENT '___' AS LN, Z_IMINVLOC.prod_cat AS Cat, IMITMIDX_SQL.stocked_fg AS Stcked, Z_IMINVLOC.item_no, 
                      IMITMIDX_SQL.item_desc_1, IMITMIDX_SQL.item_desc_2, Z_IMINVLOC.qty_on_ord AS QOO, CASE WHEN (Z_IMINVLOC.qty_on_hand > 0) 
                      THEN Z_IMINVLOC.qty_on_hand WHEN (Z_IMINVLOC.qty_on_hand < 0) THEN '0' END AS QOH, '___' AS AQOH, Z_IMINVLOC.frz_qty AS FQTY, 
                      Z_IMINVLOC.qty_allocated AS QALL, IMITMIDX_SQL.item_note_4 AS ESS, ROUND(Z_IMINVLOC.prior_year_usage / 12.5, 0) AS [P YR MNTH], 
                      ROUND(Z_IMINVLOC.usage_ytd / 11, 0) AS CMNTH, CASE WHEN (Z_IMINVLOC.qty_on_hand > 0) 
                      THEN Z_IMINVLOC.qty_on_hand - Z_IMINVLOC.qty_allocated WHEN (Z_IMINVLOC.qty_on_hand < 0) 
                      THEN Z_IMINVLOC.qty_allocated END AS [QOH-QOA], 
                      
                     CASE WHEN imitmidx_sql.stocked_fg = 'Y' AND (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND 
                      (Z_IMINVLOC.qty_on_hand < 0) AND ((ROUND(Z_IMINVLOC.qty_on_ord - Z_IMINVLOC.qty_allocated - IMITMIDX_SQL.item_note_4, 0)) < 0) 
                      THEN 'NC' WHEN  imitmidx_sql.stocked_fg = 'Y' AND ((NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (Z_IMINVLOC.qty_on_hand > 0) AND 
                      ((ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - Z_IMINVLOC.qty_allocated - IMITMIDX_SQL.item_note_4, 0)) < 0)) 
                      THEN 'NC' WHEN imitmidx_sql.stocked_fg = 'Y' AND ((IMITMIDX_SQL.item_note_4 IS NULL) AND (Z_IMINVLOC.qty_on_hand > 0) AND 
                      (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - Z_IMINVLOC.qty_allocated, 0) < 0)) 
                      THEN 'NC' WHEN imitmidx_sql.stocked_fg = 'Y' AND ((IMITMIDX_SQL.item_note_4 IS NULL) AND (Z_IMINVLOC.qty_on_hand < 0) AND 
                      (ROUND(Z_IMINVLOC.qty_on_ord - Z_IMINVLOC.qty_allocated, 0) < 0)) THEN 'NC' ELSE '' END AS [CHECK],
                      
                      Z_IMINVLOC.po_min AS MOQ,
                      
                      CASE WHEN (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (Z_IMINVLOC.qty_on_hand > 0) 
                      THEN (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - Z_IMINVLOC.qty_allocated - IMITMIDX_SQL.item_note_4, 0)) 
                      WHEN (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (Z_IMINVLOC.qty_on_hand < 0) 
                      THEN (ROUND(Z_IMINVLOC.qty_on_ord - Z_IMINVLOC.qty_allocated - IMITMIDX_SQL.item_note_4, 0)) 
                      WHEN (IMITMIDX_SQL.item_note_4 IS NULL) AND (Z_IMINVLOC.qty_on_hand > 0) 
                      THEN (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - Z_IMINVLOC.qty_allocated, 0)) 
                      WHEN (IMITMIDX_SQL.item_note_4 IS NULL) AND (Z_IMINVLOC.qty_on_hand < 0) 
                      THEN (ROUND(Z_IMINVLOC.qty_on_ord - Z_IMINVLOC.qty_allocated, 0)) END AS [QOH+QOO-QOA-SS], 
                      
                      Z_IMINVLOC.usage_ytd AS CYU, IMITMIDX_SQL.item_note_2 AS Supplier, 
                      IMITMIDX_SQL.item_note_3 AS [Critical Item], IMITMIDX_SQL.item_note_5 AS [Misc Note (N5)], IMITMIDX_SQL.p_and_ic_cd AS [Rec Loc], 
                      Z_IMINVLOC.prior_year_usage AS PYU, Z_IMINVLOC.usage_ytd, CAST(ROUND(Z_IMINVLOC.last_cost, 2, 0) AS DECIMAL(8, 2)) AS LC, 
                      CAST(ROUND(Z_IMINVLOC.std_cost, 2, 0) AS DECIMAL(8, 2)) AS SC
FROM         dbo.Z_IMINVLOC AS Z_IMINVLOC INNER JOIN
                      dbo.imitmidx_sql AS IMITMIDX_SQL ON Z_IMINVLOC.item_no = IMITMIDX_SQL.item_no

WHERE     (IMITMIDX_SQL.item_note_1 = 'ch' OR
                      IMITMIDX_SQL.item_note_1 = 'Ch' OR
                      IMITMIDX_SQL.item_note_1 = 'CH' OR
                      IMITMIDX_SQL.item_note_1 = 'CHD') AND (NOT (Z_IMINVLOC.prod_cat = '036' OR
                      Z_IMINVLOC.prod_cat = '037' OR
                      Z_IMINVLOC.prod_cat = '336' OR
                      Z_IMINVLOC.prod_cat = 'AP')) AND ((Z_IMINVLOC.usage_ytd > 0) OR (Z_IMINVLOC.qty_on_ord > 0) OR (Z_IMINVLOC.qty_allocated > 0) OR (Z_IMINVLOC.prior_year_usage > 0)) 
                      AND 
                      (imitmidx_sql.stocked_fg = 'Y' AND (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (Z_IMINVLOC.qty_on_hand < 0) AND ((ROUND(Z_IMINVLOC.qty_on_ord - Z_IMINVLOC.qty_allocated - IMITMIDX_SQL.item_note_4, 0)) < 0) 
                      OR 
                      imitmidx_sql.stocked_fg = 'Y' AND ((NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (Z_IMINVLOC.qty_on_hand > 0) AND ((ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - Z_IMINVLOC.qty_allocated - IMITMIDX_SQL.item_note_4, 0)) < 0)) 
                      OR
                      imitmidx_sql.stocked_fg = 'Y' AND ((IMITMIDX_SQL.item_note_4 IS NULL) AND (Z_IMINVLOC.qty_on_hand > 0) AND (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - Z_IMINVLOC.qty_allocated, 0) < 0)) 
                      OR
                      imitmidx_sql.stocked_fg = 'Y' AND ((IMITMIDX_SQL.item_note_4 IS NULL) AND (Z_IMINVLOC.qty_on_hand < 0) AND (ROUND(Z_IMINVLOC.qty_on_ord - Z_IMINVLOC.qty_allocated, 0) < 0)))
ORDER BY [CHECK] DESC