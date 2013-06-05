SELECT  PH.ord_dt, PL.extra_8, * FROM poordlin_sql PL JOIN POORDHDR_SQL PH ON PH.ord_no = PL.ord_no 
WHERE qty_ordered = qty_received AND LTRIM(PL.vend_no) IN ('9523') AND receipt_dt > '11/02/2011'
ORDER BY PL.receipt_dt desc