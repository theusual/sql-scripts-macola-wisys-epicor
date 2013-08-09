/*Shipments processed in WISYS, already invoiced, join with OH history to gather updated tracking and carrier if available*/ 
SELECT ltrim(pp.ord_no) AS Ord_No, 
                      pp.Line_no, 
	--If order comments contain more than 1 tracking code or carrier code in comments contains typo (doesn't exist in database), then pull the shipping data from wisys, otherwise pull comment shipping data                      
                      CASE WHEN OH.cmt_1 like '%,%' 
						   THEN (CASE PP.ParcelType
										WHEN 'UPS' THEN 'UPG'
										WHEN 'FedEx' THEN 'FXG'
										ELSE (CASE WHEN bl.ship_via_cd is null 
												  then OH.ship_via_cd 
												  ELSE bl.ship_via_cd 
											  END)
								END)
                           ELSE (CASE WHEN LEFT(OH.cmt_1, 3) IN  (SELECT     sy_code
																	FROM          sycdefil_sql
																	WHERE      cd_type = 'V') 
									  THEN LEFT(OH.cmt_1, 3) 
									  ELSE (CASE PP.ParcelType
										       WHEN 'UPS' THEN 'UPG'
										       WHEN 'FedEx' THEN 'FXG'
										       ELSE (CASE WHEN bl.ship_via_cd is null 
												          then OH.ship_via_cd 
												          ELSE bl.ship_via_cd 
											         END)
											END)
								END)
					  END AS [Carrier_Cd], pp.Loc AS loc, '0.00' AS ship_cost, '0.00' AS total_cost, pp.ID, 
                       CASE WHEN OH.cmt_3 like '%,%' 
                            THEN PP.trackingno
                            ELSE (CASE WHEN LEN(OH.cmt_3) > 3 
										  THEN OH.cmt_3 
										  ELSE pp.trackingno 
								     END) 
						END AS [tracking_no], 'WISYS-CLOSED' AS [zone], pp.weight AS [Ship_weight], '' AS void_fg, 'P' AS complete_fg, pp.Qty, CONVERT(varchar(10), 
                      pp.ship_dt, 101) AS [ship_dt], pp.item_no, cmt_3 AS [cmt_3_tracking_no], CASE WHEN PP.pallet IS NULL THEN ltrim(PP.Carton_UCC128) 
                      ELSE ltrim(pp.Pallet_UCC128) END AS [Pallet/Carton ID]
FROM         oelinhst_sql OL INNER JOIN 
					  oehdrhst_sql OH on OH.inv_no = ol.inv_no LEFT OUTER JOIN
					  [001].dbo.wsPikPak pp ON ol.item_no = pp.Item_no AND ol.ord_no = pp.ord_no LEFT OUTER JOIN
                      [001].dbo.wsShipment ws ON ws.shipment = pp.shipment LEFT OUTER JOIN
                      [001].dbo.oebolfil_sql BL ON BL.bol_no = ws.bol_no
WHERE      (CONVERT(varchar, CAST(rtrim(pp.ship_dt) AS datetime), 101) > DATEADD(day, - 40, GETDATE())) 

UNION ALL

/*Shipments processed in WISYS, NOT YET invoiced, no join on header*/ 
SELECT ltrim(pp.ord_no) AS Ord_No, 
                      pp.Line_no, 
	--If order comments contain more than 1 tracking code or carrier code in comments contains typo (doesn't exist in database), then pull the shipping data from wisys, otherwise pull comment shipping data                      
                      CASE PP.ParcelType
										WHEN 'UPS' THEN 'UPG'
										WHEN 'FedEx' THEN 'FXG'
										ELSE (CASE WHEN bl.ship_via_cd is null 
												  then OH.ship_via_cd 
												  ELSE bl.ship_via_cd 
											  END)
						END AS [Carrier_Cd], pp.Loc AS loc, '0.00' AS ship_cost, '0.00' AS total_cost, pp.ID, 
                      pp.trackingno AS [tracking_no], 'WISYS-OPEN' AS [zone], pp.weight AS [Ship_weight], '' AS void_fg, 'P' AS complete_fg, pp.Qty, CONVERT(varchar(10), 
                      pp.ship_dt, 101) AS [ship_dt], pp.item_no, cmt_3 AS [cmt_3_tracking_no], CASE WHEN PP.pallet IS NULL THEN ltrim(PP.Carton_UCC128) 
                      ELSE ltrim(pp.Pallet_UCC128) END AS [Pallet/Carton ID]
FROM         [001].dbo.wsPikPak pp INNER JOIN
					  oeordlin_sql OL ON ol.item_no = pp.Item_no AND ol.ord_no = pp.ord_no AND line_seq_no = pp.line_no INNER JOIN 
					  oeordhdr_sql OH on OH.ord_no = ol.ord_no INNER JOIN
                      [001].dbo.wsShipment ws ON ws.shipment = pp.shipment LEFT OUTER JOIN
                      [001].dbo.oebolfil_sql BL ON BL.bol_no = ws.bol_no
WHERE     (CONVERT(varchar, CAST(rtrim(pp.ship_dt) AS datetime), 101) > DATEADD(day, - 40, GETDATE())) AND 
                      pp.Shipped = 'Y'
UNION ALL

--THIS SECTION OBSOLETED BY CHANGE IN FIRST SECTION FROM INNER JOIN ON WSPIKPAK TO LEFT OUTER JOIN.  NOW EVEN SHIPMENTS NOT PROCESSED IN PICKPACK WILL BE PULLED IN AS LONG AS THEY HAVE BEEN INVOICED.

/*Shipments processed in MALVERN, already invoiced, join with OH history for updated tracking and carrier*/ 
SELECT ltrim(SH.ord_no), 
                      min(CAST(shipment_no AS varchar(max))) AS [Line No],
	--If order comments contain more than 1 tracking code or carrier code in comments contains typo (doesn't exist in database), then pull the shipping data from wisys, otherwise pull comment shipping data                      
                      CASE WHEN OH.cmt_1 like '%,%' 
						   THEN (CASE PP.ParcelType
										WHEN 'UPS' THEN 'UPG'
										WHEN 'FedEx' THEN 'FXG'
										ELSE (CASE WHEN sh.carrier_cd is null 
												  then OH.ship_via_cd 
												  ELSE sh.carrier_cd
											  END)
								     END)
                           ELSE (CASE WHEN LEFT(OH.cmt_1, 3) IN  (SELECT     sy_code
																	FROM          sycdefil_sql
																	WHERE      cd_type = 'V') 
									  THEN LEFT(OH.cmt_1, 3) 
									  ELSE (CASE PP.ParcelType
										       WHEN 'UPS' THEN 'UPG'
										       WHEN 'FedEx' THEN 'FXG'
										       ELSE (CASE WHEN sh.carrier_cd is null 
														  then OH.ship_via_cd 
														  ELSE sh.carrier_cd
											         END)
											END)
								END)
					  END AS [Carrier_Cd],
                      min(CASE mode WHEN '1' THEN 'PS' WHEN '2' THEN 'WS' WHEN '3' THEN 'BC' WHEN '4' THEN 'MS' WHEN '5' THEN 'NE' WHEN '6' THEN 'MDC' ELSE
                       '?' END) AS [LOC], min(ship_cost), min(sh.total_cost), min(A4GLIdentity), 
                       min(CASE WHEN OH.cmt_3 like '%,%' 
                                THEN SH.tracking_no
                                ELSE (CASE WHEN LEN(OH.cmt_3) > 3 
										  THEN OH.cmt_3 
										  ELSE sh.tracking_no 
								     END) 
							END)
                      AS [tracking_no], 'MALVERN-CLOSED' AS [Zone], min(ship_weight), min(void_fg), min(complete_fg), SUM(hand_chg), MIN(CONVERT(varchar, 
                      CAST(rtrim(SH.ship_dt) AS datetime), 101)), min(SH.filler_0001), min(SH.extra_1), min(CASE WHEN PP.pallet IS NULL THEN ltrim(PP.Carton_UCC128) 
                      ELSE ltrim(pp.Pallet_UCC128) END) AS [Pallet/Carton ID]
FROM         ARSHTTBL SH INNER JOIN
					  oelinhst_sql OL ON ol.item_no = sh.filler_0001 AND ltrim(ol.ord_no) = sh.ord_no INNER JOIN 
					  oehdrhst_sql OH on OH.inv_no = ol.inv_no LEFT OUTER JOIN
                      wsPikPak PP ON ltrim(PP.Ord_no) = SH.ord_no 
WHERE     NOT (SH.ord_no IN
                          (SELECT     ltrim(ord_no)
                            FROM          wsPikPak
                            WHERE shipped = 'Y')) AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > DATEADD(day, - 40, GETDATE())) AND 
                      sh.ord_no <> '' AND sh.void_fg IS NULL 
GROUP BY SH.ord_no, SH.filler_0001, [carrier_cd], cmt_1, ship_via_cd, parceltype

UNION ALL  

/*Shipments processed in MALVERN, not yet invoiced*/ 
SELECT ltrim(SH.ord_no), min(CAST(shipment_no AS varchar(max))) AS [Line No], 
                      min(carrier_cd), 
                      min(CASE mode WHEN '1' THEN 'PS' WHEN '2' THEN 'WS' WHEN '3' THEN 'BC' WHEN '4' THEN 'MS' WHEN '5' THEN 'NE' WHEN '6' THEN 'MDC' ELSE
                       '?' END) AS [LOC], min(ship_cost), min(total_cost), min(A4GLIdentity), min(tracking_no), 'MALVERN-OPEN' AS [Zone], min(ship_weight), min(void_fg), 
                      min(complete_fg), SUM(hand_chg), MIN(CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101)), SH.filler_0001, min(SH.extra_1), 
                      min(CASE WHEN PP.pallet IS NULL THEN ltrim(PP.Carton_UCC128) ELSE ltrim(pp.Pallet_UCC128) END) AS [Pallet/Carton ID]
FROM         ARSHTTBL SH LEFT OUTER JOIN
                      wsPikPak PP ON ltrim(PP.Ord_no) = SH.ord_no INNER JOIN
                      oeordhdr_sql OH ON ltrim(OH.ord_no) = SH.ord_no
WHERE     NOT (SH.ord_no IN
                          (SELECT     ltrim(ord_no)
                            FROM          ARSHTFIL_SQL)) AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > DATEADD(day, - 40, GETDATE())) AND 
                      sh.ord_no <> '' AND sh.void_fg IS NULL
