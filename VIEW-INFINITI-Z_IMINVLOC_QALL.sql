CREATE VIEW [dbo].[Z_IMINVLOC_QALL]
AS
-- CREATED:  7/13/12 
-- UPDATED:  7/13/12      BY: BG
-- PURPOSE: View for QALL

SELECT     TOP (100) PERCENT dbo.Z_IMINVLOC_QALL_WITH_LEVELS.item_no, SUM(CONVERT(Decimal(14, 4), 
                      dbo.Z_IMINVLOC_QALL_WITH_LEVELS.qty_allocated)) AS qty_allocated, dbo.imitmidx_sql.prod_cat
FROM         dbo.Z_IMINVLOC_QALL_WITH_LEVELS INNER JOIN
                      dbo.imitmidx_sql ON dbo.Z_IMINVLOC_QALL_WITH_LEVELS.item_no = dbo.imitmidx_sql.item_no
GROUP BY dbo.Z_IMINVLOC_QALL_WITH_LEVELS.item_no, dbo.imitmidx_sql.prod_cat
ORDER BY dbo.imitmidx_sql.prod_cat
