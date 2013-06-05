USE [001]
SELECT   DISTINCT  TOP (100) PERCENT oh.ord_no AS [Order], MAX(oh.cus_no) AS Customer, ol.item_no AS Item,  ol.qty_to_ship  AS [QTY Shipped]  , MAX(ol.qty_ordered) 
                      AS [QTY Ordered], MONTH(MAX(oh.ord_dt)) AS [Order Month], MAX(oh.ord_dt) AS [Order Date], MAX(oh.oe_po_no) AS PO, 'INVOICED' AS [INV OR OPEN]
FROM         dbo.OEHDRHST_SQL AS oh INNER JOIN
                      dbo.OELINHST_SQL AS ol ON oh.inv_no = ol.inv_no AND oh.shipping_dt = ol.request_dt
WHERE     (LTRIM(oh.cus_no) = 4227) AND (ol.item_no IN ('SW10168', 'ST-043 BV', 'DELI-65 RSR BK', 'SW10140', 'SW00877W', 'SW00043BK', 'SW00071WH', 
                      'SW00665', 'SW00007', 'SW00074', 'SW00076', 'SW00046WH')) 
GROUP BY oh.ord_no, ol.item_no, ol.qty_to_ship
UNION ALL
SELECT   DISTINCT  TOP (100) PERCENT oh.ord_no AS [Order], MAX(oh.cus_no) AS Customer, ol.item_no AS Item,  0  AS [QTY Shipped]  , ol.qty_ordered 
                      AS [QTY Ordered], MONTH(MAX(oh.ord_dt)) AS [Order Month], MAX(oh.ord_dt) AS [Order Date], MAX(oh.oe_po_no) AS PO, 'OPEN' AS [INV OR OPEN]
FROM         dbo.OEORDHDR_SQL AS oh INNER JOIN
                      dbo.OEORDLIN_SQL AS ol ON oh.ord_no = ol.ord_no AND oh.shipping_dt = ol.request_dt
WHERE     (LTRIM(oh.cus_no) = 4227) AND (ol.item_no IN ('SW10168', 'ST-043 BV', 'DELI-65 RSR BK', 'SW10140', 'SW00877W', 'SW00043BK', 'SW00071WH', 
                      'SW00665', 'SW00007', 'SW00074', 'SW00076', 'SW00046WH')) and NOT ltrim(rtrim(oh.ord_no)) = '4227' 
GROUP BY oh.ord_no, ol.item_no, ol.qty_ordered