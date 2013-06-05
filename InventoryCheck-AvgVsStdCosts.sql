SELECT  SUM(last_cost - avg_cost) * SUM(qty_on_hand), item_no
FROM    z_iminvloc
where last_cost > std_cost and last_cost > avg_cost and item_no
	in (select item_no 
	    from imitmidx_sql
	    where pur_or_mfg = 'P')
GROUP BY item_no
	
SELECT  ((std_cost - avg_cost) * qty_on_hand) AS diff, std_cost, avg_cost, item_no
FROM    z_iminvloc
where avg_cost < std_cost and item_no
	in (select item_no 
	    from imitmidx_sql
	    where pur_or_mfg = 'P') and qty_on_hand > 0
order by diff desc
	    
