BEGIN TRAN

SELECT top(20) case when bill_to_name like '%roger%' then 'KROGER'
					when ltrim(oh.cus_no) in ('306','323','339','389','391','398','399','501','503','22585',
'988','22580','9312','22578','22597','1130','22561','354',
'349','806','809','867','875','879','880','883',
'885','6730','8357','400','23123','22655','988','4201',
'9312','845','8124','1130','1350') then 'KROGER'
                    else bill_to_name
               end as [Customer], sum(oh.tot_sls_amt) as [slstotal], max(ar.cus_name), MAX(OH.cus_no), MAX(OH.ord_no)
FROM    oehdrhst_sql oh join arcusfil_sql ar on ar.cus_no = oh.cus_no
where inv_dt > '01/01/2013' AND inv_dt < '12/31/2013'
group by case when bill_to_name like '%roger%' then 'KROGER'
	          when LTRIM(oh.cus_no) IN ('306','323','339','389','391','398','399','501','503','22585',
'988','22580','9312','22578','22597','1130','22561','354',
'349','806','809','867','875','879','880','883',
'885','6730','8357','400','23123','22655','988','4201',
'9312','845','8124','1130','1350') then 'KROGER'
                    else bill_to_name
         end
order by SUM(tot_sls_amt) desc

ROLLBACK