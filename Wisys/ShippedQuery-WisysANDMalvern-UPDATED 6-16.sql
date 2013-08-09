/*Shipments processed in WISYS, already invoiced, join with OH history to gather updated tracking and carrier if available*/ SELECT ltrim(oh.ord_no) AS Ord_No, 
               CASE WHEN max(PP.ID) IS NULL THEN max(ol.id) ELSE max(pp.id) END AS [ID], 
               /*If order comments contain more than 1 tracking code or carrier code in comments contains typo (doesn't exist in database), then pull the shipping data from wisys, otherwise pull comment shipping data                      */ CASE
                WHEN OH.cmt_1 LIKE '%,%' THEN (CASE WHEN PP.ParcelType = 'UPS' THEN 'UPG' WHEN PP.ParcelType = 'FedEx' THEN 'FXG' WHEN PP.parcelType IS NULL 
               THEN (CASE WHEN bl.ship_via_cd IS NULL THEN OH.ship_via_cd ELSE bl.ship_via_cd END) END) ELSE (CASE WHEN LEFT(OH.cmt_1, 3) IN
                   (SELECT sy_code
                    FROM   sycdefil_sql
                    WHERE cd_type = 'V') THEN LEFT(OH.cmt_1, 3) 
               ELSE (CASE PP.ParcelType WHEN 'UPS' THEN 'UPG' WHEN 'FedEx' THEN 'FXG' ELSE (CASE WHEN bl.ship_via_cd IS NULL 
               THEN OH.ship_via_cd ELSE bl.ship_via_cd END) END) END) END AS [Carrier_Cd], ol.Loc AS loc, '0.00' AS ship_cost, '0.00' AS total_cost, 
               CASE WHEN OH.cmt_3 LIKE '%,%' THEN CASE WHEN PP.trackingno IS NULL THEN dbo.FindLastDelimited(',', cmt_3) 
               ELSE pp.trackingno END ELSE (CASE WHEN LEN(OH.cmt_3) > 3 THEN OH.cmt_3 ELSE pp.trackingno END) END AS [tracking_no], 'WISYS-CLOSED' AS [zone], 
               pp.weight AS [Ship_weight], '' AS void_fg, 'P' AS complete_fg, 
               CASE WHEN SUM(pp.qty) IS NULL THEN SUM(OL.QTY_TO_SHIP) 
					WHEN SUM(pp.qty) > SUM(QTY_TO_SHIP) THEN SUM(OL.QTY_TO_SHIP) 
                    ELSE SUM(pp.Qty) 
               END AS Qty, 
               
               CASE WHEN max(pp.ship_dt) IS NULL THEN max(CONVERT(VARCHAR(10), OL.shipped_dt, 101)) ELSE CONVERT(varchar(10), pp.ship_dt, 101) END AS [ship_dt], 
               max(ol.item_no) AS [item_no], max(cmt_3) AS [cmt_3_tracking_no], CASE WHEN PP.pallet IS NULL THEN ltrim(PP.Carton_UCC128) ELSE ltrim(pp.Pallet_UCC128) 
               END AS [Pallet/Carton ID]
FROM  oelinhst_sql OL INNER JOIN
               oehdrhst_sql OH ON OH.inv_no = ol.inv_no LEFT OUTER JOIN
               [001].dbo.wsPikPak pp ON ol.item_no = pp.Item_no AND ol.ord_no = pp.ord_no LEFT OUTER JOIN
               [001].dbo.wsShipment ws ON ws.shipment = pp.shipment LEFT OUTER JOIN
               [001].dbo.oebolfil_sql BL ON BL.bol_no = ws.bol_no
WHERE (CONVERT(varchar, CAST(rtrim(ol.shipped_dt) AS datetime), 101) > DATEADD(day, - 90, GETDATE())) AND qty_to_ship > 0
/* AND oh.ord_no = '  675101'*/ GROUP BY oh.ord_no, OL.item_no, oh.ship_via_cd, BL.ship_via_cd, pp.ParcelType, OL.loc, pp.TrackingNo, pp.weight, pp.ship_dt, OH.cmt_3, 
               pp.Pallet, pp.Carton_UCC128, pp.Pallet_UCC128, OH.cmt_1
