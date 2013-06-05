BEGIN TRAN

SELECT  pl.item_no, case when act_unit_cost = 0 THEN pl.exp_unit_cost
             else act_unit_cost
        END AS UnitCost, ph.ord_dt, YEAR(ord_dt) AS [OrdDtYr], 
        ap.vend_no, ap.vend_name, IM.prod_cat, PH.ord_no
FROM    poordlin_sql pl join apvenfil_sql ap on ap.vend_no = pl.vend_no 
		JOIN dbo.imitmidx_sql IM ON IM.item_no = PL.item_no
		join poordhdr_sql ph on ph.ord_no = pl.ord_no 
		--Pull in the lowest cost found in the previous 12-30 months of purchases 
		join  (select item_no, min(exp_unit_cost) AS [exp_unit_cost] 
				 from poordlin_sql PL join poordhdr_sql PH on PH.ord_no = pl.ord_no 
				 WHERE ord_dt > '01/01/2011' AND ord_dt < '08/01/2012'
				 group by item_no) AS PL2012 ON PL2012.item_no = PL.item_no 
		--Pull in the highest cost found in the previous 12 months of purchases 
		join  (select item_no, max(exp_unit_cost) AS [exp_unit_cost] 
				 from poordlin_sql PL join poordhdr_sql PH on PH.ord_no = pl.ord_no 
				 WHERE ord_dt > '08/02/2012'
				 group by item_no) AS PL2013 ON PL2013.item_no = PL.item_no 
WHERE 
		--Pull all PO records after 1/1/2008
		ph.ord_dt > '01/01/2008'  
		--Only pull PO records for items which have a higher previous 12 month cost than the previous 18 month period before that
	    AND PL2013.exp_unit_cost > PL2012.exp_unit_cost 
	    --Account for $0 POs
		AND pl2012.exp_unit_cost > 0
		AND (act_unit_cost > 0 or pl.exp_unit_cost > 0) 
ORDER BY item_no, ord_dt, vend_no


ROLLBACK


SELECT * FROM dbo.poordlin_sql WHERE item_no = 'ZL015'