SELECT IM.item_no, IM.item_desc_1, IM.item_desc_2, IL.sls_price, IM.item_weight 
FROM dbo.imitmidx_sql IM JOIN dbo.z_iminvloc IL ON IL.item_no = IM.item_no 
WHERE IM.item_desc_1 LIKE '%FLORAL CONE%' OR IM.item_desc_2 LIKE '%FLORAL CONE%'