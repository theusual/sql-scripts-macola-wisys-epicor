select 'P' AS PARENT_FG, OL.item_no AS PARENT, OL.item_no, OL.qty_to_ship, OH.inv_dt, STR(YEAR(OH.INV_DT)) + ' - ' + ltrim(STR(MONTH(OH.inv_dt))) AS MONTH
from oelinhst_sql OL JOIN oehdrhst_sql OH ON OH.inv_no = OL.inv_no 
WHERE year(OH.inv_dt) IN (2012,2013) AND ltrim(OH.cus_no) = '1575' AND OH.slspsn_no = '20' AND qty_to_ship > 0
UNION ALL
select 'C' AS PARENT_FG,BM.item_no AS PARENT, BM.comp_item_no, OL.qty_to_ship*BM.qty_per_par AS QTY, OH.inv_dt, STR(YEAR(OH.INV_DT)) + ' - ' + ltrim(STR(MONTH(OH.inv_dt))) AS MONTH
from oelinhst_sql OL JOIN oehdrhst_sql OH ON OH.inv_no = OL.inv_no 
					 JOIN bmprdstr_sql BM ON BM.item_no = OL.item_no
WHERE year(OH.inv_dt) IN (2012,2013) AND ltrim(OH.cus_no) = '1575' AND OH.slspsn_no = '20' AND qty_to_ship > 0

