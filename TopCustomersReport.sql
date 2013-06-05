--Year By Year Sales For Customer Above $500,000

SELECT case when ar.cus_name like '%roger%' then 'KROGER'
					when ltrim(oh.cus_no) in ('880','400', '988', '4201', '845', '8124', '1350','22585', '23123', '22655', '988', '22580', '9312', '22578', '22597', '1130', '22561', '354') then 'KROGER'
                    when LTRIM(oh.cus_no) IN ('1575', '11575', '20938','122523') THEN 'WAL-MART'
                    when ltrim(oh.cus_no) in ('13','3090') THEN 'GIANT EAGLE'
                   -- when LTRIM(oh.cus_no) = '123' THEN 'WAL-MART  REPLACEMENT BUSINESS'
                    else  ar.cus_name
               end as [Customer], case when year(inv_dt) = '2011' then sum(oh.tot_sls_amt)*1.8
								       --when MAX(ltrim(oh.cus_no)) = '123' THEN '14000000'
									   --when MAX(LTRIM(oh.cus_no)) IN ('1575', '11575', '20938','122523') THEN '15000000'
                                       ELSE sum(oh.tot_sls_amt) 
                                  END as [slstotal],  YEAR(inv_dt) AS [Year]
FROM    Z_SALES_HISTORY_2011 oh join arcusfil_sql ar on ar.cus_no = oh.Customer
where ltrim(oh.cus_no) IN 
	(SELECT max(ltrim(customer)), max([Cus_Name])
	FROM Z_SALES_HISTORY_2011_TOTALS  OH join arcusfil_sql ar on ar.cus_no = oh.customer
	group by case when [cus_name] like '%roger%' then 'KROGER' 
	              when LTRIM(Customer) IN ('880','400', '988', '4201', '845', '8124', '1350','22585', '23123', '22655', '988', '22580', '9312', '22578', '22597', '1130', '22561', '354') then 'KROGER'  
                  when LTRIM(Customer) IN ('1575', '11575', '20938','122523') THEN 'WAL-MART'
                  when ltrim(Customer) in ('13','3090') THEN 'GIANT EAGLE'
                  else ltrim(Customer)
             END
    HAVING SUM(calc) > 500000
    order by SUM(calc) desc) --and ar.cus_name NOT IN('MARSH SUPERMARKETS', 'INGLES', 'SUPERVALU-EQUIPMENT SERVICES','venger impression program','wakefern food corp.','associated food stores inc.','brookshire grocery company','hannaford brothers co', 'harris-teeter inc','INFINITI DECOR','national refrigeration','trinity industrial inc','unimarc/corp group') 
                                    --   and ar.cus_name not like 'AFFILIATED FOODS%' and ar.cus_name not like 'INFINITI%'  and ar.cus_name not like 'associated whlsl%'  and  ar.cus_name not like 'meijer%'
                             or LTRIM(Customer)IN ('1575', '11575', '20938','122523','22372','1100','22056','255','23818','7459','22418','1108','980','22372','880','400', '988', '4201', '845', '8124', '1350','22585', '23123', '22655', '988', '22580', '9312', '22578', '22597', '1130', '22561', '354','23154') 
                             or ar.cus_name like '%roger%'
group by YEAR(inv_dt), case when ar.cus_name like '%roger%' then 'KROGER'
	          when LTRIM(Customer) IN ('880','400', '988', '4201', '845', '8124', '1350','22585', '23123', '22655', '988', '22580', '9312', '22578', '22597', '1130', '22561', '354') then 'KROGER'  
              when LTRIM(Customer) IN ('1575', '11575', '20938','122523') THEN 'WAL-MART'
              when ltrim(Customer) in ('13','3090') THEN 'GIANT EAGLE'
              --when LTRIM(oh.cus_no) = '123' THEN 'WAL-MART  REPLACEMENT BUSINESS'
              else ar.cus_name
          END
