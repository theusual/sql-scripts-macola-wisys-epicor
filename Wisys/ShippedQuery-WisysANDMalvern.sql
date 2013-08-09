/*Shipments processed in WISYS, already invoiced, join with OH history to gather updated tracking and carrier if available*/ SELECT ltrim(sh.ord_no) AS Ord_No, 
                      pp.Line_no, CASE WHEN LEFT(OH.cmt_1, 3) IN
                          (SELECT     sy_code
                            FROM          sycdefil_sql
                            WHERE      cd_type = 'V') THEN LEFT(OH.cmt_1, 3) ELSE BL.ship_via_cd END AS [Carrier_Cd], pp.Loc AS loc, sh.ship_cost, sh.total_cost, sh.ID, 
                      pp.trackingno AS [tracking_no], 'WISYS-CLOSED' AS [zone], sh.ship_weight AS [Ship_weight], void_fg, sh.complete_fg, pp.Qty, CONVERT(varchar(10), 
                      pp.ship_dt, 101) AS [ship_dt], pp.item_no, cmt_3 AS [cmt_3_tracking_no], CASE WHEN PP.pallet IS NULL THEN ltrim(PP.Carton_UCC128) 
                      ELSE ltrim(pp.Pallet_UCC128) END AS [Pallet/Carton ID]
FROM         oebolfil_sql bl INNER JOIN
                      [001].dbo.wsShipment ws ON ws.bol_no = bl.bol_no INNER JOIN
                      [001].dbo.wsPikPak pp ON pp.Shipment = ws.Shipment INNER JOIN
                      [001].dbo.ARSHTFIL_SQL sh ON pp.Ord_no = sh.ord_no INNER JOIN
                      [001].dbo.oehdrhst_sql OH ON OH.Ord_no = sh.ord_no
WHERE     sh.ord_no <> '' AND sh.void_fg <> 'V' AND (CONVERT(varchar, CAST(rtrim(pp.ship_dt) AS datetime), 101) > DATEADD(day, - 40, GETDATE())) AND 
                      pp.Shipped = 'Y'
UNION ALL
/*Shipments processed in WISYS, NOT YET invoiced, no join on header*/ SELECT ltrim(sh.ord_no), pp.Line_no, bl.ship_via_cd, pp.Loc AS [LOC], sh.ship_cost, 
                      sh.total_cost, sh.ID, pp.trackingno, 'WISYS-OPEN', sh.ship_weight, void_fg, sh.complete_fg, pp.Qty, CONVERT(varchar(10), pp.ship_dt, 101) 
                      AS [ShipDt], pp.Item_no, 'N/A' AS [cmt_3_tracking_no], CASE WHEN PP.pallet IS NULL THEN ltrim(PP.Carton_UCC128) ELSE ltrim(pp.Pallet_UCC128) 
                      END AS [Pallet/Carton ID]
FROM         oebolfil_sql bl INNER JOIN
                      [001].dbo.wsShipment ws ON ws.bol_no = bl.bol_no INNER JOIN
                      [001].dbo.wsPikPak pp ON pp.Shipment = ws.Shipment INNER JOIN
                      [001].dbo.ARSHTFIL_SQL sh ON pp.Ord_no = sh.ord_no INNER JOIN
                      oeordhdr_sql OH ON OH.ord_no = PP.ord_no
WHERE     sh.ord_no <> '' AND sh.void_fg <> 'V' AND (CONVERT(varchar, CAST(rtrim(pp.ship_dt) AS datetime), 101) > DATEADD(day, - 40, GETDATE())) AND 
                      pp.Shipped = 'Y'
UNION ALL
/*Shipments processed in WISYS not in ARSHTFIL, already invoiced, join with header for updated tracking info*/ SELECT ltrim(PP.ord_no), pp.Line_no, 
                      CASE WHEN LEFT(OH.cmt_1, 3) IN
                          (SELECT     sy_code
                            FROM          sycdefil_sql
                            WHERE      cd_type = 'V') THEN LEFT(OH.cmt_1, 3) ELSE BL.ship_via_cd END AS [Carrier Cd], pp.Loc AS [LOC], OH.frt_amt, OH.frt_amt, BL.id AS ID, 
                      pp.trackingno AS [tracking_no], 'WISYS-NOT IN SHTFIL-CLOSED' AS [Zone], BL.carrier_cd_weight, '' AS [Void FG], 'P' AS [Complete FG], pp.Qty, 
                      CONVERT(varchar(10), pp.ship_dt, 101) AS [ShipDt], pp.Item_no, cmt_3 AS [cmt_3_tracking_no], CASE WHEN PP.pallet IS NULL 
                      THEN ltrim(PP.Carton_UCC128) ELSE ltrim(pp.Pallet_UCC128) END AS [Pallet/Carton ID]
FROM         wspikpak PP INNER JOIN
                      wsShipment wsSH ON wsSH.Shipment = PP.shipment INNER JOIN
                      oebolfil_sql BL ON BL.bol_no = wsSH.bol_no INNER JOIN
                      oehdrhst_sql OH ON OH.ord_no = PP.ord_no
WHERE     NOT (PP.ord_no IN
                          (SELECT     Ord_no
                            FROM          ARSHTFIL_SQL)) AND Shipped = 'Y' AND NOT (LTRIM(PP.Ord_no) IN
                          (SELECT     ord_no
                            FROM          ARSHTTBL)) AND (CONVERT(varchar, CAST(rtrim(pp.ship_dt) AS datetime), 101) > DATEADD(day, - 40, GETDATE()))
