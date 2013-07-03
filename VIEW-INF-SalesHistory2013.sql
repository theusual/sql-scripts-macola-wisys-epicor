USE [020]
GO

/****** Object:  View [dbo].[Z_SALES_HISTORY_2012]    Script Date: 06/21/2013 11:13:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[Z_SALES_HISTORY_2013] AS 
SELECT     LTRIM(oh.ord_no) AS [Order], oh.orig_ord_type AS [Original Order Type], CONVERT(varchar, oh.ord_dt, 101) AS Date, LTRIM(oh.cus_no) AS Customer, AR.cus_name, 
                      oh.oe_po_no AS PO, oh.bill_to_name AS [Bill To], LTRIM(oh.cus_alt_adr_cd) AS Store, oh.ship_to_name AS [Ship To], LTRIM(oh.slspsn_no) AS Sales, 
                      oh.discount_pct AS Discount, ol.sls_amt AS [Total Sales Amt], (1 - ol.discount_pct / 100) * ol.sls_amt AS [Total Sales Amt After Disc.], oh.frt_amt AS [Freight Amount], 
                      oh.cmt_1 AS [Cmt 1], oh.cmt_2 AS [Cmt 2], oh.cmt_3 AS [Cmt 3], CONVERT(varchar, oh.inv_dt, 101) AS [Invoice Date], ol.line_seq_no AS [Item Line Seq], 
                      ol.item_no AS Item, ol.cus_item_no AS [Customer Item], ol.qty_ordered AS [Qty Ordered], ol.qty_to_ship AS [Qty To Ship], ol.unit_price AS [Unit Price], 
                      ol.prod_cat AS [Product Category], OH.ship_to_addr_4, OH.ship_to_addr_2, OH.ship_to_addr_1
FROM         dbo.oehdrhst_sql AS oh INNER JOIN
                      dbo.oelinhst_sql AS ol ON oh.inv_no = ol.inv_no INNER JOIN
                      dbo.arcusfil_sql AS AR ON AR.cus_no = oh.cus_no
WHERE     (YEAR(oh.inv_dt) = '2013')
GO


