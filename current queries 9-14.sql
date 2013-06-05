SELECT  *
FROM    iminvloc_Sql
where item_no = 'MET-TBL 001 BV'

SELECT  *
FROM    Z_IMINVLOC_QOH_CHECK
where item_no = 'MET-TBL 001 BV'

SELECT  SUM(qty_received)
FROM     poordlin_sql
where item_no = 'MET-TBL 001 BV' and receipt_dt > '06/01/2011'

SELECT  item_no, SUM(quantity)
FROM    iminvtrx_sql
where doc_type = 'R' and quantity != 0  and user_name = 'CBARNES'
GROUP BY item_no

SELECT  SUM(qty_to_ship)
FROM    oelinhst_sql
where item_no = 'MET-TBL 001 BV' and billed_dt > '07/02/2011'
