/*Shipments processed in WISYS, already invoiced, join with OH history to gather updated tracking and carrier if available*/ SELECT ltrim(oh.ord_no) AS Ord_No, 
                      OH.cus_alt_adr_cd AS [Store], CASE WHEN LEN(cmt_1) = 3 THEN cmt_1 ELSE oh.ship_via_cd END AS [Carrier_Cd], pp.loc AS loc, OH.cmt_3 AS [tracking_no], 'WISYS-CLOSED' AS [zone], 
                      pp.weight AS [Ship_weight], pp.Qty AS Qty, CASE WHEN pp.ship_dt is null THEN  inv_dt ELSE  CONVERT(varchar(10), pp.ship_dt, 101)END AS [Shipped Dt], pp.item_no, CASE WHEN PP.pallet IS NULL 
                      THEN ltrim(PP.Carton_UCC128) ELSE ltrim(pp.Pallet_UCC128) END AS [Pallet/Carton ID], 'Y' AS Shipped
FROM         oehdrhst_sql OH INNER JOIN
                      [001].dbo.wsPikPak pp ON oh.ord_no = pp.ord_no LEFT OUTER JOIN
                      [001].dbo.wsShipment ws ON ws.shipment = pp.shipment LEFT OUTER JOIN
                      [001].dbo.oebolfil_sql BL ON BL.bol_no = ws.bol_no
WHERE     oh.ord_no < '  679508' AND oh.ord_no > '  676373' 
UNION ALL
/*Shipments processed in WISYS, not yet invoiced*/ SELECT ltrim(oh.ord_no) AS Ord_No, OH.cus_alt_adr_cd AS [Store], CASE WHEN bl.ship_via_cd is null THEN oh.ship_via_cd ELSE bl.ship_via_cd END AS [Carrier_Cd], 
                      pp.loc AS loc, pp.TrackingNo[tracking_no], 'WISYS-OPEN' AS [zone], pp.weight AS [Ship_weight], pp.Qty AS Qty, CONVERT(varchar(10), pp.ship_dt, 101) 
                      AS [Shipped Dt], pp.item_no, CASE WHEN PP.pallet IS NULL THEN ltrim(PP.Carton_UCC128) ELSE ltrim(pp.Pallet_UCC128) END AS [Pallet/Carton ID], 
                      pp.shipped
FROM         oeordhdr_sql OH INNER JOIN
                      [001].dbo.wsPikPak pp ON oh.ord_no = pp.ord_no LEFT OUTER JOIN
                      [001].dbo.wsShipment ws ON ws.shipment = pp.shipment LEFT OUTER JOIN
                      [001].dbo.oebolfil_sql BL ON BL.bol_no = ws.bol_no
WHERE     pp.ord_no < '  679508' AND pp.ord_no > '  676373'
UNION ALL
/*Shipments processed outside of Wisys, already invoiced*/ 
SELECT ltrim(oh.ord_no) AS Ord_No, OH.cus_alt_adr_cd AS [Store], CASE WHEN LEN(cmt_1) = 3 THEN cmt_1 ELSE oh.ship_via_cd END AS [Carrier_Cd], 
                      'MDC' AS loc, OH.cmt_3 AS [tracking_no], 'NOT IN WISYS-INVOICED' AS [zone], '100' AS [Ship_weight], '1' AS Qty, CONVERT(varchar(10), OH.inv_dt, 101) 
                      AS [Shipped Dt], 'WM-MOVIEDUMPBIN', '10' + cast(oh.id AS varchar(max)) AS [Pallet/Carton ID], 
                      'Y'
FROM         oehdrhst_sql OH INNER JOIN oelinhst_sql OL on OL.ord_no = OH.ord_no
WHERE     item_no = 'WM-MOVIEDUMPBIN' and loc = 'MDC'
			AND NOT(OH.ord_no IN (select ord_no from wsPikPak where item_no = 'WM-MOVIEDUMPBIN' and loc = 'MDC'))


