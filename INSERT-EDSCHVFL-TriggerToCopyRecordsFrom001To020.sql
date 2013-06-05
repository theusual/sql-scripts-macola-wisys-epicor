DECLARE @item AS Varchar(MAX)

--SET @item = 'EQUIP-100'

             --SELECT DISTINCT item_no, vend_no, vend_item_no FROM poordlin_sql WHERE not(item_no IN (SELECT item_no from poitmvnd_sql))
             
Insert Into [020].[dbo].[edcshvfl_sql] (code, cust_num, mac_ship_via, pay_type, carrier, id_scac_code, transport_type,misc_info_1, misc_num_info_1, misc_num_info_2, misc_info_3, misc_num_info_4, misc_num_info_5)
 
      Select Distinct code, cust_num, mac_ship_via, pay_type, carrier, id_scac_code, transport_type,misc_info_1, misc_num_info_1, misc_num_info_2, misc_info_3, misc_num_info_4, misc_num_info_5
      From [001].[dbo].[edcshvfl_sql]
      WHERE not(mac_ship_via IN (SELECT mac_ship_via from [020].[dbo].[edcshvfl_sql]))
 

      
