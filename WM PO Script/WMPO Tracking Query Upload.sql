                  
/*Open Order Shipping Acknowledgement*/
SELECT     '838115' AS 'Supplier Acct Number', CAST(OH.oe_po_no AS int) AS 'Wal-Mart PO Number', 
                      'Wal-Mart Store Number' = CASE WHEN len(OH.cus_alt_adr_cd) > 6 THEN CAST('9999' AS int) ELSE OH.cus_alt_adr_cd END, ltrim(OH.ord_no) 
                      AS 'Supplier Sales/Work Order Number', CONVERT(varchar, OH.shipping_dt, 101) AS 'Estimated Ship Date', CONVERT(varchar, CAST(rtrim(SH.ship_dt) 
                      AS datetime), 101) AS 'Actual Ship Date', 'Estimated Date of Arrival' = CASE WHEN OL.promise_dt IS NULL THEN CONVERT(varchar, DATEADD(day, + 5, 
                      OH.shipping_dt), 101) ELSE CONVERT(varchar, OL.promise_dt, 101) END, 
                      'Ship To Name' = CASE WHEN OH.ship_to_addr_2 =
                          (SELECT     AA.addr_2
                            FROM          ARALTADR_SQL AA
                            WHERE      OH.cus_no = AA.cus_no AND OH.cus_alt_adr_cd = AA.cus_alt_adr_cd) THEN 'S' ELSE 'CW' END, rtrim(replace(OH.ship_to_addr_2, ',', '')) 
                      AS 'Ship to Street Address', substring(OH.ship_to_addr_4, 1, (charindex(',', OH.ship_to_addr_4) - 1)) AS 'Ship to City', substring(OH.ship_to_addr_4, 
                      (charindex(',', OH.ship_to_addr_4) + 2), 2) AS 'Ship to State', 'Carrier SCAC (Standard Carrier Alpha Code) Number' = CASE WHEN XX.code IS NULL 
                      THEN
                          (SELECT     rtrim(XX.code)
                            FROM          EDCSHVFL_SQL XX
                            WHERE      OH.ship_via_cd = XX.mac_ship_via) ELSE rtrim(XX.code) END, rtrim(SH.extra_1) AS 'Pro Number or Load Number', 
                      rtrim(cast(ltrim(OH.ord_no) AS CHAR)) AS 'Bill of Lading Number', 
                      'Pallet ID Number' = CASE 
                      WHEN PL.palletid IS NULL 
                      THEN (CASE WHEN SH.A4GLIDENTITY < 99999 
							THEN ('838115F' + '0000' + CONVERT(varchar, SH.A4GLIDENTITY, 101))
							ELSE ('838115F' + '000' + CONVERT(VARCHAR, SH.A4GLIDENTITY, 101))
							END)
                      ELSE PL.palletid 
                      END,
                      'Container Type' = CASE substring(OL.item_no, 1, 2) WHEN 'SW' THEN 'BOX' ELSE 'PALLET' END, 
                      'Container Number' = '', 'Quantity in Container' = CASE WHEN PL.quantity IS NULL THEN rtrim(cast(cast(OL.qty_ordered AS int) AS char)) 
                      WHEN PL.quantity > OL.qty_ordered THEN rtrim(cast(cast(OL.qty_ordered AS int) AS char)) ELSE rtrim(cast(cast(PL.quantity AS int) AS char)) END, 
                      'Wal-Mart Item Part Number' = CASE WHEN OL.cus_item_no IS NULL AND rtrim(CI.cus_item_no) IS NULL THEN rtrim(OL.item_no) 
                      WHEN OL.cus_item_no IS NULL THEN rtrim(CI.cus_item_no) ELSE rtrim(OL.cus_item_no) END, rtrim(OL.item_no) AS 'Supplier Item Part Number', 
                      rtrim(replace(replace(replace(IM.item_desc_1, ',', ' '), '"', 'in'), '''', 'ft')) AS 'Supplier Item Part Number Description', 
                      '' AS 'Wal-Mart Component Part Number', '' AS 'Supplier Component Part Number', '' AS 'Supplier Component Description', cast(OL.qty_ordered AS int) 
                      AS 'Supplier Quantity Ordered', 'Supplier Quantity Shipped' = CASE WHEN SH.hand_chg <> OL.qty_ordered THEN cast(OL.qty_ordered AS int) 
                      ELSE cast(SH.hand_chg AS int) END, 'C' AS 'Status', 'Shipped' AS 'Ship Condition', 'I' AS 'Part Type'
FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no INNER JOIN
                      Z_ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      WMPALID PL ON OH.oe_po_no = PL.purchaseorder AND OL.item_no = PL.marco_item_no LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via LEFT OUTER JOIN
                      imitmidx_sql IM ON OL.item_no = IM.item_no
WHERE     ltrim(OH.cus_no) IN ('1575', '20938') AND OH.oe_po_no > '0' AND OH.ord_type = 'O' AND NOT OH.user_def_fld_4 LIKE '%ON%' AND 
                      NOT OH.user_def_fld_4 LIKE '%FX%' AND NOT OH.user_def_fld_4 LIKE '%RP%' AND NOT OH.user_def_fld_4 LIKE '%PH%' AND OH.slspsn_no IN ('011', 
                      '047') AND OH.oe_po_no IS NOT NULL AND NOT OH.cus_alt_adr_cd IS NULL AND NOT OH.ship_to_addr_2 LIKE 'PO BOX%' AND 
                      NOT shipping_dt IS NULL AND NOT OL.item_no IN ('ADD ON', 'BACKORDER', 'CAP EX', 'FIXTURE REQUEST', 'INITIAL DIV 01', 'INITIAL RM', 
                      'INITIAL SC', 'INITIAL WNM', 'PROTOTYPE METAL', 'PROTOTYPE PLASTIC', 'PROTOTYPE WOOD', 'REVIEW ITEM', 'SAMPLE', 'WM-PETITEMOMZONE', 
                      'WM-MOVIEDUMPBIN', 'DVD SHELF SET') AND isnumeric(OH.oe_po_no) = 1 
                      AND NOT OH.oe_po_no like '%7141840%'
                      /*	Conditions just for Open Order Shipped	- Pull orders shipped in last 7 days from Malvern*/ AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > DATEADD(day, -7, GETDATE()))
UNION ALL

/*Closed Order Shipping Acknowledgement*/
SELECT     '838115' AS 'Supplier Acct Number', CAST(OH.oe_po_no AS bigint) AS 'Wal-Mart PO Number', 
                      'Wal-Mart Store Number' = CASE WHEN len(OH.cus_alt_adr_cd) > 6 THEN CAST('9999' AS bigint) ELSE OH.cus_alt_adr_cd END, ltrim(OH.ord_no) 
                      AS 'Supplier Sales/Work Order Number', CONVERT(varchar, OH.shipping_dt, 101) AS 'Estimated Ship Date', CONVERT(varchar, CAST(rtrim(SH.ship_dt) 
                      AS datetime), 101) AS 'Actual Ship Date', 'Estimated Date of Arrival' = CASE WHEN OL.promise_dt IS NULL THEN CONVERT(varchar, DATEADD(day, + 5, 
                      OH.shipping_dt), 101) ELSE CONVERT(varchar, OL.promise_dt, 101) END, 'Ship To Name' = CASE WHEN OH.ship_to_addr_2 =
                          (SELECT     AA.addr_2
                            FROM          ARALTADR_SQL AA
                            WHERE      OH.cus_no = AA.cus_no AND OH.cus_alt_adr_cd = AA.cus_alt_adr_cd) THEN 'S' ELSE 'CW' END, rtrim(replace(OH.ship_to_addr_2, ',', '')) 
                      AS 'Ship to Street Address', substring(OH.ship_to_addr_4, 1, (charindex(',', OH.ship_to_addr_4) - 1)) AS 'Ship to City', substring(OH.ship_to_addr_4, 
                      (charindex(',', OH.ship_to_addr_4) + 2), 2) AS 'Ship to State', 'Carrier SCAC (Standard Carrier Alpha Code) Number' = CASE WHEN XX.code IS NULL 
                      THEN
                          (SELECT     rtrim(XX.code)
                            FROM          EDCSHVFL_SQL XX
                            WHERE      OH.ship_via_cd = XX.mac_ship_via) ELSE rtrim(XX.code) END, rtrim(SH.extra_1) AS 'Pro Number or Load Number', 
                      rtrim(cast(ltrim(OH.ord_no) AS CHAR)) AS 'Bill of Lading Number', 
                      'Pallet ID Number' = CASE 
                      WHEN PL.palletid IS NULL 
                      THEN (CASE WHEN SH.A4GLIDENTITY < 99999 
							THEN ('838115F' + '0000' + CONVERT(varchar, SH.A4GLIDENTITY, 101))
							ELSE ('838115F' + '000' + CONVERT(VARCHAR, SH.A4GLIDENTITY, 101))
							END)
                      ELSE PL.palletid 
                      END,
                      'Container Type' = CASE substring(OL.item_no, 1, 2) WHEN 'SW' THEN 'BOX' ELSE 'PALLET' END, 
                      'Container Number' = '', 'Quantity in Container' = CASE WHEN PL.quantity IS NULL THEN rtrim(cast(cast(OL.qty_ordered AS bigint) AS char)) 
                      WHEN PL.quantity > OL.qty_ordered THEN rtrim(cast(cast(OL.qty_ordered AS bigint) AS char)) ELSE rtrim(cast(cast(PL.quantity AS bigint) AS char)) END, 
                      'Wal-Mart Item Part Number' = CASE WHEN OL.cus_item_no IS NULL AND rtrim(CI.cus_item_no) IS NULL THEN rtrim(OL.item_no) 
                      WHEN OL.cus_item_no IS NULL THEN rtrim(CI.cus_item_no) ELSE rtrim(OL.cus_item_no) END, rtrim(OL.item_no) AS 'Supplier Item Part Number', 
                      rtrim(replace(replace(replace(IM.item_desc_1, ',', ' '), '"', 'in'), '''', 'ft')) AS 'Supplier Item Part Number Description', 
                      '' AS 'Wal-Mart Component Part Number', '' AS 'Supplier Component Part Number', '' AS 'Supplier Component Description', cast(OL.qty_ordered AS bigint) 
                      AS 'Supplier Quantity Ordered', 'Supplier Quantity Shipped' = CASE WHEN SH.hand_chg <> OL.qty_ordered THEN cast(OL.qty_ordered AS bigint) 
                      ELSE cast(SH.hand_chg AS bigint) END, 'C' AS 'Status', 'Shipped' AS 'Ship Condition', 'I' AS 'Part Type'
FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no INNER JOIN
                      Z_ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS bigint) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      WMPALID PL ON OH.oe_po_no = PL.purchaseorder AND OL.item_no = PL.marco_item_no LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via LEFT OUTER JOIN
                      imitmidx_sql IM ON OL.item_no = IM.item_no
WHERE     ltrim(OH.cus_no) IN ('1575', '20938') AND OH.ord_type = 'O' AND NOT OH.user_def_fld_4 LIKE '%ON%' AND NOT OH.user_def_fld_4 LIKE '%FX%' AND 
                      NOT OH.user_def_fld_4 LIKE '%RP%' AND NOT OH.user_def_fld_4 LIKE '%PH%' AND OH.slspsn_no IN ('011', '047') AND OH.oe_po_no > '0' AND 
                      OH.oe_po_no IS NOT NULL AND NOT OH.cus_alt_adr_cd IS NULL AND NOT OH.ship_to_addr_2 LIKE 'PO BOX%' AND NOT shipping_dt IS NULL AND 
                      NOT OL.item_no IN ('ADD ON', 'BACKORDER', 'CAP EX', 'FIXTURE REQUEST', 'INITIAL DIV 01', 'INITIAL RM', 'INITIAL SC', 'INITIAL WNM', 
                      'PROTOTYPE METAL', 'PROTOTYPE PLASTIC', 'PROTOTYPE WOOD', 'REVIEW ITEM', 'SAMPLE', 'WM-PETITEMOMZONE', 'WM-MOVIEDUMPBIN', 
                      'DVD SHELF SET') AND isnumeric(OH.oe_po_no) = 1 
                      AND NOT OH.oe_po_no like '%7141840%'
                      /*	Conditions just for History	- Pull orders shipped in last 7 days from Malvern*/ AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > DATEADD(day, -7, GETDATE()))
