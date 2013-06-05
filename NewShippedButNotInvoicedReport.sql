BEGIN TRAN

SELECT DISTINCT 
               MAX(CONVERT(varchar, CAST(RTRIM(OEORDHDR_SQL.shipping_dt) AS datetime), 101)) AS [Order Shipping Date], max(CONVERT(varchar, 
               CAST(RTRIM(SH.ship_dt) AS datetime), 101)) AS [Ship Date], OEORDHDR_SQL.ord_no AS [Order], AR.cus_name AS [Cus Name], 
               RTRIM(OEORDHDR_SQL.cus_alt_adr_cd) AS [Store #], OEORDHDR_SQL.cus_no AS [Customer #], OEORDLIN_SQL.loc AS [Shipped From], 
               OEORDHDR_SQL.tot_sls_amt, MAX(OEORDLIN_SQL.user_def_fld_1) AS [Late Order Comments 1], 
               MAX(OEORDLIN_SQL.user_def_fld_2) AS [Late Order Comments 2]
FROM  dbo.oeordhdr_sql AS OEORDHDR_SQL INNER JOIN
               dbo.oeordlin_sql AS OEORDLIN_SQL ON OEORDHDR_SQL.ord_type = OEORDLIN_SQL.ord_type AND 
               OEORDHDR_SQL.ord_no = OEORDLIN_SQL.ord_no INNER JOIN
               wsPikPak SH ON SH.Ord_no = OEORDHDR_SQL.ord_no INNER JOIN
               arcusfil_sql AR ON AR.cus_no = OEORDHDR_SQL.cus_no 
WHERE (NOT (OEORDLIN_SQL.prod_cat IN ('037', '2', '036', '102', '111', '336'))) AND OEORDHDR_SQL.ord_type = 'O' AND OEORDHDR_SQL.status != 'C' AND OEORDHDR_SQL.status < 9 AND (OEORDHDR_SQL.tot_sls_amt > 0) 
AND shipped = 'Y' AND SH.ship_dt < DATEADD(day,-2,GETDATE()) AND OEORDLIN_SQL.item_no NOT like '%TEST%' 
GROUP BY oeordhdr_sql.ord_no, AR.cus_name, oeordhdr_sql.cus_alt_adr_cd, oeordhdr_sql.cus_no, oeordlin_sql.loc, tot_sls_amt
ORDER BY [Ship Date] ASC, [Order Shipping Date] ASC


SELECT COUNT(DISTINCT  OEORDHDR_SQL.ord_no)
FROM  dbo.oeordhdr_sql AS OEORDHDR_SQL INNER JOIN
               dbo.oeordlin_sql AS OEORDLIN_SQL ON OEORDHDR_SQL.ord_type = OEORDLIN_SQL.ord_type AND 
               OEORDHDR_SQL.ord_no = OEORDLIN_SQL.ord_no INNER JOIN
               wsPikPak SH ON SH.Ord_no = OEORDHDR_SQL.ord_no INNER JOIN
               arcusfil_sql AR ON AR.cus_no = OEORDHDR_SQL.cus_no 
WHERE (NOT (OEORDLIN_SQL.prod_cat IN ('037', '2', '036', '102', '111', '336'))) AND OEORDHDR_SQL.ord_type = 'O' AND OEORDHDR_SQL.status != 'C' AND OEORDHDR_SQL.status < 9 AND (OEORDHDR_SQL.tot_sls_amt > 0) 
AND shipped = 'Y' AND SH.ship_dt < DATEADD(day,-2,GETDATE()) AND OEORDLIN_SQL.item_no NOT like '%TEST%' 

ROLLBACK