GROUP BY SH.ord_no, SH.filler_0001

UNION ALL

--Catch specific shipments that appear on the WM acknowledgement report that were left off shipment when processing or not processed in the system at all, pull shipping data from order history

SELECT ltrim(oh.ord_no) AS Ord_No, 
                      ol.Line_no, 
	--If order comments contain more than 1 tracking code or carrier code in comments contains typo (doesn't exist in database), then pull the shipping data from wisys, otherwise pull comment shipping data                      
                     CASE WHEN LEFT(OH.cmt_1, 3) IN  (SELECT     sy_code
																	FROM          sycdefil_sql
																	WHERE      cd_type = 'V') 
						 THEN LEFT(OH.cmt_1, 3) 
						 ELSE OH.ship_via_cd 
				      END AS [Carrier_Cd], ol.Loc AS loc, '0.00' AS ship_cost, '0.00' AS total_cost, pp.ID, 
                       CASE WHEN LEN(OH.cmt_3) > 3 
										  THEN OH.cmt_3 
							END AS [tracking_no], 'LEFT OFF/MISSING' AS [zone], pp.weight AS [Ship_weight], '' AS void_fg, 'P' AS complete_fg, 
							CASE WHEN pp.qty is null
							     THEN ol.qty_to_ship
							     ELSE pp.Qty
							 END as [qty], CONVERT(varchar(10), 
                      oh.inv_dt, 101) AS [ship_dt], OL.item_no, cmt_3 AS [cmt_3_tracking_no], CASE WHEN PP.pallet IS NULL THEN ltrim(PP.Carton_UCC128) 
                      ELSE ltrim(pp.Pallet_UCC128) END AS [Pallet/Carton ID]
FROM         oelinhst_sql OL INNER JOIN 
					  oehdrhst_sql OH on OH.inv_no = ol.inv_no LEFT OUTER JOIN
					  [001].dbo.wsPikPak pp ON ol.item_no = pp.Item_no AND ol.ord_no = pp.ord_no
WHERE    (CONVERT(varchar, OH.inv_dt, 101) > DATEADD(day, - 40, GETDATE())) AND ltrim(OH.ord_no) IN ('832324','673511','673714','675544','669782','673758') 
AND (SHIPPED = 'N' OR OL.item_no not IN 
    (SELECT SH.item_no FROM wsPikPak SH WHERE (CONVERT(varchar, SH.ship_dt, 101) > DATEADD(day, - 40, GETDATE())) AND ltrim(SH.ord_no) IN ('832324','673511','673714','675544','669782','673758')))
