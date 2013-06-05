SELECT job.job_desc, * FROM poordlin_sql PL LEFT OUTER JOIN dbo.jobfile_sql JOB ON JOB.job_no = PL.job_no WHERE item_no IN ('PETG-102',
'ULTRA-105',
'LAM-797',
'ULTRA-103',
'ULTRA-102',
'SINTRA-330',
'SINTRA-302',
'SINTRA-540',
'ADH-601')

SELECT * FROM dbo.poordlin_sql WHERE item_no LIKE 'ADH%'

SELECT * FROM dbo.jobfile_sql

SELECT job.job_desc, * FROM poordlin_sql PL JOIN dbo.jobfile_sql JOB ON JOB.job_no = PL.job_no WHERE (item_no IN ('PETG-102',
'ULTRA-105',
'LAM-797',
'ULTRA-103',
'ULTRA-102',
'SINTRA-330',
'SINTRA-302',
'SINTRA-540') OR item_no LIKE 'ADH%' )
AND JOB.job_no IN ('9030', '8754', '8487', 'STOCK')