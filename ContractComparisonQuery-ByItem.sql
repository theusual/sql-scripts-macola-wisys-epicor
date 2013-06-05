DECLARE @DIV1NEW INT 
DECLARE @DIV1RM INT
DECLARE @SUPNEW INT 
DECLARE @SUPRM INT 

SET @DIV1NEW = (SELECT COUNT(WMAct.store_no)
FROM WMActivityReport_Apr2011 AS WMAct
WHERE (WMAct.Order_Deadline < '3/22/11') AND Proj_Type = 'DIV1-NEW') 

SET @SUPNEW = (SELECT COUNT(WMAct.store_no)
FROM WMActivityReport_Apr2011 AS WMAct
WHERE (WMAct.Order_Deadline < '3/22/11') AND Proj_Type = 'SUP-NEW') 

SET @SUPRM = (SELECT COUNT(WMAct.store_no)
FROM WMActivityReport_Apr2011 AS WMAct
WHERE (WMAct.Order_Deadline < '3/22/11') AND Proj_Type = 'SUP-RM') ;

/*------------DEFINE TEMP TABLE 'POTOTALS' TO ACCUMULATE QTY ORDERED FROM BOTH OPEN AND HISTORY------*/
WITH POTotals (item_no, qty_ordered, ord_type) AS (SELECT item_no, SUM (qty_ordered), 'OPEN'
FROM oeordlin_sql AS OL INNER JOIN oeordhdr_sql AS OH ON OL.ord_no = OH.ord_no INNER JOIN WMActivityReport_Apr2011 AS WMAct ON WMAct.store_no = rtrim(ltrim(OH.cus_alt_adr_cd))
WHERE ltrim(rtrim(OH.cus_no)) in ('1575','20938')
AND NOT(ship_instruction_2 like '%DISTRO%') AND NOT(OH.user_def_fld_4 like '%OG%')  /*exclude distros*/
AND NOT(ship_instruction_2 like '%TURE RE%') AND NOT(OH.user_def_fld_4 like '%ON%')  AND NOT(OH.user_def_fld_4 like '%FR%')  /*exclude FR's*/
AND NOT(ship_instruction_2 like '%REPLACEMENT%') AND NOT(OH.user_def_fld_4 like '%RP%')   /*exclude replacements*/
AND NOT(ship_instruction_1 like '%DISTRO%') 
AND NOT(ship_instruction_1 like '%TURE RE%') 
AND NOT(ship_instruction_1 like '%REPLACEMENT%')
AND NOT(OH.user_def_fld_4 like '%PH%') 
AND NOT(OH.user_def_fld_4 like '%SAMPLE%') 
AND NOT(OH.user_def_fld_4 = 'S')
AND NOT(OH.user_def_fld_4 like '%PR%')
AND OH.ord_type = 'O' --Exclude masters
GROUP BY item_no

UNION ALL

SELECT item_no, SUM (qty_ordered), 'CLOSED'
FROM oelinhst_sql AS OL INNER JOIN oehdrhst_sql AS OH ON OL.inv_no = OH.inv_no INNER JOIN WMActivityReport_Apr2011 AS WMAct ON WMAct.store_no = rtrim(ltrim(OH.cus_alt_adr_cd))
WHERE ord_dt > '2010-010-05 00:00:00.000' 
AND ltrim(rtrim(OH.cus_no)) in ('1575','20938')
AND NOT(ship_instruction_2 like '%DISTRO%') AND NOT(OH.user_def_fld_4 like '%OG%')  /*exclude distros*/
AND NOT(ship_instruction_2 like '%TURE RE%') AND NOT(OH.user_def_fld_4 like '%ON%')  AND NOT(OH.user_def_fld_4 like '%FR%')  /*exclude FR's*/
AND NOT(ship_instruction_2 like '%REPLACEMENT%') AND NOT(OH.user_def_fld_4 like '%RP%')   /*exclude replacements*/
AND NOT(ship_instruction_1 like '%DISTRO%') 
AND NOT(ship_instruction_1 like '%TURE RE%') 
AND NOT(ship_instruction_1 like '%REPLACEMENT%')
AND NOT(OH.user_def_fld_4 like '%PH%') 
AND NOT(OH.user_def_fld_4 like '%SAMPLE%') 
AND NOT(OH.user_def_fld_4 = 'S')
AND NOT(OH.user_def_fld_4 like '%PR%')
AND OH.orig_ord_type IN ('O', 'I') 
GROUP BY item_no

UNION ALL

SELECT item_no, (SUM (qty_return_to_stk) * -1), 'CLOSED - CREDITS'
FROM oelinhst_sql AS OL INNER JOIN oehdrhst_sql AS OH ON OL.inv_no = OH.inv_no INNER JOIN WMActivityReport_Apr2011 AS WMAct ON WMAct.store_no = rtrim(ltrim(OH.cus_alt_adr_cd))
WHERE ord_dt > '2010-010-05 00:00:00.000' 
AND ltrim(rtrim(OH.cus_no)) in ('1575','20938')
AND NOT(ship_instruction_2 like '%DISTRO%') AND NOT(OH.user_def_fld_4 like '%OG%')  /*exclude distros*/
AND NOT(ship_instruction_2 like '%TURE RE%') AND NOT(OH.user_def_fld_4 like '%ON%')  AND NOT(OH.user_def_fld_4 like '%FR%')  /*exclude FR's*/
AND NOT(ship_instruction_2 like '%REPLACEMENT%') AND NOT(OH.user_def_fld_4 like '%RP%')   /*exclude replacements*/
AND NOT(ship_instruction_1 like '%DISTRO%') 
AND NOT(ship_instruction_1 like '%TURE RE%') 
AND NOT(ship_instruction_1 like '%REPLACEMENT%')
AND NOT(OH.user_def_fld_4 like '%PH%') 
AND NOT(OH.user_def_fld_4 like '%SAMPLE%') 
AND NOT(OH.user_def_fld_4 = 'S')
AND NOT(OH.user_def_fld_4 like '%PR%')
AND (WMAct.Order_Deadline < '3/22/11')   /*Only include Groups 14 and less on the Acitvity Schedule*/
AND OH.orig_ord_type IN ('C')  --Credits
GROUP BY item_no)


