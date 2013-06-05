SELECT OL.item_no, SUM(OL.qty_to_ship) AS Q_USAGE, 'Parent' AS ItemLevel, OL.item_no AS 'Parent Item'
FROM  dbo.oelinhst_sql AS OL INNER JOIN
               dbo.oehdrhst_sql AS OH ON OH.inv_no = OL.inv_no JOIN
               wspikpak pp ON pp.ord_no = OL.ord_no AND pp.line_no = Ol.line_no
WHERE (pp.ship_dt > '2011-10-02')
GROUP BY OL.item_no
UNION ALL
/*This query will list the level 1 allocations*/ SELECT bmprdstr_sql.comp_item_no, CONVERT(Decimal(14, 4), QU.q_usage * bmprdstr_sql.qty_per_par) AS usage_ytd, 
               'Level1', bmprdstr_sql.item_no AS 'Parent Item'
FROM  Z_IMINVLOC_USAGE_QUARTERLY_PARENTS AS QU INNER JOIN
               bmprdstr_sql ON QU.item_no = bmprdstr_sql.item_no INNER JOIN
               imitmidx_sql ON bmprdstr_sql.item_no = imitmidx_sql.item_no AND low_lvl_cd = 0
UNION ALL
/*This query will list the level 2 allocations*/ SELECT bmprdstr_sql.comp_item_no, CONVERT(Decimal(14, 4), level1.usage_ytd * bmprdstr_sql.qty_per_par) AS usage_ytd, 
               'Level2', bmprdstr_sql.item_no AS 'Parent Item'
FROM  Z_IMINVLOC_USAGE_QUARTERLY_PARENTS AS QU INNER JOIN
                   (SELECT bmprdstr_sql.comp_item_no AS item_no, CONVERT(Decimal(14, 4), QU.q_usage * bmprdstr_sql.qty_per_par) AS usage_ytd, 'Level1' AS itemLevel, 
                                   bmprdstr_sql.item_no AS 'Parent Item'
                    FROM   Z_IMINVLOC_USAGE_QUARTERLY_PARENTS AS QU INNER JOIN
                                   bmprdstr_sql ON QU.item_no = bmprdstr_sql.item_no INNER JOIN
                                   imitmidx_sql ON bmprdstr_sql.item_no = imitmidx_sql.item_no AND low_lvl_cd = 0) level1 ON QU.item_no = level1.item_no INNER JOIN
               bmprdstr_sql ON QU.item_no = bmprdstr_sql.item_no INNER JOIN
               imitmidx_sql ON bmprdstr_sql.item_no = imitmidx_sql.item_no AND low_lvl_cd = 1