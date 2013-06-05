ALTER VIEW BG_Shipping_OnTimeVsLate_Yesterday AS 

--Created:	06/1/12	 By:	BG
--Last Updated:	6/1/12	 By:	BG
--Purpose: Report for shipping on time vs shipping late report
--Last Change: --


/*Shipments processed in WISYS, not yet invoiced*/ 
SELECT MAX(CONVERT(VARCHAR(10), OH.shipping_dt, 101)) AS [ExpectedShipDt], CASE WHEN PP.ship_dt IS NULL THEN MAX(CONVERT(VARCHAR(10), OL.shipped_dt,101)) ELSE MAX(CONVERT(VARCHAR(10), pp.ship_dt, 101)) END AS [ShipDt], LTRIM(pp.shipment) AS [Shipment], ltrim(oh.ord_no) AS OrdNo, LTRIM(OH.cus_no) AS [Cust #], OH.cus_alt_adr_cd AS [Store], 
               CASE PP.ParcelType WHEN 'UPS' THEN 'UPG' WHEN 'FedEx' THEN 'FXG' ELSE (CASE WHEN bl.ship_via_cd IS NULL 
               THEN OH.ship_via_cd ELSE bl.ship_via_cd END) END AS [Carrier], pp.TrackingNo[TrackingNo], OH.ship_to_name AS [ShipTo], ol.item_no AS [Item], 
               OL.loc AS [Dock], CASE WHEN SUM(pp.qty) IS NULL THEN MAX(OL.qty_to_ship) ELSE SUM(pp.qty) END AS Qty, '' AS Comments
/*ELSE ltrim(pp.Pallet_UCC128) END AS [Pallet/Carton ID]*/ FROM oeordhdr_sql OH INNER JOIN
               oeordlin_sql OL ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
               [001].dbo.wsPikPak pp ON oh.ord_no = pp.ord_no AND OL.item_no = PP.item_no LEFT OUTER JOIN
               [001].dbo.wsShipment ws ON ws.shipment = pp.shipment LEFT OUTER JOIN
               [001].dbo.oebolfil_sql BL ON BL.bol_no = ws.bol_no LEFT OUTER JOIN
               dbo.arcusfil_sql CUS ON CUS.cus_no = OH.cus_no
WHERE (shipped = 'Y' OR
               shipped IS NULL) 
               AND (DATEPART(dw, (GETDATE())) = 2 AND (CONVERT(VARCHAR,pp.ship_dt,101) = (DATEADD(day, -3, CONVERT(VARCHAR,GETDATE(),101))) OR (pp.ship_dt IS NULL AND CONVERT(VARCHAR,OL.shipped_dt,101) = (DATEADD(day, -3, CONVERT(VARCHAR,GETDATE(),101)))))
					 OR (CONVERT(VARCHAR,pp.ship_dt,101) = (DATEADD(day, -1, CONVERT(VARCHAR,GETDATE(),101))) OR (pp.ship_dt IS NULL AND CONVERT(VARCHAR,OL.shipped_dt,101) = (DATEADD(day, -1, CONVERT(VARCHAR,GETDATE(),101)))))) 
		       AND OL.item_no NOT LIKE '%TEST ITEM%' AND qty_to_ship > 0 AND OH.shipping_dt IS NOT NULL
               AND OL.loc NOT IN ('BR','IN','CH','IT','CAN','GD')
               AND NOT (cus_name LIKE '%PUBLIX%')
GROUP BY pp.ship_dt, OH.ord_no, oh.cus_no, pp.Shipment, OH.cus_alt_adr_cd, OH.ship_to_name, BL.ship_via_cd, pp.TrackingNo, ol.Item_no, OL.loc, PP.ParcelType, 
               OH.ship_via_cd, ol.shipped_dt
              