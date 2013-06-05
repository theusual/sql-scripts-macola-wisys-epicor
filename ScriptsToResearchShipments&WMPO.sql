SELECT *
FROM BG_WMPO
WHERE [Supplier Sales/Work Order Number] like '%669993%'

SELECT *
FROM ARSHTTBL
WHERE ord_no like '%3000690%'

SELECT *
FROM oebolfil_sql

SELECT *
FROM wsPikPak 
WHERE ord_no like '%3000690%'

SELECT *
FROM wsBOLView 
where oebolord_sql_ord_no like '%9999999%'

SELECT *
FROM wsBOLViewHist
where oeordhdr_sql_ord_no like '%669993%'

SELECT *
FROM WSSHIPMENT

UPDATE oeordhdr_sql
SET status = 4
WHERE ord_no like '%99999995%'

SELECT *
FROM ARSHTFIL_SQL
ORDER BY SHIP_DATE

SELECT *
FROM oeordhdr_sql AS OH INNER JOIN oeordlin_sql AS OL ON OH.ord_no = OL.ord_no
WHERE OH.ord_no like '%3000690%'