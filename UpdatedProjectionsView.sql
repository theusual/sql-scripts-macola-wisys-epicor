SELECT item_no, SUM(qty_proj) AS qty_proj
FROM (SELECT OL.item_no, SUM(OL.qty_ordered) AS qty_proj
FROM  dbo.oeordhdr_sql AS OH INNER JOIN
               dbo.oeordlin_sql AS OL ON OL.ord_no = OH.ord_no    LEFT OUTER JOIN
                              wspikpak pp ON pp.ord_no = ol.ord_no AND pp.line_no = ol.line_no          
WHERE (LTRIM(OH.cus_no) IN ('23033', '24033')) AND (shipped = 'N' OR
                              shipped IS NULL) AND ol.loc != 'CAN' AND OH.ord_type IN ('O')
GROUP BY OL.item_no

UNION ALL

SELECT BM.comp_item_no, SUM((BM.qty_per_par * (ol.qty_to_ship - qty_return_to_stk))) AS qty_proj
FROM  dbo.oeordhdr_sql AS OH INNER JOIN
               dbo.oeordlin_sql AS OL ON OL.ord_no = OH.ord_no   JOIN
                              bmprdstr_sql BM ON BM.item_no = ol.item_no          
WHERE (LTRIM(OH.cus_no) IN ('23033', '24033')) 
GROUP BY BM.comp_item_no
--ORDER BY BM.comp_item_no

UNION ALL

SELECT BM2.comp_item_no, SUM((BM2.qty_per_par * (ol.qty_to_ship - qty_return_to_stk))) AS qty_proj
FROM  dbo.oeordhdr_sql AS OH INNER JOIN
               dbo.oeordlin_sql AS OL ON OL.ord_no = OH.ord_no    JOIN
                              bmprdstr_sql BM ON BM.item_no = ol.item_no JOIN
                              bmprdstr_sql BM2 ON BM2.item_no = BM.comp_item_no         
WHERE (LTRIM(OH.cus_no) IN ('23033', '24033')) 
GROUP BY BM2.comp_item_no
--ORDER BY BM2.comp_item_no
/*
UNION ALL

SELECT OL.item_no, SUM((BM3.qty_per_par * (ol.qty_to_ship - qty_return_to_stk))) AS qty_proj
FROM  dbo.oeordhdr_sql AS OH INNER JOIN
               dbo.oeordlin_sql AS OL ON OL.ord_no = OH.ord_no    JOIN
                              bmprdstr_sql BM ON BM.item_no = ol.item_no JOIN
                              bmprdstr_sql BM2 ON BM.item_no = ol.item_no JOIN
                              bmprdstr_sql BM3 ON BM.item_no = ol.item_no          
WHERE (LTRIM(OH.cus_no) IN ('23033', '24033'))
GROUP BY OL.item_no
*/
) AS PROJLEVELS

GROUP BY item_no
ORDER BY item_no

