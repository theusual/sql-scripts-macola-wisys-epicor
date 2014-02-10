USE [020]

GO

ALTER VIEW BG_EOD_90 AS 

--Created:	10/18/12  By:	BG
--Last Updated:	  	  By:	BG
--Purpose: View for INF EOD 90 days back
--Last Change: --

SELECT  oeordlin_Sql.user_def_fld_3 AS [ActualShipDt], 
		substring(oeordlin_sql.user_def_fld_4, 1, (charindex(',', oeordlin_sql.user_def_fld_4) - 1)) AS [Carrier], 
		substring(oeordlin_sql.user_def_fld_4, (charindex(',', oeordlin_sql.user_def_fld_4)+1), LEN(oeordlin_sql.user_Def_Fld_4)) AS [Tracking#], 
				CONVERT(varchar, CAST(RTRIM(OEORDHDR_SQL.shipping_dt) AS datetime), 101) AS [Est.ShippingDt], 
               OEORDHDR_SQL.ord_no AS [Order], OEORDHDR_SQL.job_no, JOB.job_desc, OEORDHDR_SQL.cus_no AS [Customer #],AR.cus_name AS [Cus Name], 
               RTRIM(OEORDHDR_SQL.cus_alt_adr_cd) AS [Store #],  oeordlin_Sql.line_no, OEORDLIN_SQL.item_no, OEORDLIN_SQL.item_desc_1, OEORDLIN_SQL.item_Desc_2, 
               OEORDLIN_SQL.qty_to_ship AS Qty, OEORDHDR_SQL.cmt_2 AS [Invoicing Comment]
FROM  dbo.oeordhdr_sql AS OEORDHDR_SQL INNER JOIN
               dbo.oeordlin_sql AS OEORDLIN_SQL ON OEORDHDR_SQL.ord_type = OEORDLIN_SQL.ord_type AND 
               OEORDHDR_SQL.ord_no = OEORDLIN_SQL.ord_no LEFT OUTER JOIN
               dbo.arcusfil_sql AS AR ON AR.cus_no = OEORDHDR_SQL.cus_no LEFT OUTER JOIN
               dbo.jobfile_sql AS JOB ON JOB.job_no = OEORDHDR_SQL.job_no LEFT OUTER JOIN
               dbo.OELINCMT_SQL AS CMT ON CMT.ord_no = OEORDHDR_SQL.ord_no AND CMT.line_seq_no = OEORDLIN_SQL.line_no
WHERE (OEORDHDR_SQL.ord_type = 'O') AND (OEORDLIN_SQL.user_def_fld_3 IS NOT NULL) AND OEORDLIN_SQL.user_def_fld_3 > (DATEADD(day, - 91, GETDATE()))
--ORDER BY [ActualShipDt], [Order]
UNION ALL
SELECT  OL.user_def_fld_3 AS [ActualShipDt], 
		substring(OL.user_def_fld_4, 1, (charindex(',', OL.user_def_fld_4) - 1)) AS [Carrier], 
		substring(OL.user_def_fld_4, (charindex(',', OL.user_def_fld_4)+1), LEN(OL.user_Def_Fld_4)) AS [Tracking#], 
				CONVERT(varchar, CAST(RTRIM(OH.shipping_dt) AS datetime), 101) AS [Est.ShippingDt], 
               OH.ord_no AS [Order], OH.job_no, JOB.job_desc, OH.cus_no AS [Customer #],AR.cus_name AS [Cus Name], 
               RTRIM(OH.cus_alt_adr_cd) AS [Store #],  OL.line_no, OL.item_no, OL.item_desc_1, OL.item_Desc_2, 
               OL.qty_to_ship AS Qty, OH.cmt_2 AS [Invoicing Comment]
FROM  dbo.oehdrhst_sql AS OH INNER JOIN
               dbo.oelinhst_sql AS OL ON OH.ord_type = OL.ord_type AND 
               OH.ord_no = OL.ord_no LEFT OUTER JOIN
               dbo.arcusfil_sql AS AR ON AR.cus_no = OH.cus_no LEFT OUTER JOIN
               dbo.jobfile_sql AS JOB ON JOB.job_no = OH.job_no LEFT OUTER JOIN
               dbo.OELINCMT_SQL AS CMT ON CMT.ord_no = OH.ord_no AND CMT.line_seq_no = OL.line_no
WHERE (OH.ord_type = 'O') AND (OL.user_def_fld_3 IS NOT NULL) AND OL.user_def_fld_3 > (DATEADD(day, - 91, GETDATE()))
--ORDER BY [ActualShipDt], [Order]