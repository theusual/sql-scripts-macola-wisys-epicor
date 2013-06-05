--Pull Sales for KPB:

SELECT TOP 10000000 OH.Ord_No, inv_dt, 	OL.Item_No,	OL.Item_Desc_1,	qty_to_ship,	Unit_Price,	unit_price * qty_to_ship AS Total, 
	CASE WHEN OL.item_no IN ('KR1315290', 'KR1315252', 'KR1315290', 'KB1318610', 'KB1318553','KR1318801','KB1318800','KB1318609','KB1318609','KB1319964','KB1319968','KB1319965',			'KR1315292','KR1315291') THEN 'DEC' 
		 WHEN (OL.item_Desc_1 LIKE '%ENDCAP%' OR OL.item_desc_1 LIKE '%END CAP%') THEN 'MW' ELSE 'DEC' 
	END AS [MW/DEC]
FROM oehdrhst_sql OH JOIN dbo.oelinhst_sql OL ON OH.inv_no = OL.inv_no JOIN dbo.imitmidx_sql IM ON IM.item_no = OL.item_no 
WHERE IM.item_note_3 = 'KPB' --AND ord_dt_Billed > DATEADD(DAY,-7,GETDATE()) 
ORDER BY ord_Dt_billed DESC

--Pull board purchases for KPB decor:

SELECT job.job_desc, * FROM poordlin_sql PL JOIN dbo.jobfile_sql JOB ON JOB.job_no = PL.job_no WHERE item_no IN ('PETG-102',
'ULTRA-105',
'LAM-797',
'ULTRA-103',
'ULTRA-102',
'SINTRA-330',
'SINTRA-302',
'SINTRA-540') AND JOB.job_no IN ('9030', '8754', '8487', 'STOCK')


--Pull ink purchases for KPB

SELECT job.job_desc, * FROM poordlin_sql PL JOIN dbo.jobfile_sql JOB ON JOB.job_no = PL.job_no WHERE item_no IN ('INK-1044',
'INK-1045',
'INK-1046',
'INK-1047',
'INK-1050',
'INK-1060',
'INK-1061') AND JOB.job_no IN ('9030', '8754', '8487', 'STOCK')


--Pull Grimco charges

SELECT job.job_desc, * FROM poordlin_sql PL JOIN dbo.jobfile_sql JOB ON JOB.job_no = PL.job_no WHERE  JOB.job_no IN ('9030', '8754', '8487', 'STOCK')

SELECT * FROM dbo.oelinhst_sql OL JOIN dbo.oehdrhst_sql OH ON OH.inv_no = OL.inv_no WHERE  job_no IN ('9030', '8754', '8487', 'STOCK')