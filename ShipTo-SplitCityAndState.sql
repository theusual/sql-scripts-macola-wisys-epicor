SELECT substring(RTRIM(ship_to_addr_4), charindex(',',RTRIM(ship_to_addr_4))+2 , 2) as [STATE], substring(RTRIM(ship_to_addr_4), charindex(',',RTRIM(ship_to_addr_4))+5, len(RTRIM(ship_to_addr_4))) AS [ZIP], mfg_loc
FROM dbo.oehdrhst_sql AS OH
WHERE frt_pay_cd = 'P' AND inv_dt > '10/01/2010' AND orig_ord_type = 'O'

