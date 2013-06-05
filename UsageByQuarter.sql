SELECT ol.item_no AS [Parent Item], (OL.qty_to_ship - OL.qty_return_to_stk) AS qty_to_ship, YEAR(OH.inv_dt) AS [Year], 
			  CASE WHEN MONTH(inv_dt) > 0 AND MONTH(inv_dt) < 4 THEN 'Q1'
			       WHEN MONTH(inv_dt) > 3 AND MONTH(inv_dt) < 7 THEN 'Q2'
			       WHEN MONTH(inv_dt) > 6 AND MONTH(inv_dt) < 11 THEN 'Q3'
			       WHEN MONTH(inv_dt) > 9 AND MONTH(inv_dt) < 13 THEN 'Q4'
			   END AS [Quarter]
               FROM   oelinhst_sql ol JOIN
                              oehdrhst_sql oh ON oh.inv_no = ol.inv_no
               WHERE OH.inv_dt > '01/01/2010' AND ol.loc != 'CAN' AND orig_ord_type IN ('O', 'I', 'C')
               UNION ALL
               SELECT ol.item_no AS [Parent Item], (pp.qty), YEAR(ship_dt) AS [Year], 
			  CASE WHEN MONTH(ship_dt) > 0 AND MONTH(ship_dt) < 4 THEN 'Q1'
			       WHEN MONTH(ship_dt) > 3 AND MONTH(ship_dt) < 7 THEN 'Q2'
			       WHEN MONTH(ship_dt) > 6 AND MONTH(ship_dt) < 11 THEN 'Q3'
			       WHEN MONTH(ship_dt) > 9 AND MONTH(ship_dt) < 13 THEN 'Q4'
			   END AS [Quarter]
               FROM  oeordlin_sql ol JOIN
                              wspikpak pp ON pp.ord_no = ol.ord_no AND pp.line_no = ol.line_no
               WHERE shipped = 'Y' AND ol.loc != 'CAN' AND ship_dt > '01/01/2010'
UNION ALL
SELECT BM.comp_item_no[Comp Lvl 1], (BM.qty_per_par * (ol.qty_to_ship - qty_return_to_stk)) 
                              AS [Comp Lvl 1 Qty To Ship], YEAR(OH.inv_dt) AS [Year], 
			  CASE WHEN MONTH(inv_dt) > 0 AND MONTH(inv_dt) < 4 THEN 'Q1'
			       WHEN MONTH(inv_dt) > 3 AND MONTH(inv_dt) < 7 THEN 'Q2'
			       WHEN MONTH(inv_dt) > 6 AND MONTH(inv_dt) < 11 THEN 'Q3'
			       WHEN MONTH(inv_dt) > 9 AND MONTH(inv_dt) < 13 THEN 'Q4'
			   END AS [Quarter]
               FROM   oelinhst_sql ol JOIN
                              bmprdstr_sql BM ON BM.item_no = ol.item_no JOIN
                              oehdrhst_sql oh ON oh.inv_no = ol.inv_no
               WHERE OH.inv_dt > '01/01/2010' AND ol.loc != 'CAN' AND orig_ord_type IN ('O', 'I', 'C')
               UNION ALL
               SELECT BM.comp_item_no[Comp Lvl 1], (BM.qty_per_par * (ol.qty_to_ship - qty_return_to_stk)) 
                              AS [Comp Lvl 1 Qty To Ship] , YEAR(ship_dt) AS [Year], 
			  CASE WHEN MONTH(ship_dt) > 0 AND MONTH(ship_dt) < 4 THEN 'Q1'
			       WHEN MONTH(ship_dt) > 3 AND MONTH(ship_dt) < 7 THEN 'Q2'
			       WHEN MONTH(ship_dt) > 6 AND MONTH(ship_dt) < 11 THEN 'Q3'
			       WHEN MONTH(ship_dt) > 9 AND MONTH(ship_dt) < 13 THEN 'Q4'
			   END AS [Quarter]
               FROM  oeordlin_sql ol JOIN
                              wspikpak pp ON pp.ord_no = ol.ord_no AND pp.line_no = ol.line_no JOIN
                              bmprdstr_sql BM ON BM.item_no = ol.item_no
               WHERE shipped = 'Y' AND ol.loc != 'CAN' AND ship_dt > '01/01/2010'
