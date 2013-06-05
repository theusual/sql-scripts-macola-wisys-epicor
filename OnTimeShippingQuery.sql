
 SELECT DISTINCT CASE WHEN ord_dt_shipped is null then (DATEDIFF(day,OH.shipping_dt, inv_dt))
                      ELSE  (DATEDIFF(day,OH.shipping_dt, ord_dt_shipped)) 
                 END AS [DaysLate], 
        OH.ord_no, inv_dt, MONTH(inv_Dt), ord_dt_shipped, shipping_dt, OH.user_def_fld_4

      FROM              oehdrhst_sql      OH
      INNER JOIN        oelinhst_sql    OL 
                        ON    OL.inv_no = OH.inv_no
      WHERE       /* INITIAL WHERE CLAUSE */
                    inv_dt >  '01/01/2011' and ltrim(OH.cus_no) = '1575' and
                    oh.ord_no IN (SELECT ord_no FROM oehdrhst_sql group by ord_no having COUNT(inv_no) = 1 ) 
                    AND unit_price > 0 and ol.prod_cat NOT IN ('336', '036', '102', '111', '037','7') and OL.item_no NOT like 'R&R%'
                    AND OH.ord_no not IN (select ord_no from oelinhst_sql group by ord_no, item_no having COUNT(item_no) > 5) and not (ship_instruction_2 like 'DISTRO%') 
                    and NOT(shipping_dt) is null and not(OL.item_no = 'WM-MOVIEDUMPBIN')
      ORDER BY ord_no
                              
