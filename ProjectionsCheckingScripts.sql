SELECT qtyproj.item_no, qty_proj, qty_allocated, qty_allocated - qty_proj AS [Diff]
FROM 
		(SELECT OL.item_no, SUM(OL.qty_ordered) AS qty_proj
		FROM  dbo.oeordhdr_sql AS OH INNER JOIN
					   dbo.oeordlin_sql AS OL ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                              wspikpak pp ON pp.ord_no = ol.ord_no AND pp.line_no = ol.line_no          
WHERE (LTRIM(OH.cus_no) IN ('23033', '24033')) AND (shipped = 'N' OR
                              shipped IS NULL) AND ol.loc != 'CAN' AND OH.ord_type IN ('O')
		GROUP BY OL.item_no

		UNION ALL

		SELECT BM.comp_item_no, SUM((BM.qty_per_par * (ol.qty_to_ship - qty_return_to_stk))) AS qty_proj
		FROM  dbo.oeordhdr_sql AS OH INNER JOIN
					   dbo.oeordlin_sql AS OL ON OL.ord_no = OH.ord_no   JOIN
									  bmprdstr_sql BM ON BM.item_no = ol.item_no  LEFT OUTER JOIN
                              wspikpak pp ON pp.ord_no = ol.ord_no AND pp.line_no = ol.line_no          
WHERE (LTRIM(OH.cus_no) IN ('23033', '24033')) AND (shipped = 'N' OR
                              shipped IS NULL) AND ol.loc != 'CAN' AND OH.ord_type IN ('O')
		GROUP BY BM.comp_item_no
		
		UNION ALL

		SELECT BM2.comp_item_no, SUM((BM2.qty_per_par * (ol.qty_to_ship - qty_return_to_stk))) AS qty_proj
		FROM  dbo.oeordhdr_sql AS OH INNER JOIN
					   dbo.oeordlin_sql AS OL ON OL.ord_no = OH.ord_no    JOIN
									  bmprdstr_sql BM ON BM.item_no = ol.item_no JOIN
									  bmprdstr_sql BM2 ON BM2.item_no = BM.comp_item_no LEFT OUTER JOIN
                              wspikpak pp ON pp.ord_no = ol.ord_no AND pp.line_no = ol.line_no          
WHERE (LTRIM(OH.cus_no) IN ('23033', '24033')) AND (shipped = 'N' OR
                              shipped IS NULL) AND ol.loc != 'CAN' AND OH.ord_type IN ('O')
		GROUP BY BM2.comp_item_no

		) AS qtyproj LEFT OUTER JOIN dbo.Z_IMINVLOC_QALL AS QALL ON QALL.item_no = qtyproj.item_no
		ORDER BY diff asc