UNION ALL

/*Order Acknowledgement*/
SELECT     '838115' AS 'Supplier Acct Number', CAST(OH.oe_po_no AS int) AS 'Wal-Mart PO Number', 
                      'Wal-Mart Store Number' = CASE WHEN len(OH.cus_alt_adr_cd) > 6 THEN CAST('9999' AS int) ELSE OH.cus_alt_adr_cd END, CAST(OH.ord_no AS int) 
                      AS 'Supplier Sales/Work Order Number', CONVERT(varchar, OH.shipping_dt, 101) AS 'Estimated Ship Date', 'Actual Ship Date' = '', 
                      'Estimated Date of Arrival' = CASE WHEN OL.promise_dt IS NULL THEN CONVERT(varchar, DATEADD(day, + 5, OH.shipping_dt), 101) 
                      ELSE CONVERT(varchar, OL.promise_dt, 101) END, 'Ship To Name' = CASE WHEN OH.ship_to_addr_2 =
                          (SELECT     AA.addr_2
                            FROM          ARALTADR_SQL AA
                            WHERE      OH.cus_no = AA.cus_no AND OH.cus_alt_adr_cd = AA.cus_alt_adr_cd) THEN 'S' ELSE 'CW' END, rtrim(replace(OH.ship_to_addr_2, ',', '')) 
                      AS 'Ship to Street Address', substring(OH.ship_to_addr_4, 1, (charindex(',', OH.ship_to_addr_4) - 1)) AS 'Ship to City', substring(OH.ship_to_addr_4, 
                      (charindex(',', OH.ship_to_addr_4) + 2), 2) AS 'Ship to State', 'Carrier SCAC (Standard Carrier Alpha Code) Number' = '', 
                      'Pro Number or Load Number' = '', 'Bill of Lading Number' = '', 'Pallet ID Number' = '', 'Container Type' = '', 'Container Number' = '', 
                      'Quantity in Container' = '', 'Wal-Mart Item Part Number' = CASE WHEN OL.cus_item_no IS NULL AND rtrim(CI.cus_item_no) IS NULL 
                      THEN rtrim(OL.item_no) WHEN OL.cus_item_no IS NULL THEN rtrim(CI.cus_item_no) ELSE rtrim(OL.cus_item_no) END, rtrim(OL.item_no) 
                      AS 'Supplier Item Part Number', rtrim(replace(replace(replace(IM.item_desc_1, ',', ' '), '"', 'in'), '''', 'ft')) AS 'Supplier Item Part Number Description', 
                      '' AS 'Wal-Mart Component Part Number', '' AS 'Supplier Component Part Number', '' AS 'Supplier Component Description', cast(OL.qty_ordered AS int) 
                      AS 'Supplier Quantity Ordered', 0 AS 'Supplier Quantity Shipped', 'A' AS 'Status', 'Not Shipped' AS 'Ship Condition', 'I' AS 'Part Type'
FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      Z_ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      imitmidx_sql IM ON OL.item_no = IM.item_no
WHERE     ltrim(OH.cus_no) IN ('1575', '20938') AND OH.oe_po_no > '0' AND OH.ord_type = 'O' AND NOT OH.user_def_fld_4 LIKE '%ON%' AND 
                      NOT OH.user_def_fld_4 LIKE '%FX%' AND NOT OH.user_def_fld_4 LIKE '%RP%' AND NOT OH.user_def_fld_4 LIKE '%PH%' AND OH.slspsn_no IN ('011', 
                      '047') AND OH.oe_po_no IS NOT NULL AND NOT OH.cus_alt_adr_cd IS NULL AND NOT OH.ship_to_addr_2 LIKE 'PO BOX%' AND 
                      NOT shipping_dt IS NULL AND NOT OL.item_no IN ('ADD ON', 'BACKORDER', 'CAP EX', 'FIXTURE REQUEST', 'INITIAL DIV 01', 'INITIAL RM', 
                      'INITIAL SC', 'INITIAL WNM', 'PROTOTYPE METAL', 'PROTOTYPE PLASTIC', 'PROTOTYPE WOOD', 'REVIEW ITEM', 'SAMPLE', 'WM-PETITEMOMZONE', 
                      'WM-MOVIEDUMPBIN', 'DVD SHELF SET') AND isnumeric(OH.oe_po_no) = 1 /*	Conditions just for ack script			*/ AND SH.ord_no IS NULL
                      AND NOT OH.oe_po_no like '%7141840%'
