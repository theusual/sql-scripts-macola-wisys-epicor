--BEFORE DOING ANY UPDATES, BEGIN A TRANSACTION AND VERIFY EVERYTHING UPDATED CORRECTLY BEFORE COMMITING

BEGIN TRAN

COMMIT TRAN

DECLARE @startOrd CHAR(8)
DECLARE @endOrd CHAR(8)

SET @startOrd = '  697843'
SET @endOrd = '  699047'


SELECT  *
FROM    oeordhdr_sql
where ord_no >= @startOrd and ord_no <= @endOrd

UPDATE oeordhdr_sql
SET shipping_dt = '2011-12-01 00:00:00.000'
where ord_no >= @startOrd  and ord_no <= @endOrd

UPDATE oeordhdr_sql
SET ship_instruction_1 = 'MA 1/31'
where ord_no >= @startOrd  and ord_no <= @endOrd

UPDATE oeordhdr_sql
SET ship_instruction_2 = 'DISTRO'
where ord_no >= @startOrd  and ord_no <= @endOrd

UPDATE oeordhdr_sql
SET ship_via_cd = 'YRC'
where ord_no >= @startOrd  and ord_no <= @endOrd

UPDATE oeordhdr_sql
SET ship_to_addr_3 = ''
where ord_no >= @startOrd  and ord_no <= @endOrd

--UPDATE oeordhdr_sql
--SET ship_to_name = 'CUSTOM DELI'
--where ord_no >= @startOrd  and ord_no <= @endOrd

UPDATE oeordhdr_sql
SET ship_to_addr_1 = 'PHARMACY OTC'
where ord_no >= @startOrd  and ord_no <= @endOrd

--UPDATE oeordhdr_sql
--SET ship_to_addr_2 = '153 N RIVERSIDE DR'
--where ord_no >= @startOrd  and ord_no <= @endOrd

--UPDATE oeordhdr_sql
--SET ship_to_addr_4 = 'FT WORTH, TX 76111'
--where ord_no >= @startOrd  and ord_no <= @endOrd

UPDATE oeordhdr_sql
SET frt_pay_cd = 'T'
where ord_no >= @startOrd  and ord_no <= @endOrd

UPDATE oeordhdr_sql
SET mfg_loc = 'MDC'
where ord_no >= @startOrd  and ord_no <= @endOrd

UPDATE oeordhdr_sql
SET user_def_fld_5 = 'CB'
where ord_no >= @startOrd  and ord_no <= @endOrd

UPDATE oeordhdr_sql
SET user_def_fld_4 = 'ZUS1,OG'
where ord_no >= @startOrd  and ord_no <= @endOrd

UPDATE oeordlin_sql
SET loc = 'MDC'
where ord_no >= @startOrd  and ord_no <= @endOrd

--UPDATE oeordlin_sql
--SET unit_price = 219.28
--where ord_no >= @startOrd  and ord_no <= @endOrd

--UPDATE oeordhdr_sql
--SET tax_cd = 'NON'
--where ord_no >= @startOrd  and ord_no <= @endOrd

--UPDATE oeordhdr_sql
--SET tax_pct = 0.0000
--where ord_no >= @startOrd  and ord_no <= @endOrd

--UPDATE oeordhdr_sql
--SET tax_cd_2 = null
--where ord_no >= @startOrd  and ord_no <= @endOrd

DELETE FROM OELINCMT_SQL
where LTRIM(ord_no) IN (SELECT LTRIM(ord_no) FROM [BG_backup].dbo.distro_110712)


--Update store specific fields by joining with the imported spreadsheet

UPDATE dbo.oeordhdr_sql
SET oeordhdr_sql.ship_via_cd = BG.[ship_via]
FROM [BG_backup].dbo.distro_110712 AS BG JOIN oeordhdr_sql ON LTRIM(BG.ord_no) = LTRIM(oeordhdr_Sql.ord_no)

UPDATE dbo.oeordhdr_sql
SET oeordhdr_sql.ship_to_addr_1= BG.ship_to_addr_1
FROM [BG_backup].dbo.distro_110712 AS BG JOIN oeordhdr_sql ON BG.ord_no = oeordhdr_Sql.ord_no

UPDATE dbo.oeordhdr_sql
SET oeordhdr_sql.ship_to_addr_2= BG.ship_to_addr_2
FROM [BG_backup].dbo.distro_110712 AS BG JOIN oeordhdr_sql ON BG.ord_no = oeordhdr_Sql.ord_no

UPDATE dbo.oeordhdr_sql
SET oeordhdr_sql.ship_to_addr_3= BG.[ship to addr 3]
FROM [BG_backup].dbo.distro_110712 AS BG JOIN oeordhdr_sql ON BG.ord_no = oeordhdr_Sql.ord_no

