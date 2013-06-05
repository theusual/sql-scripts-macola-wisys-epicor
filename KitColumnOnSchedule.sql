

SELECT z.item_no, im.item_desc_1, IM.item_desc_2, im.prod_cat
FROM  Z_IMINVLOC_ACCUMULATORS_AND_COSTS AS Z INNER JOIN IMITMIDX_SQL AS IM ON IM.item_no = Z.item_no
WHERE z.item_no IN (SELECT item_no 
FROM POORDLIN_SQL 
WHERE not(item_no IN 
     (SELECT item_no 
       FROM bmprdstr_sql)))
OR  z.item_no IN 
(SELECT item_no 
FROM POLINHST_SQL
WHERE not(item_no IN 
     (SELECT item_no 
       FROM bmprdstr_sql)))
       
       SELECT *
       FROM oeordhdr_sql
       WHERE not (ship_to_addr_3 is null)




