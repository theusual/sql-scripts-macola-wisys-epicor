SELECT DISTINCT user_def_fld_4 
FROM dbo.oehdrhst_sql AS OH
WHERE NOT(ship_instruction_2 like '%DISTRO%') AND NOT(OH.user_def_fld_4 like '%OG%')  /*exclude distros*/
AND NOT(ship_instruction_2 like '%TURE RE%') AND NOT(OH.user_def_fld_4 like '%ON%')  AND NOT(OH.user_def_fld_4 like '%FR%')  /*exclude FR's*/
AND NOT(ship_instruction_2 like '%REPLACEMENT%') AND NOT(OH.user_def_fld_4 like '%RP%')   /*exclude replacements*/
AND NOT(ship_instruction_1 like '%DISTRO%') 
AND NOT(ship_instruction_1 like '%TURE RE%') 
AND NOT(ship_instruction_1 like '%REPLACEMENT%')
AND NOT(OH.user_def_fld_4 like '%PH%') 
AND NOT(OH.user_def_fld_4 like '%SAMPLE%') 
AND NOT(OH.user_def_fld_4 = 'S')
AND NOT(OH.user_def_fld_4 like '%PR%')
AND ltrim(rtrim(OH.cus_no)) in ('1575','20938')
AND (OH.inv_dt > '7/22/11')