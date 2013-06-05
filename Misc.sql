SELECT *
FROM z_iminvloc_qall_with_levels
WHERE item_no like '%pbu-14%'

SELECT item_no, SUM (qty_ordered)
FROM OEORDLIN_SQL
WHERE item_no like '%PBU-14%'
GROUP BY item_no


SELECT *
FROM oeordlin_sql
WHERE item_no = 'DELI-78 BK'

SELECT SUM(qty_to_ship)
FROM oeordlin_sql
WHERE item_no = 'DELI-78 BK'

SELECT *
FROM ARSHTTBL
WHERE ltrim(rtrim(ord_no)) =   '832103'

SELECT *
FROM Z_IMINVLOC_QALL
WHERE item_no = 'DELI-78 BK'

SELECT *
FROM iminvtrx_sql
WHERE trx_dt > '2011-02-17 00:00:00.000'
ORDER BY item_no


SELECT * FROM POORDLIN_SQL WHERE not (vend_item_no is null) AND qty_received < qty_ordered

SELECT *
FROM OEHDRHST_SQL
WHERE inv_no like '%43379%'

SELECT *
FROM OELINHST_SQL
WHERE inv_no like '%43379%'
ORDER BY inv_no

SELECT * FROM poordhdr_sql WHERE ord_no like '%99005%'
SELECT * FROM poordlin_sql WHERE ord_no like '%99005%'

SELECT * FROM oeordhdr_sql WHERE ord_no like '77777775'

SELECT * FROM oehdrhst_sql WHERE ord_no like '%4012347%'

SELECT * FROM wsBOLView where oebolord_sql_ord_no like '%668517%'
SELECT * FROM wspikpak where ord_no like '%668517%'

UPDATE wsPikPak 
set Pallet = null
where ord_no like '%668517%'

SELECT *
FROM z_iminvloc
WHERE item_no like '%dump%'



UPDATE oeordhdr_sql SET status = 4 where ord_no = '77777775'