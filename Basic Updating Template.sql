--Run a select statement to find the data you will be updating
SELECT  ship_to_addr_3
FROM    oehdrhst_sql
where ord_no = '  681494'

--Run Update statement and copy where clause from the select statement
UPDATE oehdrhst_sql
SET ship_to_addr_3 = 'WAL-MART STORE 1808'
where ord_no = '  681494'

--Run second select statement to verify update occurred correctly
SELECT  ship_to_addr_3
FROM    oehdrhst_sql
where ord_no = '  681494'