UNION ALL
/*Shipments processed in WISYS, NOT YET invoiced, no join on header*/ SELECT ltrim(pp.ord_no) AS Ord_No, max(pp.id), 
               /*If order comments contain more than 1 tracking code or carrier code in comments contains typo (doesn't exist in database), then pull the shipping data from wisys, otherwise pull comment shipping data                      */ CASE
                PP.ParcelType WHEN 'UPS' THEN 'UPG' WHEN 'FedEx' THEN 'FXG' ELSE (CASE WHEN bl.ship_via_cd IS NULL THEN OH.ship_via_cd ELSE bl.ship_via_cd END) 
               END AS [Carrier_Cd], ol.Loc AS loc, '0.00' AS ship_cost, '0.00' AS total_cost, pp.trackingno AS [tracking_no], 'WISYS-OPEN' AS [zone], pp.weight AS [Ship_weight], 
               '' AS void_fg, 'P' AS complete_fg, SUM(pp.Qty), CONVERT(varchar(10), pp.ship_dt, 101) AS [ship_dt], pp.item_no, cmt_3 AS [cmt_3_tracking_no], 
               CASE WHEN PP.pallet IS NULL THEN ltrim(PP.Carton_UCC128) ELSE ltrim(pp.Pallet_UCC128) END AS [Pallet/Carton ID]
FROM  [001].dbo.wsPikPak pp INNER JOIN
               oeordlin_sql OL ON ol.item_no = pp.Item_no AND ol.ord_no = pp.ord_no INNER JOIN
               oeordhdr_sql OH ON OH.ord_no = ol.ord_no INNER JOIN
               [001].dbo.wsShipment ws ON ws.shipment = pp.shipment LEFT OUTER JOIN
               [001].dbo.oebolfil_sql BL ON BL.bol_no = ws.bol_no
WHERE (CONVERT(varchar, CAST(rtrim(pp.ship_dt) AS datetime), 101) > DATEADD(day, - 90, GETDATE())) AND pp.Shipped = 'Y' AND qty_to_ship > 0
			AND NOT((OH.ord_no + OL.item_no) IN 
				(SELECT OH.ord_no + item_no FROM oehdrhst_sql OH JOIN oelinhst_sql OL ON OH.inv_no = OL.inv_no WHERE qty_to_ship > 0))
				
GROUP BY pp.ord_no, OL.item_no, oh.ship_via_cd, BL.ship_via_cd, pp.ParcelType, OL.loc, pp.TrackingNo, pp.weight, pp.ship_dt, pp.item_no, OH.cmt_3, pp.Pallet, 
               pp.Carton_UCC128, pp.Pallet_UCC128
UNION ALL
/*Shipments processed in MALVERN, not yet invoiced*/ SELECT ltrim(SH.ord_no), MAX(sh.A4GLIdentity), min(carrier_cd), 
               min(CASE mode WHEN '1' THEN 'PS' WHEN '2' THEN 'WS' WHEN '3' THEN 'BC' WHEN '4' THEN 'MS' WHEN '5' THEN 'NE' WHEN '6' THEN 'MDC' ELSE '?' END) 
               AS [LOC], min(ship_cost), min(OL.total_cost), min(tracking_no), 'MALVERN-OPEN' AS [Zone], min(ship_weight), min(void_fg), min(complete_fg), SUM(hand_chg), 
               MIN(CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101)), SH.filler_0001, min(SH.extra_1), min(CASE WHEN PP.pallet IS NULL 
               THEN ltrim(PP.Carton_UCC128) ELSE ltrim(pp.Pallet_UCC128) END) AS [Pallet/Carton ID]
FROM  ARSHTTBL SH LEFT OUTER JOIN
               wsPikPak PP ON ltrim(PP.Ord_no) = SH.ord_no INNER JOIN
               oeordhdr_sql OH ON ltrim(OH.ord_no) = SH.ord_no INNER JOIN
               oeordlin_sql OL ON OL.ord_no = OH.ord_no
WHERE NOT (SH.ord_no IN
                   (SELECT ltrim(ord_no)
                    FROM   ARSHTFIL_SQL)) AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > DATEADD(day, - 90, GETDATE())) AND sh.ord_no <> '' AND 
               sh.void_fg IS NULL AND qty_to_ship > 0
GROUP BY SH.ord_no, SH.filler_0001
