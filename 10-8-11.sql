
UPDATE dbo.iminvloc_sql
SET frz_qty = '149'
WHERE item_no = 'ZD157' AND loc = 'MDC'

SELECT * FROM iminvloc_sql WHERE item_no = 'RUBBERANCHOR-02' 

SELECT BM.comp_item_no, il.item_no, il2.qty_allocated --, ZIQ.qty_allocated
FROM iminvloc_sql il JOIN imitmidx_sql im ON im.item_no = il.item_no 
    JOIN dbo.bmprdstr_sql AS BM ON BM.item_no = IM.item_no
    JOIN iminvloc_sql il2 ON il2.item_no = BM.comp_item_no
    --JOIN dbo.Z_IMINVLOC_QALL AS ZIQ ON ZIQ.item_no = bm.comp_item_no
WHERE stocked_fg = 'N' AND (mat_cost_type = 'AP' OR il.prod_cat = 'AP') AND IL.loc = 'MDC'
ORDER BY comp_item_no

SELECT  *
FROM    dbo.iminvloc_sql AS [IS]
WHERE item_no = 'CUFF-02 GA'

SELECT * FROM dbo.Z_IMINVLOC_QALL AS ZIQ
WHERE item_no = 'CUFF-02 GA'

SELECT *
FROM dbo.oeordlin_sql AS OS
WHERE item_no = 'BOLLARD02KITGA'






