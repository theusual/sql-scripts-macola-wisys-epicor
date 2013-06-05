SELECT IM.item_no, imitmidx_sql.item_desc_1, imitmidx_sql.item_desc_2, im.loc, IM.prod_cat, IM.qty_on_hand
FROM  dbo.iminvloc_sql AS IM INNER JOIN
               dbo.imitmidx_sql ON IM.item_no = dbo.imitmidx_sql.item_no
WHERE  (NOT (dbo.imitmidx_sql.mat_cost_type IN ('036', '037', '2', '4', '436', '5', '9', 'AUT', 'B', 'BLD', 'CE', 'CRC', 'CRM', 'CRO', 'CS', 'EMP', 'EW', 'EXP', 
               'OFC', 'PAT', 'PE', 'R'))) 
               AND (NOT (IM.prod_cat IN ('010', '011', '036', '037', '19', '2', '20', '4'))) 
               AND (dbo.imitmidx_sql.activity_cd = 'A') 
               AND (IM.usage_ytd > 0 OR IM.prior_year_usage > 0 OR IM.qty_on_hand > 0) 
/*UNION ALL
SELECT IM.item_no, imitmidx_sql.item_desc_1, imitmidx_sql.item_desc_2, 'z_ALL' AS [LOC], IM.prod_cat, SUM(IM.qty_on_hand)
FROM  dbo.iminvloc_sql AS IM INNER JOIN
               dbo.imitmidx_sql ON IM.item_no = dbo.imitmidx_sql.item_no
WHERE (NOT (IM.loc = 'CAN')) AND (NOT (dbo.imitmidx_sql.mat_cost_type IN ('036', '037', '2', '4', '436', '5', '9', 'AUT', 'B', 'BLD', 'CE', 'CRC', 'CRM', 'CRO', 'CS', 'EMP', 'EW', 'EXP', 
               'OFC', 'PAT', 'PE', 'R'))) AND (NOT (IM.prod_cat IN ('010', '011', '036', '037', '19', '2', '20', '4'))) AND (dbo.imitmidx_sql.activity_cd = 'A') AND (IM.usage_ytd > 0) OR
               (NOT (IM.loc = 'CAN')) AND (NOT (dbo.imitmidx_sql.mat_cost_type IN ('036', '037', '2', '4', '436', '5', '9', 'AUT', 'B', 'BLD', 'CE', 'CRC', 'CRM', 'CRO', 'CS', 'EMP', 'EW', 'EXP', 
               'OFC', 'PAT', 'PE', 'R'))) AND (NOT (IM.prod_cat IN ('010', '011', '036', '037', '19', '2', '20', '4'))) AND (dbo.imitmidx_sql.activity_cd = 'A') AND (IM.prior_year_usage > 0) OR
               (NOT (IM.loc = 'CAN')) AND (NOT (dbo.imitmidx_sql.mat_cost_type IN ('036', '037', '2', '4', '436', '5', '9', 'AUT', 'B', 'BLD', 'CE', 'CRC', 'CRM', 'CRO', 'CS', 'EMP', 'EW', 'EXP', 
               'OFC', 'PAT', 'PE', 'R'))) AND (NOT (IM.prod_cat IN ('010', '011', '036', '037', '19', '2', '20', '4'))) AND (dbo.imitmidx_sql.activity_cd = 'A') AND (IM.qty_on_hand > 0) OR
               (NOT (IM.loc = 'CAN')) AND (NOT (dbo.imitmidx_sql.mat_cost_type IN ('036', '037', '2', '4', '436', '5', '9', 'AUT', 'B', 'BLD', 'CE', 'CRC', 'CRM', 'CRO', 'CS', 'EMP', 'EW', 'EXP', 
               'OFC', 'PAT', 'PE', 'R'))) AND (NOT (IM.prod_cat IN ('010', '011', '036', '037', '19', '2', '20', '4'))) AND (dbo.imitmidx_sql.activity_cd = 'A') AND 
               (dbo.imitmidx_sql.activity_dt > '08/01/2010')
GROUP BY IM.item_no, imitmidx_sql.item_desc_1, imitmidx_sql.item_desc_2, IM.prod_cat)*/