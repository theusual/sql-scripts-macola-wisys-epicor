SELECT humres.BackOfficeBlocked, humres.fullname, humres.emp_type, humres.emp_stat, humres.telnr_werk, humres.toestel, humres.telnr_werk2, humres.res_id, hrjbtl.descr50, humres.MainLoc, humres.ID AS ID, humres.sur_name, humres.first_name, humres.middle_name, humres.initialen, humres.mv1, humres.iso_taalcd, humres.mail, humres.faxnr, humres.kamer, humres.funcnivo, humres.ldatindienst, humres.ldatuitdienst, humres.usr_id, humres.repto_id, humres.nat, humres.buyer, humres.representative, humres.maiden_name, humres.prafd_code, humres.job_level, humres.payempl, humres.kstdr_code, humres.predcode, kstpl.oms25_0, humres.assistant, humres.statecode, humres.sysmodified, humres.sysmodifier 
FROM humres LEFT OUTER JOIN hrjbtl ON hrjbtl.job_title = humres.job_title LEFT JOIN kstpl ON humres.costcenter = kstpl.kstplcode 
WHERE (emp_type IN('E','C','S','T')) AND  (emp_stat IN('A')) AND humres.res_id >0 AND BackOfficeBlocked = '0'
ORDER BY ldatindienst desc

--Count active users in Marco
SELECT COUNT (*) 
FROM dbo.humres
WHERE BackOfficeBlocked = '0'

--Count active users in Infiniti
SELECT COUNT (*) 
FROM [020].dbo.humres
WHERE BackOfficeBlocked = '0'

--Count active users in Infiniti
SELECT COUNT (*) 
FROM [050].dbo.humres
WHERE BackOfficeBlocked = '0'



