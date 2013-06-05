SELECT WMAct.store_no, proj_type, item_no, price, CAST(SUM(qty_ordered)AS Int) AS [Qty Ordered], 
		CASE WHEN Proj_Type = 'SUP-RM' THEN CAST(WMChk.[SUP-RM] AS nvarchar(MAX))
			 WHEN Proj_Type = 'SUP-NEW' THEN CAST(WMChk.[SUP-NEW] AS nvarchar(MAX))
			 WHEN Proj_Type = 'SAMS-RM' THEN CAST(WMChk.[SAMS-RM] AS nvarchar(MAX))
			 WHEN Proj_Type = 'SAMS-NEW' THEN CAST(WMChk.[SAMS-NEW]  AS nvarchar(MAX))
			 WHEN Proj_Type = 'DIV1-RM' THEN CAST(WMChk.[DIV1-RM]  AS nvarchar(MAX))
			 WHEN Proj_Type = 'DIV1-NEW' THEN CAST(WMChk.[DIV1-NEW] AS nvarchar(MAX))
			 WHEN Proj_Type = 'RMC' THEN CAST(WMChk.[RMC] AS nvarchar(MAX))
		END AS [Expected QTY],
		MAX(WMAct.Poss_dt)
FROM oehdrhst_sql AS OH LEFT OUTER JOIN oelinhst_sql AS OL on OH.inv_no = OL.inv_no RIGHT OUTER JOIN WMActivityReport_Apr2011  AS WMAct ON WMAct.store_no = rtrim(ltrim(OH.cus_alt_adr_cd)) INNER JOIN WMItemChecklist_Apr2011 AS WMChk on WMChk.[Marco Item #] = OL.item_no
WHERE ord_dt > '2010-010-05 00:00:00.000' 
AND ltrim(rtrim(OH.cus_no)) in ('1575','20938')
AND NOT(ship_instruction_2 like '%DISTRO%') AND NOT(OH.user_def_fld_4 like '%OG%')  /*exclude distros*/
AND NOT(ship_instruction_2 like '%TURE RE%') AND NOT(OH.user_def_fld_4 like '%ON%')  AND NOT(OH.user_def_fld_4 like '%FR%')  /*exclude FR's*/
AND NOT(ship_instruction_2 like '%REPLACEMENT%') AND NOT(OH.user_def_fld_4 like '%RP%')   /*exclude replacements*/
AND NOT(OH.user_def_fld_4 like '%PH%')   /*exclude PH*/
AND (WMAct.Order_Deadline < '3/22/11')   /*Only include Groups 14 and less*/
GROUP by WMAct.store_no, item_no, [Proj_Type], WMChk.[SUP-RM], WMChk.[SUP-NEW], WMChk.[SAMS-NEW],  WMChk.[SAMS-RM] , WMChk.[DIV1-NEW], WMChk.[DIV1-RM], WMChk.[RMC] , price 

UNION ALL /*Add open order tables*/

SELECT WMAct.store_no, proj_type, item_no, price, CAST(SUM(qty_ordered)AS Int) AS [Qty Ordered], 
		CASE WHEN Proj_Type = 'SUP-RM' THEN CAST(WMChk.[SUP-RM] AS nvarchar(MAX))
			 WHEN Proj_Type = 'SUP-NEW' THEN CAST(WMChk.[SUP-NEW] AS nvarchar(MAX))
			 WHEN Proj_Type = 'SAMS-RM' THEN CAST(WMChk.[SAMS-RM] AS nvarchar(MAX))
			 WHEN Proj_Type = 'SAMS-NEW' THEN CAST(WMChk.[SAMS-NEW]  AS nvarchar(MAX))
			 WHEN Proj_Type = 'DIV1-RM' THEN CAST(WMChk.[DIV1-RM]  AS nvarchar(MAX))
			 WHEN Proj_Type = 'DIV1-NEW' THEN CAST(WMChk.[DIV1-NEW] AS nvarchar(MAX))
			 WHEN Proj_Type = 'RMC' THEN CAST(WMChk.[RMC] AS nvarchar(MAX))
		END AS [Expected QTY],
		MAX(WMAct.Poss_dt)
FROM oeordhdr_sql AS OH LEFT OUTER JOIN oeordlin_sql AS OL on OH.ord_no = OL.ord_no RIGHT OUTER JOIN WMActivityReport_Apr2011  AS WMAct ON WMAct.store_no = rtrim(ltrim(OH.cus_alt_adr_cd)) INNER JOIN WMItemChecklist_Apr2011 AS WMChk on WMChk.[Marco Item #] = OL.item_no
WHERE ord_dt > '2010-010-05 00:00:00.000' 
AND ltrim(rtrim(OH.cus_no)) in ('1575','20938')
AND NOT(ship_instruction_2 like '%DISTRO%') AND NOT(OH.user_def_fld_4 like '%OG%')  /*exclude distros*/
AND NOT(ship_instruction_2 like '%TURE RE%') AND NOT(OH.user_def_fld_4 like '%ON%')  AND NOT(OH.user_def_fld_4 like '%FR%')  /*exclude FR's*/
AND NOT(ship_instruction_2 like '%REPLACEMENT%') AND NOT(OH.user_def_fld_4 like '%RP%')   /*exclude replacements*/
AND NOT(OH.user_def_fld_4 like '%PH%')   /*exclude PH*/
AND (WMAct.Order_Deadline < '3/22/11')   /*Only include Groups 14 and less*/
GROUP by WMAct.store_no, item_no, [Proj_Type], WMChk.[SUP-RM], WMChk.[SUP-NEW], WMChk.[SAMS-NEW],  WMChk.[SAMS-RM] , WMChk.[DIV1-NEW], WMChk.[DIV1-RM], WMChk.[RMC] , price 
ORDER BY WMAct.store_no




--------

SELECT WMAct.store_no, proj_type, item_no, price, CAST(SUM(qty_ordered)AS Int) AS [Qty Ordered], 
		CASE WHEN Proj_Type = 'SUP-RM' THEN CAST(WMChk.[SUP-RM] AS nvarchar(MAX))
			 WHEN Proj_Type = 'SUP-NEW' THEN CAST(WMChk.[SUP-NEW] AS nvarchar(MAX))
			 WHEN Proj_Type = 'SAMS-RM' THEN CAST(WMChk.[SAMS-RM] AS nvarchar(MAX))
			 WHEN Proj_Type = 'SAMS-NEW' THEN CAST(WMChk.[SAMS-NEW]  AS nvarchar(MAX))
			 WHEN Proj_Type = 'DIV1-RM' THEN CAST(WMChk.[DIV1-RM]  AS nvarchar(MAX))
			 WHEN Proj_Type = 'DIV1-NEW' THEN CAST(WMChk.[DIV1-NEW] AS nvarchar(MAX))
			 WHEN Proj_Type = 'RMC' THEN CAST(WMChk.[RMC] AS nvarchar(MAX))
		END AS [Expected QTY],
		MAX(WMAct.Poss_dt)
FROM WMItemChecklist_Apr2011 AS WMChk  LEFT OUTER JOIN
			oelinhst_sql AS OL ON OL.item_no = WMChk.[MARCO ITEM #] LEFT OUTER JOIN
			dbo.oehdrhst_sql AS OH on OH.inv_no = OL.inv_no LEFT OUTER JOIN 
			WMActivityReport_Apr2011  AS WMAct ON WMAct.store_no = rtrim(ltrim(OH.cus_alt_adr_cd)) 
WHERE ord_dt > '2010-010-05 00:00:00.000' 
AND ltrim(rtrim(OH.cus_no)) in ('1575','20938')
AND NOT(ship_instruction_2 like '%DISTRO%') AND NOT(OH.user_def_fld_4 like '%OG%')  /*exclude distros*/
AND NOT(ship_instruction_2 like '%TURE RE%') AND NOT(OH.user_def_fld_4 like '%ON%')  AND NOT(OH.user_def_fld_4 like '%FR%')  /*exclude FR's*/
AND NOT(ship_instruction_2 like '%REPLACEMENT%') AND NOT(OH.user_def_fld_4 like '%RP%')   /*exclude replacements*/
AND NOT(OH.user_def_fld_4 like '%PH%')   /*exclude PH*/
AND (WMAct.Order_Deadline < '3/22/11')   /*Only include Groups 14 and less*/
GROUP by WMAct.store_no, item_no, [Proj_Type], WMChk.[SUP-RM], WMChk.[SUP-NEW], WMChk.[SAMS-NEW],  WMChk.[SAMS-RM] , WMChk.[DIV1-NEW], WMChk.[DIV1-RM], WMChk.[RMC] , price 


SELECT WMAct.store_no, WMact.Proj_Type, Chk.item_no, OL.item_no, qty_ordered, Chk.qty AS [Expected Qty], *
FROM WMActivityReport_Apr2011  AS WMAct JOIN
     dbo.oehdrhst_sql AS OH ON WMAct.store_no = rtrim(ltrim(OH.cus_alt_adr_cd))  JOIN
     dbo.oelinhst_sql AS OL ON OL.inv_no = OH.inv_no  RIGHT OUTER JOIN
     BG_TestChkList AS Chk ON Chk.proj_Type = WMAct.Proj_Type AND Chk.item_no = OL.item_no
     
     
     SELECT * FROM dbo.WMActivityReport_Apr2011 AS WARA