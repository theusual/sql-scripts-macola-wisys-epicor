--Last month forecast comparison to actual sales  
--Last Updated: 10/1/2014
DECLARE @MonthsBack AS INT
DECLARE @Month AS VARCHAR(20)

SET @MonthsBack = -1
SET @Month = DATENAME(MONTH,DATEADD(MONTH,@MonthsBack,GETDATE()))
SELECT @Month

SELECT     DISTINCT TOP (100) PERCENT QtyOrd.item_no , EDI.edi_item_num AS SAP#, IM.item_desc_1, IM.item_desc_2, INV.qty_on_hand AS QOH, 
			QtyOrd.QtyOrd AS [QtyOrd], Forecast.[Jan 2014] AS [Forecast], (Forecast.[Jan 2014] - QtyOrd.QtyOrd) AS [DIFF], 
			CASE WHEN Forecast.[Jan 2014] IS NULL THEN 'N' ELSE 'Y' END AS [On Forecast?]
FROM         (
				SELECT SUM(QtyOrd) AS QtyOrd, item_no
				FROM (
					SELECT item_no, SUM(qty_ordered) AS QtyOrd
					FROM dbo.oehdrhst_sql OH JOIN oelinhst_Sql OL ON OL.inv_no = OH.inv_no 
					WHERE     (MONTH(OH.entered_dt) = (MONTH(GETDATE())+@MonthsBack) AND (YEAR(OH.entered_dt)) = (YEAR(GETDATE()))
							AND (LTRIM(OH.cus_no) IN ('20938', '1575')))
						  --Exclude Case Fronts and AP
						  AND OL.prod_cat NOT IN ('037', '2', '036', '102', '111', '336','AP','7')
						  --Exclude Z parts 
						  AND OL.item_no NOT LIKE 'Z%'
						  --Exclude Replacements
						  AND OH.user_def_fld_3 NOT LIKE ('%RP%') 
						  AND cus_item_no IS NOT NULL
						  --Exclude prototypes
						  AND OL.item_no NOT LIKE 'PROTO%'
						  --Exclude BAK619 door pieces
						  AND OL.item_no NOT LIKE 'B619%'
						  AND OL.item_no NOT IN ('BAK-619 DOORSBL','BAK-619 DOORSBR')
						  --Exclude FR (Cororate Orders)
						  AND OH.user_def_fld_3 NOT LIKE '%FR%'
						  --Exclude CapEx
						  AND OH.user_def_fld_3 NOT LIKE '%CAPEX%'
					GROUP BY item_no
					UNION ALL
					SELECT item_no, SUM(qty_ordered) AS QtyOrd 
					FROM dbo.oeordhdr_sql OH JOIN oeordlin_Sql OL ON OL.ord_no = OH.ord_no 
					WHERE     (MONTH(OH.entered_dt) = (MONTH(GETDATE())+@MonthsBack) AND (YEAR(OH.entered_dt)) = (YEAR(GETDATE()))
							AND (LTRIM(OH.cus_no) IN ('20938', '1575')))
						  --Exclude Case Fronts and AP
						  AND OL.prod_cat NOT IN ('037', '2', '036', '102', '111', '336','AP','7')
						  --Exclude Z parts 
						  AND OL.item_no NOT LIKE 'Z%'
						  --Exclude Replacements
						  AND OH.user_def_fld_3 NOT LIKE ('%RP%') 
						  AND cus_item_no IS NOT NULL
						  --Exclude prototypes
						  AND OL.item_no NOT LIKE 'PROTO%'
						  --Exclude BAK619 door pieces
						  AND OL.item_no NOT LIKE 'B619%'
						  AND OL.item_no NOT IN ('BAK-619 DOORSBL','BAK-619 DOORSBR')
						  --Exclude FR (Cororate Orders)
						  AND OH.user_def_fld_3 NOT LIKE '%FR%'
						  --Exclude CapEx
						  AND OH.user_def_fld_3 NOT LIKE '%CAPEX%'
						  --Exclude Projections

					GROUP BY item_no
					) AS Tot
				GROUP BY item_no
				) AS QtyOrd
			 JOIN edcitmfl_sql EDI ON EDI.mac_item_num = QtyOrd.item_no
             LEFT OUTER JOIN (
							  SELECT   SUM([Jan 2014]) AS [Jan 2014],
									   --SUM([Feb 2014]) AS [Feb 2014],
									  -- SUM([Mar 2014]) AS [Mar 2014],
									   --SUM([Apr 2014]) AS [Apr 2014], 
									   --SUM([May 2014]) AS [May 2014], 
									   --SUM([Jun 2014]) AS [Jun 2014], 
									   --SUM([Jul 2014]) AS [Jul 2014], 
									   --SUM([Aug 2014]) AS [Aug 2014], 
									   --SUM([Sep 2014]) AS [Sep 2014], 
									   --SUM([Oct 2014]) AS [Oct 2014],
									   --SUM([Nov 2014]) AS [Nov 2014],
									   [Article]
							   FROM  dbo.WM_Forecast_2014_January AS Forecast 
							   GROUP BY [Article]
							   ) AS Forecast ON Forecast.[Article] =  CAST(EDI.edi_item_num AS VARCHAR)
			 JOIN Z_IMINVLOC INV ON INV.item_no = QtyOrd.item_no
			 JOIN imitmidx_sql AS IM ON IM.item_no = QtyOrd.item_no
--WHERE QtyOrd.item_no = 'SW00026'
--GROUP BY Tot.item_no, Tot.cus_item_no, INV.qty_on_hand, QtyOrd.QtyOrd, Forecast.[Jun 2014], [Sep 2014]
ORDER BY QtyOrd.item_no DESC

--To check numbers:
SELECT * FROM dbo.WM_Forecast_2014_January WHERE [Article] = '100034476'

SELECT * 
FROM oehdrhst_sql OH JOIN oelinhst_sql OL ON OH.inv_no = OL.inv_no 
WHERE [item_no] = '58685-2 BK'  AND entered_dt > '09/01/2014'              




