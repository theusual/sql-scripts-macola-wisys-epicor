USE [001]
SELECT DISTINCT OELINHST_SQL.item_no AS Parent, oelinhst_sql.item_desc_1 AS ParentDesc, oelinhst_sql.item_desc_2 AS ParentDesc2, BM.comp_item_no AS Component, unit_price AS ParentPrice
FROM OEHDRHST_SQL INNER JOIN OELINHST_SQL ON OEHDRHST_SQL.ord_no = OELINHST_SQL.ord_no LEFT OUTER JOIN bmprdstr_sql AS BM ON BM.item_no = oelinhst_sql.item_no
WHERE ltrim(oehdrhst_sql.cus_no) IN ('122523','22523') AND inv_dt > '01/01/2010' AND NOT(BM.item_no = 'WN-094 OAK')
ORDER BY OELINHST_SQL.item_no