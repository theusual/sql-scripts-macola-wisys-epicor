SELECT SUM((1 - (OL.discount_pct) / 100) * (OL.sls_amt))
FROM oelinhst_Sql OL JOIN oehdrhst_sql OH ON OL.inv_no = OH.inv_no
WHERE inv_dt > '01/01/2011'