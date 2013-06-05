Use [001]
UPDATE
                  iminvloc_sql
SET
                  price =     (ol.unit_price * 1.5)
                  
FROM  oelinhst_sql ol, iminvloc_sql

where iminvloc_sql.item_no = ol.item_no
      and   iminvloc_sql.item_no in
                        (
                              select distinct ol.item_no
                              from oelinhst_sql ol, oehdrhst_sql oh
                              where ol.ord_no = oh.ord_no
                              and LTRIM(oh.cus_no) = '1575'
                              and oh.inv_dt > DATEADD(year, - 1, GETDATE())
                        )
      and   iminvloc_sql.price < (ol.unit_price * 1.5)
