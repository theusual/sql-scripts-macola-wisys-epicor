--Shipments processed in WISYS, already invoiced, join with OH history to gather updated tracking and carrier if available
SELECT ltrim(oh.ord_no) AS Ord_No, OH.cus_alt_adr_cd AS [Store],
	bl.ship_via_cd AS [Carrier_Cd], pp.loc AS loc,   
                       pp.TrackingNo [tracking_no], 'WISYS-CLOSED' AS [zone], pp.weight AS [Ship_weight],  pp.Qty AS Qty, CONVERT(varchar(10), 
                      pp.ship_dt, 101) AS [Shipped Dt], pp.item_no, CASE WHEN PP.pallet IS NULL THEN ltrim(PP.Carton_UCC128) 
                      ELSE ltrim(pp.Pallet_UCC128) END AS [Pallet/Carton ID]
FROM         	  oehdrhst_sql OH  LEFT OUTER JOIN
					  [001].dbo.wsPikPak pp ON oh.ord_no = pp.ord_no LEFT OUTER JOIN
                      [001].dbo.wsShipment ws ON ws.shipment = pp.shipment LEFT OUTER JOIN
                      [001].dbo.oebolfil_sql BL ON BL.bol_no = ws.bol_no
WHERE      oh.ord_no < '  679508' AND oh.ord_no > '  676373' AND shipped = 'Y'

UNION ALL

--Shipments processed in WISYS, not yet invoiced
SELECT ltrim(oh.ord_no) AS Ord_No, OH.cus_alt_adr_cd AS [Store],
	bl.ship_via_cd AS [Carrier_Cd], pp.loc AS loc,   
                       pp.TrackingNo [tracking_no], 'WISYS-OPEN' AS [zone], pp.weight AS [Ship_weight],  pp.Qty AS Qty, CONVERT(varchar(10), 
                      pp.ship_dt, 101) AS [Shipped Dt], pp.item_no, CASE WHEN PP.pallet IS NULL THEN ltrim(PP.Carton_UCC128) 
                      ELSE ltrim(pp.Pallet_UCC128) END AS [Pallet/Carton ID]
FROM         	  oeordhdr_sql OH  LEFT OUTER JOIN
					  [001].dbo.wsPikPak pp ON oh.ord_no = pp.ord_no LEFT OUTER JOIN
                      [001].dbo.wsShipment ws ON ws.shipment = pp.shipment LEFT OUTER JOIN
                      [001].dbo.oebolfil_sql BL ON BL.bol_no = ws.bol_no
WHERE      oh.ord_no < '  679508' AND oh.ord_no > '  676373' AND shipped = 'Y'

