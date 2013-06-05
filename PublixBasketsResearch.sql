SELECT  frz_qty, *
FROM    iminvloc_sql
WHERE item_no like 'SW00245'

SELECT  oh.ord_no, qty_to_ship
FROM    oelinhst_sql OL INNER JOIN oehdrhst_sql OH ON OH.inv_no = OL.inv_no
WHERE rtrim(ltrim(OH.cus_no)) = '1108' AND item_no like 'SW00245' AND shipped_dt > '01/01/2011'

SELECT *
FROM poordlin_sql
WHERE item_no like 'SW00245' and qty_received < qty_ordered

SELECT  cus_no, bill_to_name,*
FROM    oehdrhst_sql 
WHERE ord_no = ' 5011400'

SELECT  SUM(qty_to_ship)
FROM    oelinhst_sql OL INNER JOIN oehdrhst_sql OH ON OH.inv_no = OL.inv_no AND OH.ord_type = OL.ord_type
WHERE rtrim(ltrim(OH.cus_no)) IN ('1108','1100') AND item_no like 'SW00245' AND oh.ord_type = 'O'

SELECT  oh.ord_no, qty_to_ship
FROM    oeordlin_sql OL INNER JOIN oeordhdr_sql OH ON OH.ord_no = OL.ord_no
WHERE rtrim(ltrim(OH.cus_no)) = '1108' AND item_no like 'SW00245'