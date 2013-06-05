SELECT  *
FROM wsBOLView
WHERE oebolord_sql_ord_no = '  670139' OR oebolord_sql_ord_no = '  669380'

SELECT  *
FROM wsBOLView
WHERE oebolord_sql_ord_no = '  670095' OR oebolord_sql_ord_no = '  669443'

select * from wsShipment where bol_no in (
select bol_no from wsShipment group by bol_no having COUNT(1) > 1) order by bol_no

UPDATE OEORDHDR_SQL
SET status = 4
where ord_no = '77777772'

SELECT *
FROM oeordhdr_sql
where ord_no = '77777772'

SELECT *
FROM wsThirdPartyAcct

SELECT SUM(qty_ordered)
FROM oeordlin_sql
WHERE item_no like 'GRO-011SNPRL BV'  

SELECT SUM(qty_ordered)
FROM poordlin_sql
WHERE item_no like 'GRO-011SNPRLBVD%' AND qty_ordered > qty_received

SELECT *
FROM OEHDRHST_SQL  AS OH INNER JOIN oELINHST_sql AS OL ON OL.ord_no = OH.ord_no
WHERE OH.oe_po_no like '%30670881%'


SELECT *
FROM wsPikPak
WHERE Item_no like '%BAK-HLDR 2 BK%'

SELECT *
FROM oehdrhst_sql
WHERE cus_no like '%2007%'

SELECT *
FROM poordlin_sql
WHERE item_no like '%MDWM-0001 SB%'

SELECT *
FROM wsPikPak
ORDER BY Shipment

UPDATE wsPikPak
SET Carton = Pallet, Carton_UCC128 = Pallet_UCC128
WHERE shipment > 850

SELECT *
FROM ARSHTTBL
WHERE ord_no like '%1111111%'

SELECT *
FROM wsBOLView
WHERE oeordhdr_sql_ord_no like '%5011471%'

SELECT *
FROM  imitmidx_sql
WHERE item_no = 'test item'

SELECT *
FROM wsPikPak
where item_no like '%BAK-HLDR 1 BK%'

UPDATE OEORDHDR_SQL
SET status = 4
WHERE ord_no = '66666661'

SELECT *
FROM OEORDLIN_SQL
WHERE ord_no = '66666661'

SELECT *
FROM ARSHTTBL
WHERE ord_no = '715651'

SELECT *
FROM imitmidx_sql INNER JOIN iminvloc_sql ON imitmidx_sql.item_no = iminvloc_sql.item_no
WHERE IMITMIDX_SQL.item_no like 'DELI-65 RSR BK%'

SELECT * 
FROM Z_IMINVLOC_USAGE
WHERE item_no = 'DELI-65 RSR BK' 

SELECT * 
FROM Z_IMINVLOC
WHERE item_no = 'DELI-65 RSR BK'

SELECT * 
FROM IMINVLOC_SQL
WHERE item_no = 'DELI-65 RSR BK'

SELECT OEHDRHST_SQL.inv_no, item_no, qty_to_ship, inv_dt, qty_ordered, OEHDRHST_SQL.ord_no, oehdrhst_sql.cus_no
FROM OEHDRHST_SQL INNER JOIN OELINHST_SQL ON OEHDRHST_SQL.ord_no = OELINHST_SQL.ord_no
WHERE item_no = 'DELI-65 RSR BK' AND inv_dt > '01/01/2011'




