--First, count the tables to verify if they need to be purged

 --5,303,217 as of 8/30/11.  164,484 as of 8/31/11 after purge.  921,666 as of 1/21/13.  268,743 after purge 1/21/2013.
SELECT  COUNT(*)  
--INTO  [BG_BACKUP].[dbo].[iminvtrx_012113]
FROM    iminvtrx_sql

--3,144,738 as of 8/30/11.   197,100 as of 8/31/11 after purge.  232,895 as of 1/21/2013.  15,076 after purge 1/21/2013.
SELECT  COUNT(*)  
--INTO  [BG_BACKUP].[dbo].[iminvaud_012113] 
FROM    iminvaud_sql

--864,691 as of 8/30/11.  188,959 as of 8/31/11 after purge. 986,167 as of 1/21/2013. 270,410 after purge 1/21/2013.
SELECT  COUNT(*)  
--INTO  [BG_BACKUP].[dbo].[oehdraud_012113]
FROM    oehdraud_sql

--1,192,480 as of 8/30/11.  386,305 as of 8/31/11 after purge.  2,363,958 as of 1/21/2013. 855,972 after purge 1/21/2013.
SELECT  COUNT(*) 
--INTO  [BG_BACKUP].[dbo].[oelinaud_012113]
FROM    oelinaud_sql

-- 252,075 as of 8/30/11.  252,774 as of 8/31/11 after purge. 459,282 as of 1/21/2013. 68,734  after purge 1/21/2013.
SELECT  COUNT(*) 
--INTO  [BG_BACKUP].[dbo].[polinaud_012113] 
FROM    polinaud_sql

-- 52,075 as of 8/30/11.  13,734 as of 8/31/11 after purge.  65,583 as of 1/21/2013. 17,844 after purge 1/21/2013.
SELECT  COUNT(*) 
--INTO  [BG_BACKUP].[dbo].[pohdraud_012113] 
FROM    pohdraud_sql

-- 950,371 as of 8/30/11. 280,007 as of 8/31/11 after purge.  872,476 as of 1/21/2013.  454,028 after purge 1/21/2013.
SELECT  COUNT(*)  
--INTO  [BG_BACKUP].[dbo].[imdisfil_012113] 
FROM    imdisfil_sql

--Table that holds BOM data for invoiced orders.  This is how Macola tracks the BOM for an order which contains non-stocked items. Rather than referring in real-time to the bmpstdr table, it takes a snapshot of the BOM at the time the order is entered and places that snapshot into the IMORDHST table
-- 2,378,287 as of 8/30/11.  943,625 as of 8/31/11 after purge.  958,111 as of 1/21/13. 
SELECT  *--COUNT(*) 
--INTO  [BG_BACKUP].[dbo].[imordhst_012113]  
FROM    imordhst_sql

-- 924,165 as of 8/30/11.  354,967 as of 8/31/11 after purge.  519,448 as of 1/21/13. 322,997 after purge.
SELECT  *--COUNT(*) 
--INTO  [BG_BACKUP].[dbo].[OESLSHST_012113] 
FROM    OESLSHST_SQL

-- 311,087 as of 8/30/11.  219,226 as of 8/31/11 after purge. 1,133,687 as of 1/21/13. 360,132 after purge. 
SELECT  *--COUNT(*) 
--INTO  [BG_BACKUP].[dbo].[OECMTHST_012113] 
FROM    OECMTHST_SQL

--Obsolete table that is no longer in use by Macola, but still gets populated with data
--1,052,219 as of 8/30/11.   22 as of 8/31/11 after purge. 11,885 as of 1/21/13.  0 after purge.
SELECT  *--COUNT(*)  
--INTO  [BG_BACKUP].[dbo].[imprdbal_012113] 
FROM    imprdbal_sql

--IMINVHST_SQL?

--Second, insert the records to be deleted into the table archive found in the BG_BACKUP database

--GO
--select *
--INTO  [BG_BACKUP].[dbo].[iminvtrx_sql_full_8_30_2011]
--from  [001].[dbo].[iminvtrx_sql]

--GO
--select *
--INTO  [BG_BACKUP].[dbo].[oehdraud_sql_full_8_30_2011]
--from  [001].[dbo].[oehdraud_sql]

 
--GO
--select *
--INTO  [BG_BACKUP].[dbo].[oelinaud_sql_full_8_30_2011]
--from  [001].[dbo].[oelinaud_sql]

--GO
--select *
--INTO  [BG_BACKUP].[dbo].[polinaud_sql_full_8_30_2011]
--from  [001].[dbo].[polinaud_sql]

--GO
--select *
--INTO  [BG_BACKUP].[dbo].[pohdraud_sql_full_8_30_2011]
--from  [001].[dbo].[pohdraud_sql]

--GO
--select *
--INTO  [BG_BACKUP].[dbo].[pohdraud_sql_full_8_30_2011]
--from  [001].[dbo].[imordhst_sql]

--GO
--select *
--INTO [BG_BACKUP].[dbo].[oeslshst_sql_full_8_30_2011]
--from [001].[dbo].[OESLSHST_SQL]

--GO 
--select *
--INTO [BG_BACKUP].[dbo].[oecmthst_sql_full_8_30_2011]
--from [001].[dbo].[OECMTHST_SQL]

--GO
--select *
--INTO [BG_BACKUP].[dbo].[iminvaud_sql_full_8_30_2011]
--from [001].[dbo].[iminvaud_SQL]

--GO
--select *
--INTO [BG_BACKUP].[dbo].[imprdbal_sql_full_8_30_2011]
--from [001].[dbo].[imprdbal_sql]

--Third, purge the older records from the tables

GO
DELETE FROM iminvtrx_sql
WHERE trx_dt < '2012-08-01 00:00:00.000'

GO
DELETE FROM iminvaud_sql
where aud_dt < '2012-08-01 00:00:00.000'

GO
DELETE FROM oelinaud_sql
where aud_dt < '2012-08-01 00:00:00.000'

GO
DELETE FROM oehdraud_sql
where aud_dt < '2012-08-01 00:00:00.000'

GO
DELETE FROM polinaud_sql
where aud_dt < '2012-08-01 00:00:00.000'

GO
DELETE FROM pohdraud_sql
where poha_system_date < '2012-08-01 00:00:00.000'

GO
DELETE FROM imordhst_sql
where system_dt < '2010-01-01 00:00:00.000'

--Done
GO
DELETE FROM    OESLSHST_SQL
where hst_year < 2010

GO
DELETE FROM    OECMTHST_SQL
WHERE real_ord_no NOT in (select ord_no from oehdrhst_sql where inv_dt > '08/01/2012')

GO
DELETE FROM    imprdbal_sql

--Lastly, run IMDISFIL purge under System tools in Macola.

--Rebuilding of indexes will occur at night when the daily maintenance job is run










