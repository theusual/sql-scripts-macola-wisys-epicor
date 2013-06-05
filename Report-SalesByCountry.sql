SELECT entered_dt, OH.ord_Type, bill_to_name, ship_to_name, ship_to_addr_2, ship_to_country, OL.item_no, OL.qty_to_ship, OL.unit_price, OL.item_desc_1, OL.item_desc_2
FROM dbo.oehdrhst_sql OH JOIN OELINHST_SQL OL ON OL.inv_no = OH.inv_no  AND OH.ord_type = OL.ord_type
WHERE ship_to_country IN ('MX','DO','BS')

SELECT DISTINCT ship_to_country, land.oms60_0 
FROM dbo.oehdrhst_sql JOIN dbo.land ON land.landcode = ship_to_country 
WHERE ship_to_country != 'US'

SELECT * FROM dbo.sycdefil_sql

SELECT * FROM dbo.land