 USE [001]
 /*
 SELECT               'Dock' = CASE 
							WHEN (SH.mode = 1) THEN CAST('Plastics' AS varchar) 
							WHEN (SH.mode = 2) THEN CAST('Woodshop' As varchar) 
							WHEN (SH.mode = 3) THEN CAST('Beach' AS varchar) 
							WHEN (SH.mode = 4) THEN CAST('Central Shipping' AS varchar)
							WHEN (SH.mode = 5) THEN CAST('New Everman' AS varchar)
						ELSE CAST('Other' AS varchar) END,
					/*OH.status AS 'STATUS',*/ CAST(OH.ord_no AS int) AS 'ORDER', CAST(OH.oe_po_no AS int) AS 'PO', /*CAST(OH.cus_no AS int) AS 'CUSTOMER',*/ 
                      OH.cus_alt_adr_cd AS 'STORE', rtrim(OL.item_no) AS 'ITEM', rtrim(CI.cus_item_no) AS 'WM_ITEM', /*rtrim(OL.item_desc_1) AS 'ITEM_DESC',*/SH.hand_chg AS 'QTY_SHIPPED', /*CONVERT(varchar, OH.shipping_dt, 101) AS 'EST_SHIP_DATE'*/ 
                      CONVERT(varchar, CAST(RTRIM(SH.ship_dt) AS datetime), 101) AS [SHIP_DT], /*CONVERT(varchar, OL.promise_dt, 101) AS 'PROMISE_DATE',*/ /*OH.ship_to_name AS 'SHIP_TO_NAME',*/ /*rtrim(OH.ship_to_addr_2) 
                      AS 'ADDRESS', substring(OH.ship_to_addr_4, 1, (charindex(',', OH.ship_to_addr_4) - 1)) AS 'CITY', substring(OH.ship_to_addr_4, (charindex(',', 
                      OH.ship_to_addr_4) + 2), 2) AS 'STATE', SH.carrier_cd AS 'CARRIER', */rtrim(XX.code) AS 'SCAC',  /*rtrim(SH.tracking_no) AS 'TRACKING' */
                      PL.palletid AS 'PALLET_ID'/*, PL.quantity AS 'SUM_PALLET_QTY',*/  /*OL.qty_ordered AS 'QTY_ORDERED', */
					   
 FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      WMPALID PL ON OH.oe_po_no = PL.purchaseorder AND OL.item_no = PL.marco_item_no LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via
WHERE     /* INITIAL WHERE CLAUSE */ ltrim(OH.cus_no) IN ('1575', '20938') AND OH.oe_po_no > '0' AND OH.ord_type = 'O' AND 
                      NOT OH.user_def_fld_4 LIKE '%ON%' AND NOT OH.user_def_fld_4 LIKE '%FX%' AND NOT OH.user_def_fld_4 LIKE '%RP%' AND OH.slspsn_no IN ('011',
                       '047') AND OH.oe_po_no IS NOT NULL AND SH.void_fg IS NULL AND NOT OL.item_no IN ('ADD ON', 'BACKORDER', 'CAP EX', 'FIXTURE REQUEST', 
                      'INITIAL DIV 01', 'INITIAL RM', 'INITIAL SC', 'INITIAL WNM', 'PROTOTYPE METAL', 'PROTOTYPE PLASTIC', 'PROTOTYPE WOOD', 'REVIEW ITEM', 
                      'SAMPLE','DVD SHELF SET','WM-PETITEMOMZONE','WM-MOVIEDUMPBIN') AND isnumeric(OH.oe_po_no) = 1 /* ONLY PALLET_MISSING_SHIPPED RECORDS */ AND (OH.ord_no IN
                          (SELECT DISTINCT cast(ord_no AS int)
                            FROM          arshttbl) AND NOT SH.hand_chg IS NULL)  
                            /*For Only Yesterday*/
                            AND ((SH.void_fg IS NULL) AND (CONVERT(varchar, CAST(RTRIM(SH.ship_dt) 
                      AS datetime), 101) > (CONVERT(VARCHAR, (DATEADD(day, - 6, GETDATE()) ), 101))) )

