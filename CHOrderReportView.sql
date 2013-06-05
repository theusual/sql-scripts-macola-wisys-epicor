

SELECT     TOP (100) PERCENT '___' AS LN, IMINVLOC_SQL.prod_cat AS Cat, IMITMIDX_SQL.stocked_fg AS Stcked, IMINVLOC_SQL.item_no, 
                      IMITMIDX_SQL.item_desc_1, IMITMIDX_SQL.item_desc_2, IMINVLOC_SQL.qty_on_ord AS QOO, 
                      CASE WHEN (iminvloc_sql.qty_on_hand > 0)
                      THEN IMINVLOC_SQL.qty_on_hand 
                      WHEN  (iminvloc_sql.qty_on_hand < 0) 
                      THEN '0'
                      END AS QOH, '___' AS AQOH, 
                      IMINVLOC_SQL.frz_qty AS FQTY, IMINVLOC_SQL.qty_allocated AS QALL, IMITMIDX_SQL.item_note_4 AS [Est Safety Stock], 
                      ROUND(IMINVLOC_SQL.prior_year_usage / 12.5, 0) AS [P YR MNTH], ROUND(IMINVLOC_SQL.usage_ytd / 11, 0) AS CMNTH,
                      CASE WHEN (iminvloc_sql.qty_on_hand > 0)
                      THEN IMINVLOC_SQL.qty_on_hand - IMINVLOC_SQL.qty_allocated
                      WHEN  (iminvloc_sql.qty_on_hand < 0) 
                      THEN IMINVLOC_SQL.qty_allocated
                      END AS [QOH-QOA], 
                      CASE WHEN ((NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (iminvloc_sql.qty_on_hand < 0) AND 
                      ((ROUND(IMINVLOC_SQL.qty_on_ord - IMINVLOC_SQL.qty_allocated - IMITMIDX_SQL.item_note_4, 0)) < 0)) 
                      THEN 'NC' 
                      WHEN ((NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (iminvloc_sql.qty_on_hand > 0) AND 
                      ((ROUND(IMINVLOC_SQL.qty_on_hand + IMINVLOC_SQL.qty_on_ord - IMINVLOC_SQL.qty_allocated - IMITMIDX_SQL.item_note_4, 0)) < 0)) 
                      THEN 'NC' 
                      WHEN ((IMITMIDX_SQL.item_note_4 IS NULL) AND (iminvloc_sql.qty_on_hand > 0) AND 
                      (ROUND(IMINVLOC_SQL.qty_on_hand + IMINVLOC_SQL.qty_on_ord - IMINVLOC_SQL.qty_allocated, 0) < 0)) 
                      THEN 'NC' 
                      WHEN  ((IMITMIDX_SQL.item_note_4 IS NULL) AND (iminvloc_sql.qty_on_hand < 0) AND 
                      (ROUND(IMINVLOC_SQL.qty_on_ord - IMINVLOC_SQL.qty_allocated, 0) < 0)) 
                      THEN 'NC'
                      ELSE '' 
                      END AS [CHECK], 
                      CASE WHEN (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (IMINVLOC_SQL.qty_on_hand > 0)
                      THEN (ROUND(IMINVLOC_SQL.qty_on_hand + IMINVLOC_SQL.qty_on_ord - IMINVLOC_SQL.qty_allocated - IMITMIDX_SQL.item_note_4, 0)) 
                      WHEN (NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (IMINVLOC_SQL.qty_on_hand < 0)
                      THEN (ROUND(IMINVLOC_SQL.qty_on_ord - IMINVLOC_SQL.qty_allocated - IMITMIDX_SQL.item_note_4, 0))
                      WHEN (IMITMIDX_SQL.item_note_4 IS NULL) AND (IMINVLOC_SQL.qty_on_hand > 0)
                      THEN (ROUND(IMINVLOC_SQL.qty_on_hand + IMINVLOC_SQL.qty_on_ord - IMINVLOC_SQL.qty_allocated, 0)) 
                      WHEN (IMITMIDX_SQL.item_note_4 IS NULL) AND (IMINVLOC_SQL.qty_on_hand < 0)
                      THEN (ROUND(IMINVLOC_SQL.qty_on_ord - IMINVLOC_SQL.qty_allocated, 0))
                      END AS [QOH+QOO-QOA-SS], 
                      
                      CASE WHEN (IMINVLOC_SQL.qty_on_hand > 0)
                      THEN ROUND((IMINVLOC_SQL.qty_on_hand + IMINVLOC_SQL.qty_on_ord - IMINVLOC_SQL.qty_allocated) - IMINVLOC_SQL.usage_ytd / 11, 0) 
                      WHEN (IMINVLOC_SQL.qty_on_hand < 0)
                      THEN ROUND((IMINVLOC_SQL.qty_on_ord - IMINVLOC_SQL.qty_allocated) - IMINVLOC_SQL.usage_ytd / 11, 0)
                      END AS SS1MNTH, 
                      
                      CASE WHEN (IMINVLOC_SQL.qty_on_hand > 0)
                      THEN ROUND((IMINVLOC_SQL.qty_on_hand + IMINVLOC_SQL.qty_on_ord - IMINVLOC_SQL.qty_allocated) - IMINVLOC_SQL.usage_ytd / 11, 0) 
                      WHEN (IMINVLOC_SQL.qty_on_hand < 0)
                      THEN ROUND(((IMINVLOC_SQL.qty_on_ord - IMINVLOC_SQL.qty_allocated) - ((IMINVLOC_SQL.usage_ytd / 11)*2)), 0)
                      END  AS SS2MNTH, IMINVLOC_SQL.usage_ytd AS CYU, '_____' AS [Order], '____' AS [PO Check], IMITMIDX_SQL.item_note_2 AS Supplier, 
                      IMITMIDX_SQL.item_note_3 AS [Critical Item], IMITMIDX_SQL.item_note_5 AS [Misc Note (N5)], IMITMIDX_SQL.p_and_ic_cd AS [Rec Loc], 
                      IMINVLOC_SQL.prior_year_usage AS PYU, IMINVLOC_SQL.usage_ytd, CAST(ROUND(IMINVLOC_SQL.last_cost, 2, 0) AS DECIMAL(8, 2)) AS LC, 
                      CAST(ROUND(IMINVLOC_SQL.std_cost, 2, 0) AS DECIMAL(8, 2)) AS SC
FROM				  dbo.iminvloc_sql AS IMINVLOC_SQL INNER JOIN
                      dbo.imitmidx_sql AS IMITMIDX_SQL ON IMINVLOC_SQL.item_no = IMITMIDX_SQL.item_no
WHERE    
               
(NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (iminvloc_sql.qty_on_hand < 0) AND 
                      ((ROUND(IMINVLOC_SQL.qty_on_ord - IMINVLOC_SQL.qty_allocated - IMITMIDX_SQL.item_note_4, 0)) < 0) AND
(NOT (IMINVLOC_SQL.prod_cat = '036' OR
                      IMINVLOC_SQL.prod_cat = '037' OR
                      IMINVLOC_SQL.prod_cat = '336' OR
                      IMINVLOC_SQL.prod_cat = 'AP')) 
AND (IMITMIDX_SQL.item_note_1 = 'ch' OR
                      IMITMIDX_SQL.item_note_1 = 'Ch' OR
                      IMITMIDX_SQL.item_note_1 = 'CH' OR
                      IMITMIDX_SQL.item_note_1 = 'CHD') 

OR   
(NOT (IMITMIDX_SQL.item_note_4 IS NULL)) AND (iminvloc_sql.qty_on_hand > 0) AND 
                      ((ROUND(IMINVLOC_SQL.qty_on_hand + IMINVLOC_SQL.qty_on_ord - IMINVLOC_SQL.qty_allocated - IMITMIDX_SQL.item_note_4, 0)) < 0) AND
(NOT (IMINVLOC_SQL.prod_cat = '036' OR
                      IMINVLOC_SQL.prod_cat = '037' OR
                      IMINVLOC_SQL.prod_cat = '336' OR
                      IMINVLOC_SQL.prod_cat = 'AP')) 
AND (IMITMIDX_SQL.item_note_1 = 'ch' OR
                      IMITMIDX_SQL.item_note_1 = 'Ch' OR
                      IMITMIDX_SQL.item_note_1 = 'CH' OR
                      IMITMIDX_SQL.item_note_1 = 'CHD') 
AND (IMINVLOC_SQL.prior_year_usage > 0) 

OR  
(IMITMIDX_SQL.item_note_4 IS NULL) AND (iminvloc_sql.qty_on_hand > 0) AND 
                      (ROUND(IMINVLOC_SQL.qty_on_hand + IMINVLOC_SQL.qty_on_ord - IMINVLOC_SQL.qty_allocated, 0) < 0) AND
(NOT (IMINVLOC_SQL.prod_cat = '036' OR
                      IMINVLOC_SQL.prod_cat = '037' OR
                      IMINVLOC_SQL.prod_cat = '336' OR
                      IMINVLOC_SQL.prod_cat = 'AP')) 
AND (IMITMIDX_SQL.item_note_1 = 'ch' OR
                      IMITMIDX_SQL.item_note_1 = 'Ch' OR
                      IMITMIDX_SQL.item_note_1 = 'CH' OR
                      IMITMIDX_SQL.item_note_1 = 'CHD') 
AND (IMINVLOC_SQL.qty_on_ord > 0) 

OR 
(IMITMIDX_SQL.item_note_4 IS NULL) AND (iminvloc_sql.qty_on_hand < 0) AND 
                      (ROUND(IMINVLOC_SQL.qty_on_ord - IMINVLOC_SQL.qty_allocated, 0) < 0) AND
(NOT (IMINVLOC_SQL.prod_cat = '036' OR
                      IMINVLOC_SQL.prod_cat = '037' OR
                      IMINVLOC_SQL.prod_cat = '336' OR
                      IMINVLOC_SQL.prod_cat = 'AP')) 
AND (IMITMIDX_SQL.item_note_1 = 'ch' OR
                      IMITMIDX_SQL.item_note_1 = 'Ch' OR
                      IMITMIDX_SQL.item_note_1 = 'CH' OR
                      IMITMIDX_SQL.item_note_1 = 'CHD') 
AND (IMINVLOC_SQL.qty_allocated > 0)

ORDER BY [CHECK] DESC