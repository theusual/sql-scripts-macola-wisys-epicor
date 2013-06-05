SELECT     TOP (100) PERCENT IM.prod_cat, IM.item_no, IM.item_desc_1, IM.item_desc_2, IM.drawing_release_no, IM.drawing_revision_no, 
                      CASE WHEN ACC.Qty_Allocated > 0 THEN ACC.Qty_Allocated ELSE '0' END AS QALL, 
                      CASE WHEN IL.qty_on_ord > 0 THEN IL.qty_on_ord ELSE '0' END AS QOO, 
                      CASE WHEN IL.qty_on_hand > 0 THEN IL.qty_on_hand ELSE '0' END AS QOH, 
                      CASE WHEN IM.item_no IN (SELECT comp_item_no FROM bmprdstr_sql) THEN 'N' ELSE 'Y' END AS  [PARENT FLAG], BM.item_no AS [PARENT ITEM (IF COMP.)]
FROM         dbo.imitmidx_sql AS IM INNER JOIN
                      dbo.Z_IMINVLOC AS IL ON IL.item_no = IM.item_no LEFT OUTER JOIN
                      dbo.Z_IMINVLOC_ACCUMULATORS_AND_COSTS AS ACC ON ACC.item_no = IM.item_no LEFT OUTER JOIN
                      dbo.bmprdstr_sql AS BM ON BM.comp_item_no = IM.item_no 
WHERE     (IM.activity_cd = 'A')  AND NOT(IM.item_desc_1 like '%OBSOLETE%')
ORDER BY IM.item_no