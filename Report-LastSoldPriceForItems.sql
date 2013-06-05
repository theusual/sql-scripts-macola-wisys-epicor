SELECT DISTINCT OL.item_no, IM.item_desc_1, IM.item_desc_2, (LTRIM(IM.drawing_release_no) + LTRIM(IM.drawing_revision_no)) AS DWG, IM.prod_cat, IM.pur_or_mfg, S2010.QTY_2010, S2011.QTY_2011, 
S2012.QTY_2012,
LASTSLS.unit_price AS [LastSoldPrice]
FROM oehdrhst_sql OH 
JOIN oelinhst_sql OL ON OH.inv_no = OL.inv_no 
JOIN imitmidx_sql IM ON IM.item_no = OL.item_no 
LEFT OUTER JOIN (
                        SELECT item_no, SUM(OL.qty_to_ship - OL.qty_return_to_stk) AS QTY_2010
                        FROM oehdrhst_sql OH JOIN oelinhst_sql OL ON OH.inv_no = OL.inv_no 
                        WHERE YEAR(inv_dt) = '2010'
                        GROUP BY item_no
                        ) AS S2010 ON S2010.item_no = OL.item_no
LEFT OUTER JOIN (
                        SELECT item_no, SUM(OL.qty_to_ship - OL.qty_return_to_stk) AS QTY_2011
                        FROM oehdrhst_sql OH JOIN oelinhst_sql OL ON OH.inv_no = OL.inv_no 
                        WHERE YEAR(inv_dt) = '2011'
                        GROUP BY item_no
                        ) AS S2011 ON S2011.item_no = OL.item_no
LEFT OUTER JOIN (
                        SELECT item_no, SUM(OL.qty_to_ship - OL.qty_return_to_stk) AS QTY_2012
                        FROM oehdrhst_sql OH JOIN oelinhst_sql OL ON OH.inv_no = OL.inv_no 
                        WHERE YEAR(inv_dt) = '2012'
                        GROUP BY item_no
                        ) AS S2012 ON S2012.item_no = OL.item_no
LEFT OUTER JOIN (
                        SELECT DISTINCT unit_price, OL.item_no
						FROM OEHDRHST_SQL OH JOIN OELINHST_SQL OL  ON OL.inv_no = OH.inv_no
								JOIN (SELECT item_no, MAX(OH.inv_dt) AS [LastDate]
									  FROM OEHDRHST_SQL OH JOIN dbo.oelinhst_sql OL ON OL.inv_no = OH.inv_no 
									  WHERE LTRIM(OH.cus_no) = '1575'
									  GROUP BY item_no) AS LASTDT ON LASTDT.item_no = OL.item_no AND OH.inv_dt = LASTDT.LastDate
						WHERE OL.item_no IN ('GRO-010 WM GB', 'GRO-012 WM GB', 'GRO-014 WM GB') AND OL.unit_price > 0
                        ) AS  LASTSLS ON LASTSLS.item_no = OL.item_no
WHERE OL.item_no IN ('GRO-010 WM GB', 'GRO-012 WM GB', 'GRO-014 WM GB') AND OL.unit_price > 0



/*
SELECT DISTINCT unit_price, OL.item_no
FROM OEHDRHST_SQL OH JOIN OELINHST_SQL OL  ON OL.inv_no = OH.inv_no JOIN (SELECT item_no, MAX(OH.inv_dt) AS [LastDate]
                        FROM OEHDRHST_SQL OH JOIN dbo.oelinhst_sql OL ON OL.inv_no = OH.inv_no 
                        WHERE LTRIM(OH.cus_no) = '1575'
                        GROUP BY item_no) AS LASTDT ON LASTDT.item_no = OL.item_no AND OH.inv_dt = LASTDT.LastDate
WHERE OL.item_no IN ('GRO-010 WM GB', 'GRO-012 WM GB', 'GRO-014 WM GB') AND OL.unit_price > 0


SELECT * FROM oelinhst_sql WHERE item_no = 'GRO-010 WM GB' ORDER BY lasT_post_dt DESC
*/