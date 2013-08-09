BEGIN TRAN

SELECT  *
FROM    poordlin_sql
where item_no = 'md-0031 hu sb'

SELECT  *
FROM    wsViewFields

UPDATE wsViewFields
SET ViewColumnName = 'OrdNo-工作秩序'
where ID = '559'

ROLLBACK