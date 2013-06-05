SELECT  DISTINCT   max(ord_dt), PL.item_no AS Item, MAX(PH.ord_no) AS [PO #], IM.prod_cat AS Cat, PL.exp_unit_cost AS [UnitPrice]
FROM    POORDLIN_SQL PL INNER JOIN poordhdr_sql PH ON PH.ord_no = PL.ord_no
					LEFT OUTER JOIN imitmidx_sql IM ON im.item_no = PL.item_no 
WHERE ltrim(PL.vend_no) = '8859' AND ord_dt > '2009-01-01 00:00:00.000' AND PL.qty_received > 0 
	  AND PL.item_no IN (SELECT item_no
					FROM (SELECT DISTINCT item_no,  exp_unit_cost
					FROM poordlin_sql 
					GROUP BY item_no, exp_unit_cost ) AS TEMP
					GROUP BY item_no
					HAVING count(temp.item_no) > 1) 
	 AND PL.item_no IN (SELECT DISTINCT item_no 
						FROM poordlin_sql PL INNER JOIN poordhdr_sql PH ON PL.ord_no = PH.ord_no
						WHERE YEAR(ord_dt) = '2008')
GROUP by pl.item_no, pl.exp_unit_cost, im.prod_cat
ORDER BY PL.item_no

--SELECT item_no
--FROM (SELECT DISTINCT item_no,  exp_unit_cost
--FROM poordlin_sql 
--GROUP BY item_no, exp_unit_cost ) AS TEMP
--GROUP BY item_no
--HAVING count(temp.item_no) > 1
--ORDER BY item_no

