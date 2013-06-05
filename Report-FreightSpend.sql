--ALTER VIEW BG_Freight_Report AS

--Created:	9/13/12	 By:	BG
--Last Updated:	9/13/12	 By:	BG
--Purpose:	Shows freight history for freight bids and freight analysis
--Last changes: --


SELECT DISTINCT ltrim(oh.inv_no) AS Inv_No, 
               /*If order comments contain more than 1 tracking code or carrier code in comments contains typo (doesn't exist in database), then pull the shipping data from wisys, otherwise pull comment shipping data                      */ 
             CASE WHEN OH.cmt_1 LIKE '%,%' THEN (CASE WHEN PP.ParcelType = 'UPS' THEN 'UPG' WHEN PP.ParcelType = 'FedEx' THEN 'FXG' WHEN PP.parcelType IS NULL 
                  THEN (CASE WHEN bl.ship_via_cd IS NULL THEN OH.ship_via_cd ELSE bl.ship_via_cd END) END) ELSE (CASE WHEN LEFT(OH.cmt_1, 3) IN
                   (SELECT sy_code
                    FROM   sycdefil_sql
                    WHERE cd_type = 'V') THEN LEFT(OH.cmt_1, 3) 
               ELSE (CASE PP.ParcelType WHEN 'UPS' THEN 'UPG' WHEN 'FedEx' THEN 'FXG' ELSE (CASE WHEN bl.ship_via_cd IS NULL 
               THEN OH.ship_via_cd ELSE bl.ship_via_cd END) END) END) END AS [Carrier_Cd], CASE WHEN pp.Loc IS NULL THEN OH.mfg_loc ELSE pp.loc END AS loc, frt_amt AS frt_cost, tot_sls_amt AS Inv_Amt,  
               SUM(pp.weight) AS [Ship_weight],  
               --OH.frt_pay_cd, BL.bol_pre_collect_fg,
               CASE WHEN pp.ship_dt IS NOT NULL  THEN pp.ship_dt 
					 ELSE CONVERT(varchar(10), oh.inv_dt, 101) END AS [ship_dt], 
			   OH.ship_to_addr_4,
			   substring(OH.ship_to_addr_4, 0, (charindex(',', OH.ship_to_addr_4) - 0)) AS 'Ship to City', 
			   substring(OH.ship_to_addr_4, (charindex(',', OH.ship_to_addr_4) + 2), 2) AS 'Ship to State',
			   RIGHT(RTRIM(OH.ship_to_addr_4), 5) AS [Ship to Zip],
			   cmt_1,
			   cmt_2,
			   cmt_3
			   
FROM     oehdrhst_sql OH LEFT OUTER JOIN
               [001].dbo.wsPikPak pp ON oh.ord_no = pp.ord_no LEFT OUTER JOIN
               [001].dbo.wsShipment ws ON ws.shipment = pp.shipment LEFT OUTER JOIN
               [001].dbo.oebolfil_sql BL ON BL.bol_no = ws.bol_no
WHERE OH.inv_dt > '01/01/2012' AND NOT OH.ship_to_addr_2 LIKE 'PO BOX%'
		AND (bol_pre_collect_fg = 'P' OR (frt_pay_cd = 'T' AND bol_pre_collect_fg IS NULL))
		AND OH.ship_to_country = 'US'
GROUP BY inv_no, carrier_cd, loc, frt_amt, OH.ship_to_addr_4, PP.ship_dt, OH.inv_dt, OH.cmt_3, OH.cmt_1, pp.ParcelType, OH.ship_via_cd, BL.ship_via_cd, OH.mfg_loc, OH.tot_sls_amt, cmt_1, cmt_2, cmt_3
