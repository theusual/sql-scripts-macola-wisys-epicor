--Last month projection comparison to actual sales
SELECT     TOP (100) PERCENT OL.item_no ,
			 DATENAME(month, DATEADD(month, MONTH(OL.shipped_dt), 0) - 1) AS MONTH
			, SUM(OL.qty_ordered) AS [QtyOrd], Forecast.[Mar 2013] AS [Forecast], 
		    (Forecast.[Mar 2013] - SUM(OL.qty_ordered)) AS [DIFFERENCE], 
			MAX(OL.cus_item_no) AS SAP#
FROM         dbo.oehdrhst_sql AS OH INNER JOIN
             dbo.oelinhst_sql AS OL ON OH.ord_no = OL.ord_no
             JOIN dbo.WM_Forecast_2013_PreviousUpdate AS Forecast 
				ON Forecast.[Article Number] =  CAST(OL.cus_item_no AS VARCHAR)
WHERE     (MONTH(OL.shipped_dt) = (MONTH(GETDATE())-1) AND (YEAR(OH.inv_dt)) = (YEAR(GETDATE()))
			AND (LTRIM(OH.cus_no) IN ('20938', '1575')))
GROUP BY MONTH(OL.shipped_dt), OL.item_no, Forecast.[Mar 2013]
ORDER BY OL.item_no DESC, MONTH

SELECT * FROM dbo.WM_Forecast_2013_PreviousUpdate

SELECT cus_item_no 
FROM dbo.oelinhst_sql OL JOIN dbo.oeordhdr_sql OH ON OH.inv_no = OL.inv_no
WHERE --(MONTH(OL.shipped_dt) = (MONTH(GETDATE())-1) AND 
(LTRIM(OH.cus_no) IN ('20938', '1575'))



