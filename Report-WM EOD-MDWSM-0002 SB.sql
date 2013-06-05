--ALTER VIEW [BG_EOD_MDWM-0002SB] AS 

--Created:	10/24/12	 By:	BG
--Last Updated:	/ / 	 By:	BG
--Purpose: Report for EOD for MDWM-0002 SB
--Last Change: --

/*Shipments processed in WISYS, already invoiced, join with OH history to gather updated tracking and carrier if available*/ 
SELECT ltrim(oh.ord_no) AS Ord_No, 
               OH.cus_alt_adr_cd AS [Store], CASE WHEN LEN(cmt_1) = 3 THEN cmt_1 ELSE oh.ship_via_cd END AS [Carrier_Cd], pp.loc AS loc, OH.cmt_3 AS [tracking_no], 
               'INVOICED' AS [zone], pp.weight AS [Ship_weight], pp.Qty AS Qty, CASE WHEN pp.ship_dt IS NULL THEN inv_dt ELSE CONVERT(varchar(10), pp.ship_dt, 101) 
               END AS [Shipped Dt], pp.item_no, CASE WHEN PP.pallet IS NULL THEN ltrim(PP.Carton_UCC128) ELSE ltrim(pp.Pallet_UCC128) END AS [Pallet/Carton ID], 
               'Y' AS Shipped
FROM  			oehdrhst_sql OH LEFT OUTER JOIN
               [001].dbo.wsPikPak pp ON oh.ord_no = pp.ord_no LEFT OUTER JOIN
               [001].dbo.wsShipment ws ON ws.shipment = pp.shipment LEFT OUTER JOIN
               [001].dbo.oebolfil_sql BL ON BL.bol_no = ws.bol_no
WHERE pp.item_no = 'MDWM-0002 SB'