SELECT  *
FROM    wspikpak
where item_no = 'TEST ITEM PUR'

DELETE FROM wspikpak
where ord_no = '33333333'

SELECT  *
FROM    iminvloc_sql
where loc = 'FW' and item_no like 'TEST ITEM%'

UPDATE iminvloc_sql
SET qty_on_hand = 500
WHERE item_no = 'TEST ITEM WISYS' and loc = 'FW'

SELECT  *
FROM    bmprdstr_sql
where item_no = 'TEST ITEM PUR'

UPDATE oeordhdr_sql
SET status = 4
where ord_no = '44444444'

SELECT  *
FROM    oeordlin_sql
where item_no = 'test item pur'
