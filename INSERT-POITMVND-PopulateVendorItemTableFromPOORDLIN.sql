DECLARE @item AS Varchar(MAX)

--SET @item = 'EQUIP-100'

             --SELECT DISTINCT item_no, vend_no, vend_item_no FROM poordlin_sql WHERE not(item_no IN (SELECT item_no from poitmvnd_sql))
             
 Insert Into POITMVND_SQL (item_no, vend_no, curr_cd, vend_item_no, tolerance_cd)
      Select Distinct item_no, vend_no, 'USD', '', ''
 
      From poordlin_sql
      WHERE not(item_no IN (SELECT item_no from poitmvnd_sql))
      
      --SELECT * FROM poitmvnd_sql
      
