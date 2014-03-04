USE [001]
GO

/****** Object:  View [dbo].[Z_IMINVLOC_QALL_WITH_LEVELS]    Script Date: 1/14/2014 2:58:01 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[Z_IMINVLOC_QALL_WITH_LEVELS] AS

SELECT [Parent Item] AS [item_no], SUM(qty_to_ship) AS [qty_allocated], 'PARENT' AS [Level], 
                      [Parent Item] AS [Parent Item]
FROM         (SELECT     ol.item_no AS [Parent Item], qty_to_ship
              FROM          oeordlin_sql ol WITH(NOLOCK) JOIN
                            imitmidx_sql IM WITH(NOLOCK) ON IM.item_no = ol.item_no JOIN
                            oeordhdr_sql OH WITH(NOLOCK) ON OH.ord_no = ol.ord_no LEFT OUTER JOIN
                            (SELECT DISTINCT item_no, line_no, shipped, ord_no
                             FROM          wspikpak WITH(NOLOCK)) AS PP ON PP.ord_no = OL.ord_no AND PP.line_no = OL.line_no
              WHERE      (shipped = 'N' OR shipped IS NULL) 
							AND ol.loc NOT IN ('CAN', 'IN', 'BR') 
							AND oh.ord_type IN ('O') 
							AND ltrim(OH.cus_no) != '999999'
							/*Exclude KPB items sold to Inf*/ 
							AND OH.ord_no NOT IN (SELECT OH.ord_no AS ord_no
												  FROM dbo.oeordhdr_sql OH WITH(NOLOCK) JOIN oeordlin_sql OL WITH(NOLOCK) ON OH.ord_no = OL.ord_no 
																		   JOIN dbo.imitmidx_sql IM WITH(NOLOCK) ON IM.item_no = OL.item_no
												  WHERE ltrim(oh.cus_no) = '22523' AND IM.item_note_3 = 'KPB')
							--Test item
							--AND OL.item_no = 'INF-METAL-238'
							) AS LVL_ALL
GROUP BY [Parent Item]
UNION ALL
SELECT     [Comp Lvl 1] AS [item_no], SUM([Comp Lvl 1 Qty To Ship]) AS [qty_allocated], 'LVL 1' AS [Level], [Parent Item] AS [Parent Item]
FROM         (SELECT     ol.item_no AS [Parent Item], OL.qty_to_ship, BM.comp_item_no[Comp Lvl 1], BM.qty_per_par[Comp Lvl 1 Per Par], 
                                              BM.qty_per_par * ol.qty_to_ship AS [Comp Lvl 1 Qty To Ship]
                       FROM          oeordlin_sql ol WITH(NOLOCK) JOIN
                                     oeordhdr_sql OH WITH(NOLOCK) ON OH.ord_no = ol.ord_no 
							         LEFT OUTER JOIN dbo.bmprdstr_sql AS BM WITH(NOLOCK) ON BM.item_no = ol.item_no 
									 LEFT OUTER JOIN (SELECT DISTINCT item_no, line_no, shipped, ord_no
                                                       FROM wspikpak WITH(NOLOCK)) AS PP ON PP.ord_no = OL.ord_no AND PP.line_no = OL.line_no
                       WHERE      (shipped = 'N' OR shipped IS NULL) 
								  AND ol.loc NOT IN ('CAN', 'IN', 'BR') 
								  AND OH.ord_type IN ('O')
								  AND ltrim(OH.cus_no) != '999999') AS LVL_ALL
GROUP BY [Comp Lvl 1], [Parent Item]
GO


