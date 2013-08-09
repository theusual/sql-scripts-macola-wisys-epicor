select *
from wsPikPak
where Ord_no = ' 2022096'

SELECT  *
FROM    wsBOLView
where oeordhdr_sql_ord_no = ' 2022096'

SELECT  *
FROM    oeordhdr_sql
where ord_no = ' 2022096'

SELECT  *
FROM    oeordlin_Sql
where item_no = 'PBU-14'

USE [001]
GO
SELECT  *
FROM    iminvtrx_sql
where item_no = 'BAK-663 OAK' and trx_dt > '08/10/2011' and doc_type = 'T'
order by trx_dt desc, trx_tm desc

USE [msdb]
GO
EXEC dbo.sp_start_job N'TestSSISPackage'


DELETE FROM TEST_SSIS_SCRIPT

USE [PH]
GO
select *
from TEST_SSIS_SCRIPT