UNION ALL
/*Shipments processed in WISYS not in ARSHTFIL, not yet invoiced, no join with header*/ SELECT ltrim(PP.ord_no), pp.Line_no, CASE WHEN LEFT(OH.cmt_1, 3) 
                      IN
                          (SELECT     sy_code
                            FROM          sycdefil_sql
                            WHERE      cd_type = 'V') THEN LEFT(OH.cmt_1, 3) ELSE BL.ship_via_cd END AS [Carrier Cd], pp.Loc AS [LOC], OH.frt_amt, OH.frt_amt, BL.id AS ID, 
                      pp.trackingno AS [Tracking_No], 'WISYS-NOT IN SHTFIL-OPEN' AS [Zone], BL.carrier_cd_weight, '' AS [Void FG], 'P' AS [Complete FG], pp.Qty, 
                      CONVERT(varchar(10), pp.ship_dt, 101) AS [Ship_Dt], pp.Item_no, 'N/A' AS [cmt_3_tracking_no], CASE WHEN PP.pallet IS NULL 
                      THEN ltrim(PP.Carton_UCC128) ELSE ltrim(pp.Pallet_UCC128) END AS [Pallet/Carton ID]
FROM         wspikpak PP INNER JOIN
                      wsShipment wsSH ON wsSH.Shipment = PP.shipment INNER JOIN
                      oebolfil_sql BL ON BL.bol_no = wsSH.bol_no INNER JOIN
                      oeordhdr_sql OH ON OH.ord_no = PP.ord_no
WHERE     NOT (PP.ord_no IN
                          (SELECT     Ord_no
                            FROM          ARSHTFIL_SQL)) AND Shipped = 'Y' AND NOT (LTRIM(PP.Ord_no) IN
                          (SELECT     ord_no
                            FROM          ARSHTTBL)) AND (CONVERT(varchar, CAST(rtrim(pp.ship_dt) AS datetime), 101) > DATEADD(day, - 40, GETDATE()))
UNION ALL
/*Shipments processed in MALVERN, already invoiced, join with OH history for updated tracking and carrier*/ SELECT ltrim(SH.ord_no), 
                      min(CAST(shipment_no AS varchar(max))) AS [Line No], min(carrier_cd), 
                      min(CASE mode WHEN '1' THEN 'PS' WHEN '2' THEN 'WS' WHEN '3' THEN 'BC' WHEN '4' THEN 'MS' WHEN '5' THEN 'NE' WHEN '6' THEN 'MDC' ELSE
                       '?' END) AS [LOC], min(ship_cost), min(total_cost), min(A4GLIdentity), min(CASE WHEN LEN(OH.cmt_3) > 3 THEN OH.cmt_3 ELSE sh.tracking_no END) 
                      AS [tracking_no], 'MALVERN-CLOSED' AS [Zone], min(ship_weight), min(void_fg), min(complete_fg), SUM(hand_chg), MIN(CONVERT(varchar, 
                      CAST(rtrim(SH.ship_dt) AS datetime), 101)), SH.filler_0001, min(SH.extra_1), min(CASE WHEN PP.pallet IS NULL THEN ltrim(PP.Carton_UCC128) 
                      ELSE ltrim(pp.Pallet_UCC128) END) AS [Pallet/Carton ID]
FROM         ARSHTTBL SH LEFT OUTER JOIN
                      wsPikPak PP ON ltrim(PP.Ord_no) = SH.ord_no INNER JOIN
                      [001].dbo.oehdrhst_sql OH ON ltrim(OH.ord_no) = sh.ord_no
WHERE     NOT (SH.ord_no IN
                          (SELECT     ltrim(ord_no)
                            FROM          ARSHTFIL_SQL)) AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > DATEADD(day, - 40, GETDATE())) AND 
                      sh.ord_no <> '' AND sh.void_fg IS NULL
GROUP BY SH.ord_no, SH.filler_0001, A4GLIdentity
UNION ALL
/*Shipments processed in MALVERN, not yet invoiced, no join with header*/ SELECT ltrim(SH.ord_no), min(CAST(shipment_no AS varchar(max))) AS [Line No], 
                      min(carrier_cd), 
                      min(CASE mode WHEN '1' THEN 'PS' WHEN '2' THEN 'WS' WHEN '3' THEN 'BC' WHEN '4' THEN 'MS' WHEN '5' THEN 'NE' WHEN '6' THEN 'MDC' ELSE
                       '?' END) AS [LOC], min(ship_cost), min(total_cost), min(A4GLIdentity), min(tracking_no), 'MALVERN-OPEN' AS [Zone], min(ship_weight), min(void_fg), 
                      min(complete_fg), SUM(hand_chg), MIN(CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101)), SH.filler_0001, min(SH.extra_1), 
                      min(CASE WHEN PP.pallet IS NULL THEN ltrim(PP.Carton_UCC128) ELSE ltrim(pp.Pallet_UCC128) END) AS [Pallet/Carton ID]
FROM         ARSHTTBL SH LEFT OUTER JOIN
                      wsPikPak PP ON ltrim(PP.Ord_no) = SH.ord_no INNER JOIN
                      oeordhdr_sql OH ON OH.ord_no = PP.ord_no
WHERE     NOT (SH.ord_no IN
                          (SELECT     ltrim(ord_no)
                            FROM          ARSHTFIL_SQL)) AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > DATEADD(day, - 40, GETDATE())) AND 
                      sh.ord_no <> '' AND sh.void_fg IS NULL
GROUP BY SH.ord_no, SH.filler_0001, A4GLIdentity