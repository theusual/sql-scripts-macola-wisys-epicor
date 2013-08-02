--Components:  025,026,028,051,052,053,054,057,1,326,331,351,625,7,N,OE,W51,551
--Parents: 026,051,052,053,054,1,326,351,551,625,7,W51

SELECT IM.item_no AS Parent, IM.drawing_release_no+IM.drawing_revision_no AS Drawing, IM.prod_cat AS ProdCat, IM.item_desc_1, IM.item_desc_2, IMCOMP.item_no AS Component, IMCOMP.drawing_release_no+IMCOMP.drawing_revision_no AS CompDrawing, IMCOMP.prod_cat AS CompProdCat, IMCOMP.item_desc_1 AS CompDescr1, IMCOMP.item_desc_2 AS CompDescr2, BM.qty_per_par
FROM dbo.imitmidx_sql IM LEFT OUTER JOIN dbo.bmprdstr_sql BM ON BM.item_no = IM.item_no 
								LEFT OUTER JOIN dbo.imitmidx_sql IMCOMP ON IMCOMP.item_no = BM.comp_item_no
WHERE --IM.prod_cat IN ('026','051','052','053','054','1','326','351','551','625','7','W51') 
	  IM.activity_cd = 'A'
ORDER BY Parent