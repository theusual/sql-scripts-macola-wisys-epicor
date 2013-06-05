--By Line Total
SELECT OH.inv_no, CONVERT(varchar, CAST(rtrim(inv_dt) AS datetime), 101) AS [Inv Dt.], OH.bill_to_name AS [Customer], item_no AS [Item], item_desc_1, item_desc_2, qty_ordered AS [Lbs], unit_price AS [Cost Per LB], (unit_price * qty_ordered) AS [Line Total]
FROM OEHDRHST_SQL OH INNER JOIN OELINHST_SQL OL ON OH.ord_no = OL.ord_no
WHERE OH.inv_dt > '20070101'
ORDER BY inv_dt DESC

--By Order Total
SELECT OH.inv_no, CONVERT(varchar, CAST(rtrim(inv_dt) AS datetime), 101) AS [Inv Dt.], max(OH.bill_to_name) AS [Customer], max(item_no) AS [Item], max(item_desc_1) AS [Desc 1], max(item_desc_2) AS [Desc 2], SUM(qty_ordered) AS [Lbs], (OH.tot_sls_amt / SUM(qty_ordered)) AS [Cost Per LB], avg(OH.tot_sls_amt) AS [Total]
FROM OEHDRHST_SQL OH INNER JOIN OELINHST_SQL OL ON OH.ord_no = OL.ord_no
WHERE OH.inv_dt > '20070101'
GROUP BY OH.inv_no, inv_dt, tot_sls_amt
ORDER BY inv_dt DESC