order by (case when ar.cus_name like '%roger%' then 'KROGER'
	          when LTRIM(oh.cus_no) IN ('880','400', '988', '4201', '845', '8124', '1350','22585', '23123', '22655', '988', '22580', '9312', '22578', '22597', '1130', '22561', '354') then 'KROGER'  
              when LTRIM(oh.cus_no) IN ('1575', '11575', '20938','122523') THEN 'WAL-MART'
              when ltrim(oh.cus_no) in ('13','3090') THEN 'GIANT EAGLE'
              --when LTRIM(oh.cus_no) = '123' THEN 'WAL-MART  REPLACEMENT BUSINESS'
              else ar.cus_name
              end), YEAR(inv_dt) desc   --when max(ltrim(oh.cus_no)) ='123' THEN '14000000'
				--when max(LTRIM(oh.cus_no)) IN ('1575', '11575', '20938','122523') THEN '15000000'
                                      -- ELSE sum(oh.tot_sls_amt) 
                                 -- END desc




--Top 25 Query for Pie Chart
SELECT top(20) case  when [ar].cus_name like '%roger%' then 'KROGER'
				     when ltrim(Customer) in ('400', '988', '4201', '845', '8124', '1350','22585', '23123', '22655', '988', '22580', '9312', '22578', '22597', '1130', '22561', '354') then 'KROGER'
                     when LTRIM(customer) IN ('1575','11575','20938','122523') THEN 'WAL-MART'
                     else [Cus_name]
               end as [Customer], sum(Calc) as [slstotal]
FROM    z_sales_history_2010_totals oh join arcusfil_sql ar on ar.cus_no = oh.customer
where [Invoice Date] > '01/01/2010' and [Invoice Date] < '07/15/2010'
group by case when [ar].cus_name like '%roger%' then 'KROGER'
			  when LTRIM(customer) IN ('400', '988', '4201', '845', '8124', '1350','22585', '23123', '22655', '988', '22580', '9312', '22578', '22597', '1130', '22561', '354') then 'KROGER'  
              when LTRIM(customer) IN ('1575','11575','20938','122523') THEN 'WAL-MART'
              else [cus_name]
          END
order by SUM(Calc) desc

--Sales Goal Report Query
SELECT top(20) case when [Bill To] like '%roger%' then 'KROGER'
					when ltrim(Customer) in ('400', '988', '4201', '845', '8124', '1350','22585', '23123', '22655', '988', '22580', '9312', '22578', '22597', '1130', '22561', '354') then 'KROGER'
                    when LTRIM(Customer) IN ('1575', '11575', '20938','122523') THEN 'WAL-MART'
                    when LTRIM(Customer) = '123' THEN 'WAL-MART  REPLACEMENT BUSINESS'
                    else [Bill To]
               end as [Customer], case when MAX(ltrim(Customer)) = '123' THEN '14000000'
									   when MAX(LTRIM(Customer)) IN ('1575', '11575', '20938','122523') THEN '15000000'
                                       ELSE sum([Total Sales Amt])*2 
                                  END as [slstotal]
FROM    Z_SALES_HISTORY_2011 oh
group by case when [Bill To] like '%roger%' then 'KROGER'
	          when LTRIM(Customer) IN ('400', '988', '4201', '845', '8124', '1350','22585', '23123', '22655', '988', '22580', '9312', '22578', '22597', '1130', '22561', '354') then 'KROGER'  
              when LTRIM(Customer) IN ('1575', '11575', '20938','122523') THEN 'WAL-MART'
              when LTRIM(Customer) = '123' THEN 'WAL-MART  REPLACEMENT BUSINESS'
              else [Bill To]
          END
order by case when max(ltrim(Customer)) ='123' THEN '14000000'
				when max(LTRIM(Customer)) IN ('1575', '11575', '20938','122523') THEN '15000000'
                                       ELSE sum([Total Sales Amt]) 
                                  END desc