SELECT * FROM OEORDHDR_SQL WHERE ord_type = 'O'

SELECT * FROM wspikpak WHERE Pallet like '%1390%'

UPDATE wsPikPak
set Carton = Pallet, Carton_UCC128 = Pallet_UCC128
WHERE Ord_no like '%669182%'  

UPDATE oeordhdr_sql
SET status = 4
WHERE ord_no = '77777773'

SELECT *
FROM wsProcess
WHERE Name like '%pallet%'

SELECT *
FROM sysobjects
WHERE name like '%wsiss%'

SELECT * FROM wspikpak ORDER BY pallet     

SELECT * FROM Z_IMINVLOC WHERE item_no like '%TEST ITEM PUR%'  OR item_no like '%TEST ITEM BOM%'

UPDATE imitmidx_sql SET stocked_fg = 'Y' WHERE item_no = 'TEST ITEM PUR'

SELECT * FROM bmprdstr_sql WHERE item_no like '%TEST ITEM PUR%' 

SELECT comp_item_no FROM bmprdstr_sql WHERE item_no like '%TEST ITEM PUR%'