UNION ALL
SELECT BM.comp_item_no[Comp Lvl 2], 
         (BM2.qty_per_par * BM.qty_per_par * (ol.qty_to_ship - qty_return_to_stk)) AS [Comp Lvl 2 Qty To Ship], YEAR(OH.inv_dt) AS [Year], 
			  CASE WHEN MONTH(inv_dt) > 0 AND MONTH(inv_dt) < 4 THEN 'Q1'
			       WHEN MONTH(inv_dt) > 3 AND MONTH(inv_dt) < 7 THEN 'Q2'
			       WHEN MONTH(inv_dt) > 6 AND MONTH(inv_dt) < 11 THEN 'Q3'
			       WHEN MONTH(inv_dt) > 9 AND MONTH(inv_dt) < 13 THEN 'Q4'
			   END AS [Quarter]
               FROM   oelinhst_sql ol JOIN
                              bmprdstr_sql BM ON BM.item_no = ol.item_no JOIN
                              bmprdstr_sql BM2 ON BM2.item_no = BM.comp_item_no JOIN
                              oehdrhst_sql oh ON oh.inv_no = ol.inv_no
               WHERE OH.inv_dt > '01/01/2010' AND ol.loc != 'CAN' AND orig_ord_type IN ('O', 'I', 'C')
               UNION ALL
               SELECT BM2.comp_item_no[Comp Lvl 2], (BM2.qty_per_par * (ol.qty_to_ship - qty_return_to_stk)) 
                              AS [Comp Lvl 2 Qty To Ship] , YEAR(ship_dt) AS [Year], 
			  CASE WHEN MONTH(ship_dt) > 0 AND MONTH(ship_dt) < 4 THEN 'Q1'
			       WHEN MONTH(ship_dt) > 3 AND MONTH(ship_dt) < 7 THEN 'Q2'
			       WHEN MONTH(ship_dt) > 6 AND MONTH(ship_dt) < 11 THEN 'Q3'
			       WHEN MONTH(ship_dt) > 9 AND MONTH(ship_dt) < 13 THEN 'Q4'
			   END AS [Quarter]
               FROM  oeordlin_sql ol JOIN
                              wspikpak pp ON pp.ord_no = ol.ord_no AND pp.line_no = ol.line_no JOIN
                              bmprdstr_sql BM ON BM.item_no = ol.item_no JOIN
                              bmprdstr_sql BM2 ON BM2.item_no = BM.comp_item_no
               WHERE shipped = 'Y' AND ol.loc != 'CAN' AND ship_dt > '01/01/2010'
UNION ALL
SELECT BM.comp_item_no[Comp Lvl 3],  
                              (BM3.qty_per_par * BM2.qty_per_par * BM.qty_per_par * (ol.qty_to_ship - qty_return_to_stk)) AS [Comp Lvl 3 Qty To Ship],
                              YEAR(OH.inv_dt) AS [Year], 
			  CASE WHEN MONTH(inv_dt) > 0 AND MONTH(inv_dt) < 4 THEN 'Q1'
			       WHEN MONTH(inv_dt) > 3 AND MONTH(inv_dt) < 7 THEN 'Q2'
			       WHEN MONTH(inv_dt) > 6 AND MONTH(inv_dt) < 11 THEN 'Q3'
			       WHEN MONTH(inv_dt) > 9 AND MONTH(inv_dt) < 13 THEN 'Q4'
			   END AS [Quarter]
               FROM   oelinhst_sql ol JOIN
                              bmprdstr_sql BM ON BM.item_no = ol.item_no JOIN
                              bmprdstr_sql BM2 ON BM2.item_no = BM.comp_item_no JOIN
                              bmprdstr_sql BM3 ON BM3.item_no = BM2.comp_item_no JOIN
                              oehdrhst_sql oh ON oh.inv_no = ol.inv_no
               WHERE OH.inv_dt > '01/01/2010' AND ol.loc != 'CAN' AND orig_ord_type IN ('O', 'I', 'C')
               UNION ALL
               SELECT BM3.comp_item_no[Comp Lvl 3],  (BM3.qty_per_par * (ol.qty_to_ship - qty_return_to_stk)) 
                              AS [Comp Lvl 3 Qty To Ship] , YEAR(ship_dt) AS [Year], 
			  CASE WHEN MONTH(ship_dt) > 0 AND MONTH(ship_dt) < 4 THEN 'Q1'
			       WHEN MONTH(ship_dt) > 3 AND MONTH(ship_dt) < 7 THEN 'Q2'
			       WHEN MONTH(ship_dt) > 6 AND MONTH(ship_dt) < 11 THEN 'Q3'
			       WHEN MONTH(ship_dt) > 9 AND MONTH(ship_dt) < 13 THEN 'Q4'
			   END AS [Quarter]
               FROM  oeordlin_sql ol JOIN
                              wspikpak pp ON pp.ord_no = ol.ord_no AND pp.line_no = ol.line_no JOIN
                              bmprdstr_sql BM ON BM.item_no = ol.item_no JOIN
                              bmprdstr_sql BM2 ON BM2.item_no = BM.comp_item_no JOIN
                              bmprdstr_sql BM3 ON BM3.item_no = BM2.comp_item_no
               WHERE shipped = 'Y' AND ol.loc != 'CAN' AND ship_dt > '01/01/2010'