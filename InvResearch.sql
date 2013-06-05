SELECT * 
FROM bmprdstr_sql
WHERE comp_item_no = 'obp-36x36x8 bk'

SELECT SUM(qty) FROM wspikpak
WHERE item_no = 'SW00240' AND ship_dt > '10/02/2011'

SELECT * FROM iminvtrx_Sql WHERE item_no = 'SW00240' AND trx_dt > '10/02/2011' ORDER BY trx_dt, trx_tm

SELECT * FROM iminvloc_sql WHERE item_no = 'mty9203 bk'
