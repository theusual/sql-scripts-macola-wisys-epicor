
SELECT oh.ord_no, inv_dt, oh.cus_no, country, cus_name, qty_to_ship, unit_price, item_no, item_desc_1, item_desc_2
FROM oehdrhst_sql OH INNER JOIN oelinhst_sql OL on OH.inv_no = OL.inv_no INNER JOIN arcusfil_sql AR ON AR.cus_no = OH.cus_no
WHERE OH.ord_type = 'O' AND (OH.cus_no IN ('354',
'3680',
'23077',
'25178',
'7055',
'23005',
'3494',
'26108',
'23125',
'25000',
'20691',
'21063') OR AR.country != 'US')
