--Daily EOD, shipments processed in WISYS, not yet invoiced
SELECT CONVERT(varchar(10), pp.ship_dt, 101) AS [ShippedDt], ltrim(oh.ord_no) AS OrdNo, OH.cus_alt_adr_cd AS [Store],
				 CASE  PP.ParcelType 
				        WHEN 'UPS' THEN 'UPG' 
				        WHEN 'FedEx' THEN 'FXG' 
				        ELSE (CASE WHEN bl.ship_via_cd IS NULL THEN OH.ship_via_cd
				                   ELSE bl.ship_via_cd 
				              END) 
                 END AS [Carrier],  pp.TrackingNo [TrackingNo], OH.ship_to_name AS [ShipTo], pp.item_no AS [Item], OL.loc AS [Dock],   
                       SUM(pp.qty) AS Qty, '' AS Comments
                      -- CASE WHEN PP.pallet IS NULL THEN ltrim(PP.Carton_UCC128) 
                      --ELSE ltrim(pp.Pallet_UCC128) END AS [Pallet/Carton ID]
FROM         	  oeordhdr_sql OH  INNER JOIN
					oeordlin_sql OL ON OL.ord_no = OH.ord_no INNER JOIN
					  [001].dbo.wsPikPak pp ON oh.ord_no = pp.ord_no and OL.item_no = PP.item_no LEFT OUTER JOIN
                      [001].dbo.wsShipment ws ON ws.shipment = pp.shipment LEFT OUTER JOIN
                      [001].dbo.oebolfil_sql BL ON BL.bol_no = ws.bol_no
WHERE      shipped = 'Y' and PP.ship_dt > (DATEADD(day,-1,GETDATE())) AND PP.item_no not like '%TEST ITEM%' AND qty_to_ship > 0
           /* AND NOT ((OH.ord_no + OL.item_no) IN
                   (SELECT OH.ord_no + item_no
                    FROM   oehdrhst_sql OH JOIN
                                   oelinhst_sql OL ON OH.inv_no = OL.inv_no
                    WHERE qty_to_ship > 0 and inv_dt > (DATEADD(day,-90,GETDATE())))) */
GROUP BY pp.ship_dt, OH.ord_no, OH.cus_alt_adr_cd, OH.ship_to_name, BL.ship_via_cd, pp.TrackingNo, pp.Item_no, OL.loc, PP.ParcelType, OH.ship_via_cd

