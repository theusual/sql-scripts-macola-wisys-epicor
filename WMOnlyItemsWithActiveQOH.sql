SELECT  distinct OL.item_no, IM.qty_on_hand
FROM    oelinhst_sql OL join oehdrhst_sql OH on OH.inv_no = OL.inv_no join Z_IMINVLOC IM on IM.item_no = OL.item_no
where inv_dt > '01/01/2009' and OL.item_no IN (SELECT item_no FROM Z_IMINVLOC WHERE qty_on_hand > 0) 
       and OL.prod_cat not in ('2', '036', '037', '336', '337', '102', '111','AP') 
       and OL.item_no not in (select item_no from oelinhst_sql where ltrim(cus_no) not in ('23033', '20938', '1575'))