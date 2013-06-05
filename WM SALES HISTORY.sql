SELECT OL.prod_cat, OH.ord_no, OH.inv_no, inv_dt, item_no, item_desc_1 , qty_to_ship, unit_price , qty_to_ship*unit_price AS [Total]
FROM oehdrhst_sql AS OH INNER JOIN oelinhst_sql OL ON OH.inv_no = OL.inv_no
WHERE rtrim(ltrim(OH.cus_no)) in ('1575') AND inv_dt >= '03/01/2013' AND unit_price > 0