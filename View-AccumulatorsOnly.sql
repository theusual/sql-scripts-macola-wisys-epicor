USE [001]
GO

/****** Object:  View [dbo].[BG_IMINVLOC_ACCUMULATORS_ONLY]    Script Date: 1/17/2014 8:50:21 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[BG_IMINVLOC_ACCUMULATORS_ONLY] AS
--Created By: Bryan Gregory
--Last Updated By:  ---
--Last Updated: 1/17/2014
--Purpose:  Last month forecast comparison to actual sales  

SELECT        IM.item_no, IL.prod_cat, IL.loc, IL.qty_on_hand, IL.avg_cost, IL.last_cost, IL.std_cost, IL.prior_year_usage, QA.qty_allocated AS [QALL_All Loc], 
                         QU.usage_ytd AS [USG YTD_All Loc], IM.extra_1 AS [Par/Sub/Comp Flag], IM.item_desc_1, IM.item_desc_2, IL.qty_on_ord, IL.frz_qty
FROM            dbo.iminvloc_sql AS IL WITH(NOLOCK) INNER JOIN
                         dbo.imitmidx_sql AS IM WITH(NOLOCK) ON IM.item_no = IL.item_no LEFT OUTER JOIN
                         dbo.Z_IMINVLOC_QALL AS QA WITH(NOLOCK) ON QA.item_no = IL.item_no LEFT OUTER JOIN
                         dbo.Z_IMINVLOC_USAGE AS QU WITH(NOLOCK) ON QU.item_no = QA.item_no
WHERE        (IL.qty_on_hand <> 0) OR
                         (QA.qty_allocated <> 0) OR
                         (IL.qty_on_ord <> 0) OR
                         (IL.usage_ytd <> 0) OR
                         (IL.prior_year_usage <> 0)
GO


