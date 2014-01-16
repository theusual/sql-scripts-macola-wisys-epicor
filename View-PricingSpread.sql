--Created:	1/9/14		 By:	BG
--Last Updated:	1/9/14	 By:	BG
--Purpose: Show pricing spread of items sold in the last 3 years

ALTER VIEW [dbo].[BG_OE_PRICING_SPREAD] AS

select item_no, AVG(unit_price) AS avg_price, OH.cus_no, CUS.cus_name, SUM(qty_ordered) AS tot_qty_sold
from oehdrhst_Sql OH JOIN oelinhst_sql OL ON OL.inv_no = OH.inv_no
					 JOIN arcusfil_sql CUS ON CUS.cus_no = OH.cus_no
WHERE OH.inv_dt > DATEADD(year,-3,GETDATE()) 
		AND qty_to_ship > 3
	    AND OH.ord_type = 'O'
		AND unit_price > 0
GROUP BY item_no, OH.cus_no, CUS.cus_name






