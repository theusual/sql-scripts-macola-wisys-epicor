SELECT  RIGHT(cus.cus_no,3) AS Cus_No,  Cus_Name,
	       CASE WHEN LastYrSls.LastYearSales is null THEN 0
	            ELSE LastYrSls.LastYearSales
	       END AS [Prior_Yr_Sales], 
	       CASE WHEN YTD.YTDSales is null THEN 0
	            ELSE YTD.YTDSales
	       END AS [YTD_Sales]   
FROM    arcusfil_sql CUS
		LEFT OUTER JOIN
         (SELECT  oh.cus_no, CAST(SUM(ol.sls_amt) AS MONEY) AS LastYearSales
		 FROM    oehdrhst_sql OH join oelinhst_sql OL on ol.inv_no = oh.inv_no
		 where YEAR(CONVERT(varchar(24), CAST(RTRIM(oh.inv_dt) AS datetime), 101)) = (YEAR(DATEADD(year, -1, (GETDATE()))))
		 GROUP BY oh.cus_no) AS LastYrSls
			ON LastYrSls.cus_no = CUS.cus_no
		LEFT OUTER JOIN
		 (SELECT  oh.cus_no, CAST(SUM(ol.sls_amt) AS MONEY) AS YTDSales
		 FROM    oehdrhst_sql OH join oelinhst_sql OL on ol.inv_no = oh.inv_no
		 where YEAR(CONVERT(varchar(24), CAST(RTRIM(oh.inv_dt) AS datetime), 101)) = (YEAR(GETDATE()))
		 GROUP BY OH.cus_no) AS YTD
		    ON YTD.cus_no = CUS.cus_no
		LEFT OUTER JOIN
		 (SELECT  oh.cus_no, CAST(SUM(ol.sls_amt) AS MONEY) AS MTDSales
		 FROM    oehdrhst_sql OH join oelinhst_sql OL on ol.inv_no = oh.inv_no
		 where YEAR(CONVERT(varchar(24), CAST(RTRIM(oh.inv_dt) AS datetime), 101)) = (YEAR(GETDATE()))
		 GROUP BY OH.cus_no) AS MTD
		    ON MTD.cus_no = CUS.cus_no
WHERE LastYearSales > 0 or YTDSales > 0
		 
		 
		 

SELECT  RIGHT(cus.cus_no,3) AS Cus_No,  Cus_Name, ol.sls_amt, YEAR(CONVERT(varchar(24), CAST(RTRIM(oh.inv_dt) AS datetime), 101)) AS inv_yr, MONTH(CONVERT(varchar(24), CAST(RTRIM(oh.inv_dt) AS datetime), 101)) AS inv_mo,  qty_to_ship as [Lbs]
FROM    oelinhst_Sql ol join oehdrhst_Sql oh on oh.inv_no = ol.inv_no join arcusfil_Sql cus on cus.cus_no = oh.cus_no
WHERE inv_dt > '20090101'
