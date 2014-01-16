USE [001]
GO

/****** Object:  View [dbo].[Z_IMINVLOC_USAGE_QUARTERLY_WITH_LEVELS]    Script Date: 1/14/2014 3:07:55 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[Z_IMINVLOC_USAGE_QUARTERLY_WITH_LEVELS]
AS
/*Last changes: --*/ 
SELECT [Parent Item] AS [item_no], SUM(qty_to_ship) AS [usage_ytd], 'PARENT' AS [Level], [Parent Item] AS [Parent Item]
FROM            (SELECT        ol.item_no AS [Parent Item], (OL.qty_to_ship - OL.qty_return_to_stk) AS qty_to_ship
                          FROM            oelinhst_sql ol WITH(NOLOCK) JOIN
                                                    oehdrhst_sql oh WITH(NOLOCK) ON oh.inv_no = ol.inv_no
                          WHERE        OH.inv_dt >= '10/01/2013' AND ol.loc NOT IN ('CAN', 'IN', 'BR','ID') AND orig_ord_type IN ('O', 'I', 'C')
                          UNION ALL
                          SELECT        ol.item_no AS [Parent Item], (pp.qty)
                          FROM            oeordlin_sql ol WITH(NOLOCK) JOIN
                                                   wspikpak pp WITH(NOLOCK) ON pp.ord_no = ol.ord_no AND pp.line_no = ol.line_no
                          WHERE        shipped = 'Y' AND ol.loc NOT IN ('CAN', 'IN', 'BR','ID') AND ship_dt >= '10/01/2013') AS LVL_USG
GROUP BY [Parent Item]
UNION ALL
SELECT        [Comp Lvl 1] AS [item_no], SUM([Comp Lvl 1 Qty To Ship]) AS [Usage], 'LVL 1' AS [Level], [Parent Item] AS [Parent Item]
FROM            (SELECT        ol.item_no AS [Parent Item], BM.comp_item_no[Comp Lvl 1], BM.qty_per_par[Comp Lvl 1 Per Par], (BM.qty_per_par * (ol.qty_to_ship - qty_return_to_stk)) 
                                                    AS [Comp Lvl 1 Qty To Ship]
                          FROM            oelinhst_sql ol WITH(NOLOCK) JOIN
                                                    bmprdstr_sql BM WITH(NOLOCK) ON BM.item_no = ol.item_no JOIN
                                                    oehdrhst_sql oh WITH(NOLOCK) ON oh.inv_no = ol.inv_no
                          WHERE        OH.inv_dt >= '07/01/2013' AND ol.loc NOT IN ('CAN', 'IN', 'BR','ID') AND orig_ord_type IN ('O', 'I', 'C')
                          UNION ALL
                          SELECT        ol.item_no AS [Parent Item], BM.comp_item_no[Comp Lvl 1], BM.qty_per_par[Comp Lvl 1 Per Par], (BM.qty_per_par * (ol.qty_to_ship - qty_return_to_stk)) 
                                                   AS [Comp Lvl 1 Qty To Ship]
                          FROM            oeordlin_sql ol WITH(NOLOCK) JOIN
                                                   wspikpak pp WITH(NOLOCK) ON pp.ord_no = ol.ord_no AND pp.line_no = ol.line_no JOIN
                                                   bmprdstr_sql BM WITH(NOLOCK) ON BM.item_no = ol.item_no
                          WHERE        shipped = 'Y' AND ol.loc NOT IN ('CAN', 'IN', 'BR','ID') AND ship_dt >= '07/01/2013') AS [LVL_USG]
GROUP BY [Comp Lvl 1], [Parent Item]

GO


