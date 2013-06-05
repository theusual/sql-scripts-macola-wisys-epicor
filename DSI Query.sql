SELECT  OH.cus_no, OH.ord_no, OH.oe_po_no, ol.item_no, ol.qty_to_ship, loc, entered_dt, shipping_dt, inv_dt, oh.cmt_1, oh.cmt_3
FROM    oelinhst_sql ol join oehdrhst_sql oh on oh.inv_no = ol.inv_no
where item_no IN
('DELI-65 RSR BK',
'ST-043 BV',
'SW00007',
'SW00043BK',
'SW00046WH',
'SW00071WH',
'SW00074',
'SW00076',
'SW00665',
'SW00877W',
'SW10140',
'SW10168',
'SW10209',
'SW10210',
'SW10217') and ltrim(OH.cus_no) = '4227' and qty_to_ship > 0 and unit_price > 0
order by ord_no