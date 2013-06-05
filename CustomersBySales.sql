
SELECT max(cus_no), case when [cus_name] like '%roger%' then 'KROGER' 
	              when LTRIM(Customer) IN ('880','400', '988', '4201', '845', '8124', '1350','22585', '23123', '22655', '988', '22580', '9312', '22578', '22597', '1130', '22561', '354') then 'KROGER'  
                  when LTRIM(Customer) IN ('22523','1575', '11575', '20938','122523') THEN 'WAL-MART'
                  when ltrim(Customer) in ('13','3090') THEN 'GIANT EAGLE'
                  else ltrim(cus_name) END AS [CUS NAME], YEAR([invoice date]) AS [YEAR], SUM(CALC) AS [SlsTotal]
	FROM Z_SALES_HISTORY_ALLYEARS_TOTALS  OH join arcusfil_sql ar on ar.cus_no = oh.customer
	WHERE LTRIM(Customer)IN ('1575', '11575', '20938','122523','22372','1100','22056','255','23818','7459','22418','1108','980','22372','880','400', '988', '4201', '845', '8124', '1350','22585', '23123', '22655', '988', '22580', '9312', '22578', '22597', '1130', '22561', '354','23154','1565','110','3090','13','22056','7158','23818','23154','7459','1100','2255','22418','1108','22502') 
	group by YEAR([invoice date]), case when [cus_name] like '%roger%' then 'KROGER' 
	              when LTRIM(Customer) IN ('880','400', '988', '4201', '845', '8124', '1350','22585', '23123', '22655', '988', '22580', '9312', '22578', '22597', '1130', '22561', '354') then 'KROGER'  
                  when LTRIM(Customer) IN ('22523','1575', '11575', '20938','122523') THEN 'WAL-MART'
                  when ltrim(Customer) in ('13','3090') THEN 'GIANT EAGLE'
                  else ltrim(cus_name)
             END
    order by SUM(calc) desc
