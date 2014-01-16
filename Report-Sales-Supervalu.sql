select oe_po_no, entered_dt, shipping_dt, OL.item_no, OL.item_desc_1, OL.item_desc_2, OL.qty_to_ship, OL.unit_price
from oehdrhst_Sql OH JOIN OELINHST_SQL OL ON OL.ord_no = OH.ord_no
WHERE ltrim(OH.cus_no) IN
('1755',
'7055',
'2755',
'32985',
'32720',
'40',
'8392',
'6849',
'22525')
AND inv_dt > '06/01/2013'