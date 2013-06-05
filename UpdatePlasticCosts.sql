BEGIN TRAN

--Last run on 12/20/2011
UPDATE iminvloc_sql
SET last_cost = (std_cost*1.4), avg_cost = (std_cost*1.4), std_cost = (std_cost*1.4)
where iminvloc_sql.prod_cat IN ('1','25') AND item_no in (SELECT  item_no
                                                  FROM    imitmidx_sql 
                                                  WHERE activity_dt > '07/25/2011')
                                                  
   SELECT  *
   FROM    iminvloc_sql
   where iminvloc_sql.prod_cat IN ('1','25') AND item_no not in (SELECT  item_no
                                                  FROM    tmp_old_mfg_items)
                                                  
                                                  SELECT  *
                                                  from iminvloc_sql
                                                  where item_no = 'VEG-67DR BK'
                                                  
SELECT  *
FROM   imitmidx_sql
where prod_cat IN ('1','25') AND activity_dt > '2010-01-01 00:00:00.000'

SELECT  *
FROM   tmp_old_mfg_items
where prod_cat IN ('1','25')
ORDER BY activity_dt DESC