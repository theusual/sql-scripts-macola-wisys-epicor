select OL.item_no, EDI.edi_item_num, OL.qty_to_ship, OH.inv_dt, OH.oe_po_no, OH.cus_alt_adr_cd, OL.unit_price , OH.ship_to_addr_2, OH.ship_to_city, 
		OH.ship_to_zip, OH.ship_to_state,  substring(OH.ship_to_addr_4, 1, (charindex(',', OH.ship_to_addr_4) - 1)) AS 'Ship to City', 
		substring(OH.ship_to_addr_4, (charindex(',', OH.ship_to_addr_4) + 2), 2) AS 'Ship to State', 
		substring(OH.ship_to_addr_4, (charindex(',', OH.ship_to_addr_4) + 4), LEN(OH.ship_to_addr_4)) AS 'Ship to Zip'
FROM oelinhst_sql OL join oehdrhst_sql OH ON OH.inv_no = OL.inv_no
					 left outer join edcitmfl_sql EDI ON EDI.mac_item_num = OL.item_no
WHERE OL.item_no like '%corral%' AND OL.qty_to_ship > 0 AND OL.unit_price > 0 --AND OH.inv_dt > '01/01/2012'

UNION ALL

select BM.comp_item_no, EDI.edi_item_num, qty_to_ship * BM.qty_per_par, OH.inv_dt, OH.oe_po_no, BM.item_no AS Parent, EDI2.edi_item_num AS ParentSAP#
FROM oelinhst_sql OL join oehdrhst_sql OH ON OH.inv_no = OL.inv_no
					 join bmprdstr_sql BM ON BM.item_no = OL.item_no
					 join edcitmfl_sql EDI ON EDI.mac_item_num = BM.comp_item_no
					 join edcitmfl_sql EDI2 ON EDI2.mac_item_num = BM.item_no
WHERE OL.item_no like '%corral%' AND OH.inv_dt > '01/01/2012'


select distinct ol.item_no, OH.inv_dt
FROM oelinhst_sql OL join oehdrhst_sql OH ON OH.inv_no = OL.inv_no
					 join edcitmfl_sql EDI ON EDI.mac_item_num = OL.item_no
WHERE OL.item_no like '%corral%'-- AND OH.inv_dt > '01/01/2012'
order by item_no