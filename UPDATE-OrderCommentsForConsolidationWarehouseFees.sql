SELECT * FROM oelinhst_Sql OL WHERE OL.ord_no = ' 2027834'

SELECT * FROM dbo.wsPikPak WHERE ord_no = ' 2027834'

SELECT * FROM oeordlin_sql WHERE item_no LIKE '%"%'

SELECT ship_to_addr_1, ship_to_addr_2, ship_to_addr_3, ship_to_addr_4, (RTRIM(address1) + '%'), * 
FROM oehdrhst_sql CROSS JOIN BG_Extra_Shipping_Fee_Warehouse_List
WHERE ship_to_addr_2 LIKE (RTRIM(address1) + '%')