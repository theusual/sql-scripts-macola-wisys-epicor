SELECT  *
FROM    oeordlin_sql ol join oeordhdr_sql OH on OH.ord_no = ol.ord_no
where loc = 'NE' and OH.shipping_dt > '9/25/2011'

UPDATE oeordhdr_sql
SET mfg_loc = 'MDC'
FROM    oeordlin_sql ol join oeordhdr_sql OH on OH.ord_no = ol.ord_no
where mfg_loc = 'NE' and OH.shipping_dt > '9/25/2011'

SELECT  *
FROM    oeordlin_sql ol join oeordhdr_sql OH on OH.ord_no = ol.ord_no
where loc = 'MDC' and OH.shipping_dt > '9/25/2011'

--Check Open POs
SELECT  *
FROM    poordlin_sql
where stk_loc = 'NE' AND qty_received < qty_ordered

--Check Inventory Table
SELECT  *
FROM    iminvloc_sql
where loc = 'NE' and qty_allocated > 0

