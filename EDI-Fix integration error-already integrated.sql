SELECT * FROM EDCAUDFL_SQL 

SELECT CAST(date_created_yy AS VARCHAR) + CAST(date_created_mm AS VARCHAR) + CAST(date_created_dd AS VARCHAR) AS Date,* 
FROM dbo.edccapfl_sql AS EDI_Inbound   WHERE document_num = ('31971559') ORDER BY Date DESC

SELECT CAST(date_created_yy AS VARCHAR) + CAST(date_created_mm AS VARCHAR) + CAST(date_created_dd AS VARCHAR) AS Date, * 
FROM dbo.edcsdqfl_sql AS EDI_OE_Xref   WHERE document_num = '31974894' --AND document_num <= '31972021' 
ORDER BY Date DESC

SELECT * FROM oeordhdr_sql WHERE ord_no = ' 6003187'
SELECT * FROM oeordlin_sql WHERE ord_no = ' 6003187'

SELECT * FROM dbo.edccapfl_sql

DELETE FROM dbo.oeordhdr_sql  WHERE ord_no = ' 6003187'

BEGIN TRANSACTION
DELETE FROM dbo.edccapfl_sql
WHERE document_num >= '31971559' AND document_num <= '31972021' 

DELETE FROM dbo.edcsdqfl_sql
WHERE document_num >= '31971559' AND document_num <= '31972021' 

COMMIT TRANSACTION



SELECT * FROM oeordhdr_sql WHERE ord_no = '  690968'