UNION ALL*/

 SELECT               'Dock' = CASE 
							WHEN (SH.mode = 1) THEN CAST('Plastics' AS varchar) 
							WHEN (SH.mode = 2) THEN CAST('Woodshop' As varchar) 
							WHEN (SH.mode = 3) THEN CAST('Beach' AS varchar) 
							WHEN (SH.mode = 4) THEN CAST('Central Shipping' AS varchar)
							WHEN (SH.mode = 5) THEN CAST('New Everman' AS varchar)
						ELSE CAST('Other' AS varchar) END,
					/*OH.status AS 'STATUS',*/ CAST(OH.ord_no AS int) AS 'ORDER', CAST(OH.oe_po_no AS int) AS 'PO', /*CAST(OH.cus_no AS int) AS 'CUSTOMER',*/ 
                      OH.cus_alt_adr_cd AS 'STORE', rtrim(OL.item_no) AS 'ITEM', rtrim(CI.cus_item_no) AS 'WM_ITEM', /*rtrim(OL.item_desc_1) AS 'ITEM_DESC',*/SH.hand_chg AS 'QTY_SHIPPED', /*CONVERT(varchar, OH.shipping_dt, 101) AS 'EST_SHIP_DATE'*/ 
                      CONVERT(varchar, CAST(RTRIM(SH.ship_dt) AS datetime), 101) AS [SHIP_DT], /*CONVERT(varchar, OL.promise_dt, 101) AS 'PROMISE_DATE',*/ /*OH.ship_to_name AS 'SHIP_TO_NAME',*/ /*rtrim(OH.ship_to_addr_2) 
                      AS 'ADDRESS', substring(OH.ship_to_addr_4, 1, (charindex(',', OH.ship_to_addr_4) - 1)) AS 'CITY', substring(OH.ship_to_addr_4, (charindex(',', 
                      OH.ship_to_addr_4) + 2), 2) AS 'STATE', SH.carrier_cd AS 'CARRIER', */rtrim(XX.code) AS 'SCAC',  /*rtrim(SH.tracking_no) AS 'TRACKING' */
                      PL.palletid AS 'PALLET_ID'/*, PL.quantity AS 'SUM_PALLET_QTY',*/  /*OL.qty_ordered AS 'QTY_ORDERED', */
					   
 FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no INNER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      WMPALID PL ON OH.oe_po_no = PL.purchaseorder AND OL.item_no = PL.marco_item_no LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via
WHERE     /* INITIAL WHERE CLAUSE */ ltrim(OH.cus_no) IN ('1575', '20938') AND OH.oe_po_no > '0' AND OH.ord_type = 'O' AND 
                      NOT OH.user_def_fld_4 LIKE '%ON%' AND NOT OH.user_def_fld_4 LIKE '%FX%' AND NOT OH.user_def_fld_4 LIKE '%RP%' AND OH.slspsn_no IN ('011',
                       '047') AND OH.oe_po_no IS NOT NULL AND SH.void_fg IS NULL AND NOT OL.item_no IN ('ADD ON', 'BACKORDER', 'CAP EX', 'FIXTURE REQUEST', 
                      'INITIAL DIV 01', 'INITIAL RM', 'INITIAL SC', 'INITIAL WNM', 'PROTOTYPE METAL', 'PROTOTYPE PLASTIC', 'PROTOTYPE WOOD', 'REVIEW ITEM', 
                      'SAMPLE','DVD SHELF SET','WM-PETITEMOMZONE','WM-MOVIEDUMPBIN') AND isnumeric(OH.oe_po_no) = 1 /* ONLY PALLET_MISSING_SHIPPED RECORDS */ AND (OH.ord_no IN
                          (SELECT DISTINCT cast(ord_no AS int)
                            FROM          arshttbl) AND NOT SH.hand_chg IS NULL)  
                            /*For Only Yesterday*/
                            AND ((SH.void_fg IS NULL) AND (CONVERT(varchar, CAST(RTRIM(SH.ship_dt) 
                      AS datetime), 101) > (CONVERT(VARCHAR, (DATEADD(day, - 3, GETDATE()) ), 101))) )


