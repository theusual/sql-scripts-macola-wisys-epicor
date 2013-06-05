USE [020]

GO

ALTER VIEW Z_OPEN_OPS_INF AS 

--Created:	09/21/12	 By:	BG&AA
--Last Updated:	  	 By:	BG
--Purpose: Production Schedule for Infiniti
--Last Change: --

--****UNCOMMENT THIS SECTION IF WISYS IS EVER INSTALLED AT INF****--
--SELECT DISTINCT 
--               TOP (100) PERCENT MAX(CONVERT(varchar, CAST(RTRIM(OEORDHDR_SQL.shipping_dt) AS datetime), 101)) AS [Order Shipping Date], MAX(CONVERT(varchar, 
--               CAST(RTRIM(SH.ship_dt) AS datetime), 101)) AS [Ship Date], OEORDHDR_SQL.ord_no AS [Order], AR.cus_name AS [Cus Name], 
--               RTRIM(OEORDHDR_SQL.cus_alt_adr_cd) AS [Store #], OEORDHDR_SQL.cus_no AS [Customer #], OEORDLIN_SQL.loc AS [Shipped From], SH.TrackingNo, 
--               sh.item_no AS [Shipped Items], SUM(qty) AS [Qty Shipped], (unit_price * SUM(qty)) AS [line total $], MAX(OEORDLIN_SQL.user_def_fld_1) 
--               AS [Late Order Comments 1], MAX(OEORDLIN_SQL.user_def_fld_2) AS [Late Order Comments 2], OEORDHDR_SQL.cmt_2 AS [Invoicing Comment]
--FROM  dbo.oeordhdr_sql AS OEORDHDR_SQL INNER JOIN
--               dbo.oeordlin_sql AS OEORDLIN_SQL ON OEORDHDR_SQL.ord_type = OEORDLIN_SQL.ord_type AND OEORDHDR_SQL.ord_no = OEORDLIN_SQL.ord_no JOIN
--               dbo.wsPikPak AS SH ON SH.Ord_no = OEORDHDR_SQL.ord_no AND SH.line_no = OEORDLIN_SQL.line_no JOIN
--               dbo.arcusfil_sql AS AR ON AR.cus_no = OEORDHDR_SQL.cus_no
--WHERE (OEORDHDR_SQL.ord_type = 'O') 
--				AND (OEORDHDR_SQL.status <> 'C') 
--				AND (OEORDLIN_SQL.item_no NOT LIKE '%TEST%') 
--				AND (OEORDHDR_SQL.status < 9) 
--				AND ((OEORDLIN_SQL.ord_no + OEORDLIN_SQL.item_no) IN
--                   (SELECT Ord_no + Item_no AS Expr1
--                    FROM   dbo.wsPikPak AS pp
--                    WHERE (Shipped = 'Y') AND (ship_dt < DATEADD(DAY, - 4, GETDATE()))))
--GROUP BY OEORDHDR_SQL.ord_no, AR.cus_name, OEORDHDR_SQL.cus_alt_adr_cd, OEORDHDR_SQL.cus_no, OEORDLIN_SQL.loc, OEORDHDR_SQL.tot_sls_amt, 
--               sh.item_no, SH.TrackingNo, unit_price, OEORDHDR_SQL.cmt_2
--UNION ALL


SELECT TOP (100) PERCENT MAX(CONVERT(varchar, CAST(RTRIM(OEORDHDR_SQL.shipping_dt) AS datetime), 101)) AS [Order Shipping Date], 
			   'N/A' AS [Ship Date], 
               OEORDHDR_SQL.ord_no AS [Order], 
               oeordhdr_sql.job_no, 
               JOB.job_desc, 
               AR.cus_name AS [Cus Name], 
               RTRIM(OEORDHDR_SQL.cus_alt_adr_cd) AS [Store #], 
               OEORDHDR_SQL.cus_no AS [Customer #], 
               --OEORDLIN_SQL.loc AS [Shipped From], 
               --'N/A', 
               --oeordlin_Sql.item_no AS [Items],
               SUM(oeordlin_sql.qty_to_ship) AS [Qty], 
               SUM((OEORDLIN_SQL.unit_price * OEORDLIN_SQL.qty_to_ship)) AS [Ord Total $], 
               --MAX(OEORDLIN_SQL.user_def_fld_1) AS [Late Order Comments 1], 
               --MAX(OEORDLIN_SQL.user_def_fld_2) AS [Late Order Comments 2], 
               OEORDHDR_SQL.cmt_2 AS [Invoicing Comment]
               
FROM  dbo.oeordhdr_sql AS OEORDHDR_SQL 
			INNER JOIN dbo.oeordlin_sql AS OEORDLIN_SQL ON OEORDHDR_SQL.ord_type = OEORDLIN_SQL.ord_type AND OEORDHDR_SQL.ord_no = OEORDLIN_SQL.ord_no 
			LEFT OUTER JOIN dbo.arcusfil_sql AS AR ON AR.cus_no = OEORDHDR_SQL.cus_no
            LEFT OUTER JOIN dbo.jobfile_sql JOB ON JOB.job_no = OEORDHDR_SQL.job_no
            LEFT OUTER JOIN dbo.OELINCMT_SQL CMT ON CMT.ord_no = oeordhdr_Sql.ord_no AND CMT.line_seq_no = OEORDLIN_SQL.line_no
WHERE (OEORDHDR_SQL.ord_type = 'O')
		 AND (OEORDHDR_SQL.status <> 'C') 
		 --AND (OEORDLIN_SQL.item_no NOT LIKE '%TEST%') 
		 AND (OEORDHDR_SQL.status < 8) 
		 --Take off order marked as shipped
		 AND (NOT (oeordlin_Sql.user_def_fld_2 LIKE '%S%') OR oeordlin_sql.user_def_fld_2 IS NULL)
GROUP BY OEORDHDR_SQL.ord_no, AR.cus_name, OEORDHDR_SQL.cus_alt_adr_cd, OEORDHDR_SQL.cus_no, OEORDHDR_SQL.tot_sls_amt, OEORDHDR_SQL.cmt_2, JOB.job_desc, OEORDHDR_SQL.job_no
ORDER BY [Order], [Ship Date], [Order Shipping Date]

