USE [060]
GO

/****** Object:  View [dbo].[BG_BOM_ALL]    Script Date: 2/4/2014 1:32:41 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW  [dbo].[BG_BOM_ALL]
AS
select *
FROM BG_BOM_TEMPLATE
GO


