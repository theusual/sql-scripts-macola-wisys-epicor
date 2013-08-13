--Update order locations
BEGIN TRAN
UPDATE oeordhdr_sql
SET mfg_loc = 'MDC'
FROM    oeordlin_sql ol join oeordhdr_sql OH on OH.ord_no = ol.ord_no
where mfg_loc = 'WS' AND item_no = 'FIXFS0327'
COMMIT TRAN

BEGIN TRAN
UPDATE oeordlin_sql
SET loc = 'MDC'
FROM    oeordlin_sql ol join oeordhdr_sql OH on OH.ord_no = ol.ord_no
WHERE loc = 'WS' AND item_no = 'FIXFS0327'
COMMIT TRAN

--Update allocations in IL
SELECT SUM(qty_to_ship)
FROM dbo.oeordlin_sql
where loc = 'mdc' AND item_no = 'FIXFS0327'

UPDATE dbo.iminvloc_sql
SET qty_allocated = 756
WHERE loc = 'MDC' AND item_no = 'FIXFS0327'

UPDATE dbo.iminvloc_sql
SET qty_allocated = 0
WHERE loc = 'WS' AND item_no = 'FIXFS0327'

--Update allocations in inv trx
SELECT * FROM dbo.iminvtrx_sql 
WHERE loc = 'WS' AND item_no = 'FIXFS0327'

UPDATE dbo.iminvtrx_sql
SET loc = 'MDC'
WHERE loc = 'WS' AND item_no = 'FIXFS0327' AND doc_type = 'A'


