--MARCO PO RECORDS IN DESC ORDER WITH FREIGHT/COST INFORMATION BY ITEM #
SELECT CONVERT(varchar, PH.ord_dt, 101) AS OrdDate, LTRIM(LEFT(PH.ord_no,6)) AS PO#, PL.line_no, 
            CASE WHEN LTRIM(AP.vend_no) = '8859' THEN 'AIFEI' WHEN LTRIM(AP.vend_no) = '8830' THEN 'PAFIC' ELSE AP.vend_name END AS vend_name, 
            LTRIM(PH.vend_no) AS Vend#, RTRIM(PL.item_no) AS ITEM, RTRIM(PL.item_desc_1) AS Desc1, 
            RTRIM(PL.item_desc_2) AS Desc2, pl.qty_ordered, PL.uom, PL.act_unit_cost, 
            CASE WHEN LTRIM(PL.vend_no) NOT IN (SELECT vend_no FROM BG_CH_Vendors) THEN NULL 
				 WHEN PL.qty_received = 0 THEN NULL 
				 WHEN PL.qty_received > 0 AND PC.flat_amt = 0 THEN NULL 
            ELSE CAST(ROUND(((PC.flat_amt / PL.qty_received) + PL.act_unit_cost),2) AS FLOAT) END AS Landed_Cost, 
            PC.flat_amt AS [TOTAL FREIGHT], PL.extra_8 AS Ship_Dt, PL.stk_loc, CONVERT(varchar, PL.receipt_dt, 101) AS RcptDt, PL.qty_received,
			PL.user_def_fld_1
            
FROM poordlin_sql PL JOIN poordhdr_sql PH ON PL.ord_no = PH.ord_no JOIN apvenfil_sql AP ON AP.vend_no = PH.vend_no 
LEFT OUTER JOIN (SELECT ord_no, line_no, SUM(PC.flat_amt) AS flat_amt FROM popurcst_sql PC GROUP BY ord_no, line_no) AS PC ON PC.ord_no = PL.ord_no AND PC.line_no = PL.line_no

WHERE PL.ord_status <> 'X' AND PH.ord_status <> 'X' and receipt_dt > '01/01/2012' --AND PL.qty_received > 0
ORDER BY PL.receipt_dt DESC--, PL.item_no ASC

--SELECT ord_no, line_no FROM dbo.popurcst_sql GROUP BY ord_no, line_no  HAVING COUNT(*) > 1 ORDER BY ord_no, line_no

--SELECT * FROM dbo.popurcst_sql WHERE ord_no = '11833300'

--SELECT * FROM dbo.poordlin_sql WHERE item_no = 'WM-MOVIEDUMPBIN'
