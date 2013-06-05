--ALTER VIEW dbo.BG_MONTHLY_FREIGHT_CHARGES_PREPAID AS 

--Created:	02/12/13     By:	BG
--Last Updated:	02/12/13 By:	BG
--Purpose: View for freight charges per month by carrier (Pre-Paid Only)
--Last Change: --

SELECT LEFT(cmt_1,3) AS [Carrier], SUM(frt_amt) AS [TotCharges], MONTH(inv_dt) AS [Month], YEAR(inv_dt) AS [Year]
FROM dbo.oehdrhst_sql 
WHERE  cmt_1 IS NOT NULL AND inv_Dt > '01/01/2011' AND LEFT(cmt_1,3) NOT IN ('CPU',' 56','3rd','10%','A)','WTL')
		AND LEFT(cmt_1,3) IN (SELECT sy_code FROM dbo.sycdefil_sql WHERE cd_Type = 'V') AND frT_amt > 0
GROUP BY LEFT(cmt_1,3), MONTH(inv_dt), YEAR(inv_dt)
--ORDER BY LEFT(cmt_1,3)