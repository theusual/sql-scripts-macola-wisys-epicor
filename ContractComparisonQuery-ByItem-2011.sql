DECLARE @SUPNEW INT 
DECLARE @SUPRM INT 
DECLARE @WNMNEW INT 
DECLARE @WNMRM INT 
DECLARE @MISC INT 


SET @SUPNEW = (SELECT COUNT(WMAct.[Str Nbr])
FROM WMActReport_2011  AS WMAct
WHERE [Str-Proj Type] = 'SUP-NEW');
--(WMAct.[Poss Date] < '3/22/11') AND [Str-Proj Type] = 'SUP-NEW') 

SET @SUPRM = (SELECT COUNT(WMAct.[Str Nbr])
FROM WMActReport_2011  AS WMAct
WHERE [Str-Proj Type] = 'SUP-RM') ;
--WHERE (WMAct.[Poss Date] < '3/22/11') AND [Str-Proj Type] = 'SUP-RM') ;


SET @WNMNEW = (SELECT COUNT(WMAct.[Str Nbr])
FROM WMActReport_2011  AS WMAct
WHERE [Str-Proj Type] = 'WNM-NEW') ;
--WHERE (WMAct.[Poss Date] < '3/22/11') AND [Str-Proj Type] = 'WNM-NEW') ;

SET @WNMRM = (SELECT COUNT(WMAct.[Str Nbr])
FROM WMActReport_2011  AS WMAct
WHERE [Str-Proj Type] = 'WNM-RM') ;
--WHERE (WMAct.[Poss Date] < '3/22/11') AND [Str-Proj Type] = 'WNM-NEW') ;

SET @MISC = (SELECT COUNT(WMAct.[Str Nbr])
FROM WMActReport_2011  AS WMAct
WHERE [Str-Proj Type] = 'MISC') ;
--WHERE (WMAct.[Poss Date] < '3/22/11') AND [Str-Proj Type] = 'MISC') ;

--SELECT @SUPNEW, @SUPRM
/*------------DEFINE TEMP TABLE 'POTOTALS' TO ACCUMULATE QTY ORDERED FROM BOTH OPEN AND HISTORY------*/
WITH POTotals (item_no, qty_ordered, ord_type) AS 
(SELECT CASE item_no WHEN 'VEG-EURO PS BSV' THEN 'VEG-EURO PS BV'
		             WHEN 'BAK-697-2FT OBV97' THEN 'BAK-697-2 OBV97'
		             WHEN 'BAK-697-4FT OBV97' THEN 'BAK-697-4 OBV97'
		             WHEN 'BAK-ARTBRDCTR OBV97' THEN 'BAK-ARTBRDC 97'
		             WHEN 'BAK-ARTBRDEND OBV97' THEN 'BAK-ARTBRDE 97'
		             WHEN 'SW10073TAN COOKIE' THEN 'SW10073TAN COOK'
		             WHEN 'SW00134BK' THEN 'SW10216BK'
		             WHEN 'BAK-SPI 36OBV97' THEN 'BAK-SPI 2OBV97'
		             WHEN 'MET-24 BV' THEN 'MET-27 BV'
		             WHEN 'BAK-692 COBV-97' THEN 'BAK-692 COBV97'
		             WHEN 'GRO-011 WM OW' THEN 'GRO-011 WM BV'
		             WHEN 'GRO-011SNPRL OW' THEN 'GRO-011SNPRL BV'
		             ELSE item_no
		END AS item_no, SUM (qty_ordered), 'OPEN'
FROM oeordlin_sql AS OL INNER JOIN oeordhdr_sql AS OH ON OL.ord_no = OH.ord_no INNER JOIN WMActReport_2011 AS WMAct ON WMAct.[Str Nbr] = rtrim(ltrim(OH.cus_alt_adr_cd))
WHERE ltrim(rtrim(OH.cus_no)) in ('1575','20938','25000')
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

SELECT CASE item_no WHEN 'VEG-EURO PS BSV' THEN 'VEG-EURO PS BV'
		             WHEN 'BAK-697-2FT OBV97' THEN 'BAK-697-2 OBV97'
		             WHEN 'BAK-697-4FT OBV97' THEN 'BAK-697-4 OBV97'
		             WHEN 'BAK-ARTBRDCTR OBV97' THEN 'BAK-ARTBRDC 97'
		             WHEN 'BAK-ARTBRDEND OBV97' THEN 'BAK-ARTBRDE 97'
		             WHEN 'SW10073TAN COOKIE' THEN 'SW10073TAN COOK'
		             WHEN 'SW00134BK' THEN 'SW10216BK'
		             WHEN 'BAK-SPI 36OBV97' THEN 'BAK-SPI 2OBV97'
		             WHEN 'MET-24 BV' THEN 'MET-27 BV'
		             WHEN 'BAK-692 COBV-97' THEN 'BAK-692 COBV97'
		             WHEN 'GRO-011 WM OW' THEN 'GRO-011 WM BV'
		             WHEN 'GRO-011SNPRL OW' THEN 'GRO-011SNPRL BV'
		             ELSE item_no
		END AS item_no, SUM (qty_ordered), 'CLOSED'
FROM oelinhst_sql AS OL INNER JOIN oehdrhst_sql AS OH ON OL.inv_no = OH.inv_no INNER JOIN WMActReport_2011 AS WMAct ON CAST(WMAct.[Str Nbr] AS VARCHAR) = rtrim(ltrim(OH.cus_alt_adr_cd))
WHERE ord_dt > '2010-010-05 00:00:00.000' 
AND ltrim(rtrim(OH.cus_no)) in ('1575','20938', '25000')
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

SELECT CASE item_no WHEN 'VEG-EURO PS BSV' THEN 'VEG-EURO PS BV'
		             WHEN 'BAK-697-2FT OBV97' THEN 'BAK-697-2 OBV97'
		             WHEN 'BAK-697-4FT OBV97' THEN 'BAK-697-4 OBV97'
		             WHEN 'BAK-ARTBRDCTR OBV97' THEN 'BAK-ARTBRDC 97'
		             WHEN 'BAK-ARTBRDEND OBV97' THEN 'BAK-ARTBRDE 97'
		             WHEN 'SW10073TAN COOKIE' THEN 'SW10073TAN COOK'
		             WHEN 'SW00134BK' THEN 'SW10216BK'
		             WHEN 'BAK-SPI 36OBV97' THEN 'BAK-SPI 2OBV97'
		             WHEN 'MET-24 BV' THEN 'MET-27 BV'
		             WHEN 'BAK-692 COBV-97' THEN 'BAK-692 COBV97'
		             WHEN 'GRO-011 WM OW' THEN 'GRO-011 WM BV'
		             WHEN 'GRO-011SNPRL OW' THEN 'GRO-011SNPRL BV'
		             ELSE item_no
		END AS item_no, (SUM (qty_return_to_stk) * -1), 'CLOSED - CREDITS'
FROM oelinhst_sql AS OL INNER JOIN oehdrhst_sql AS OH ON OL.inv_no = OH.inv_no INNER JOIN WMActReport_2011 AS WMAct ON CAST(WMAct.[Str Nbr] AS VARCHAR) = rtrim(ltrim(OH.cus_alt_adr_cd))
WHERE ord_dt > '2010-010-05 00:00:00.000' 
AND ltrim(rtrim(OH.cus_no)) in ('1575','20938', '25000')
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
   /*Only include Groups 14 and less on the Acitvity Schedule*/
AND OH.orig_ord_type IN ('C')  --Credits
GROUP BY item_no)

