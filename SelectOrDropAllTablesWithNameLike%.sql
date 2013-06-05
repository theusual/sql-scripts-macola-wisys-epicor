DECLARE @sql NVARCHAR(MAX) = N'';

SELECT @sql += '
DROP VIEW ' 
    + QUOTENAME(OBJECT_SCHEMA_NAME([object_id]))
    + '.' + QUOTENAME(name) + ';'
    FROM sys.views
    WHERE name LIKE 'ws%';

--PRINT @sql;
EXEC sp_executesql @sql;


USE [020]
SELECT schema_name(schema_id), name FROM sys.tables AS V WHERE name LIKE 'ws%'


SELECT * FROM dbo.LicenseAttachments 
SELECT * FROM dbo.WiSysLicense 
SELECT * FROM dbo.wsCompaniesUpdater 
SELECT * FROM dbo.wsProductUpdater