UPDATE dbo.oeordhdr_sql
SET oeordhdr_sql.ship_to_addr_4 = BG.[ship_to_addr_4]                  --[city] + ', ' + [state] + ' ' + CAST([zip] AS VARCHAR)
FROM [BG_backup].dbo.distro_110712 AS BG JOIN oeordhdr_sql ON BG.ord_no = oeordhdr_Sql.ord_no

UPDATE dbo.oeordhdr_sql
SET oeordhdr_sql.ship_to_name= BG.ship_to_name
FROM [BG_backup].dbo.distro_110712 AS BG JOIN oeordhdr_sql ON BG.ord_no = oeordhdr_Sql.ord_no

UPDATE dbo.oeordhdr_sql
SET oeordhdr_sql.user_Def_fld_5= BG.[initials]
FROM [BG_backup].dbo.distro_110712 AS BG JOIN oeordhdr_sql ON BG.ord_no = oeordhdr_Sql.ord_no

UPDATE dbo.oeordhdr_sql
SET oeordhdr_sql.user_Def_fld_4= BG.[MISC COMM 2]
FROM [BG_backup].dbo.distro_110712 AS BG JOIN oeordhdr_sql ON BG.ord_no = oeordhdr_Sql.ord_no

UPDATE dbo.oeordhdr_sql
SET oeordhdr_sql.user_Def_fld_3= BG.[MISC COMM 3]
FROM [BG_backup].dbo.distro_110712 AS BG JOIN oeordhdr_sql ON BG.ord_no = oeordhdr_Sql.ord_no

UPDATE dbo.oeordhdr_sql
SET oeordhdr_sql.user_Def_fld_2 = ''
FROM [BG_backup].dbo.distro_110712 AS BG JOIN oeordhdr_sql ON BG.ord_no = oeordhdr_Sql.ord_no

UPDATE dbo.oeordhdr_sql
SET oeordhdr_sql.frt_pay_cd = BG.[frt_pay_cd]
FROM [BG_backup].dbo.distro_110712 AS BG JOIN oeordhdr_sql ON BG.ord_no = oeordhdr_Sql.ord_no

UPDATE dbo.oeordhdr_sql
SET oeordhdr_sql.shipping_dt= '2012-11-26 00:00:00.000'
FROM [BG_backup].dbo.distro_110712 AS BG JOIN oeordhdr_sql ON BG.ord_no = oeordhdr_Sql.ord_no

UPDATE dbo.oeordhdr_sql
SET oeordhdr_sql.ship_instruction_1= BG.[ship_instruction_1]
FROM [BG_backup].dbo.distro_110712 AS BG JOIN oeordhdr_sql ON BG.ord_no = oeordhdr_Sql.ord_no


UPDATE dbo.oeordhdr_sql
SET oeordhdr_sql.ship_instruction_2= BG.[ship_instruction_2]
FROM [BG_backup].dbo.distro_110712 AS BG JOIN oeordhdr_sql ON BG.ord_no = oeordhdr_Sql.ord_no

UPDATE dbo.oeordhdr_sql
SET oeordhdr_sql.mfg_loc = 'MS'
FROM [BG_backup].dbo.distro_110712 AS BG JOIN oeordhdr_sql ON BG.ord_no = oeordhdr_Sql.ord_no

UPDATE dbo.oeordlin_sql
SET dbo.oeordlin_sql.loc = 'MS'
FROM [BG_backup].dbo.distro_110712 AS BG JOIN oeordlin_Sql ON BG.ord_no = dbo.oeordlin_sql.ord_no


UPDATE dbo.oeordlin_sql
SET dbo.oeordlin_sql.unit_price = BG.unit_price
FROM [BG_backup].dbo.distro_110712 AS BG JOIN oeordlin_Sql ON BG.ord_no = dbo.oeordlin_sql.ord_no AND BG.item_no = oeordlin_Sql.item_no


--Check an order for errors

SELECT ship_to_addr_4, [city] + ', ' + [state] + ' ' + CAST([zip] AS VARCHAR), city, STATE, zip, * FROM oeordhdr_sql OH JOIN [BG_backup].dbo.wm_distro_10_1 BG ON BG.ord_no = OH.ord_no WHERE OH.ord_no = BG.ord_no

 SELECT * FROM oeordlin_sql WHERE ord_no = '  700473'
 
 SELECT * FROM oeordhdr_sql WHERE ord_no = '  700473'

SELECT * FROM oehdrhst_sql WHERE inv_no = '  508133'

SELECT * FROM OELINCMT_SQL WHERE ord_no = '  700473'

SELECT * FROM [BG_Backup].dbo.distro_110712

UPDATE dbo.oehdrhst_sql
SET ship_to_name = 'ACADEMY SPORTS & OUTDOORS 165'
WHERE inv_no = '  508133'
