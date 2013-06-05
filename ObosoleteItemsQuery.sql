 USE [001]
 SELECT IMINV.item_no, IMINV.sls_ytd, IMINV.cost_ytd, IMINV.qty_sold_ytd, IMINV.last_cost, IMINV.last_sold_dt, IM.prod_cat, IM.item_desc_1, IMINV.frz_qty, IMINV.prior_year_usage, IMINV.usage_ytd
 FROM   IMINVLOC_SQL AS IMINV INNER JOIN imitmidx_sql IM ON IMINV.item_no=IM.item_no
 WHERE  
 IMINV.frz_qty = 0 
 AND (IMINV.last_sold_dt<{ts '2009-01-01 00:00:00'}  OR IMINV.last_sold_dt is null)
 AND  NOT (IMINV.item_no LIKE 'PC-%' OR IMINV.item_no LIKE 'POB-%' OR IMINV.item_no LIKE '*EDI-ITEM') 
 AND IMINV.usage_ytd = 0
 AND IMINV.prior_year_usage = 0 
 AND  NOT (IM.prod_cat='010' OR IM.prod_cat='036' OR IM.prod_cat='037' OR IM.prod_cat='053' OR IM.prod_cat='054' OR IM.prod_cat='111' OR IM.prod_cat='336' OR IM.prod_cat='7' OR IM.prod_cat='9')
 AND IMINV.loc = 'FW'
 AND NOT(IMINV.item_no IN (
 SELECT DISTINCT item_no 
 FROM poordlin_sql
 WHERE receipt_dt >  ('2009-01-01 00:00:00')
 ))
 ORDER BY IMINV.item_no


