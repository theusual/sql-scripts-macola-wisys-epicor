SELECT  bmprdstr_sql.item_no, qty_per_par, comp_item_no, item_desc_1, item_desc_2
FROM    bmprdstr_sql INNER JOIN imitmidx_sql AS IM ON comp_item_no = IM.item_no
WHERE im.prod_cat like '6%'
ORDER BY bmprdstr_sql.item_no


SELECT  *
FROM    iminvloc_sql INNER JOIN oelinhst_sql AS OL ON Ol.item_no = iminvloc_sql.item_no INNER JOIN bmprdstr_sql BM on BM.item_no = OL.item_no
WHERE ol.prod_cat = '336'
ORDER BY usage_ytd DESC