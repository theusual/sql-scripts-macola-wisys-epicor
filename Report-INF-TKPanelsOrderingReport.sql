SELECT PL.ord_no, AP.vend_name, qty_received, request_dt, receipt_Dt, qty_ordered, item_no, item_desc_1, item_desc_2, job_no, * FROM poordlin_Sql PL JOIN dbo.apvenfil_sql AP ON AP.vend_no = PL.vend_no JOIN dbo.poordhdr_sql PH ON PH.ord_no = PL.ord_no WHERE item_no IN ('sintra-538','sintra-334','SINTRA-541', 'SINTRA-301', 'SINTRA-545', 'SINTRA-546') AND PH.ord_status != 'X' ORDER BY PL.receipt_Dt

SELECT OL.ord_no, OH.bill_to_name, qty_to_ship, entered_dt, inv_dt, unit_price, OL.item_no, OL.item_desc_1, OL.item_desc_2, OH.job_no FROM oelinhst_Sql OL JOIN OEHDRHST_SQL OH ON OH.inv_no = OL.inv_no WHERE job_no = '8485' AND OL.item_desc_2 LIKE '%WALL%' AND inv_Dt > '4/1/2013'

SELECT * FROM poordlin_sql WHERE LTRIM(ord_no) = '903200'

SELECT * FROM dbo.poordlin_sql PL JOIN apvenfil_sql ven ON ven.vend_no = PL.vend_no WHERE item_no LIKE 'SINTRA%' AND job_no = '8485' 

