SELECT  activity_dt,*
FROM    iminvloc_sql JOIN imitmidx_sql IM ON IM.item_no = iminvloc_sql.item_no JOIN poordlin_sql OL ON OL.item_no = IM.item_no
WHERE IM.item_no like '%.'

UPDATE poordlin_sql
SET item_no = 'Z-PROPANE CO'
WHERE item_no = 'Z-PROPANE CO.'

SELECT  *
FROM    poordlin_sql
WHERE item_no = 'Z-PROPANE CO.'

SELECT  activity_dt,*
FROM    imitmidx_sql IM join bmprdstr_sql BM on BM.comp_item_no = IM.item_no
WHERE IM.item_no like '%.'

SELECT  *
FROM    imitmidx_sql IM
WHERE IM.item_no like '%.'
