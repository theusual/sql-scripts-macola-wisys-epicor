USE [001]
SELECT RTRIM(imitmidx_sql.item_no), iminvloc_sql.loc, iminvloc_sql.prod_cat, qty_on_hand, qty_allocated, qty_on_ord, usage_ytd, prior_year_usage, imitmidx_sql.item_desc_1, imitmidx_sql.item_desc_2
FROM iminvloc_sql INNER JOIN imitmidx_sql on iminvloc_sql.item_no = imitmidx_sql.item_no
WHERE len(rtrim(imitmidx_sql.item_no)) > 15 and activity_cd = 'A'