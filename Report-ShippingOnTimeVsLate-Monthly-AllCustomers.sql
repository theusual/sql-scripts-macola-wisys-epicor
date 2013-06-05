ALTER VIEW BG_Shipping_OnTimeVsLate_Monthly_AllCustomers AS 

--Created:	07/12/12	 By:	BG
--Last Updated:	7/12/12	 By:	BG
--Purpose: Report for shipping on time vs shipping late report
--Last Change: --


/*Shipments processed in WISYS, already invoiced, join with OH history to gather updated tracking and carrier if available*/ 
SELECT         MAX(CONVERT(VARCHAR(10), OH.shipping_dt, 101)) AS [ExpectedShipDt], CASE WHEN max(pp.ship_dt) 
               IS NOT NULL THEN max(CONVERT(VARCHAR(10), PP.ship_dt, 101)) WHEN max(OL.shipped_dt) IS NOT NULL THEN max(CONVERT(VARCHAR(10), OL.shipped_dt, 
               101)) ELSE max(CONVERT(varchar(10), OH.inv_dt, 101)) END AS [ShippedDt], LTRIM(pp.shipment) AS [Shipment], ltrim(oh.ord_no) AS OrdNo, LTRIM(OH.cus_no) AS [Cust #], 
               OH.cus_alt_adr_cd AS [Store], 
               /*If order comments contain more than 1 tracking code or carrier code in comments contains typo (doesn't exist in database), then pull the shipping data from wisys, otherwise pull comment shipping data */ CASE
                WHEN OH.cmt_1 LIKE '%,%' THEN (CASE WHEN PP.ParcelType = 'UPS' THEN 'UPG' WHEN PP.ParcelType = 'FedEx' THEN 'FXG' WHEN PP.parcelType IS NULL 
               THEN (CASE WHEN bl.ship_via_cd IS NULL THEN OH.ship_via_cd ELSE bl.ship_via_cd END) END) ELSE (CASE WHEN LEFT(OH.cmt_1, 3) IN
                   (SELECT sy_code
                    FROM   sycdefil_sql
                    WHERE cd_type = 'V') THEN LEFT(OH.cmt_1, 3) 
               ELSE (CASE PP.ParcelType WHEN 'UPS' THEN 'UPG' WHEN 'FedEx' THEN 'FXG' ELSE (CASE WHEN bl.ship_via_cd IS NULL 
               THEN OH.ship_via_cd ELSE bl.ship_via_cd END) END) END) END AS [Carrier], CASE WHEN OH.cmt_3 LIKE '%,%' THEN CASE WHEN PP.trackingno IS NULL 
               THEN dbo.FindLastDelimited(',', cmt_3) ELSE pp.trackingno END ELSE (CASE WHEN LEN(OH.cmt_3) > 3 THEN OH.cmt_3 ELSE pp.trackingno END) 
               END AS [TrackingNo], OH.ship_to_name AS [ShipTo], ol.item_no AS [Item], OL.loc AS [Dock], CASE WHEN SUM(pp.qty) IS NULL THEN SUM(OL.QTY_TO_SHIP) 
               WHEN SUM(pp.qty) > SUM(QTY_TO_SHIP) THEN SUM(OL.QTY_TO_SHIP) ELSE SUM(pp.Qty) END AS Qty, 'Invoiced' AS Comments
FROM  oelinhst_sql OL INNER JOIN
               oehdrhst_sql OH WITH (NOLOCK) ON OH.inv_no = ol.inv_no LEFT OUTER JOIN
               [001].dbo.wsPikPak pp WITH (NOLOCK) ON ol.item_no = pp.Item_no AND ol.ord_no = pp.ord_no LEFT OUTER JOIN
               [001].dbo.wsShipment ws WITH (NOLOCK) ON ws.shipment = pp.shipment LEFT OUTER JOIN
               [001].dbo.oebolfil_sql BL WITH (NOLOCK) ON BL.bol_no = ws.bol_no LEFT OUTER JOIN
               dbo.arcusfil_sql CUS WITH (NOLOCK) ON CUS.cus_no = OH.cus_no
WHERE (CONVERT(varchar, CAST(rtrim(oh.inv_dt) AS datetime), 101) > DATEADD(day, -31, GETDATE())) AND qty_to_ship > 0 AND OH.shipping_dt IS NOT null
				/* AND oh.ord_no = '  675101'*/ 
				AND OL.loc NOT IN ('BR','IN','CH','IT','CAN','GD')
			 --Excluded customers
			   --AND NOT(LTRIM(OH.cus_no) IN ('1100','32334'))
			   --AND NOT(OH.ship_to_name LIKE '%HAYES%' OR OH.ship_to_name LIKE '%SCHWARZ%')
GROUP BY oh.ord_no, oh.cus_no, pp.shipment, OL.item_no, oh.ship_via_cd, BL.ship_via_cd, pp.ParcelType, OL.loc, pp.TrackingNo, 
               pp.ship_dt, OH.cmt_3, OH.cmt_1, OH.cus_alt_adr_cd, OH.ship_to_name
UNION ALL
/*Shipments processed in WISYS, not yet invoiced*/ 
SELECT MAX(CONVERT(VARCHAR(10), OH.shipping_dt, 101))  AS [ExpectedShipDt], CASE WHEN PP.ship_dt IS NULL THEN MAX(CONVERT(VARCHAR(10), OL.shipped_dt, 101)) ELSE MAX(CONVERT(VARCHAR(10), pp.ship_dt,101)) END AS [ShipDt], LTRIM(pp.shipment) AS [Shipment], ltrim(oh.ord_no) AS OrdNo, LTRIM(OH.cus_no) AS [Cust #], OH.cus_alt_adr_cd AS [Store], 
               CASE PP.ParcelType WHEN 'UPS' THEN 'UPG' WHEN 'FedEx' THEN 'FXG' ELSE (CASE WHEN bl.ship_via_cd IS NULL 
               THEN OH.ship_via_cd ELSE bl.ship_via_cd END) END AS [Carrier], pp.TrackingNo[TrackingNo], OH.ship_to_name AS [ShipTo], ol.item_no AS [Item], 
               OL.loc AS [Dock], CASE WHEN SUM(pp.qty) IS NULL THEN MAX(OL.qty_to_ship) ELSE SUM(pp.qty) END AS Qty, '' AS Comments
/*ELSE ltrim(pp.Pallet_UCC128) END AS [Pallet/Carton ID]*/ FROM oeordhdr_sql OH INNER JOIN
               oeordlin_sql OL WITH (NOLOCK) ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
               [001].dbo.wsPikPak pp WITH (NOLOCK) ON oh.ord_no = pp.ord_no AND OL.item_no = PP.item_no LEFT OUTER JOIN
               [001].dbo.wsShipment ws WITH (NOLOCK) ON ws.shipment = pp.shipment LEFT OUTER JOIN
               [001].dbo.oebolfil_sql BL WITH (NOLOCK) ON BL.bol_no = ws.bol_no LEFT OUTER JOIN
               dbo.arcusfil_sql CUS WITH (NOLOCK) ON CUS.cus_no = OH.cus_no
WHERE (shipped = 'Y' OR
               shipped IS NULL) AND (CONVERT(VARCHAR,pp.ship_dt,101) > (DATEADD(day, -31, CONVERT(VARCHAR,GETDATE(),101))) OR (pp.ship_dt IS NULL AND CONVERT(VARCHAR,OL.shipped_dt,101) > (DATEADD(day, -8, CONVERT(VARCHAR,GETDATE(),101))))) AND OL.item_no NOT LIKE '%TEST ITEM%' AND qty_to_ship > 0 AND OH.shipping_dt IS NOT NULL 
				AND OL.loc NOT IN ('BR','IN','CH','IT','CAN','GD')
			--Excluded customers
			   --AND NOT(LTRIM(OH.cus_no) IN ('1100','32334'))
			   --AND NOT(OH.ship_to_name LIKE '%HAYES%' OR OH.ship_to_name LIKE '%SCHWARZ%')
GROUP BY pp.ship_dt, OH.ord_no, oh.cus_no, pp.Shipment, OH.cus_alt_adr_cd, OH.ship_to_name, BL.ship_via_cd, pp.TrackingNo, ol.Item_no, OL.loc, PP.ParcelType, 
               OH.ship_via_cd, ol.shipped_dt

               
              