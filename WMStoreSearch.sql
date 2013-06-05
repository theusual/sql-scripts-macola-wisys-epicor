SELECT  OH.cus_alt_adr_cd, OH.ord_no, OH.oe_po_no, ol.item_no, cus_item_no, ol.qty_to_ship, loc, entered_dt, shipping_dt, inv_dt, oh.cmt_1, oh.cmt_3
FROM    oelinhst_sql ol join oehdrhst_sql oh on oh.inv_no = ol.inv_no
where cus_alt_adr_cd IN
('5860',
'5855',
'5647',
'5990',
'5991',
'5875',
'5863',
'5856',
'5846',
'5986',
'5876',
'5179') and ltrim(OH.cus_no) = '1575' and qty_to_ship > 0 and unit_price > 0

UNION ALL

SELECT  OH.cus_alt_adr_cd, OH.ord_no, OH.oe_po_no, ol.item_no, cus_item_no, ol.qty_to_ship, loc, entered_dt, shipping_dt, inv_dt, 'NOT SHIPPED', 'NOT SHIPPPED'
FROM    oeordlin_sql ol join oeordhdr_sql oh on oh.ord_no = ol.ord_no
where cus_alt_adr_cd IN
('5860',
'5855',
'5647',
'5990',
'5991',
'5875',
'5863',
'5856',
'5846',
'5986',
'5876',
'5179') and ltrim(OH.cus_no) = '1575' and qty_to_ship > 0 and unit_price > 0
