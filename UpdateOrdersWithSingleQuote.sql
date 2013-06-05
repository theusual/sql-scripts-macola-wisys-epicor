SELECT * FROM araltadr_sql WHERE addr_1 like '%''%'
SELECT * FROM araltadr_sql WHERE addr_2 like '%''%'
SELECT * FROM araltadr_sql WHERE addr_3 like '%''%'
SELECT * FROM OEORDHDR_SQL WHERE ship_to_addr_3 like '%''%'
SELECT * FROM OEORDHDR_SQL WHERE ship_to_addr_4 like '%''%'

UPDATE araltadr_sql
SET addr_3 = REPLACE(addr_3,'''', '')
WHERE addr_3 like '%''%'

