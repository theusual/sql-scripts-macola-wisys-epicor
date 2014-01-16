USE [001]
GO

/****** Object:  View [dbo].[Z_IMINVLOC_USAGE]    Script Date: 1/14/2014 2:59:49 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[Z_IMINVLOC_USAGE]
AS
SELECT TOP (100) PERCENT dbo.Z_IMINVLOC_USAGE_WITH_LEVELS.item_no, dbo.imitmidx_sql.prod_cat, SUM(dbo.Z_IMINVLOC_USAGE_WITH_LEVELS.usage_ytd) 
               AS usage_ytd
FROM  dbo.Z_IMINVLOC_USAGE_WITH_LEVELS WITH(NOLOCK) INNER JOIN
               dbo.imitmidx_sql WITH(NOLOCK) ON dbo.Z_IMINVLOC_USAGE_WITH_LEVELS.item_no = dbo.imitmidx_sql.item_no
GROUP BY dbo.Z_IMINVLOC_USAGE_WITH_LEVELS.item_no, dbo.imitmidx_sql.prod_cat
ORDER BY dbo.imitmidx_sql.prod_cat

GO


