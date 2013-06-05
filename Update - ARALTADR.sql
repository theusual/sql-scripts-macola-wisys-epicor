SELECT * FROM dbo.arcusfil_sql WHERE slspsn_no = 4

SELECT DISTINCT cus_no FROM dbo.oehdrhst_sql WHERE slspsn_no = 4

SELECT  DISTINCT zip, [code 2], city, * FROM [BG_backup].dbo.[WMNCStoreList]

SELECT * FROM dbo.araltadr_sql
WHERE zip+city IN (SELECT CONVERT(VARCHAR, cus_alt_adr_cd) FROM [BG_Backup].dbo.[WMNCStoreList]) AND LTRIM(cus_no) = '1575'

SELECT * FROM araltadr_Sql

UPDATE araltadr_Sql 
SET tax_cd_2 = [code 2]
FROM dbo.araltadr_sql , [BG_Backup].dbo.[WMNCStoreList] WM
WHERE dbo.araltadr_sql.city = WM.city AND dbo.araltadr_sql.city IN (SELECT CONVERT(varchar,city) FROM [BG_Backup].dbo.[WMNCStoreList] WHERE cus_alt_adr_cd IS null) AND LTRIM(ARALTADR_SQL.cus_no) = '1575' AND tax_cd_2 IS NULL AND dbo.araltadr_sql.cus_alt_adr_cd != ' 5787'

SELECT DISTINCT dbo.araltadr_sql.cus_alt_adr_cd, tax_cd_2
FROM dbo.araltadr_sql , [BG_Backup].dbo.[WMNCStoreList] WM
WHERE dbo.araltadr_sql.city = WM.city AND dbo.araltadr_sql.city IN (SELECT CONVERT(varchar,city) FROM [BG_Backup].dbo.[WMNCStoreList] WHERE cus_alt_adr_cd IS null) AND LTRIM(ARALTADR_SQL.cus_no) = '1575' --AND tax_cd_2 IS NULL AND dbo.araltadr_sql.cus_alt_adr_cd != ' 5787'