 SELECT IL."item_no", IL."sls_ytd", IL."cost_ytd", IL."qty_sold_ytd", IL."last_cost", IL."last_sold_dt", IM."prod_cat", IM."item_desc_1", IL."frz_qty", IL."prior_year_usage", IL."usage_ytd", frz_qty, qty_on_hand
 FROM   z_iminvloc IL INNER JOIN 
		IMITMIDX_SQL IM ON IL.item_no = IM.item_no 
 WHERE  IL.qty_on_hand > 0 
	    AND NOT (IL.item_no LIKE 'PC-%' OR IL.item_no LIKE 'POB-%' OR IL.item_no LIKE 'X-%' OR IL.item_no LIKE 'ZX%') 
	    AND IL.item_no  NOT IN (SELECT item_no FROM dbo.Z_IMINVLOC_USAGE)
	    AND IL.prior_year_usage=0 
	    AND NOT (IM.prod_cat IN ('010','036','037', '053','054','057', '111','336','7','9','ST','S', 'X', 'OFC', 'EMP'))
 ORDER BY IL.item_no



