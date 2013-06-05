USE [001]

SELECT     TOP (100) PERCENT OL.item_no, DATENAME(month, DATEADD(month, MONTH(OH.inv_dt), 0) - 1) AS Month, SUM(OL.qty_ordered) 
                      AS [Tot FR Qty Ordered]
FROM         dbo.oehdrhst_sql AS OH INNER JOIN
                      dbo.oelinhst_sql AS OL ON OH.ord_no = OL.ord_no
WHERE     (OH.inv_dt > '01/01/2010') AND (LTRIM(OH.cus_no) IN ('20938', '1575')) AND (OH.user_def_fld_4 LIKE 'ON' OR
                      OH.user_def_fld_4 LIKE '%FX%') AND (NOT (OH.user_def_fld_4 LIKE '%ADD%')) AND (OH.inv_dt < '01/01/2011')
GROUP BY MONTH(OH.inv_dt), OL.item_no
ORDER BY OL.item_no DESC, Month