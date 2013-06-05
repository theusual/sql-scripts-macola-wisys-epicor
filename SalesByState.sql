SELECT   --substring(OH.ship_to_addr_4, 1, (charindex(',', OH.ship_to_addr_4) - 1)) AS [Ship to City], 
          substring(OH.ship_to_addr_4, (charindex(',', OH.ship_to_addr_4) + 2), 2) AS [Ship to State], 
          --CASE WHEN OH.ship_to_addr_4 like '%-%' THEN RIGHT(rtrim(OH.ship_to_addr_4), 10) ELSE RIGHT(rtrim(OH.ship_to_addr_4), 6) END AS [Zip], 
          SUM(OH.tot_sls_amt) AS [TotSlsBySt]
FROM    oehdrhst_sql OH --JOIN oelinhst_sql OL on OH.inv_no = OL.inv_no
where inv_dt > '01/01/2010' AND inv_dt < '12/31/2010' AND OH.ship_to_addr_4 LIKE '%,%' AND ship_to_country = 'US'
GROUP BY substring(OH.ship_to_addr_4, (charindex(',', OH.ship_to_addr_4) + 2), 2)