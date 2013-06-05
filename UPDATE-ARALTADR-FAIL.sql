 --OE Alt Adr 
  SELECT COUNT(*)
  FROM [001].[dbo].[araltadr_sql]
  WHERE cus_no like '%122523%'
  
  SELECT COUNT(*)
  FROM [020].[dbo].[araltadr_sql]
  WHERE cus_no like '%122523%'
  --
     Insert Into [020].[dbo].[araltadr_sql] (cus_no, cus_alt_adr_cd, cus_name, addr_1, addr_2, addr_3, city, state, zip, country, ups_zone, tax_cd, tax_cd_2, tax_cd_3, tax_sched, slspsn_no, phone_no, ship_via_cd, loc, user_def_fld_1, user_def_fld_2, user_def_fld_3, user_def_fld_4)
 
      Select Distinct cus_no, cus_alt_adr_cd, cus_name, addr_1, addr_2, addr_3, city, state, zip, country, ups_zone, tax_cd, tax_cd_2, tax_cd_3, tax_sched, slspsn_no, phone_no, ship_via_cd, loc, user_def_fld_1, user_def_fld_2, user_def_fld_3, user_def_fld_4
      From [001].[dbo].[araltadr_sql]
      WHERE not((cus_alt_adr_cd + cus_no) IN (SELECT (cus_alt_adr_cd + cus_no) from [020].[dbo].[oecusitm_sql]))