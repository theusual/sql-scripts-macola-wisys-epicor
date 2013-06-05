CREATE VIEW Z_IMINVLOC_USAGE  AS

-- CREATED:  7/13/12
-- UPDATED:  7/13/12      BY: BG
-- PURPOSE:  Usage View

SELECT     TOP (100) PERCENT item_no AS item_no, SUM(CONVERT(Decimal(14, 4), usage_ytd)) AS usage_ytd
FROM         dbo.Z_IMINVLOC_USAGE_WITH_LEVELS
GROUP BY item_no
ORDER BY item_no