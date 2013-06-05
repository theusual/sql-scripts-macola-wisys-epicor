--Created:	02/01/11	 By:	BG
--Last Updated:	2/22/13	 By:	BG
--Purpose: Calculates current projections based on customer #
--Last Update: Removed 3rd level of BOMs

USE [001]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--ALTER VIEW [dbo].[BG_WM_Current_Projections] AS

SELECT TOP (100) PERCENT item_no, SUM(qty_proj) AS qty_proj
FROM  (SELECT OL.item_no, SUM(OL.qty_ordered) AS qty_proj
               FROM   dbo.oeordhdr_sql AS OH INNER JOIN
                              dbo.oeordlin_sql AS OL ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                              dbo.wsPikPak AS pp ON pp.Ord_no = OL.ord_no AND pp.Line_no = OL.line_no
               WHERE (LTRIM(OH.cus_no) IN (SELECT cus_no FROM dbo.BG_Projection_Customers)) AND (pp.Shipped = 'N' OR
                              pp.Shipped IS NULL) AND (OL.loc <> 'CAN') AND (OH.ord_type IN ('O'))
               GROUP BY OL.item_no, OH.cus_no
               UNION ALL
               SELECT BM.comp_item_no, SUM(BM.qty_per_par * (OL.qty_to_ship - OL.qty_return_to_stk)) AS qty_proj
               FROM  dbo.oeordhdr_sql AS OH INNER JOIN
                              dbo.oeordlin_sql AS OL ON OL.ord_no = OH.ord_no INNER JOIN
                              dbo.bmprdstr_sql AS BM ON BM.item_no = OL.item_no
               WHERE (LTRIM(OH.cus_no) IN (SELECT cus_no FROM dbo.BG_Projection_Customers))
               GROUP BY BM.comp_item_no
               /*UNION ALL
               SELECT BM2.comp_item_no, SUM(BM2.qty_per_par * (OL.qty_to_ship - OL.qty_return_to_stk)) AS qty_proj
               FROM  dbo.oeordhdr_sql AS OH INNER JOIN
                              dbo.oeordlin_sql AS OL ON OL.ord_no = OH.ord_no INNER JOIN
                              dbo.bmprdstr_sql AS BM ON BM.item_no = OL.item_no INNER JOIN
                              dbo.bmprdstr_sql AS BM2 ON BM2.item_no = BM.comp_item_no
               WHERE (LTRIM(OH.cus_no) IN (SELECT cus_no FROM dbo.BG_Projection_Customers))
               GROUP BY BM2.comp_item_no*/) AS PROJLEVELS
GROUP BY item_no
ORDER BY item_no
