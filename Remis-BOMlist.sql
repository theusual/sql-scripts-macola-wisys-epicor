SELECT  BM.item_no, IMPAR.item_desc_1 AS par_item_desc_1, IMPAR.item_desc_2 AS par_item_desc_2, qty_per_par, comp_item_no, IM.item_desc_1 AS comp_item_desc_1, IM.item_desc_2 AS comp_item_desc_2
FROM    bmprdstr_sql BM 
		JOIN imitmidx_sql AS IM ON comp_item_no = IM.item_no 
		JOIN dbo.imitmidx_sql IMPAR ON IMPAR.item_no = IM.item_no
ORDER BY BM.item_no