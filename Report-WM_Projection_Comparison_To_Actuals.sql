--Last month forecast comparison to actual sales  
--Last Updated: 6/28/2013
DECLARE @MonthsBack AS INT
DECLARE @Month AS VARCHAR(20)

SET @MonthsBack = 0
SET @Month = DATENAME(month, GETDATE() - @MonthsBack)

SELECT     DISTINCT TOP (100) PERCENT OL.item_no , OL.cus_item_no AS SAP#, MAX(OL.item_desc_1), MAX(OL.item_desc_2), 
			INV.qty_on_hand, QtyOrd.QtyOrd AS [QtyOrd], 
			Forecast.[Jun 2013], MAX((Forecast.[Jun 2013] - QtyOrd.QtyOrd)) AS [DIFF], 
			CASE WHEN Forecast.[Sep 2013] IS NULL THEN 'N' ELSE 'Y' END AS [On Forecast?]
FROM         dbo.oehdrhst_sql AS OH INNER JOIN
             dbo.oelinhst_sql AS OL ON OH.ord_no = OL.ord_no
             LEFT OUTER JOIN (SELECT SUM([Apr 2013]) AS [Apr 2013], SUM([May 2013]) AS [May 2013], SUM([Jun 2013]) AS [Jun 2013], 
							  SUM([Jul 2013]) AS [Jul 2013], SUM([Aug 2013]) AS [Aug 2013], SUM([Sep 2013]) AS [Sep 2013], 
							  SUM([Oct 2013]) AS [Oct 2013],[Article Number]
                   FROM  dbo.WM_Forecast_2013_PreviousUpdate AS Forecast 
                   GROUP BY [Article Number]) AS Forecast
			    ON Forecast.[Article Number] =  CAST(OL.cus_item_no AS VARCHAR)
			 LEFT OUTER JOIN (SELECT item_no, SUM(qty_ordered) AS QtyOrd
						   FROM dbo.oehdrhst_sql OH JOIN oelinhst_Sql OL ON OL.inv_no = OH.inv_no 
						   WHERE     (MONTH(OH.entered_dt) = (MONTH(GETDATE())-@MonthsBack) AND (YEAR(OH.inv_dt)) = (YEAR(GETDATE()))
									AND (LTRIM(OH.cus_no) IN ('20938', '1575')))
								  AND OL.prod_cat NOT IN ('037', '2', '036', '102', '111', '336')
								  AND OL.item_no NOT LIKE 'Z%'
								  AND OH.user_def_fld_3 NOT LIKE ('%RP%') 
							GROUP BY item_no) AS QtyOrd ON QtyOrd.item_no = OL.item_no 
			 JOIN Z_IMINVLOC INV ON INV.item_no = OL.item_no
WHERE     OH.inv_dt > '01/01/2013'
		  AND (LTRIM(OH.cus_no) IN ('20938', '1575'))
		  AND OL.prod_cat NOT IN ('037', '2', '036', '102', '111', '336')
		  AND OL.item_no NOT LIKE 'Z%'
		  AND OL.item_no NOT LIKE 'PROTO%'
		  AND OH.user_def_fld_3 NOT LIKE ('%RP%')
		  AND cus_item_no IS NOT null
GROUP BY OL.item_no, OL.cus_item_no, INV.qty_on_hand, QtyOrd.QtyOrd, Forecast.[Jun 2013], [Sep 2013]
ORDER BY OL.item_no DESC

--SELECT * FROM dbo.WM_Forecast_2013_PreviousUpdate



