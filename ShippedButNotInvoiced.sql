SELECT DISTINCT 
               TOP (100) PERCENT MAX(CONVERT(varchar, CAST(RTRIM(OEORDHDR_SQL.shipping_dt) AS datetime), 101)) AS [Order Shipping Date], MAX(CONVERT(varchar, 
               CAST(RTRIM(SH.ship_dt) AS datetime), 101)) AS [Ship Date], OEORDHDR_SQL.ord_no AS [Order], AR.cus_name AS [Cus Name], 
               RTRIM(OEORDHDR_SQL.cus_alt_adr_cd) AS [Store #], OEORDHDR_SQL.cus_no AS [Customer #], OEORDLIN_SQL.loc AS [Shipped From], SH.TrackingNo, 
               sh.item_no AS [Shipped Items], SUM(qty) AS [Qty Shipped], (unit_price * SUM(qty)) AS [line total $], MAX(OEORDLIN_SQL.user_def_fld_1) 
               AS [Late Order Comments 1], MAX(OEORDLIN_SQL.user_def_fld_2) AS [Late Order Comments 2], OEORDHDR_SQL.cmt_2 AS [Invoicing Comment]
FROM  dbo.oeordhdr_sql AS OEORDHDR_SQL INNER JOIN
               dbo.oeordlin_sql AS OEORDLIN_SQL ON OEORDHDR_SQL.ord_type = OEORDLIN_SQL.ord_type AND OEORDHDR_SQL.ord_no = OEORDLIN_SQL.ord_no JOIN
               dbo.wsPikPak AS SH ON SH.Ord_no = OEORDHDR_SQL.ord_no AND SH.line_no = OEORDLIN_SQL.line_no JOIN
               dbo.arcusfil_sql AS AR ON AR.cus_no = OEORDHDR_SQL.cus_no JOIN
               (SELECT line_no, ord_no, SUM(qty) AS qtysum
                FROM dbo.wsPikPak AS WPP
                WHERE shipped = 'Y'
                GROUP BY ord_no, line_no) AS SHSUM ON SHSUM.line_no = oeordlin_sql.line_no AND SHSUM.ord_no = oeordhdr_sql.ord_no
WHERE (OEORDHDR_SQL.ord_type = 'O') AND (NOT (OEORDLIN_SQL.prod_cat IN ('037', '2', '036', '102', '111', '336'))) AND (OEORDHDR_SQL.status <> 'C') AND 
               (OEORDHDR_SQL.tot_sls_amt > 0) AND (OEORDLIN_SQL.item_no NOT LIKE '%TEST%') AND (OEORDHDR_SQL.status < 9) AND 
               ((OEORDLIN_SQL.ord_no + OEORDLIN_SQL.item_no) IN
                   (SELECT Ord_no + Item_no AS Expr1
                    FROM   dbo.wsPikPak AS pp
                    WHERE (Shipped = 'Y') AND (ship_dt < DATEADD(DAY, - 4, GETDATE())))) 
               AND SHSUM.qtysum = qty_to_ship OR (oeordhdr_sql.ord_no IN (' 4013564', ' 4013708'))
GROUP BY OEORDHDR_SQL.ord_no, AR.cus_name, OEORDHDR_SQL.cus_alt_adr_cd, OEORDHDR_SQL.cus_no, OEORDLIN_SQL.loc, OEORDHDR_SQL.tot_sls_amt, 
               sh.item_no, SH.TrackingNo, unit_price, OEORDHDR_SQL.cmt_2, qty_to_ship
               
UNION ALL

SELECT TOP (100) PERCENT MAX(CONVERT(varchar, CAST(RTRIM(OEORDHDR_SQL.shipping_dt) AS datetime), 101)) AS [Order Shipping Date], 'N/A' AS [Ship Date], 
               OEORDHDR_SQL.ord_no AS [Order], AR.cus_name AS [Cus Name], RTRIM(OEORDHDR_SQL.cus_alt_adr_cd) AS [Store #], 
               OEORDHDR_SQL.cus_no AS [Customer #], OEORDLIN_SQL.loc AS [Shipped From], 'N/A', oeordlin_Sql.item_no AS [Items], SUM(oeordlin_sql.qty_to_ship) AS [Qty], 
               (OEORDLIN_SQL.unit_price * OEORDLIN_SQL.qty_to_ship), MAX(OEORDLIN_SQL.user_def_fld_1) AS [Late Order Comments 1], 
               MAX(OEORDLIN_SQL.user_def_fld_2) AS [Late Order Comments 2], OEORDHDR_SQL.cmt_2 AS [Invoicing Comment]
FROM  dbo.oeordhdr_sql AS OEORDHDR_SQL INNER JOIN
               dbo.oeordlin_sql AS OEORDLIN_SQL ON OEORDHDR_SQL.ord_type = OEORDLIN_SQL.ord_type AND 
               OEORDHDR_SQL.ord_no = OEORDLIN_SQL.ord_no LEFT OUTER JOIN
               dbo.arcusfil_sql AS AR ON AR.cus_no = OEORDHDR_SQL.cus_no
WHERE (OEORDHDR_SQL.ord_type = 'O') AND (NOT (OEORDLIN_SQL.prod_cat IN ('037', '2', '036', '102', '111', '336'))) AND (OEORDHDR_SQL.status <> 'C') AND 
               (OEORDHDR_SQL.tot_sls_amt > 0) AND (OEORDLIN_SQL.item_no NOT LIKE '%TEST%') AND (OEORDHDR_SQL.status < 9) AND shipping_dt < DATEADD(day, - 90, 
               GETDATE())
GROUP BY OEORDHDR_SQL.ord_no, AR.cus_name, OEORDHDR_SQL.cus_alt_adr_cd, OEORDHDR_SQL.cus_no, OEORDLIN_SQL.loc, OEORDHDR_SQL.tot_sls_amt, 
               oeordlin_sql.item_no, unit_price, qty_to_ship, OEORDHDR_SQL.cmt_2
ORDER BY [Order], [Ship Date], [Order Shipping Date]


        