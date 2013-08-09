SELECT  *
FROM    iminvtrx_sql
where ord_no = '99999997'

SELECT *
FROM iminvloc_sql
WHERE item_no like 'TEST ITEM%' and loc = 'FW'

SELECT  *
FROM    imitmidx_sql
where stocked_fg = 'N'

SELECT  ord_no, line_no, item_no, par_item_no,qty, loc
FROM    imordbld_sql
where ord_no = '99999997'

SELECT  *
FROM    iminvtrx_sql
where ord_no = '99999997'

SELECT  *
FROM    oeordlin_sql
where item_no = 'Test item pur'

UPDATE iminvloc_sql
set qty_allocated = 90
where item_no = 'test item bom' and loc = 'FW'

SELECT  *
FROM    bmprdstr_sql
where item_no like 'bak-676%'

SELECT  *
FROM    poordlin_sql
where item_no like 'bak-676%'

SELECT  *
FROM    oeordhdr_sql
where ord_no = '99999997'

update oeordhdr_sql
set status = 4
where ord_no = '99999997'

USE [JobOutputLogs]

SELECT  *
FROM    Auto_ConfirmShipCHComponents