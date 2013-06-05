SELECT PL.ord_no, PH.ord_dt, CONVERT(varchar(10), PL.extra_8, 101), PL. act_unit_cost, PL.qty_received, (PL.act_unit_cost * PL.qty_received), * 
FROM poordlin_sql PL JOIN dbo.poordhdr_sql PH ON PH.ord_no = PL.ord_no 
WHERE (ltrim(PH.vend_no) = '9533' OR ltrim(PH.vend_no) = '9535') AND PL.extra_8 IS NOT NULL AND PL.ord_status != 'X'


