SELECT prproject.id, prproject.ProjectNr, cicmpy.cmp_name
FROM PRProject LEFT OUTER JOIN cicmpy ON cicmpy.cmp_wwn = prproject.IDCustomer 
WHERE prproject.status IN ('A','P') 

SELECT job_no, * FROM dbo.poordhdr_sql PH JOIN dbo.poordlin_sql PL ON PL.ord_no = PH.ord_no JOIN dbo.PRProject ON PL.job_no = dbo.PRProject.ProjectNr