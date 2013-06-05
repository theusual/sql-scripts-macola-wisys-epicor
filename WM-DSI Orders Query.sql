USE [001]

SELECT     TOP (100) PERCENT oh.ord_no AS [Order], oh.cus_no AS Customer, ol.item_no AS Item, SUM(ol.qty_to_ship) AS [QTY Shipped], MAX(ol.qty_ordered) 
                      AS [QTY Ordered], MONTH(oh.ord_dt) AS [Order Month], oh.ord_dt AS [Order Date], oh.oe_po_no AS PO, MONTH(MAX(oh.shipping_dt)) 
                      AS [Shipped Month], MAX(oh.shipping_dt) AS [Shipping Date]
FROM         dbo.Z_ALLORDHDR AS oh INNER JOIN
                      dbo.Z_ALLORDLIN AS ol ON oh.ord_no = ol.ord_no AND oh.shipping_dt = ol.request_dt
WHERE     (LTRIM(oh.cus_no) = 4227) AND (ol.item_no IN ('SW10168', 'ST-043 BV', 'DELI-65 RSR BK', 'SW10140', 'SW00877W', 'SW00043BK', 'SW00071WH', 
                      'SW00665', 'SW00007', 'SW00074', 'SW00076', 'SW00046WH')) AND (ol.qty_to_ship > 0)
GROUP BY oh.ord_no, ol.item_no, oh.cus_no, oh.ord_dt, oh.oe_po_no