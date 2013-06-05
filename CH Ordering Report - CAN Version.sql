SELECT     TOP (100) PERCENT  IMINVLOC_SQL.loc, '___' AS LN, IMINVLOC_SQL.prod_cat AS Cat, CASE WHEN (IMITMIDX_SQL.extra_1) IS NULL 
                      THEN '' ELSE IMITMIDX_SQL.extra_1 END AS Parent, IMINVLOC_SQL.item_no, IMITMIDX_SQL.item_desc_1, IMITMIDX_SQL.item_desc_2, 
                      IMINVLOC_SQL.qty_on_ord AS QOO, IMINVLOC_SQL.qty_on_hand AS QOH, '___' AS AQOH, IMINVLOC_SQL.frz_qty AS FQTY, 
                      IMINVLOC_SQL.qty_allocated AS QALL, IMITMIDX_SQL.item_note_4 AS ESS, ROUND(IMINVLOC_SQL.prior_year_usage / 12, 0) AS [P YR MNTH], 
                      CEILING(IMINVLOC_SQL.usage_ytd / (DATEDIFF(day, CONVERT(datetime, '01/01/2011', 103), GETDATE()) / 30.5)) AS CMNTH, 
                      IMINVLOC_SQL.qty_on_hand - IMINVLOC_SQL.qty_allocated AS [QOH-QOA], CASE WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR
                      imitmidx_sql.extra_1 IS NULL) AND (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (IMINVLOC_SQL.qty_on_hand < 0) AND 
                      ((ROUND(IMINVLOC_SQL.qty_on_ord - IMINVLOC_SQL.qty_allocated - IMITMIDX_SQL.item_note_4, 0)) < 0) 
                      THEN 'NC' WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR
                      imitmidx_sql.extra_1 IS NULL) AND ((NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (IMINVLOC_SQL.qty_on_hand > 0) AND 
                      ((ROUND(IMINVLOC_SQL.qty_on_hand + IMINVLOC_SQL.qty_on_ord - IMINVLOC_SQL.qty_allocated - IMITMIDX_SQL.item_note_4, 0)) < 0)) 
                      THEN 'NC' WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR
                      imitmidx_sql.extra_1 IS NULL) AND ((NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (IMINVLOC_SQL.qty_on_hand = 0) AND 
                      ((ROUND(IMINVLOC_SQL.qty_on_ord - IMINVLOC_SQL.qty_allocated - IMITMIDX_SQL.item_note_4, 0)) < 0)) 
                      THEN 'NC' WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR
                      imitmidx_sql.extra_1 IS NULL) AND ((IMITMIDX_SQL.item_note_4 IS NULL) AND (IMINVLOC_SQL.qty_on_hand > 0) AND 
                      (ROUND(IMINVLOC_SQL.qty_on_hand + IMINVLOC_SQL.qty_on_ord - IMINVLOC_SQL.qty_allocated, 0) < 0)) 
                      THEN 'NC' WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR
                      imitmidx_sql.extra_1 IS NULL) AND ((IMITMIDX_SQL.item_note_4 IS NULL) AND (IMINVLOC_SQL.qty_on_hand < 0) AND 
                      (ROUND(IMINVLOC_SQL.qty_on_ord - IMINVLOC_SQL.qty_allocated, 0) < 0)) THEN 'NC' WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR
                      imitmidx_sql.extra_1 IS NULL) AND ((IMITMIDX_SQL.item_note_4 IS NULL) AND (IMINVLOC_SQL.qty_on_hand > 0) AND 
                      (ROUND(IMINVLOC_SQL.qty_on_hand + IMINVLOC_SQL.qty_on_ord - IMINVLOC_SQL.qty_allocated, 0) < 0)) 
                      THEN 'NC' WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR
                      imitmidx_sql.extra_1 IS NULL) AND ((IMITMIDX_SQL.item_note_4 IS NULL) AND (IMINVLOC_SQL.qty_on_hand = 0) AND 
                      (ROUND(IMINVLOC_SQL.qty_on_ord - IMINVLOC_SQL.qty_allocated, 0) < 0)) THEN 'NC' ELSE '' END AS [CHECK], 
                      CASE WHEN (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (IMINVLOC_SQL.qty_on_hand > 0) 
                      THEN (ROUND(IMINVLOC_SQL.qty_on_hand + IMINVLOC_SQL.qty_on_ord - IMINVLOC_SQL.qty_allocated - IMITMIDX_SQL.item_note_4, 0)) 
                      WHEN (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (IMINVLOC_SQL.qty_on_hand < 0) 
                      THEN (ROUND(IMINVLOC_SQL.qty_on_ord - IMINVLOC_SQL.qty_allocated - IMITMIDX_SQL.item_note_4, 0)) 
                      WHEN (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (IMINVLOC_SQL.qty_on_hand = 0) 
                      THEN (ROUND(IMINVLOC_SQL.qty_on_ord - IMINVLOC_SQL.qty_allocated - IMITMIDX_SQL.item_note_4, 0)) WHEN (IMITMIDX_SQL.item_note_4 IS NULL) 
                      AND (IMINVLOC_SQL.qty_on_hand > 0) THEN (ROUND(IMINVLOC_SQL.qty_on_hand + IMINVLOC_SQL.qty_on_ord - IMINVLOC_SQL.qty_allocated, 0)) 
                      WHEN (IMITMIDX_SQL.item_note_4 IS NULL) AND (IMINVLOC_SQL.qty_on_hand < 0) 
                      THEN (ROUND(IMINVLOC_SQL.qty_on_ord - IMINVLOC_SQL.qty_allocated, 0)) WHEN (IMITMIDX_SQL.item_note_4 IS NULL) AND 
                      (IMINVLOC_SQL.qty_on_hand = 0) THEN (ROUND(IMINVLOC_SQL.qty_on_ord - IMINVLOC_SQL.qty_allocated, 0)) ELSE '' END AS [QOH+QOO-QOA-SS], 
                      CASE WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR
                      imitmidx_sql.extra_1 IS NULL) AND (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (IMINVLOC_SQL.qty_on_hand < 0) AND 
                      ((ROUND(IMINVLOC_SQL.qty_on_ord - IMINVLOC_SQL.qty_allocated - IMITMIDX_SQL.item_note_4 - (3 * (IMINVLOC_SQL.prior_year_usage / 12)), 0)) < 0) 
                      THEN 'NC' WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR
                      imitmidx_sql.extra_1 IS NULL) AND ((NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (IMINVLOC_SQL.qty_on_hand > 0) AND 
                      ((ROUND(IMINVLOC_SQL.qty_on_hand + IMINVLOC_SQL.qty_on_ord - IMINVLOC_SQL.qty_allocated - IMITMIDX_SQL.item_note_4 - (3 * (IMINVLOC_SQL.prior_year_usage
                       / 12)), 0)) < 0)) THEN 'NC' WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR
                      imitmidx_sql.extra_1 IS NULL) AND ((NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (IMINVLOC_SQL.qty_on_hand = 0) AND 
                      ((ROUND(IMINVLOC_SQL.qty_on_ord - IMINVLOC_SQL.qty_allocated - IMITMIDX_SQL.item_note_4 - (3 * (IMINVLOC_SQL.prior_year_usage / 12)), 0)) < 0)) 
                      THEN 'NC' WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR
                      imitmidx_sql.extra_1 IS NULL) AND ((IMITMIDX_SQL.item_note_4 IS NULL) AND (IMINVLOC_SQL.qty_on_hand > 0) AND 
                      (ROUND(IMINVLOC_SQL.qty_on_hand + IMINVLOC_SQL.qty_on_ord - IMINVLOC_SQL.qty_allocated - (3 * (IMINVLOC_SQL.prior_year_usage / 12)), 0) < 0)) 
                      THEN 'NC' WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR
                      imitmidx_sql.extra_1 IS NULL) AND ((IMITMIDX_SQL.item_note_4 IS NULL) AND (IMINVLOC_SQL.qty_on_hand < 0) AND 
                      (ROUND(IMINVLOC_SQL.qty_on_ord - IMINVLOC_SQL.qty_allocated - (3 * (IMINVLOC_SQL.prior_year_usage / 12)), 0) < 0)) 
                      THEN 'NC' WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR
                      imitmidx_sql.extra_1 IS NULL) AND ((IMITMIDX_SQL.item_note_4 IS NULL) AND (IMINVLOC_SQL.qty_on_hand > 0) AND 
                      (ROUND(IMINVLOC_SQL.qty_on_hand + IMINVLOC_SQL.qty_on_ord - IMINVLOC_SQL.qty_allocated - (3 * (IMINVLOC_SQL.prior_year_usage / 12)), 0) < 0)) 
                      THEN 'NC' WHEN (NOT (imitmidx_sql.extra_1 = 'P') OR
                      imitmidx_sql.extra_1 IS NULL) AND ((IMITMIDX_SQL.item_note_4 IS NULL) AND (IMINVLOC_SQL.qty_on_hand = 0) AND 
                      (ROUND(IMINVLOC_SQL.qty_on_ord - IMINVLOC_SQL.qty_allocated - (3 * (IMINVLOC_SQL.prior_year_usage / 12)), 0) < 0)) 
                      THEN 'NC' ELSE '' END AS [CHECK 90], CASE WHEN (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (IMINVLOC_SQL.qty_on_hand > 0) 
                      THEN (ROUND(IMINVLOC_SQL.qty_on_hand + IMINVLOC_SQL.qty_on_ord - IMINVLOC_SQL.qty_allocated - IMITMIDX_SQL.item_note_4 - (3 * (IMINVLOC_SQL.prior_year_usage
                       / 12)), 0)) WHEN (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (IMINVLOC_SQL.qty_on_hand < 0) 
                      THEN (ROUND(IMINVLOC_SQL.qty_on_ord - IMINVLOC_SQL.qty_allocated - IMITMIDX_SQL.item_note_4 - (3 * (IMINVLOC_SQL.prior_year_usage / 12)), 0)) 
                      WHEN (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (IMINVLOC_SQL.qty_on_hand = 0) 
                      THEN (ROUND(IMINVLOC_SQL.qty_on_ord - IMINVLOC_SQL.qty_allocated - IMITMIDX_SQL.item_note_4 - (3 * (IMINVLOC_SQL.prior_year_usage / 12)), 0)) 
                      WHEN (IMITMIDX_SQL.item_note_4 IS NULL) AND (IMINVLOC_SQL.qty_on_hand > 0) 
                      THEN (ROUND(IMINVLOC_SQL.qty_on_hand + IMINVLOC_SQL.qty_on_ord - IMINVLOC_SQL.qty_allocated - (3 * (IMINVLOC_SQL.prior_year_usage / 12)), 0)) 
                      WHEN (IMITMIDX_SQL.item_note_4 IS NULL) AND (IMINVLOC_SQL.qty_on_hand < 0) 
                      THEN (ROUND(IMINVLOC_SQL.qty_on_ord - IMINVLOC_SQL.qty_allocated - (3 * (IMINVLOC_SQL.prior_year_usage / 12)), 0)) 
                      WHEN (IMITMIDX_SQL.item_note_4 IS NULL) AND (IMINVLOC_SQL.qty_on_hand = 0) 
                      THEN (ROUND(IMINVLOC_SQL.qty_on_ord - IMINVLOC_SQL.qty_allocated - (3 * (IMINVLOC_SQL.prior_year_usage / 12)), 0)) 
                      ELSE '' END AS [QOH+QOO-QOA-SS-90], IMINVLOC_SQL.po_min AS MOQ, '_________' AS [ORDER], IMITMIDX_SQL.item_note_2 AS Supplier, 
                      IMITMIDX_SQL.item_note_3 AS [Critical Item], IMITMIDX_SQL.item_note_5 AS [Misc Note (N5)], IMITMIDX_SQL.p_and_ic_cd AS [Rec Loc], 
                      IMINVLOC_SQL.prior_year_usage AS PYU, IMINVLOC_SQL.usage_ytd, CAST(ROUND(IMINVLOC_SQL.last_cost, 2, 0) AS DECIMAL(8, 2)) AS LC, 
                      CAST(ROUND(IMINVLOC_SQL.std_cost, 2, 0) AS DECIMAL(8, 2)) AS SC
FROM         dbo.IMINVLOC_SQL AS IMINVLOC_SQL INNER JOIN
                      dbo.imitmidx_sql AS IMITMIDX_SQL ON IMINVLOC_SQL.item_no = IMITMIDX_SQL.item_no
WHERE     IMINVLOC_SQL.loc = 'CAN' AND ((IMITMIDX_SQL.item_note_1 = 'ch' OR
                      IMITMIDX_SQL.item_note_1 = 'Ch' OR
                      IMITMIDX_SQL.item_note_1 = 'CH' OR
                      IMITMIDX_SQL.item_note_1 = 'CHD') AND (NOT (IMINVLOC_SQL.prod_cat = '036' OR
                      IMINVLOC_SQL.prod_cat = '037' OR
                      IMINVLOC_SQL.prod_cat = '336')) )
ORDER BY IMINVLOC_SQL.item_no