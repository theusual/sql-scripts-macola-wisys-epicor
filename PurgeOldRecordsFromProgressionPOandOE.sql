select *
INTO  [OldMPWRecords].[dbo].[data_40_oeordhdr_sql_prior_to_10_30_10]
from  [DATA_40].[dbo].[oeordhdr_sql]
where ord_no IN (select ord_no from oeordhdr_sql where ord_dt < CONVERT(varchar(24), '20101030', 112))

select *
INTO  [OldMPWRecords].[dbo].[data_40_oeordlin_sql_prior_to_10_30_10]
from  [DATA_40].[dbo].[oeordlin_sql]
where ord_no IN (select ord_no from oeordhdr_sql where ord_dt < CONVERT(varchar(24), '20101030', 112))


delete from oeordlin_sql
where ord_no IN (select ord_no from oeordhdr_sql where ord_dt < CONVERT(varchar(24), '20101030', 112))

delete from oeordhdr_sql
where ord_no IN (select ord_no from oeordhdr_sql where ord_dt < CONVERT(varchar(24), '20101030', 112))

