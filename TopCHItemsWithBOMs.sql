--Version1
SELECT  distinct im.item_no AS [Item], SUM(qty_ordered) AS [TotalSold]
FROM    imitmidx_sql im join bmprdstr_sql bm ON bm.item_no = im.item_no join oelinhst_sql on oelinhst_sql.item_no = im.item_no JOIN oehdrhst_sql ON oehdrhst_sql.inv_no = oelinhst_sql.inv_no
where item_note_1 = 'CH' and inv_dt > '01/01/2010'
GROUP BY im.item_no 
ORDER BY SUM(qty_ordered) desc

--Version2 - Catch Open Line Items Also
SELECT  distinct  im.item_no AS [Item], comp_item_no
FROM    oelinhst_sql JOIN oehdrhst_sql ON oehdrhst_sql.inv_no = oelinhst_sql.inv_no join imitmidx_sql im on im.item_no = oelinhst_sql.item_no 
					 join bmprdstr_sql BM on BM.item_no = IM.item_no join imitmidx_sql AS im2 on im2.item_no = BM.comp_item_no
where im.item_note_1 = 'CH' AND inv_dt > '01/01/2009' and im.prod_cat not in ('336','036','037','111') and IM.item_no 
	IN 
		(SELECT  item_no
		 FROM   poordlin_sql PL
		 WHERE receipt_dt > '01/01/2010')
GROUP BY im.item_no, comp_item_no

SELECT * 
FROM imitmidx_sql 
WHERE item_no LIKE '%.'

--Catch ALL CH items both bomed and not bomed
SELECT  IM.item_no AS [Item], BM.comp_item_no, BM.qty_per_par
FROM    imitmidx_sql im left outer join bmprdstr_sql BM on BM.item_no = IM.item_no 
where im.item_note_1 = 'CH' and (im.item_no IN 
		(SELECT  item_no
		 FROM   poordlin_sql PL
		 where receipt_dt > '01/01/2010' AND (LTRIM(PL.vend_no) IN ('1613', '23877', '91202', '1620', '1697', '9516', '50', '1717', '9703', '216', '2999', '9441', '8859', '9523', 
               '9533')))) and im.prod_cat not in ('336','036','037','111', 'AP')  

ORDER BY IM.item_no


