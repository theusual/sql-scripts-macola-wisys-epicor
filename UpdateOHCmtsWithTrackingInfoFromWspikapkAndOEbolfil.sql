update oh
set	oh.cmt_3 = pp.trackingno,
    oh.cmt_1 = CASE
                PP.ParcelType WHEN 'UPS' THEN 'UPG' WHEN 'FedEx' THEN 'FXG' ELSE (CASE WHEN bl.ship_via_cd IS NULL THEN OH.ship_via_cd ELSE bl.ship_via_cd END) 
               END
from [001].dbo.wsPikPak pp INNER JOIN
               oeordlin_sql OL ON ol.item_no = pp.Item_no AND ol.ord_no = pp.ord_no INNER JOIN
               oeordhdr_sql OH ON OH.ord_no = ol.ord_no INNER JOIN
               [001].dbo.wsShipment ws ON ws.shipment = pp.shipment LEFT OUTER JOIN
               [001].dbo.oebolfil_sql BL ON BL.bol_no = ws.bol_no
where   pp.ship_dt > '9/21/2011' and pp.Shipped = 'Y' AND qty_to_ship > 0 and (cmt_3 is null or cmt_1 is null)

--update ol
--set ol.extra_5 = 'X'
--from [001].dbo.wsPikPak pp INNER JOIN
--               oeordlin_sql OL ON ol.item_no = pp.Item_no AND ol.ord_no = pp.ord_no INNER JOIN
--               oeordhdr_sql OH ON OH.ord_no = ol.ord_no INNER JOIN
--               [001].dbo.wsShipment ws ON ws.shipment = pp.shipment LEFT OUTER JOIN
--               [001].dbo.oebolfil_sql BL ON BL.bol_no = ws.bol_no
--where  ol.extra_5 is null and pp.ship_dt > '9/21/2011' and pp.Shipped = 'Y' AND qty_to_ship > 0

SELECT  CASE PP.ParcelType WHEN 'UPS' THEN 'UPG' WHEN 'FedEx' THEN 'FXG' ELSE (CASE WHEN bl.ship_via_cd IS NULL THEN OH.ship_via_cd ELSE bl.ship_via_cd END) 
               END, cmt_1, cmt_3
from [001].dbo.wsPikPak pp INNER JOIN
               oeordlin_sql OL ON ol.item_no = pp.Item_no AND ol.ord_no = pp.ord_no INNER JOIN
               oeordhdr_sql OH ON OH.ord_no = ol.ord_no INNER JOIN
               [001].dbo.wsShipment ws ON ws.shipment = pp.shipment LEFT OUTER JOIN
               [001].dbo.oebolfil_sql BL ON BL.bol_no = ws.bol_no
where   pp.ship_dt > '9/21/2011' and pp.Shipped = 'Y' AND qty_to_ship > 0 and cmt_3 is null