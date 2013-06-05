/*Old Code
select z_iminvloc.item_no, Convert(Decimal(14,4), z_iminvloc.usage_ytd) As usage_ytd, Convert(Decimal(14,4), z_iminvloc.usage_ytd) As usage_ytd, 'Parent' as ItemLevel, z_iminvloc.item_no as 'Parent Item'
from z_iminvloc
inner join imitmidx_sql on z_iminvloc.item_no = imitmidx_sql.item_no and low_lvl_cd = 3

select z_iminvloc.item_no, Convert(Decimal(14,4), z_iminvloc.usage_ytd) As usage_ytd, Convert(Decimal(14,4), z_iminvloc.usage_ytd) As usage_ytd, 'Parent' as ItemLevel, z_iminvloc.item_no as 'Parent Item'
from z_iminvloc
inner join imitmidx_sql on z_iminvloc.item_no = imitmidx_sql.item_no and low_lvl_cd = 0
*/ SELECT
                item_no, SUM(CONVERT(Decimal(14, 4), OL.qty_to_ship)) AS usage_ytd, 'Parent' AS ItemLevel, OL.item_no AS 'Parent Item'
FROM  oelinhst_sql AS OL INNER JOIN
               oehdrhst_sql AS OH ON OL.inv_no = OH.inv_no
WHERE OH.ord_type = 'O' AND OH.inv_dt > '01/01/2011'
GROUP BY item_no
UNION ALL
/*This query will list the level 1 allocations*/ SELECT bmprdstr_sql.comp_item_no, CONVERT(Decimal(14, 4), z_iminvloc.usage_ytd * bmprdstr_sql.qty_per_par) 
               AS usage_ytd, 'Level1', bmprdstr_sql.item_no AS 'Parent Item'
FROM  z_iminvloc INNER JOIN
               bmprdstr_sql ON z_iminvloc.item_no = bmprdstr_sql.item_no INNER JOIN
               imitmidx_sql ON bmprdstr_sql.item_no = imitmidx_sql.item_no AND low_lvl_cd = 0
UNION ALL
/*This query will list the level 2 allocations*/ SELECT bmprdstr_sql.comp_item_no, CONVERT(Decimal(14, 4), level1.usage_ytd * bmprdstr_sql.qty_per_par) AS usage_ytd, 
               'Level2', bmprdstr_sql.item_no AS 'Parent Item'
FROM  z_iminvloc INNER JOIN
                   (SELECT bmprdstr_sql.comp_item_no AS item_no, CONVERT(Decimal(14, 4), z_iminvloc.usage_ytd * bmprdstr_sql.qty_per_par) AS usage_ytd, 
                                   'Level1' AS itemLevel, bmprdstr_sql.item_no AS 'Parent Item'
                    FROM   z_iminvloc INNER JOIN
                                   bmprdstr_sql ON z_iminvloc.item_no = bmprdstr_sql.item_no INNER JOIN
                                   imitmidx_sql ON bmprdstr_sql.item_no = imitmidx_sql.item_no AND low_lvl_cd = 0) level1 ON z_iminvloc.item_no = level1.item_no INNER JOIN
               bmprdstr_sql ON z_iminvloc.item_no = bmprdstr_sql.item_no INNER JOIN
               imitmidx_sql ON bmprdstr_sql.item_no = imitmidx_sql.item_no AND low_lvl_cd = 1
UNION ALL
/*This query will list the level 3 allocations*/ SELECT bmprdstr_sql.comp_item_no, CONVERT(Decimal(14, 4), level2.usage_ytd * bmprdstr_sql.qty_per_par) AS usage_ytd, 
               'Level3', bmprdstr_sql.item_no AS 'Parent Item'
FROM  z_iminvloc INNER JOIN
                   (SELECT bmprdstr_sql.comp_item_no AS item_no, CONVERT(Decimal(14, 4), level1.usage_ytd * bmprdstr_sql.qty_per_par) AS usage_ytd, 'Level2' AS itemLevel, 
                                   bmprdstr_sql.item_no AS 'Parent Item'
                    FROM   z_iminvloc INNER JOIN
                                       (SELECT bmprdstr_sql.comp_item_no AS item_no, CONVERT(Decimal(14, 4), z_iminvloc.usage_ytd * bmprdstr_sql.qty_per_par) AS usage_ytd, 
                                                       'Level1' AS itemLevel, bmprdstr_sql.item_no AS 'Parent Item'
                                        FROM   z_iminvloc INNER JOIN
                                                       bmprdstr_sql ON z_iminvloc.item_no = bmprdstr_sql.item_no INNER JOIN
                                                       imitmidx_sql ON bmprdstr_sql.item_no = imitmidx_sql.item_no AND low_lvl_cd = 0) level1 ON z_iminvloc.item_no = level1.item_no INNER JOIN
                                   bmprdstr_sql ON z_iminvloc.item_no = bmprdstr_sql.item_no INNER JOIN
                                   imitmidx_sql ON bmprdstr_sql.item_no = imitmidx_sql.item_no AND low_lvl_cd = 1) level2 ON z_iminvloc.item_no = level2.item_no INNER JOIN
               bmprdstr_sql ON z_iminvloc.item_no = bmprdstr_sql.item_no INNER JOIN
               imitmidx_sql ON bmprdstr_sql.item_no = imitmidx_sql.item_no AND low_lvl_cd = 2