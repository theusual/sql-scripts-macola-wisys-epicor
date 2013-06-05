SELECT  iminvtrx_sql.item_no, iminvtrx_Sql.loc, SUM(quantity) AS [Kitted Total], qty_on_hand
FROM    iminvtrx_sql join z_iminvloc on z_iminvloc.item_no = iminvtrx_sql.item_no
where doc_type = 'R' and comment like '%KITTED%'  and trx_dt > '07/01/2011' 
	and iminvtrx_sql.item_no IN
	(SELECT  distinct  im.item_no AS [Item]
	 FROM    imitmidx_sql AS im 
	 where im.item_note_1 = 'CH' and im.prod_cat not in ('336','036','037','111') 
		and IM.item_no IN 
			(SELECT  item_no
			 FROM   poordlin_sql PL
			 where (LTRIM(PL.vend_no) IN ('1613', '23877', '91202', '1620', '1697', '9516', '50', '1717', '9703', '216', '2999', '9441', '8859', '9523', 
				   '9533'))) 
		and IM.item_no NOT IN
			(select item_no
			 from bmprdstr_sql))
GROUP BY iminvtrx_sql.item_no, iminvtrx_sql.loc, qty_on_hand
