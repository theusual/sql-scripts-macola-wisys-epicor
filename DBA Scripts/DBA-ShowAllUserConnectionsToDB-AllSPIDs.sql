--Purpose:  Show all user connections to database

USE master
go

DECLARE @dbname sysname
SET @dbname = '001'

DECLARE @spid int
SELECT spid from master.dbo.sysprocesses where dbid = db_id(@dbname)