	SELECT DISTINCT MIN(PH.ord_dt),pl.item_no,  MAX(ph.ord_no), exp_unit_cost, IM.prod_cat
					FROM poordlin_sql pl  INNER JOIN imitmidx_sql IM ON IM.item_no = PL.item_no INNER JOIN poordhdr_sql PH ON PH.ord_no = PL.ord_no
					WHERE pl.item_no in 
						(SELECT item_no
						FROM (SELECT DISTINCT item_no,  exp_unit_cost
						FROM poordlin_sql 
						GROUP BY item_no, exp_unit_cost ) AS TEMP
						GROUP BY item_no
						HAVING count(temp.item_no) > 1)
					AND PL.item_no IN (SELECT DISTINCT item_no 
						FROM poordlin_sql PL INNER JOIN poordhdr_sql PH ON PL.ord_no = PH.ord_no
						WHERE YEAR(ord_dt) = '2008')
					AND PL.item_no IN (SELECT DISTINCT item_no 
						FROM poordlin_sql PL INNER JOIN poordhdr_sql PH ON PL.ord_no = PH.ord_no
						WHERE YEAR(ord_dt) = '2010')
					AND ord_dt > '2008-01-01 00:00:00.000'
					GROUP BY pl.item_no, exp_unit_cost , IM.prod_cat
					ORDER BY pl.item_no
					
					--			(SELECT item_no
					--FROM (SELECT DISTINCT item_no,  exp_unit_cost
					--FROM poordlin_sql 
					--GROUP BY item_no, exp_unit_cost ) AS TEMP
					--GROUP BY item_no
					--HAVING count(temp.item_no) > 1)