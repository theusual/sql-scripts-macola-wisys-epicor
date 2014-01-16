select item_no, AVG(unit_price), OH.cus_no, OH.bill_to_name, SUM(qty_ordered)
from oehdrhst_Sql OH JOIN oelinhst_sql OL ON OL.inv_no = OH.inv_no
WHERE item_no = 'EZ-12 X 14 BK W' AND OH.inv_dt > '01/01/2012'
GROUP BY item_no, OH.cus_no, OH.bill_to_name



