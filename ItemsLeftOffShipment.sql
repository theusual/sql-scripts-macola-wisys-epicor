--Items left off shipment
SELECT *
FROM         		  oelinhst_sql OL INNER JOIN 
					  oehdrhst_sql OH on OH.inv_no = ol.inv_no LEFT OUTER JOIN
					  [001].dbo.wsPikPak pp ON ol.item_no = pp.Item_no AND ol.ord_no = pp.ord_no AND line_seq_no = pp.line_no LEFT OUTER JOIN
                      [001].dbo.wsShipment ws ON ws.shipment = pp.shipment LEFT OUTER JOIN
                      [001].dbo.oebolfil_sql BL ON BL.bol_no = ws.bol_no
WHERE        pp.Shipped = 'N' 
