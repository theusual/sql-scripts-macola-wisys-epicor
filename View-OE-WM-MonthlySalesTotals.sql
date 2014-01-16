--Monthly sales

SELECT     DISTINCT TOP (100) PERCENT QtyOrd.item_no , EDI.edi_item_num AS SAP#, IM.item_desc_1, IM.item_desc_2, INV.qty_on_hand AS QOH, 
			QtyOrd.QtyOrd AS [QtyOrd]
FROM         (
				SELECT SUM(QtyOrd) AS QtyOrd, item_no
				FROM (
					SELECT item_no, SUM(qty_ordered) AS QtyOrd
					FROM dbo.oehdrhst_sql OH WITH(NOLOCK) JOIN oelinhst_Sql OL ON OL.inv_no = OH.inv_no 
					WHERE   MONTH(OH.inv_dt) = MONTH(DATEADD(month, -1, GETDATE()))
							AND YEAR(OH.inv_dt) = YEAR(DATEADD(month, -1, getdate()))
							AND (LTRIM(OH.cus_no) IN ('20938', '1575'))
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
					GROUP BY item_no, inv_dt
					UNION ALL
					SELECT item_no, SUM(qty_ordered) AS QtyOrd 
					FROM dbo.oeordhdr_sql OH WITH(NOLOCK) JOIN oeordlin_Sql OL ON OL.ord_no = OH.ord_no 
					WHERE   MONTH(OH.inv_dt) = MONTH(DATEADD(month, -1, GETDATE()))
							AND YEAR(OH.inv_dt) = YEAR(DATEADD(month, -1, getdate()))
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
					) AS Tot
				GROUP BY item_no
				) AS QtyOrd
			 JOIN edcitmfl_sql EDI WITH(NOLOCK) ON EDI.mac_item_num = QtyOrd.item_no
			 JOIN Z_IMINVLOC INV WITH(NOLOCK) ON INV.item_no = QtyOrd.item_no
			 JOIN imitmidx_sql IM WITH(NOLOCK) ON IM.item_no = QtyOrd.item_no
ORDER BY QtyOrd.item_no DESC






