----------------------------------------------------------------------------------------
--Update usage and allocations in the iminvloc_Sql table
----------------------------------------------------------------------------------------
UPDATE dbo.iminvloc_Sql
SET usage_ytd = 0, qty_allocated = 0
FROM dbo.iminvloc_sql IM

UPDATE dbo.iminvloc_Sql
SET usage_ytd = USG.usage_ytd
FROM dbo.iminvloc_sql IM, z_iminvloc_usage_by_loc USG
WHERE USG.item_no = IM.item_no AND USG.loc = IM.loc

UPDATE dbo.iminvloc_Sql
SET qty_allocated = QALL.qty_allocated
FROM dbo.iminvloc_sql IM, dbo.Z_IMINVLOC_QALL_BY_LOC QALL
WHERE QALL.item_no = IM.item_no AND QALL.loc = IM.loc

----------------------------------------------------------------------------------------
--Update TOTAL usage and allocations into a reference field in the imitmidx_sql table
----------------------------------------------------------------------------------------
UPDATE dbo.imitmidx_Sql
SET extra_10 = USG.usage_ytd
FROM dbo.imitmidx_sql IM, z_iminvloc_usage USG
WHERE USG.item_no = IM.item_no 

UPDATE dbo.imitmidx_Sql
SET  extra_11 = QALL.qty_allocated
FROM dbo.imitmidx_sql IM, z_iminvloc_qall QALL
WHERE QALL.item_no = IM.item_no


SELECT qty_on_hand, qty_allocated, usage_ytd, * FROM  dbo.iminvloc_sql WHERE item_no = 'VEG-212 BK'
SELECT * FROM dbo.Z_IMINVLOC_QALL_BY_LOC WHERE item_no LIKE 'VEG-212%'

SELECT * FROM dbo.oeordlin_sql WHERE item_no LIKE 'VEG-212%'
