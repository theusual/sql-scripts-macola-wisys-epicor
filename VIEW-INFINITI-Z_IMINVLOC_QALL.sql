ALTER VIEW [dbo].[Z_IMINVLOC_QALL]
AS
-- CREATED:  7/13/12 
-- UPDATED:  8/16/12      BY: BG
-- PURPOSE: View for QALL

SELECT     TOP (100) PERCENT IM.item_no, CASE WHEN Z_IMINVLOC_QALL_WITH_LEVELS.item_no IS NULL THEN 0 
											  ELSE SUM(CONVERT(Decimal(14, 4), dbo.Z_IMINVLOC_QALL_WITH_LEVELS.qty_allocated)) 
										 END AS qty_allocated, IM.prod_cat
FROM         dbo.imitmidx_sql AS IM LEFT OUTER JOIN
                      dbo.Z_IMINVLOC_QALL_WITH_LEVELS ON dbo.Z_IMINVLOC_QALL_WITH_LEVELS.item_no = IM.item_no
GROUP BY IM.item_no, dbo.Z_IMINVLOC_QALL_WITH_LEVELS.item_no, IM.prod_cat
ORDER BY IM.prod_cat