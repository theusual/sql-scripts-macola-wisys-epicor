Sp_configure "allow updates", 1
go
Reconfigure with override
GO
Update sysdatabases set status = 32768 
go
Sp_configure "allow updates", 0
go
Reconfigure with override
GO





DBCC REBUILD_LOG(001,'C:\Program Files\Microsoft SQL Server\MSSQL10.MSSQLSERVER\MSSQL\DATA\001_log.LDF')

EXEC sp_attach_single_file_db @dbname='001-new',@physname='C:\Program Files\Microsoft SQL Server\MSSQL10.MSSQLSERVER\MSSQL\DATA\001-main.mdf'

CREATE DATABASE [001-main] ON
    (FILENAME = 'c:\Program Files\Microsoft SQL Server\MSSQL10.MSSQLSERVER\MSSQL\DATA\001-main.mdf')
FOR ATTACH_REBUILD_LOG


alter database [001] set emergency


ALTER DATABASE [001] SET SINGLE_USER WITH ROLLBACK IMMEDIATE 

--do you stuff here 
dbcc checkdb ('001',repair_allow_data_loss)

ALTER DATABASE [001] SET MULTI_USER

alter database [001] set online

ALTER DATABASE [001] SET SINGLE_USER WITH NO_WAIT

select sysprocesses table syslogins 

select * 
from oeordhdr_Sql
order by entered_dt