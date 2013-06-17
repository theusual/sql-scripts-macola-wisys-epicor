SELECT OH.slspsn_no, entered_dt, OH.ord_Type, bill_to_name, ship_to_name, ship_to_addr_2, ship_to_country, OL.item_no, OL.qty_to_ship, OL.unit_price, OL.item_desc_1, OL.item_desc_2
FROM dbo.oehdrhst_sql OH JOIN OELINHST_SQL OL ON OL.inv_no = OH.inv_no  AND OH.ord_type = OL.ord_type
WHERE (--ship_to_country IN ('MX','DO','BS') OR LTRIM(OH.cus_no) IN ('9416','2009','21166','26050','7171','21890','20571','6544','3210','2014','2019','20602','10235','23011') OR 
bill_to_name LIKE '%BM MARKETING%' OR bill_to_name LIKE '%BMMARK%' )AND OH.ord_type != 'Q'

SELECT DISTINCT ship_to_country, land.oms60_0 
FROM dbo.oehdrhst_sql JOIN dbo.land ON land.landcode = ship_to_country 
WHERE ship_to_country != 'US'

SELECT * FROM dbo.sycdefil_sql

SELECT * FROM dbo.land

SELECT * FROM dbo.arslmfil_SQL


SELECT OH.slspsn_no, entered_dt, OH.ord_Type, bill_to_name, ship_to_name, ship_to_addr_2, ship_to_country, OL.item_no, OL.qty_to_ship, OL.unit_price, OL.item_desc_1, OL.item_desc_2
FROM dbo.oehdrhst_sql OH JOIN OELINHST_SQL OL ON OL.inv_no = OH.inv_no  AND OH.ord_type = OL.ord_type
WHERE OH.slspsn_no IN ('17','28') AND OH.ord_Type = 'O'