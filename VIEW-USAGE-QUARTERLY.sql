CREATE VIEW Z_IMINVLOC_USAGE_QUARTERLY AS

--Created:	2/15/13			 By:	BG
--Last Updated:	02/15/13	 By:	BG
--Purpose:	View for Usage
--Last changes: 1) 

SELECT TOP (100) PERCENT item_no, SUM(usage_ytd) AS Q_USAGE
FROM  dbo.Z_IMINVLOC_USAGE_QUARTERLY_WITH_LEVELS
GROUP BY item_no
ORDER BY item_no