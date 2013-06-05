SELECT            OH.ord_no, OH.oe_po_no, OL.item_no, OL.cus_item_no, EDI.tp_item_num, OL.qty_ordered, OL.qty_to_ship, OL.unit_price, OL.billed_dt, OH.inv_no
FROM        oelinhst_sql      OL
join        oehdrhst_sql      OH
            ON    OL.inv_no = OH.inv_no
left outer join   edcitmfl_sql      EDI
            On    OH.cus_no = EDI.cust_num and OL.item_no = EDI.mac_item_num        
WHERE       LTRIM(OH.cus_no) = '1575' AND (OH.slspsn_no = '20' OR OL.item_no IN ('CR END PANEL LABOR', 'CR INSTALL TRIP', 'CR LG END PANEL', 
                  'CR PRECON UNDER', 'R&R M9041790', 'SCOPE & INSTALL', 'WM-CRGDEXT2010', 'WM-CRMDEXT2010', 'WM-CRMDINT2010', 'WM-MDEXT2010', 
                  'WMCRCCECEXT2010', 'WMCRCCECINT2010')) AND OH.ord_dt_billed > '05/01/11' AND OH.oe_po_no LIKE '3%' AND OL.unit_price != 0 AND
                  OH.orig_ord_type = 'O' AND OL.item_no != 'WM-CR SCOPETRIP'-- AND OL.cus_item_no != EDI.tp_item_num
