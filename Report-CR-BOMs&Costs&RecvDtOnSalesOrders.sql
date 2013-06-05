
SELECT IM.avg_Cost AS CompAvgCost, IM.price AS CompPrice, IM.item_no AS CompItem, OL.item_no AS ParentItem, IM2.price AS ParentPrice, BM.qty_per_par, IM.item_desc_1, IM.item_desc_2,  IMM.drawing_release_no + IMM.drawing_revision_no, Recv.RecvDt, OL.ord_no  
FROM dbo.oeordlin_sql OL LEFT OUTER JOIN dbo.bmprdstr_sql BM ON BM.item_no = OL.item_no 
	LEFT OUTER JOIN Z_IMINVLOC IM ON IM.item_no = BM.comp_item_no 
	LEFT OUTER JOIN Z_IMINVLOC IM2 ON IM2.item_no = OL.item_no  
	LEFT OUTER JOIN dbo.imitmidx_sql IMM ON IMM.item_no = BM.comp_item_no
	LEFT OUTER JOIN (SELECT item_no, MAX(receipt_dt) AS RecvDt FROM dbo.poordlin_sql GROUP BY item_no) AS Recv ON Recv.item_no = BM.comp_item_no
WHERE OL.ord_no IN (' 1006768',' 1006762', ' 1006761', ' 1006767')


