--Created:	1/14/14		 By:	BG
--Last Updated:	1/14/14	 By:	BG
--Purpose:  All POs

USE [001]
GO

SET QUOTED_IDENTIFIER ON
GO

--ALTER VIEW [dbo].[BG_PO_ALL_LAST_2_YR] AS
SELECT PH.vend_no, VEN.vend_name, PH.ord_no, PL.item_no, PL.item_desc_1, PL.item_desc_2, PL.qty_received, PL.purch_uom, act_unit_cost, LND.flat_amt/qty_received AS [Freight Cost],
		(LND.flat_amt/qty_received + PL.act_unit_cost) AS [Landed Cost], PL.receipt_dt, CASE WHEN CH.vend_name is null THEN 'Y' ELSE 'N' END AS CH
FROM poordhdr_sql PH JOIN poordlin_sql PL ON PL.ord_no = PH.ord_no 
					 JOIN apvenfil_sql VEN ON VEN.vend_no = PH.vend_no
					 LEFT OUTER JOIN BG_CH_Vendors CH ON CH.vend_no = ltrim(PH.vend_no)
					 LEFT OUTER JOIN popurcst_sql LND ON LND.ord_no = PL.ord_no AND LND.line_no = PL.line_no
WHERE receipt_dt > DATEADD(year,-2,GETDATE()) AND qty_received > 0


select *
from popurcst_sql
