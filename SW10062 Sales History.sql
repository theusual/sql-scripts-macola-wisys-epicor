SELECT oh.ord_no, item_no, item_desc_1, item_desc_2, qty_ordered, qty_to_ship, request_dt, oh.cus_no, cus_alt_adr_cd
FROM oehdrhst_sql OH INNER JOIN oelinhst_sql OL ON OL.ord_no = OH.ord_no
WHERE item_no = 'SW10062' AND not OH.cus_no like '%25166'
ORDER BY entered_dt


SELECT *
FROM oehdrhst_sql OH INNER JOIN oelinhst_sql OL ON OL.ord_no = OH.ord_no
WHERE item_no = 'SW10062' AND ((ltrim(OH.cus_no) > '25100' AND ltrim(OH.cus_no) < '25200') OR ltrim(OH.cus_no) = '25590' OR ltrim(OH.cus_no) = '28011' OR ltrim(OH.cus_no) = '22056' OR (ltrim(OH.cus_no) > '28067' AND ltrim(OH.cus_no) < '28101'))
ORDER BY entered_dt