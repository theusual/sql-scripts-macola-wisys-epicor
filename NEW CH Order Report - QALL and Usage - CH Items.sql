SELECT     TOP (100) PERCENT '___' AS LN, Z_IMINVLOC.prod_cat AS Cat, CASE WHEN (IMITMIDX_SQL.extra_1) IS NULL 
                      THEN '' ELSE IMITMIDX_SQL.extra_1 END AS Parent, Z_IMINVLOC.item_no, IMITMIDX_SQL.item_desc_1, IMITMIDX_SQL.item_desc_2, 
                      Z_IMINVLOC.qty_on_ord AS QOO, Z_IMINVLOC.qty_on_hand AS QOH, '___' AS AQOH, Z_IMINVLOC.frz_qty AS FQTY, 
                      z_iminvloc_qall.qty_allocated AS QALL, IMITMIDX_SQL.item_note_4 AS ESS, ROUND(Z_IMINVLOC.prior_year_usage / 12, 0) AS [P YR MNTH], 
                      ROUND(Z_IMINVLOC.prior_year_usage / 12, 0) AS CMNTH, Z_IMINVLOC.qty_on_hand - z_iminvloc_qall.qty_allocated AS [QOH-QOA], 
                      CASE WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR
                      imitmidx_sql.extra_1 IS NULL) AND (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (Z_IMINVLOC.qty_on_hand < 0) AND 
                      ((ROUND(Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated - IMITMIDX_SQL.item_note_4, 0)) < 0) 
                      THEN 'NC' WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR
                      imitmidx_sql.extra_1 IS NULL) AND ((NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (Z_IMINVLOC.qty_on_hand > 0) AND 
                      ((ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated - IMITMIDX_SQL.item_note_4, 0)) < 0)) 
                      THEN 'NC' WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR
                      imitmidx_sql.extra_1 IS NULL) AND ((NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (Z_IMINVLOC.qty_on_hand = 0) AND 
                      ((ROUND(Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated - IMITMIDX_SQL.item_note_4, 0)) < 0)) 
                      THEN 'NC' WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR
                      imitmidx_sql.extra_1 IS NULL) AND ((IMITMIDX_SQL.item_note_4 IS NULL) AND (Z_IMINVLOC.qty_on_hand > 0) AND 
                      (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated, 0) < 0)) 
                      THEN 'NC' WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR
                      imitmidx_sql.extra_1 IS NULL) AND ((IMITMIDX_SQL.item_note_4 IS NULL) AND (Z_IMINVLOC.qty_on_hand < 0) AND 
                      (ROUND(Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated, 0) < 0)) THEN 'NC' WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR
                      imitmidx_sql.extra_1 IS NULL) AND ((IMITMIDX_SQL.item_note_4 IS NULL) AND (Z_IMINVLOC.qty_on_hand > 0) AND 
                      (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated, 0) < 0)) 
                      THEN 'NC' WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR
                      imitmidx_sql.extra_1 IS NULL) AND ((IMITMIDX_SQL.item_note_4 IS NULL) AND (Z_IMINVLOC.qty_on_hand = 0) AND 
                      (ROUND(Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated, 0) < 0)) THEN 'NC' ELSE '' END AS [CHECK], 
                      CASE WHEN (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (Z_IMINVLOC.qty_on_hand > 0) 
                      THEN (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated - IMITMIDX_SQL.item_note_4, 0)) 
                      WHEN (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (Z_IMINVLOC.qty_on_hand < 0) 
                      THEN (ROUND(Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated - IMITMIDX_SQL.item_note_4, 0)) 
                      WHEN (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (Z_IMINVLOC.qty_on_hand = 0) 
                      THEN (ROUND(Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated - IMITMIDX_SQL.item_note_4, 0)) WHEN (IMITMIDX_SQL.item_note_4 IS NULL) 
                      AND (Z_IMINVLOC.qty_on_hand > 0) THEN (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated, 0)) 
                      WHEN (IMITMIDX_SQL.item_note_4 IS NULL) AND (Z_IMINVLOC.qty_on_hand < 0) THEN (ROUND(Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated,
                       0)) WHEN (IMITMIDX_SQL.item_note_4 IS NULL) AND (Z_IMINVLOC.qty_on_hand = 0) 
                      THEN (ROUND(Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated, 0)) ELSE '' END AS [QOH+QOO-QOA-SS], 
                      CASE WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR
                      imitmidx_sql.extra_1 IS NULL) AND (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (Z_IMINVLOC.qty_on_hand < 0) AND 
                      ((ROUND(Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated - IMITMIDX_SQL.item_note_4 - (3 * (z_iminvloc.prior_year_usage / 12)), 0)) < 0) 
                      THEN 'NC' WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR
                      imitmidx_sql.extra_1 IS NULL) AND ((NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (Z_IMINVLOC.qty_on_hand > 0) AND 
                      ((ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated - IMITMIDX_SQL.item_note_4 - (3 * (z_iminvloc.prior_year_usage
                       / 12)), 0)) < 0)) THEN 'NC' WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR
                      imitmidx_sql.extra_1 IS NULL) AND ((NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (Z_IMINVLOC.qty_on_hand = 0) AND 
                      ((ROUND(Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated - IMITMIDX_SQL.item_note_4 - (3 * (z_iminvloc.prior_year_usage / 12)), 0)) < 0)) 
                      THEN 'NC' WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR
                      imitmidx_sql.extra_1 IS NULL) AND ((IMITMIDX_SQL.item_note_4 IS NULL) AND (Z_IMINVLOC.qty_on_hand > 0) AND 
                      (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated - (3 * (z_iminvloc.prior_year_usage / 12)), 0) < 0)) 
                      THEN 'NC' WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR
                      imitmidx_sql.extra_1 IS NULL) AND ((IMITMIDX_SQL.item_note_4 IS NULL) AND (Z_IMINVLOC.qty_on_hand < 0) AND 
                      (ROUND(Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated - (3 * (z_iminvloc.prior_year_usage / 12)), 0) < 0)) 
                      THEN 'NC' WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR
                      imitmidx_sql.extra_1 IS NULL) AND ((IMITMIDX_SQL.item_note_4 IS NULL) AND (Z_IMINVLOC.qty_on_hand > 0) AND 
                      (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated - (3 * (z_iminvloc.prior_year_usage / 12)), 0) < 0)) 
                      THEN 'NC' WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR
                      imitmidx_sql.extra_1 IS NULL) AND ((IMITMIDX_SQL.item_note_4 IS NULL) AND (Z_IMINVLOC.qty_on_hand = 0) AND 
                      (ROUND(Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated - (3 * (z_iminvloc.prior_year_usage / 12)), 0) < 0)) THEN 'NC' ELSE '' END AS [CHECK 90],
                       CASE WHEN (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (Z_IMINVLOC.qty_on_hand > 0) 
                      THEN (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated - IMITMIDX_SQL.item_note_4 - (3 * (z_iminvloc.prior_year_usage
                       / 12)), 0)) WHEN (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (Z_IMINVLOC.qty_on_hand < 0) 
                      THEN (ROUND(Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated - IMITMIDX_SQL.item_note_4 - (3 * (z_iminvloc.prior_year_usage / 12)), 0)) 
                      WHEN (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (Z_IMINVLOC.qty_on_hand = 0) 
                      THEN (ROUND(Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated - IMITMIDX_SQL.item_note_4 - (3 * (z_iminvloc.prior_year_usage / 12)), 0)) 
                      WHEN (IMITMIDX_SQL.item_note_4 IS NULL) AND (Z_IMINVLOC.qty_on_hand > 0) 
                      THEN (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated - (3 * (z_iminvloc.prior_year_usage / 12)), 0)) 
                      WHEN (IMITMIDX_SQL.item_note_4 IS NULL) AND (Z_IMINVLOC.qty_on_hand < 0) 
                      THEN (ROUND(Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated - (3 * (z_iminvloc.prior_year_usage / 12)), 0)) 
                      WHEN (IMITMIDX_SQL.item_note_4 IS NULL) AND (Z_IMINVLOC.qty_on_hand = 0) 
                      THEN (ROUND(Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated - (3 * (z_iminvloc.prior_year_usage / 12)), 0)) 
                      ELSE '' END AS [QOH+QOO-QOA-SS-90], Z_IMINVLOC.po_min AS MOQ, Z_IMINVLOC_USAGE.usage_ytd AS CYU, IMITMIDX_SQL.item_note_2 AS Supplier, 
                      IMITMIDX_SQL.item_note_3 AS [Critical Item], IMITMIDX_SQL.item_note_5 AS [Misc Note (N5)], IMITMIDX_SQL.p_and_ic_cd AS [Rec Loc], 
                      Z_IMINVLOC.prior_year_usage AS PYU, Z_IMINVLOC_USAGE.usage_ytd, CAST(ROUND(Z_IMINVLOC.last_cost, 2, 0) AS DECIMAL(8, 2)) AS LC, 
                      CAST(ROUND(Z_IMINVLOC.std_cost, 2, 0) AS DECIMAL(8, 2)) AS SC
FROM         dbo.Z_IMINVLOC AS Z_IMINVLOC INNER JOIN
                      dbo.imitmidx_sql AS IMITMIDX_SQL ON Z_IMINVLOC.item_no = IMITMIDX_SQL.item_no LEFT OUTER JOIN
                      dbo.Z_IMINVLOC_QALL ON dbo.Z_IMINVLOC_QALL.item_no = Z_IMINVLOC.item_no INNER JOIN Z_IMINVLOC_USAGE ON Z_IMINVLOC_USAGE.item_no = Z_IMINVLOC.item_no
WHERE     (IMITMIDX_SQL.item_note_1 = 'ch' OR
                      IMITMIDX_SQL.item_note_1 = 'Ch' OR
                      IMITMIDX_SQL.item_note_1 = 'CH' OR
                      IMITMIDX_SQL.item_note_1 = 'CHD') AND (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (NOT (Z_IMINVLOC.prod_cat = '036' OR
                      Z_IMINVLOC.prod_cat = '037' OR
                      Z_IMINVLOC.prod_cat = '336' OR
                      Z_IMINVLOC.prod_cat = 'AP')) AND (z_iminvloc_usage.usage_ytd > 0) AND (Z_IMINVLOC.qty_on_hand < 1) AND (NOT (IMITMIDX_SQL.extra_1 = 'P') OR
                      IMITMIDX_SQL.extra_1 IS NULL) AND 
                      (ROUND(Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated - IMITMIDX_SQL.item_note_4, 0) < 0) OR
                      (IMITMIDX_SQL.item_note_1 = 'ch' OR
                      IMITMIDX_SQL.item_note_1 = 'Ch' OR
                      IMITMIDX_SQL.item_note_1 = 'CH' OR
                      IMITMIDX_SQL.item_note_1 = 'CHD') AND (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (NOT (Z_IMINVLOC.prod_cat = '036' OR
                      Z_IMINVLOC.prod_cat = '037' OR
                      Z_IMINVLOC.prod_cat = '336' OR
                      Z_IMINVLOC.prod_cat = 'AP')) AND (Z_IMINVLOC.qty_on_hand < 1) AND (NOT (IMITMIDX_SQL.extra_1 = 'P') OR
                      IMITMIDX_SQL.extra_1 IS NULL) AND 
                      (ROUND(Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated - IMITMIDX_SQL.item_note_4, 0) < 0) AND (Z_IMINVLOC.qty_on_ord > 0) OR
                      (IMITMIDX_SQL.item_note_1 = 'ch' OR
                      IMITMIDX_SQL.item_note_1 = 'Ch' OR
                      IMITMIDX_SQL.item_note_1 = 'CH' OR
                      IMITMIDX_SQL.item_note_1 = 'CHD') AND (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (NOT (Z_IMINVLOC.prod_cat = '036' OR
                      Z_IMINVLOC.prod_cat = '037' OR
                      Z_IMINVLOC.prod_cat = '336' OR
                      Z_IMINVLOC.prod_cat = 'AP')) AND (Z_IMINVLOC.qty_on_hand < 1) AND (NOT (IMITMIDX_SQL.extra_1 = 'P') OR
                      IMITMIDX_SQL.extra_1 IS NULL) AND 
                      (ROUND(Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated - IMITMIDX_SQL.item_note_4, 0) < 0) AND 
                      (z_iminvloc_qall.qty_allocated > 0)
                       OR
                      (IMITMIDX_SQL.item_note_1 = 'ch' OR
                      IMITMIDX_SQL.item_note_1 = 'Ch' OR
                      IMITMIDX_SQL.item_note_1 = 'CH' OR
                      IMITMIDX_SQL.item_note_1 = 'CHD') AND (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (NOT (Z_IMINVLOC.prod_cat = '036' OR
                      Z_IMINVLOC.prod_cat = '037' OR
                      Z_IMINVLOC.prod_cat = '336' OR
                      Z_IMINVLOC.prod_cat = 'AP')) AND (Z_IMINVLOC.qty_on_hand < 1) AND (NOT (IMITMIDX_SQL.extra_1 = 'P') OR
                      IMITMIDX_SQL.extra_1 IS NULL) AND 
                      (ROUND(Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated - IMITMIDX_SQL.item_note_4, 0) < 0) AND (Z_IMINVLOC.prior_year_usage > 0) OR
                      (IMITMIDX_SQL.item_note_1 = 'ch' OR
                      IMITMIDX_SQL.item_note_1 = 'Ch' OR
                      IMITMIDX_SQL.item_note_1 = 'CH' OR
                      IMITMIDX_SQL.item_note_1 = 'CHD') AND (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (NOT (Z_IMINVLOC.prod_cat = '036' OR
                      Z_IMINVLOC.prod_cat = '037' OR
                      Z_IMINVLOC.prod_cat = '336' OR
                      Z_IMINVLOC.prod_cat = 'AP')) AND (z_iminvloc_usage.usage_ytd > 0) AND (Z_IMINVLOC.qty_on_hand > 1) AND (NOT (IMITMIDX_SQL.extra_1 = 'P') OR
                      IMITMIDX_SQL.extra_1 IS NULL) AND 
                      (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated - IMITMIDX_SQL.item_note_4, 0) < 0) OR
                      (IMITMIDX_SQL.item_note_1 = 'ch' OR
                      IMITMIDX_SQL.item_note_1 = 'Ch' OR
                      IMITMIDX_SQL.item_note_1 = 'CH' OR
                      IMITMIDX_SQL.item_note_1 = 'CHD') AND (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (NOT (Z_IMINVLOC.prod_cat = '036' OR
                      Z_IMINVLOC.prod_cat = '037' OR
                      Z_IMINVLOC.prod_cat = '336' OR
                      Z_IMINVLOC.prod_cat = 'AP')) AND (Z_IMINVLOC.qty_on_hand > 1) AND (NOT (IMITMIDX_SQL.extra_1 = 'P') OR
                      IMITMIDX_SQL.extra_1 IS NULL) AND (Z_IMINVLOC.qty_on_ord > 0) AND 
                      (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated - IMITMIDX_SQL.item_note_4, 0) < 0) OR
                      (IMITMIDX_SQL.item_note_1 = 'ch' OR
                      IMITMIDX_SQL.item_note_1 = 'Ch' OR
                      IMITMIDX_SQL.item_note_1 = 'CH' OR
                      IMITMIDX_SQL.item_note_1 = 'CHD') AND (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (NOT (Z_IMINVLOC.prod_cat = '036' OR
                      Z_IMINVLOC.prod_cat = '037' OR
                      Z_IMINVLOC.prod_cat = '336' OR
                      Z_IMINVLOC.prod_cat = 'AP')) AND (Z_IMINVLOC.qty_on_hand > 0) AND (NOT (IMITMIDX_SQL.extra_1 = 'P') OR
                      IMITMIDX_SQL.extra_1 IS NULL) AND 
                      (z_iminvloc_qall.qty_allocated > 0)
                       AND 
                      (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated  - IMITMIDX_SQL.item_note_4, 0) < 0) OR
                      (IMITMIDX_SQL.item_note_1 = 'ch' OR
                      IMITMIDX_SQL.item_note_1 = 'Ch' OR
                      IMITMIDX_SQL.item_note_1 = 'CH' OR
                      IMITMIDX_SQL.item_note_1 = 'CHD') AND (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (NOT (Z_IMINVLOC.prod_cat = '036' OR
                      Z_IMINVLOC.prod_cat = '037' OR
                      Z_IMINVLOC.prod_cat = '336' OR
                      Z_IMINVLOC.prod_cat = 'AP')) AND (Z_IMINVLOC.qty_on_hand > 1) AND (NOT (IMITMIDX_SQL.extra_1 = 'P') OR
                      IMITMIDX_SQL.extra_1 IS NULL) AND (Z_IMINVLOC.prior_year_usage > 0) AND 
                      (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated  - IMITMIDX_SQL.item_note_4, 0) < 0) OR
                      (IMITMIDX_SQL.item_note_1 = 'ch' OR
                      IMITMIDX_SQL.item_note_1 = 'Ch' OR
                      IMITMIDX_SQL.item_note_1 = 'CH' OR
                      IMITMIDX_SQL.item_note_1 = 'CHD') AND (IMITMIDX_SQL.item_note_4 IS NULL) AND (NOT (Z_IMINVLOC.prod_cat = '036' OR
                      Z_IMINVLOC.prod_cat = '037' OR
                      Z_IMINVLOC.prod_cat = '336' OR
                      Z_IMINVLOC.prod_cat = 'AP')) AND (z_iminvloc_usage.usage_ytd > 0) AND (Z_IMINVLOC.qty_on_hand > 1) AND (NOT (IMITMIDX_SQL.extra_1 = 'P') OR
                      IMITMIDX_SQL.extra_1 IS NULL) AND 
                      (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated , 0) < 0) OR
                      (IMITMIDX_SQL.item_note_1 = 'ch' OR
                      IMITMIDX_SQL.item_note_1 = 'Ch' OR
                      IMITMIDX_SQL.item_note_1 = 'CH' OR
                      IMITMIDX_SQL.item_note_1 = 'CHD') AND (IMITMIDX_SQL.item_note_4 IS NULL) AND (NOT (Z_IMINVLOC.prod_cat = '036' OR
                      Z_IMINVLOC.prod_cat = '037' OR
                      Z_IMINVLOC.prod_cat = '336' OR
                      Z_IMINVLOC.prod_cat = 'AP')) AND (Z_IMINVLOC.qty_on_hand > 1) AND (NOT (IMITMIDX_SQL.extra_1 = 'P') OR
                      IMITMIDX_SQL.extra_1 IS NULL) AND (Z_IMINVLOC.qty_on_ord > 0) AND 
                      (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated , 0) < 0) OR
                      (IMITMIDX_SQL.item_note_1 = 'ch' OR
                      IMITMIDX_SQL.item_note_1 = 'Ch' OR
                      IMITMIDX_SQL.item_note_1 = 'CH' OR
                      IMITMIDX_SQL.item_note_1 = 'CHD') AND (IMITMIDX_SQL.item_note_4 IS NULL) AND (NOT (Z_IMINVLOC.prod_cat = '036' OR
                      Z_IMINVLOC.prod_cat = '037' OR
                      Z_IMINVLOC.prod_cat = '336' OR
                      Z_IMINVLOC.prod_cat = 'AP')) AND (Z_IMINVLOC.qty_on_hand > 1) AND (NOT (IMITMIDX_SQL.extra_1 = 'P') OR
                      IMITMIDX_SQL.extra_1 IS NULL) AND 
                      (z_iminvloc_qall.qty_allocated > 0)
                       AND 
                      (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated , 0) < 0) OR
                      (IMITMIDX_SQL.item_note_1 = 'ch' OR
                      IMITMIDX_SQL.item_note_1 = 'Ch' OR
                      IMITMIDX_SQL.item_note_1 = 'CH' OR
                      IMITMIDX_SQL.item_note_1 = 'CHD') AND (IMITMIDX_SQL.item_note_4 IS NULL) AND (NOT (Z_IMINVLOC.prod_cat = '036' OR
                      Z_IMINVLOC.prod_cat = '037' OR
                      Z_IMINVLOC.prod_cat = '336' OR
                      Z_IMINVLOC.prod_cat = 'AP')) AND (Z_IMINVLOC.qty_on_hand > 1) AND (NOT (IMITMIDX_SQL.extra_1 = 'P') OR
                      IMITMIDX_SQL.extra_1 IS NULL) AND (Z_IMINVLOC.prior_year_usage > 0) AND 
                      (ROUND(Z_IMINVLOC.qty_on_hand + Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated, 0) < 0) OR
                      (IMITMIDX_SQL.item_note_1 = 'ch' OR
                      IMITMIDX_SQL.item_note_1 = 'Ch' OR
                      IMITMIDX_SQL.item_note_1 = 'CH' OR
                      IMITMIDX_SQL.item_note_1 = 'CHD') AND (IMITMIDX_SQL.item_note_4 IS NULL) AND (NOT (Z_IMINVLOC.prod_cat = '036' OR
                      Z_IMINVLOC.prod_cat = '037' OR
                      Z_IMINVLOC.prod_cat = '336' OR
                      Z_IMINVLOC.prod_cat = 'AP')) AND (z_iminvloc_usage.usage_ytd > 0) AND (Z_IMINVLOC.qty_on_hand < 1) AND (NOT (IMITMIDX_SQL.extra_1 = 'P') OR
                      IMITMIDX_SQL.extra_1 IS NULL) AND 
                      (ROUND(Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated, 0) < 0) OR
                      (IMITMIDX_SQL.item_note_1 = 'ch' OR
                      IMITMIDX_SQL.item_note_1 = 'Ch' OR
                      IMITMIDX_SQL.item_note_1 = 'CH' OR
                      IMITMIDX_SQL.item_note_1 = 'CHD') AND (IMITMIDX_SQL.item_note_4 IS NULL) AND (NOT (Z_IMINVLOC.prod_cat = '036' OR
                      Z_IMINVLOC.prod_cat = '037' OR
                      Z_IMINVLOC.prod_cat = '336' OR
                      Z_IMINVLOC.prod_cat = 'AP')) AND (Z_IMINVLOC.qty_on_hand < 1) AND (NOT (IMITMIDX_SQL.extra_1 = 'P') OR
                      IMITMIDX_SQL.extra_1 IS NULL) AND (Z_IMINVLOC.qty_on_ord > 0) AND 
                      (ROUND(Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated, 0) < 0) OR
                      (IMITMIDX_SQL.item_note_1 = 'ch' OR
                      IMITMIDX_SQL.item_note_1 = 'Ch' OR
                      IMITMIDX_SQL.item_note_1 = 'CH' OR
                      IMITMIDX_SQL.item_note_1 = 'CHD') AND (IMITMIDX_SQL.item_note_4 IS NULL) AND (NOT (Z_IMINVLOC.prod_cat = '036' OR
                      Z_IMINVLOC.prod_cat = '037' OR
                      Z_IMINVLOC.prod_cat = '336' OR
                      Z_IMINVLOC.prod_cat = 'AP')) AND (Z_IMINVLOC.qty_on_hand < 1) AND (NOT (IMITMIDX_SQL.extra_1 = 'P') OR
                      IMITMIDX_SQL.extra_1 IS NULL) AND 
                      (z_iminvloc_qall.qty_allocated  > 0)
                       AND 
                      (ROUND(Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated, 0) < 0) OR
                      (IMITMIDX_SQL.item_note_1 = 'ch' OR
                      IMITMIDX_SQL.item_note_1 = 'Ch' OR
                      IMITMIDX_SQL.item_note_1 = 'CH' OR
                      IMITMIDX_SQL.item_note_1 = 'CHD') AND (IMITMIDX_SQL.item_note_4 IS NULL) AND (NOT (Z_IMINVLOC.prod_cat = '036' OR
                      Z_IMINVLOC.prod_cat = '037' OR
                      Z_IMINVLOC.prod_cat = '336' OR
                      Z_IMINVLOC.prod_cat = 'AP')) AND (Z_IMINVLOC.qty_on_hand < 1) AND (NOT (IMITMIDX_SQL.extra_1 = 'P') OR
                      IMITMIDX_SQL.extra_1 IS NULL) AND (Z_IMINVLOC.prior_year_usage > 0) AND 
                      (ROUND(Z_IMINVLOC.qty_on_ord - z_iminvloc_qall.qty_allocated, 0) < 0)
ORDER BY Z_IMINVLOC.item_no DESC