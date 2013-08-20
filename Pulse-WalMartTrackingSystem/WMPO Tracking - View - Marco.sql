--ALTER VIEW BG_WMPO AS

--Created:	4/27/10			     By:	BG
--Last Updated:	08/15/13	     By:	BG
--Purpose:	View for WM PO tracking
--Last changes: 0) Added completely fake line script at bottom  1a)  Added old PO Num  1) Added qty_to_ship > 0 to where clause in shipping acknowledgements, and added temp table that calc's a sum of qty shipped per item per load # and puts that info in the qty shipped column 2) Fixed ship_instruction_1 in where clause to include NULL values


/***********************************************************************/
/*Open Order Shipping Acknowledgement*/
/***********************************************************************/ 

SELECT DISTINCT '838115' AS 'Supplier Acct Number', CAST(OH.oe_po_no AS int) AS 'Wal-Mart PO Number', 
               'Wal-Mart Store Number' = CASE WHEN OH.cus_alt_adr_cd = 'SCHWARZ' THEN '9560'
											  WHEN len(OH.cus_alt_adr_cd) > 5 THEN OH.cus_alt_adr_cd 
											  ELSE OH.cus_alt_adr_cd 
										 END, 
               ltrim(OH.ord_no) AS 'Supplier Sales/Work Order Number', 
               CASE WHEN OL.promise_dt IS NULL THEN CONVERT(varchar, DATEADD(day, + 5, OH.shipping_dt), 101) 
					ELSE CONVERT(varchar, OL.promise_dt, 101) 
			   END AS 'Estimated Ship Date', 
               CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) AS 'Actual Ship Date', 
               'Estimated Date of Arrival' = CONVERT(varchar, DATEADD(day, + 5, SH.ship_dt), 101), 
               'Ship To Name' = CASE WHEN (OH.ship_to_name LIKE 'HAYES%' OR OH.ship_to_name  LIKE 'SCHWARZ%' 
													OR OH.ship_to_name LIKE '%HAYES%'  OR OH.ship_to_name LIKE '%SCHWARZ%') THEN 'CW' 
									WHEN OH.cus_alt_adr_cd = '3P' THEN '3P'
									ELSE 'S' END, 
			   rtrim(replace(OH.ship_to_addr_2, ',', '')) 
               AS 'Ship to Street Address', substring(OH.ship_to_addr_4, 1, (charindex(',', OH.ship_to_addr_4) - 1)) AS 'Ship to City', substring(OH.ship_to_addr_4, (charindex(',', 
               OH.ship_to_addr_4) + 2), 2) AS 'Ship to State', 
               'Carrier SCAC (Standard Carrier Alpha Code) Number' = 
				   CASE WHEN XX.code IS NULL THEN
								   (SELECT rtrim(XX.code)
									FROM   EDCSHVFL_SQL XX
									WHERE OH.ship_via_cd = XX.mac_ship_via) 
						ELSE rtrim(XX.code) END, 
               'Pro Number or Load Number' = 
				   CASE WHEN oh.ship_via_cd = 'XYZ' THEN rtrim(SH.tracking_no) + '-' + (REPLICATE('0',4 - LEN(OH.cus_alt_adr_cd)) + OH.cus_alt_adr_cd)
						ELSE RTRIM(SH.tracking_no) 
				   END, 
               rtrim(cast(ltrim(OH.ord_no) AS CHAR)) AS 'Bill of Lading Number', 
               'Pallet ID Number' = 
					CASE WHEN SH.[Pallet/Carton ID] IS NULL THEN (CASE WHEN SH.ID < 9999 THEN ('838115F' + '00000' + CONVERT(varchar, SH.ID, 101)) 
																	   WHEN SH.ID < 99999 THEN ('838115F' + '0000' + CONVERT(varchar, SH.ID, 101)) 
																	   ELSE ('838115F' + '000' + CONVERT(VARCHAR, SH.ID, 101)) 
																  END) 
						 ELSE '838115A' + '0' + rtrim(ltrim(SH.[Pallet/Carton ID])) 
					END, 
               'Container Type' = CASE substring(OL.item_no, 1, 2) WHEN 'SW' THEN 'BOX' ELSE 'PALLET' END, 'Container Number' = '', 
               'Quantity in Container' = CASE WHEN SH.qty IS NULL THEN rtrim(cast(cast(OL.qty_to_ship AS int) AS char)) 
               WHEN SH.qty > OL.qty_to_ship THEN rtrim(cast(cast(OL.qty_to_ship AS int) AS char)) ELSE rtrim(cast(cast(SH.qty AS int) AS char)) END, 
               'Wal-Mart Item Part Number' = CASE WHEN OL.cus_item_no IS NULL AND rtrim(CI.cus_item_no) IS NULL THEN rtrim(OL.item_no) WHEN OL.cus_item_no IS NULL 
               THEN rtrim(CI.cus_item_no) ELSE rtrim(OL.cus_item_no) END, rtrim(OL.item_no) AS 'Supplier Item Part Number', rtrim(replace(replace(replace(OL.item_desc_1, ',', 
               ' '), '"', 'in'), '''', 'ft')) AS 'Supplier Item Part Number Description', '' AS 'Wal-Mart Component Part Number', '' AS 'Supplier Component Part Number', 
               '' AS 'Supplier Component Description', cast(OL.qty_ordered AS int) AS 'Supplier Quantity Ordered', 
               'Supplier Quantity Shipped' = cast(ShpSum.qty AS int), 
               CASE WHEN qty_to_ship < qty_ordered THEN 'A' ELSE 'C' END AS 'Status', 
               '' AS 'Ship Condition', 'I' AS 'Part Type'
FROM  OEORDLIN_SQL OL WITH (NOLOCK) INNER JOIN
               OEORDHDR_SQL OH WITH (NOLOCK) ON OL.ord_no = OH.ord_no INNER JOIN
               BG_SHIPPED SH WITH (NOLOCK) ON ltrim(OL.ord_no) = ltrim(SH.ord_no) AND OL.line_no = SH.line_no LEFT OUTER JOIN
               OECUSITM_SQL CI WITH (NOLOCK) ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
               EDCSHVFL_SQL XX WITH (NOLOCK) ON SH.carrier_cd = XX.mac_ship_via 
              --LEFT OUTER JOIN imitmidx_sql IM WITH (NOLOCK) ON OL.item_no = IM.item_no               
               --Line Below Added On 3/6/13:  Adds view to sum qty shipped per load/tracking # for the qty shipped column
               LEFT OUTER JOIN
               (SELECT ord_no, item_no, line_no, SUM(qty) AS qty, tracking_no 
               FROM dbo.BG_SHIPPED WITH (NOLOCK)
               GROUP BY line_no, item_no, tracking_no, ord_no) AS ShpSum ON ShpSum.line_no = SH.line_no  
					AND ShpSum.ord_no = SH.ord_no AND ShpSum.tracking_no = SH.tracking_no
WHERE ltrim(OH.cus_no) IN ('1575', '20938', '25000', '35000') AND OH.oe_po_no > '0' AND OH.ord_type = 'O' AND NOT OL.item_no IN ('ADD ON', 'BACKORDER', 
               'CAP EX', 'FIXTURE REQUEST', 'INITIAL DIV 01', 'INITIAL RM', 'INITIAL SC', 'INITIAL WNM', 'PROTOTYPE METAL', 'PROTOTYPE PLASTIC', 'PROTOTYPE WOOD', 
               'REVIEW ITEM', 'SAMPLE') AND OH.oe_po_no IS NOT NULL AND NOT OH.cus_alt_adr_cd IS NULL AND NOT OH.ship_to_addr_2 LIKE 'PO BOX%' AND 
               NOT shipping_dt IS NULL 
               AND OH.ship_to_addr_4 LIKE '%,%' 
               AND isnumeric(cus_alt_adr_cd) = 1 
               AND isnumeric(oe_po_no) = 1 
               AND qty_to_ship > 0 
               AND (NOT(OH.ship_instruction_1 LIKE '%REPLA%') OR OH.ship_instruction_1 IS NULL)
               AND (NOT(OH.user_def_Fld_3 LIKE '%RP%') OR OH.user_def_fld_3 IS NULL)
               AND (NOT(OH.user_def_Fld_4 LIKE '%RP%') OR OH.user_def_fld_4 IS NULL)
               AND NOT ((OH.ord_no + OL.item_no) IN
                   (SELECT OH.ord_no + item_no
                    FROM   oehdrhst_sql OH WITH (NOLOCK) JOIN
                                   oelinhst_sql OL WITH (NOLOCK) ON OH.inv_no = OL.inv_no
                    WHERE qty_to_ship > 0)) 
                  --Exclude split shipment orders
                  AND (OH.ord_no + OL.item_no) NOT IN ('  680261BAK-695 OBV-097', '  680102BAK-ARTBRDE 97', 
               '  680261OBP-1822BSOBV97', '  680524MDWM-0015 SB', '  680524MDWM-0002 SB', '  680524MDWM-0003 SB', '  680524MDWM-0001 SB', '  681451BAK-707 C OBV97', '  681451BAK-707EC OBV97', '  680451BAK-ARTBRDE 97', '  681591BAK-707EC OBV97', '  832531BAK-ARTBRDE 97')
                  --Exclude CR
                  AND (OL.prod_cat NOT IN ('2', '036', '037','102','336') OR LTRIM(OH.ord_no) IN ('697190','695496','696754','696650','695878','695530','696173','696547','696924','697354','695686','696661','696046','692044','695535','696809',' 695736','695632','695490','696480','696456','696370','697823','691111','697064','692430','696045','695110','696856','695633'))
               --Line added 3/6/13: Exclude line items with a qty to ship of 0
               AND qty_to_ship > 0
               --Test Order
               --AND OH.ord_no = '  703650'
                  --Line removed on 2/10/11: Excluding open shipped orders entered more than 14 days ago affects backorder situations where new promise date needs to be transmitted
                  --   AND SH.ship_dt > DATEADD(DAY, - 14, GETDATE())
                                 
/***********************************************************************/
/*Closed Order Shipping Acknowledgement*/
/***********************************************************************/                  

UNION ALL

 SELECT  '838115' AS 'Supplier Acct Number', CAST(OH.oe_po_no AS int) AS 'Wal-Mart PO Number', 
               'Wal-Mart Store Number' = CASE WHEN OH.cus_alt_adr_cd = 'SCHWARZ' THEN '9560'
											  WHEN len(OH.cus_alt_adr_cd) > 5 THEN OH.cus_alt_adr_cd 
											  ELSE OH.cus_alt_adr_cd 
										 END, 
               ltrim(OH.ord_no) AS 'Supplier Sales/Work Order Number', 
               CASE WHEN OL.promise_dt IS NULL THEN CONVERT(varchar, DATEADD(day, + 5, OH.shipping_dt), 101) 
               ELSE CONVERT(varchar, OL.promise_dt, 101) END AS 'Estimated Ship Date', CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) AS 'Actual Ship Date', 
               'Estimated Date of Arrival' = CONVERT(varchar, DATEADD(day, + 5, SH.ship_dt), 101), 
               'Ship To Name' = CASE WHEN (OH.ship_to_name LIKE 'HAYES%' OR OH.ship_to_name  LIKE 'SCHWARZ%' OR OH.ship_to_name LIKE '%HAYES%'  OR OH.ship_to_name LIKE '%SCHWARZ%') THEN 'CW' 
									WHEN OH.cus_alt_adr_cd = '3P' THEN '3P'
									ELSE 'S' 
				END,
               rtrim(replace(OH.ship_to_addr_2, ',', '')) AS 'Ship to Street Address', 
               substring(OH.ship_to_addr_4, 1, (charindex(',', OH.ship_to_addr_4) - 1)) AS 'Ship to City', 
               substring(OH.ship_to_addr_4, (charindex(',', OH.ship_to_addr_4) + 2), 2) AS 'Ship to State', 
               'Carrier SCAC (Standard Carrier Alpha Code) Number' = 
				   CASE WHEN XX.code IS NULL THEN
								   (SELECT rtrim(XX.code)
									FROM   EDCSHVFL_SQL XX
									WHERE OH.ship_via_cd = XX.mac_ship_via) 
						ELSE rtrim(XX.code) END, 
               'Pro Number or Load Number' = 
				   CASE WHEN oh.ship_via_cd = 'XYZ' THEN rtrim(SH.tracking_no) + '-' + (REPLICATE('0',4 - LEN(OH.cus_alt_adr_cd)) + OH.cus_alt_adr_cd)
						ELSE RTRIM(SH.tracking_no) 
				   END, 
               rtrim(cast(ltrim(OH.ord_no) AS CHAR)) AS 'Bill of Lading Number', 
               'Pallet ID Number' = 
					CASE WHEN SH.[Pallet/Carton ID] IS NULL THEN (CASE WHEN SH.ID < 9999 THEN ('838115F' + '00000' + CONVERT(varchar, SH.ID, 101)) 
																	   WHEN SH.ID < 99999 THEN ('838115F' + '0000' + CONVERT(varchar, SH.ID, 101)) 
																	   ELSE ('838115F' + '000' + CONVERT(VARCHAR, SH.ID, 101)) 
																  END) 
						 ELSE '838115A' + '0' + rtrim(ltrim(SH.[Pallet/Carton ID])) 
					END,                 
               'Container Type' = CASE substring(OL.item_no, 1, 2) WHEN 'SW' THEN 'BOX' ELSE 'PALLET' END, 'Container Number' = '', 
               'Quantity in Container' = CASE WHEN SH.qty IS NULL THEN rtrim(cast(cast(OL.qty_to_ship AS int) AS char)) WHEN SH.qty > SUM(OL.qty_to_ship) 
               THEN rtrim(cast(cast(sum(OL.qty_to_ship) AS int) AS char)) ELSE rtrim(cast(cast(SH.qty AS int) AS char)) END, 
               'Wal-Mart Item Part Number' = 
               CASE WHEN max(OL.cus_item_no) IS NULL AND rtrim(max(CI.cus_item_no)) IS NULL THEN rtrim(max(OL.item_no)) 
					WHEN max(OL.cus_item_no) IS NULL THEN rtrim(max(CI.cus_item_no)) ELSE rtrim(max(OL.cus_item_no)) END, rtrim(MAX(OL.item_no)) 
               AS 'Supplier Item Part Number', rtrim(replace(replace(replace(OL.item_desc_1, ',', ' '), '"', 'in'), '''', 'ft')) AS 'Supplier Item Part Number Description', 
               '' AS 'Wal-Mart Component Part Number', '' AS 'Supplier Component Part Number', '' AS 'Supplier Component Description', cast(SUM(OL.qty_ordered) AS int) 
               AS 'Supplier Quantity Ordered', 
               'Supplier Quantity Shipped' = 
               CASE WHEN OH.ord_no = '  701736' THEN '0'
                    ELSE cast(ShpSumTot.qty AS int)
               END, 
               CASE WHEN OH.ord_no+OL.item_no IN 
							(SELECT ord_no+item_no  FROM oeordlin_Sql) 
					THEN 'A' 
                    ELSE 'C' 
               END AS 'Status', 
               '' AS 'Ship Condition', 'I' AS 'Part Type'
FROM  OELINHST_SQL OL  WITH (NOLOCK) INNER JOIN 
       OEHDRHST_SQL OH WITH (NOLOCK) ON OL.inv_no = OH.inv_no 
       JOIN  BG_SHIPPED SH WITH (NOLOCK) ON ltrim(OL.ord_no) = ltrim(SH.ord_no) AND OL.line_no = SH.line_no 
        --Join Below Added On 3/6/13:  Adds view to sum TOTAL qty shipped per ORDER for the A/C column
        --Join Below Removed on 3/7/13:  Making query run too long
       /*LEFT OUTER JOIN
         (SELECT BG.ord_no, BG.item_no, BG.line_no, SUM(BG.qty) AS qty
		  FROM dbo.BG_SHIPPED BG  WITH (NOLOCK)
		  GROUP BY BG.ord_no, BG.line_no, BG.item_no) AS ShpSumTot ON ShpSumTot.line_no = OL.line_no  
		           AND ShpSumTot.ord_no = OL.ord_no*/
       LEFT OUTER JOIN OECUSITM_SQL CI WITH (NOLOCK) ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no 
       LEFT OUTER JOIN EDCSHVFL_SQL XX WITH (NOLOCK) ON SH.carrier_cd = XX.mac_ship_via 
       --LEFT OUTER JOIN imitmidx_sql IM WITH (NOLOCK) ON OL.item_no = IM.item_no 
       --Join Below Added On 3/6/13:  Adds view to sum qty shipped per load/tracking # for the qty shipped column
       LEFT OUTER JOIN
		   (SELECT ord_no, item_no, line_no, SUM(qty) AS qty, tracking_no 
		   FROM dbo.BG_SHIPPED WITH (NOLOCK)
		   GROUP BY line_no, item_no, tracking_no, ord_no) AS ShpSum ON ShpSum.line_no = SH.line_no  
				AND ShpSum.ord_no = SH.ord_no AND ShpSum.tracking_no = SH.tracking_no
	  --Join Below Added On 8/1/13:  Adds view to sum total qty shipped per item # for the total qty shipped column
	   LEFT OUTER JOIN
		   (SELECT ord_no AS ord_no, item_no, SUM(qty) AS qty 
			--changed from wspikpak on 8/15 to account for items not processed in Wisys (BG_shipped includes invoiced orders not proc. in wisys)
			FROM bg_shipped WITH (NOLOCK)
			GROUP BY item_no, ord_no) AS ShpSumTot ON ShpSumTot.item_no = SH.item_no  
				AND ShpSumTot.ord_no = SH.ord_no 
WHERE (ltrim(OH.cus_no) IN ('1575', '20938', '25000', '35000') 
	   AND OH.oe_po_no > '0' AND OH.ord_type = 'O' 
	   AND NOT OL.item_no IN ('ADD ON', 'BACKORDER', 'CAP EX', 'FIXTURE REQUEST', 'INITIAL DIV 01', 'INITIAL RM', 'INITIAL SC', 
	   'INITIAL WNM', 'PROTOTYPE METAL', 'PROTOTYPE PLASTIC', 'PROTOTYPE WOOD','REVIEW ITEM', 'SAMPLE') 
 	   AND OH.oe_po_no IS NOT NULL 
 	   AND NOT OH.cus_alt_adr_cd IS NULL 
 	   AND NOT OH.ship_to_addr_2 LIKE 'PO BOX%'  
       AND NOT shipping_dt IS NULL 
       AND OH.ship_to_addr_4 LIKE '%,%' 
       --AND isnumeric(cus_alt_adr_cd) = 1 
       AND isnumeric(oe_po_no) = 1 
       AND qty_to_ship > 0
       AND (NOT(OH.ship_instruction_1 LIKE '%REPLA%') OR OH.ship_instruction_1 IS NULL)
       AND (NOT(OH.user_def_Fld_3 LIKE '%RP%') OR OH.user_def_fld_3 IS NULL)
       AND (NOT(OH.user_def_Fld_4 LIKE '%RP%') OR OH.user_def_fld_4 IS NULL)
       --Exclude split shipment orders
       AND (OH.ord_no + OL.item_no) NOT IN ('  680261BAK-695 OBV-097', '  680102BAK-ARTBRDE 97', 
       '  680261OBP-1822BSOBV97', '  680524MDWM-0015 SB', '  680524MDWM-0002 SB', '  680524MDWM-0003 SB', '  680524MDWM-0001 SB', 
       '  681451BAK-707 C OBV97', '  681451BAK-707EC OBV97', '  680451BAK-ARTBRDE 97', '  681591BAK-707EC OBV97', '  832531BAK-ARTBRDE 97')
       --Line added 11/9/11: Exclude orders entered more than 30 days ago
       AND OH.inv_dt > DATEADD(DAY,-33,GETDATE())
       --Line added 3/6/13: Exclude line items with a qty to ship of 0
       -- AND qty_to_ship > 0
       --Exclude fucked up orders with duplicate line numbers
       AND NOT (OH.ord_no = '  701266' AND OL.id = '683182')             
       --Exclude CR
       AND (OL.prod_cat NOT IN ('2', '036', '037','102','336') OR LTRIM(OH.ord_no) IN ('697190','695496','696754','696650','695878','695530','696173','696547','696924','697354','695686','696661','696046','692044','695535','696809',' 695736','695632','695490','696480','696456','696370','697823','691111','697064','692430','696045','695110','696856','695633'))
       --Test Order
       --AND OH.ord_no = '  711395'
       --Exclude bad shipments that have to be manually fixed
       --AND ((OH.ord_no + RTRIM(OL.item_no)) NOT IN ('  701911OBP-BAN008OBV97'))
       --Add older orders
       ) OR OH.oe_po_no IN ('31971720' , '31951116', '31772580', '31994422','31915613','32055458')
GROUP BY OH.ord_no, oe_po_no, OH.cus_alt_adr_cd, OL.promise_dt, OH.shipping_dt, SH.ship_dt, OH.cus_no, OH.ship_to_addr_2, OH.ship_to_addr_4, OH.ship_via_cd, OH.ship_via_cd, XX.code, SH.tracking_no, SH.[Pallet/Carton ID], SH.ID, OL.item_desc_1, OL.item_no, SH.Qty, OL.qty_to_ship, OH.ship_to_name, ShpSumTot.Qty

/***********************************************************************/
/*Order Acknowledgement*/
/***********************************************************************/

UNION ALL

 SELECT '838115' AS 'Supplier Acct Number', CAST(OH.oe_po_no AS int) AS 'Wal-Mart PO Number', 
               'Wal-Mart Store Number' = CASE WHEN OH.cus_alt_adr_cd = 'SCHWARZ' THEN '9560'
											  WHEN len(OH.cus_alt_adr_cd) > 5 THEN OH.cus_alt_adr_cd 
											  ELSE OH.cus_alt_adr_cd 
										 END, 
               CAST(OH.ord_no AS int) AS 'Supplier Sales/Work Order Number', 
               CASE WHEN OL.promise_dt IS NULL THEN CONVERT(varchar, DATEADD(day, + 5, OH.shipping_dt), 101) 
				    ELSE CONVERT(varchar, OL.promise_dt, 101) 
			   END AS 'Estimated Ship Date', 
			   '' AS 'Actual Ship Date', 
               'Estimated Date of Arrival' = CASE WHEN OL.promise_dt IS NULL THEN CONVERT(varchar, DATEADD(day, + 9, OH.shipping_dt), 101) 
               ELSE CONVERT(varchar, DATEADD(day, + 4, OL.promise_dt), 101) END, 
               'Ship To Name' = CASE WHEN (OH.ship_to_name LIKE 'HAYES%' OR OH.ship_to_name  LIKE 'SCHWARZ%' OR OH.ship_to_name LIKE '%HAYES%'  OR OH.ship_to_name LIKE '%SCHWARZ%') THEN 'CW' 
									WHEN OH.cus_alt_adr_cd = '3P' THEN '3P'
									ELSE 'S' END,
               rtrim(replace(OH.ship_to_addr_2, ',', ''))  AS 'Ship to Street Address', 
               substring(OH.ship_to_addr_4, 1, (charindex(',', OH.ship_to_addr_4) - 1)) AS 'Ship to City', 
               substring(OH.ship_to_addr_4, (charindex(',', OH.ship_to_addr_4) + 2), 2) AS 'Ship to State', 
               'Carrier SCAC (Standard Carrier Alpha Code) Number' = '', 
               'Pro Number or Load Number' = '', 
               'Bill of Lading Number' = '', 
               'Pallet ID Number' = '', 
               'Container Type' = '', 
               'Container Number' = '', 
               'Quantity in Container' = '', 
               'Wal-Mart Item Part Number' = CASE WHEN OL.cus_item_no IS NULL AND rtrim(CI.cus_item_no) IS NULL THEN rtrim(OL.item_no) WHEN OL.cus_item_no IS NULL 
               THEN rtrim(CI.cus_item_no) ELSE rtrim(OL.cus_item_no) END, rtrim(OL.item_no) AS 'Supplier Item Part Number', rtrim(replace(replace(replace(OL.item_desc_1, ',', 
               ' '), '"', 'in'), '''', 'ft')) AS 'Supplier Item Part Number Description', '' AS 'Wal-Mart Component Part Number', '' AS 'Supplier Component Part Number', 
               '' AS 'Supplier Component Description', 
               CASE WHEN OH.ord_no + OL.item_no = '  680451BAK-ARTBRDE 97' THEN 2 WHEN OH.ord_no + OL.item_no = '  681451BAK-707EC OBV97' THEN 6 WHEN OH.ord_no +
                OL.item_no = '  681451BAK-707 C OBV97' THEN 3 WHEN OH.ord_no + OL.item_no = '  681591BAK-707EC OBV97' THEN 8 ELSE cast(OL.qty_ordered AS int) 
               END AS 'Supplier Quantity Ordered', 0 AS 'Supplier Quantity Shipped', 'A' AS 'Status', '' AS 'Ship Condition', 'I' AS 'Part Type'
FROM  OEORDLIN_SQL OL  WITH (NOLOCK) INNER JOIN
               OEORDHDR_SQL OH  WITH (NOLOCK) ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
               OECUSITM_SQL CI  WITH (NOLOCK) ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no 
               --LEFT OUTER JOIN imitmidx_sql IM  WITH (NOLOCK) ON OL.item_no = IM.item_no
WHERE ltrim(OH.cus_no) IN ('1575', '20938', '25000', '35000') AND OH.oe_po_no > '0' AND OH.ord_type = 'O' AND NOT OL.item_no IN ('ADD ON', 
               'BACKORDER', 'CAP EX', 'FIXTURE REQUEST', 'INITIAL DIV 01', 'INITIAL RM', 'INITIAL SC', 'INITIAL WNM', 'PROTOTYPE METAL', 'PROTOTYPE PLASTIC', 
               'PROTOTYPE WOOD', 'REVIEW ITEM', 'SAMPLE') AND OH.oe_po_no IS NOT NULL AND NOT OH.cus_alt_adr_cd IS NULL AND 
               NOT OH.ship_to_addr_2 LIKE 'PO BOX%' 
               AND NOT shipping_dt IS NULL  
               AND LEN(cus_alt_adr_cd) < 11 
               AND isnumeric(oe_po_no) = 1
               AND OL.shipped_dt IS NULL 
               AND (NOT(OH.ship_instruction_1 LIKE '%REPLA%') OR OH.ship_instruction_1 IS NULL)
               AND (NOT(OH.user_def_Fld_3 LIKE '%RP%') OR OH.user_def_fld_3 IS NULL)
               AND (NOT(OH.user_def_Fld_4 LIKE '%RP%') OR OH.user_def_fld_4 IS NULL)
               --Exclude split shipment orders
               AND (OH.ord_no + OL.item_no) NOT IN ('  680261BAK-695 OBV-097', 
               '  680102BAK-ARTBRDE 97', '  680261OBP-1822BSOBV97', '  680524MDWM-0015 SB', '  680524MDWM-0002 SB', 
               '  680524MDWM-0003 SB', '  680524MDWM-0001 SB', '  832531BAK-ARTBRDE 97') 
               --Test Order
               --AND OH.ord_no = '  711531'
               --Line added 11/9/11: Exclude orders entered more than 21 days ago
               --Line removed 2/8/11:  Orders entered more than 21 days ago are necessary to be included in situations of backorders where promise date is updated on the old item
               --AND entered_dt > DATEADD(DAY,-21,GETDATE())
               
UNION ALL
--Fake upload lines for split shipments, etc.  **Be sure to exclude the faked lines from the actual acknowledgements above to avoid duplication***/ 

SELECT '838115' AS 'Supplier Acct Number',
                CAST(OH.oe_po_no AS int) AS 'Wal-Mart PO Number', 'Wal-Mart Store Number' = CASE WHEN len(OH.cus_alt_adr_cd) > 6 THEN CAST('9999' AS int) 
               ELSE OH.cus_alt_adr_cd END, ltrim(OH.ord_no) AS 'Supplier Sales/Work Order Number', CASE WHEN OL.promise_dt IS NULL THEN CONVERT(varchar, 
               DATEADD(day, + 5, OH.shipping_dt), 101) ELSE CONVERT(varchar, OL.promise_dt, 101) END AS 'Estimated Ship Date', 
               CASE WHEN OH.ord_no = '  670551' THEN '04/07/2011' ELSE CONVERT(varchar, CAST(rtrim(PP.ship_dt) AS datetime), 101) END AS 'Actual Ship Date', 
               CASE WHEN OH.ord_no = '  670551' THEN '04/12/2011' ELSE CONVERT(varchar, DATEADD(day, + 5, PP.ship_dt), 101) END AS 'Estimated Date of Arrival', 
               'Ship To Name' = CASE WHEN (OH.ship_to_name LIKE 'HAYES%' OR OH.ship_to_name  LIKE 'SCHWARZ%' OR OH.ship_to_name LIKE '%HAYES%'  OR OH.ship_to_name LIKE '%SCHWARZ%') THEN 'CW' 
									WHEN OH.cus_alt_adr_cd = '3P' THEN '3P'
									ELSE 'S' END, rtrim(replace(OH.ship_to_addr_2, ',', '')) 
               AS 'Ship to Street Address', substring(OH.ship_to_addr_4, 1, (charindex(',', OH.ship_to_addr_4) - 1)) AS 'Ship to City', substring(OH.ship_to_addr_4, (charindex(',', 
               OH.ship_to_addr_4) + 2), 2) AS 'Ship to State', 'Carrier SCAC (Standard Carrier Alpha Code) Number' = CASE WHEN XX.code IS NULL THEN
                   (SELECT rtrim(XX.code)
                    FROM   EDCSHVFL_SQL XX
                    WHERE OH.ship_via_cd = XX.mac_ship_via) ELSE rtrim(XX.code) END, 
               CASE WHEN pp.trackingno IS NULL 
					THEN CASE WHEN OH.cmt_3 LIKE '%,%' 
							  THEN dbo.FindLastDelimited(',', cmt_3) 
							  WHEN LEN(OH.cmt_3) > 3 
							  THEN OH.cmt_3 
							  ELSE '087558833'
						 END
					ELSE pp.TrackingNo
               END AS 'Pro Number or Load Number', 
               rtrim(cast(ltrim(OH.ord_no) AS CHAR)) AS 'Bill of Lading Number', 'Pallet ID Number' = CASE WHEN PP.Carton IS NULL 
               THEN (CASE WHEN OL.ID < 9999 THEN ('838115F' + '00000' + CONVERT(varchar, OL.ID, 101)) WHEN OL.ID < 99999 THEN ('838115F' + '0000' + CONVERT(varchar, 
               OL.ID, 101)) ELSE ('838115F' + '000' + CONVERT(VARCHAR, OL.ID, 101)) END) ELSE '838115A' + '0' + rtrim(ltrim(PP.Carton)) END, 
               'Container Type' = CASE substring(OL.item_no, 1, 2) WHEN 'SW' THEN 'BOX' ELSE 'PALLET' END, 'Container Number' = '', 
               'Quantity in Container' = CASE WHEN (OH.ord_no + OL.item_no) IN ('  701816BSC-16UNIV WMBV') THEN '4' WHEN (OH.ord_no + OL.item_no) 
               IN ('  680524MDWM-0015 SB') THEN '7' WHEN (OH.ord_no + OL.item_no) IN ('  680524MDWM-0002 SB') THEN '3' WHEN (OH.ord_no + OL.item_no) 
               IN ('  680524MDWM-0003 SB') THEN '11' WHEN (OH.ord_no + OL.item_no) IN ('  680524MDWM-0001 SB') THEN '3' WHEN (OH.ord_no + OL.item_no) 
               IN ('  680085GRO-011 WM BV') THEN '14' WHEN (OH.ord_no + OL.item_no) IN ('  832531BAK-ARTBRDE 97') 
               THEN '2' /*WHEN PP.qty > OL.qty_to_ship THEN rtrim(cast(cast(OL.qty_to_ship AS int) AS char)) */ ELSE rtrim(cast(cast(PP.qty AS int) AS char)) END, 
               'Wal-Mart Item Part Number' = CASE WHEN OL.cus_item_no IS NULL AND rtrim(CI.cus_item_no) IS NULL THEN rtrim(OL.item_no) WHEN OL.cus_item_no IS NULL 
               THEN rtrim(CI.cus_item_no) ELSE rtrim(OL.cus_item_no) END, rtrim(OL.item_no) AS 'Supplier Item Part Number', rtrim(replace(replace(replace(OL.item_desc_1, ',', 
               ' '), '"', 'in'), '''', 'ft')) AS 'Supplier Item Part Number Description', '' AS 'Wal-Mart Component Part Number', '' AS 'Supplier Component Part Number', 
               '' AS 'Supplier Component Description', 
               CASE WHEN (OH.ord_no + OL.item_no) IN ('  701816BSC-16UNIV WMBV') THEN '4' ELSE cast(OL.qty_ordered AS int) END AS 'Supplier Quantity Ordered', 
               CASE WHEN (OH.ord_no + OL.item_no) 
               IN ('  701816BSC-16UNIV WMBV') THEN '4' ELSE cast(OL.qty_ordered AS int) END AS 'Supplier Quantity Shipped', 
               'C' AS 'Status', '' AS 'Ship Condition', 'I' AS 'Part Type'
FROM  OELINHST_SQL OL WITH (NOLOCK) INNER JOIN
               OEHDRHST_SQL OH WITH (NOLOCK) ON OL.inv_no = OH.inv_no LEFT OUTER JOIN
               wsPikPak PP WITH (NOLOCK) ON PP.Ord_no = OH.ord_no AND PP.line_no = OL.line_no LEFT OUTER JOIN
               /*BG_SHIPPED SH ON ltrim(OL.ord_no) = ltrim(SH.ord_no) AND OL.item_no = SH.item_no LEFT OUTER JOIN*/ OECUSITM_SQL CI WITH (NOLOCK) ON OL.item_no = CI.item_no AND 
               OH.cus_no = CI.cus_no LEFT OUTER JOIN
               EDCSHVFL_SQL XX WITH (NOLOCK) ON
                   (SELECT CASE WHEN OH.cmt_1 LIKE '%,%' THEN (CASE WHEN PP.ParcelType = 'UPS' THEN 'UPG' WHEN PP.ParcelType = 'FedEx' THEN 'FXG' WHEN PP.parcelType
                                    IS NULL THEN (CASE WHEN LEFT(OH.cmt_1, 3) IN
                                       (SELECT sy_code
                                        FROM   sycdefil_sql
                                        WHERE cd_type = 'V') THEN LEFT(OH.cmt_1, 3) 
                                   ELSE (CASE PP.ParcelType WHEN 'UPS' THEN 'UPG' WHEN 'FedEx' THEN 'FXG' ELSE OH.ship_via_cd END) END) END) END) 
               = XX.mac_ship_via 
               --LEFT OUTER JOIN imitmidx_sql IM WITH (NOLOCK) ON OL.item_no = OL.item_no
WHERE ltrim(OH.cus_no) IN ('1575', '20938', '25000', '35000') AND OH.oe_po_no > '0' AND OH.ord_type = 'O' AND NOT OL.item_no IN ('ADD ON', 'BACKORDER', 
               'CAP EX', 'FIXTURE REQUEST', 'INITIAL DIV 01', 'INITIAL RM', 'INITIAL SC', 'INITIAL WNM', 
               'PROTOTYPE METAL', 'PROTOTYPE PLASTIC', 'PROTOTYPE WOOD', 'REVIEW ITEM', 'SAMPLE') 
               AND OH.oe_po_no IS NOT NULL AND NOT OH.cus_alt_adr_cd IS NULL AND NOT OH.ship_to_addr_2 LIKE 'PO BOX%' AND 
               NOT shipping_dt IS NULL AND OH.ship_to_addr_4 LIKE '%,%' AND isnumeric(cus_alt_adr_cd) = 1 
               AND isnumeric(oe_po_no) = 1 AND qty_to_ship > 0 AND ((OH.ord_no + OL.item_no) IN ('') OR OH.ord_no = '  ')
UNION ALL
--Totally fake item, never was shipped, but we are acknowledging it to get it off of the report
SELECT '838115'	,'31756973'	,'5337'	,'701579'	,'1/26/2013'	,'1/26/2013'	,'1/29/2013'	,'CW'	,'951 TOWN EAST BLVD'                      	,'MESQUITE'	,'TX'	,'TRN'    ,'1261343'	,'701579',	'838115F009234210',	'PALLET',	'', '1',	'100047072',	'BW-WALLSTEP','STEP WALL FLORAL DEPT 84 208 PROTO','','','', '1'	,'1','C','','I'

