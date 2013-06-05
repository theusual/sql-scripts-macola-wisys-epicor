SELECT            LTRIM(OH.cus_no) AS Cust#, LTRIM(OH.ord_no) AS Ord#, CONVERT(VARCHAR(10),OH.shipping_dt,110) AS [Est Ship Dt], MONTH(OH.shipping_dt) AS [Est Ship Month], 
                  YEAR(OH.shipping_dt) AS [Est Ship Year], OL.item_no, CAST((OL.qty_to_ship) as INT) AS Qty, OH.ship_to_name, 'OPEN' AS [Order Status], 
                  CONVERT(VARCHAR(10),OH.inv_dt,110) AS [Actual Ship Dt], MONTH(OH.inv_dt) AS [Actual Ship Month], YEAR(OH.inv_dt) AS [Actual Ship Year]
FROM        oeordhdr_sql      OH
inner join  oeordlin_sql      OL
            ON    OH.ord_no = OL.ord_no
WHERE       LTRIM(OH.cus_no) = '4227'
            AND OL.item_no IN ('DELI-65 RSR BK', 'ST-043 BV', 'SW00007', 'SW00043BK', 'SW00046WH', 'SW00071WH', 'SW00074', 'SW00076', 
                                          'SW00665', 'SW00877W', 'SW10140', 'SW10168', 'SW10209', 'SW10210', 'SW10217')
            AND OH.ord_type = 'O'
            AND OL.qty_to_ship > 0
            AND OL.unit_price > 0
            
UNION ALL
            
SELECT            LTRIM(OH.cus_no) AS Cust#, LTRIM(OH.ord_no) AS Ord#, CONVERT(VARCHAR(10),OH.shipping_dt,110) AS [Est Ship Dt], MONTH(OH.shipping_dt) AS [Est Ship Month], 
                  YEAR(OH.shipping_dt) AS [Ship Year], OL.item_no, CAST((OL.qty_to_ship) as INT) AS Qty, OH.ship_to_name, 'CLOSED' AS [Order Status], 
                  CONVERT(VARCHAR(10),OH.inv_dt,110) AS [Actual Ship Dt], MONTH(OH.inv_dt) AS [Actual Ship Month], YEAR(OH.inv_dt) AS [Actual Ship Year]
                  , CASE  WHEN qtrly_qty is null then 0
                          WHEN qtyAll is null then ((Qtrly_Qty)/3) 
                         else ((Qtrly_Avg.Qtrly_Qty+ DSIAllocations.qtyAll)/3) END AS [3 Month Avg], CASE WHEN qtyAll is null then 0 else qtyAll end AS [DSI Allocations]
FROM        oehdrhst_sql      OH
INNER JOIN  oelinhst_sql      OL
            ON    OH.inv_no = OL.inv_no
LEFT OUTER JOIN (
                              SELECT      OL.item_no, SUM(OL.qty_to_ship) AS Qtrly_Qty
                              FROM        oelinhst_sql      OL
                              INNER JOIN  oehdrhst_sql      OH
                                          ON    OL.inv_no = OH.inv_no
                              WHERE MONTH(inv_dt) BETWEEN (MONTH(GETDATE())) - 2 AND (MONTH(GETDATE())) AND YEAR(inv_dt) = YEAR(GETDATE()) AND LTRIM(OH.cus_no) = '4227'
                              GROUP BY    OL.item_no
                        ) AS Qtrly_Avg
                  ON    Qtrly_Avg.item_no = OL.item_no
LEFT OUTER JOIN (
                              SELECT      OL.item_no, SUM(OL.qty_to_ship) AS qtyAll
                              FROM        oeordlin_sql      OL
                              INNER JOIN  oeordhdr_sql      OH
                                          ON    OL.ord_no = OH.ord_no
                              WHERE MONTH(shipping_dt) = MONTH(GETDATE()) AND LTRIM(OH.cus_no) = '4227'
                              GROUP BY    OL.item_no
                        ) AS DSIAllocations
                  ON    DSIAllocations.item_no = OL.item_no
                              
WHERE       LTRIM(OH.cus_no) = '4227'
            AND OL.item_no IN ('DELI-65 RSR BK', 'ST-043 BV', 'SW00007', 'SW00043BK', 'SW00046WH', 'SW00071WH', 'SW00074', 'SW00076', 
                                          'SW00665', 'SW00877W', 'SW10140', 'SW10168', 'SW10209', 'SW10210', 'SW10217') 
            AND   OH.orig_ord_type = 'O'
            AND OL.qty_to_ship > 0
            AND OL.unit_price > 0

SELECT DATEADD(MONTH, -12, GETDATE())