--Last month forecast comparison to actual sales  
--Last Updated: 7/30/2013
DECLARE @MonthsBack AS INT
DECLARE @Month AS VARCHAR(20)

SET @MonthsBack = -1
SET @Month = DATENAME(MONTH,DATEADD(MONTH,@MonthsBack,GETDATE()))
SELECT @Month

SELECT     DISTINCT TOP (100) PERCENT QtyOrd.item_no , EDI.edi_item_num AS SAP#, IM.item_desc_1, IM.item_desc_2, INV.qty_on_hand AS QOH, 
			QtyOrd.QtyOrd AS [FR-CAPEX QtyOrd]
FROM         (
				SELECT SUM(QtyOrd) AS QtyOrd, item_no
				FROM (
					SELECT item_no, SUM(qty_ordered) AS QtyOrd
					FROM dbo.oehdrhst_sql OH JOIN oelinhst_Sql OL ON OL.inv_no = OH.inv_no 
					WHERE   (MONTH(OH.entered_dt) = (MONTH(GETDATE())+@MonthsBack) AND (YEAR(OH.entered_dt)) = (YEAR(GETDATE())) AND
							(LTRIM(OH.cus_no) IN ('20938', '1575'))) AND
						  --Exclude Case Fronts and AP
						    OL.prod_cat NOT IN ('037', '2', '036', '102', '111', '336','AP','7')
						  --Exclude Z parts 
						    AND OL.item_no NOT LIKE 'Z%'
						  --Exclude Replacements
						    AND OH.user_def_fld_3 NOT LIKE ('%RP%') 
						    AND cus_item_no IS NOT NULL
						  --Exclude prototypes
						    AND OL.item_no NOT LIKE 'PROTO%'
						  --Exclude BAK619 door pieces
						    AND OL.item_no NOT LIKE 'B619%'
						    AND OL.item_no NOT IN ('BAK-619 DOORSBL','BAK-619 DOORSBR') AND 
						  --FR (Cororate Orders) and CapEx
						  (OH.user_def_fld_3 LIKE '%FR%' OR OH.user_def_fld_3 LIKE '%ON%' OR OH.user_def_fld_3 LIKE '%CAPEX%')
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
						  --FR (Cororate Orders) and CapEx
						  AND (OH.user_def_fld_3 LIKE '%FR%' OR OH.user_def_fld_3 LIKE '%ON%' OR OH.user_def_fld_3 LIKE '%CAPEX%')
					GROUP BY item_no
					) AS Tot
				GROUP BY item_no
				) AS QtyOrd
			 JOIN edcitmfl_sql EDI ON EDI.mac_item_num = QtyOrd.item_no
			 JOIN Z_IMINVLOC INV ON INV.item_no = QtyOrd.item_no
			 JOIN imitmidx_sql AS IM ON IM.item_no = QtyOrd.item_no
--WHERE QtyOrd.item_no = 'SW00026'
--GROUP BY Tot.item_no, Tot.cus_item_no, INV.qty_on_hand, QtyOrd.QtyOrd, Forecast.[Jun 2013], [Sep 2013]
ORDER BY QtyOrd.item_no DESC

--To check numbers:
SELECT * FROM dbo.WM_Forecast_2013_May WHERE [Article Number] = '100059937'

SELECT OH.user_def_fld_3, * 
FROM oehdrhst_sql OH JOIN oelinhst_sql OL ON OH.inv_no = OL.inv_no 
WHERE [item_no] = 'VEG-39 B-BK'  AND MONTH(entered_dt) = 2        




