SELECT  *
FROM    imitmidx_sql
where stocked_fg = 'N'

SELECT  *
FROM    bmprdstr_sql join iminvloc_sql on iminvloc_sql.item_no = bmprdstr_sql.comp_item_no
where bmprdstr_sql.item_no = 'AP-POS 54X20 GA'     and iminvloc_Sql.loc = 'MDC'    

SELECT  *
FROM    oeordlin_sql
where ord_no = '99999998'   

SELECT  *
FROM    araltadr_sql
where ltrim(cus_alt_adr_cd) = '1324'

SELECT  *
FROM    edcshtfl_sql

exec bgSearchTablesForColumn 'loc'

SELECT  *
FROM    edcctlfl_sql

SELECT  alt_location, *
FROM    edcshtfl_sql

SELECT  *
FROM    edcitmfl_sql

SELECT  *
FROM    arcusfil_sql
where loc = 'NE'

update  edcshtfl_sql
SET lit_default_loc_3 = 'MDC'


SELECT  warehouse, Location, LocationShort, *
FROM    cicmpy cc JOIN addresses ad ON cc.cmp_wwn = ad.account
WHERE cmp_name LIKE '%WAL-MART CANADA%' AND LTRIM(cmp_code) != '22056' AND type = 'del' AND (AD.AddressCode IS NOT NULL) AND (debcode IS NOT NULL)

SELECT warehouse
FROM dbo.Addresses AS AD

UPDATE dbo.Addresses
SET warehouse = 'CAN'
FROM    cicmpy cc JOIN addresses ad ON cc.cmp_wwn = ad.account
WHERE cmp_name LIKE '%WAL-MART CANADA%' AND LTRIM(cmp_code) != '22056' AND type = 'del' AND (AD.AddressCode IS NOT NULL) AND (debcode IS NOT NULL)