/*-----------------BEGIN FINAL SELECT STATEMENT FOR DISPLAY---------*/

SELECT [marco item #], price, [Commodity Sub-Class Description] AS [Commodity], [Percentage Award By Category] AS [% Award], ([SUP-RM] * @SUPRM) AS [ALLVENDOR PQTY SUP-RM], ([DIV1-NEW] * @DIV1NEW) AS [ALLVENDOR PQTY DIV1-NEW], ([SUP-NEW] * @SUPNEW) AS [ALLVENDOR PQTY SUP-NEW], /*Total WM QTY's Ordered From All Vendors According to Store Totals*/
       CAST(([SUP-RM] * @SUPRM * [Percentage Award By Category]) AS INT) AS [MARCO PQTY SUP-RM],  CAST(([DIV1-NEW] * @DIV1NEW * [Percentage Award By Category]) AS INT) AS [MARCO PQTY DIV1-NEW],  CAST(([SUP-NEW] * @SUPNEW * [Percentage Award By Category]) AS Int) AS [MARCO PQTY SUP-NEW], /*Projected QTY to be ordered from Marco By Proj Type, according to the percentage awarded multiplied into total vendor qty*/
       CAST(([SUP-RM] * @SUPRM * [Percentage Award By Category]) * (CAST([DIV1-NEW] AS Int)) AS INT) AS [MARCO TOT PQTY], /*PQTY TOTAL for all Proj Types*/
           /*QTY Difference between PO Totals and Projected QTY Totals*/
           /*$ Difference between PO Totals and Projected QTY Totals*/
       CAST(SUM(POT.qty_ordered)AS Int) AS [MARCO TOT PO QTY]
FROM WMItemChecklist_Apr2011 AS WMChk INNER JOIN POTotals AS POT ON POT.item_no = WMChk.[Marco Item #] /*only accumulate order totals for stores on the activity list*/
GROUP BY [marco item #], [Commodity Sub-Class Description], [Percentage Award By Category] , [SUP-RM], [DIV1-NEW], [SUP-NEW], price
ORDER BY [marco item #]