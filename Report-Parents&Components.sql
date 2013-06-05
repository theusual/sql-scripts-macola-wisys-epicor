SELECT IMPAR.item_no, IMPAR.prod_cat, BM.comp_item_no, IMBOM.prod_cat
FROM imitmidx_Sql IMPAR JOIN dbo.bmprdstr_sql BM ON BM.item_no = IMPAR.item_no
		JOIN dbo.imitmidx_sql IMBOM ON IMBOM.item_no = BM.comp_item_no
WHERE IMPAR.prod_cat NOT IN (SELECT prod_cat FROM dbo.imitmidx_sql IM JOIN dbo.bmprdstr_sql BM ON BM.comp_item_no = IM.item_no WHERE BM.item_no = IMPAR.item_no) AND IMPAR.activity_cd = 'A'
	AND IMPAR.item_no IN (SELECT item_no FROM dbo.oelinhst_sql WHERE billed_dt > '01/01/2012')


SELECT IMPAR.item_no, IMPAR.prod_cat, BM.comp_item_no, IMBOM.prod_cat, * 
FROM imitmidx_Sql IMPAR JOIN dbo.bmprdstr_sql BM ON BM.item_no = IMPAR.item_no
		JOIN dbo.imitmidx_sql IMBOM ON IMBOM.item_no = BM.comp_item_no
WHERE IMPAR.item_no = 'BAK-697 L WMMBV'