--SELECT * FROM POTotals ORDER BY item_no
/*-----------------BEGIN FINAL SELECT STATEMENT FOR DISPLAY---------*/

SELECT [marco item #], price, [Commodity] AS [Commodity], [Award Percent] AS [% Award], ([SUP-RM] * @SUPRM) AS [ALLVENDOR PQTY SUP-RM], ([WNM-NEW] * @WNMNEW) AS [ALLVENDOR PQTY WNM-NEW], ([SUP-NEW] * @SUPNEW) AS [ALLVENDOR PQTY SUP-NEW], ([WNM-RM] * @WNMRM) AS [ALLVENDOR PQTY WNM-RM],/*Total WM QTY's Ordered From All Vendors According to Store Totals*/
       CAST(([SUP-RM] * @SUPRM * [Award Percent]) AS INT) AS [MARCO PQTY SUP-RM],  CAST(([WNM-NEW] * @WNMNEW * [Award Percent]) AS INT) AS [MARCO PQTY WNM-NEW],  CAST(([SUP-NEW] * @SUPNEW * [Award Percent]) AS Int) AS [MARCO PQTY SUP-NEW],  CAST(([WNM-RM] * @WNMRM * [Award Percent]) AS Int) AS [MARCO PQTY WNM-RM], /*Projected QTY to be ordered from Marco By Proj Type, according to the Award Percentage awarded multiplied into total vendor qty*/
        /*PQTY TOTAL for all Proj Types*/
           /*QTY Difference between PO Totals and Projected QTY Totals*/
           /*$ Difference between PO Totals and Projected QTY Totals*/
       CAST(SUM(POT.qty_ordered)AS Int) AS [MARCO TOT PO QTY]
FROM [WMItemChecklist 1-20-12-B] AS WMChk INNER JOIN POTotals AS POT ON POT.item_no = WMChk.[Marco Item #] /*only accumulate order totals for stores on the activity list*/
GROUP BY [marco item #], [Commodity], [Award Percent] , [SUP-RM], [WNM-RM], [WNM-NEW],[SUP-NEW], [SUP-RM], price
ORDER BY [marco item #]