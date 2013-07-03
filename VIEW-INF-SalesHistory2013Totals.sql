USE [020]
GO

/****** Object:  View [dbo].[Z_SALES_HISTORY_2012_TOTALS]    Script Date: 06/21/2013 11:13:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[Z_SALES_HISTORY_2013_TOTALS] AS 
SELECT     CAST(LTRIM(Customer) AS int) AS Customer, cus_name, CAST(LTRIM(Sales) AS int) AS Sales, SUM([Total Sales Amt After Disc.]) AS [Total Sales Amount], 
                      SUM([Total Sales Amt After Disc.]) AS [Sales After Disc.]
FROM         dbo.Z_SALES_HISTORY_2013
GROUP BY Customer, cus_name, Sales
GO


