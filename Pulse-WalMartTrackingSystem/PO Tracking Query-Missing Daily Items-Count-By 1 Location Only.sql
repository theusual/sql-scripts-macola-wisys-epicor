SELECT COUNT(distinct OL.item_no)
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
                            FROM          arshttbl) AND PL.palletid IS NULL AND NOT SH.hand_chg IS NULL)
                            /*FOR ONLY 1 SHOP*/
							AND (SH.mode = 2)   
                            /*For Only Yesterday*/
                            AND ((SH.void_fg IS NULL) AND (CONVERT(varchar, CAST(RTRIM(SH.ship_dt) 
                      AS datetime), 101) > DATEADD(day, - 4, GETDATE()))) 

/* HISTORY RECORDS */
/*UNION ALL
SELECT OH.status AS 'STATUS', CAST(OH.ord_no AS int) AS 'ORDER', CAST(OH.oe_po_no AS int) AS 'PO', CAST(OH.cus_no AS int) 
                      AS 'CUSTOMER', OH.cus_alt_adr_cd AS 'STORE', rtrim(OL.item_no) AS 'ITEM', rtrim(CI.cus_item_no) AS 'CUST_ITEM', 
                      OH.shipping_dt AS 'EST_SHIP_DATE', SH.ship_dt AS 'ACTUAL_SHIP_DATE', OL.promise_dt AS 'PROMISE_DATE', 
                      OH.ship_to_name AS 'SHIP_TO_NAME', rtrim(OH.ship_to_addr_2) AS 'ADDRESS', substring(OH.ship_to_addr_4, 1, (charindex(',', OH.ship_to_addr_4) 
                      - 1)) AS 'CITY', substring(OH.ship_to_addr_4, (charindex(',', OH.ship_to_addr_4) + 2), 2) AS 'STATE', SH.carrier_cd AS 'CARRIER', rtrim(XX.code) 
                      AS 'SCAC', rtrim(SH.tracking_no) AS 'TRACKING', PL.palletid AS 'PALLET_ID', PL.quantity AS 'SUM_PALLET_QTY', rtrim(OL.item_desc_1) 
                      AS 'ITEM_DESC', OL.qty_ordered AS 'QTY_ORDERED', SH.hand_chg AS 'QTY_SHIPPED', 'MISSING' AS 'ERROR', SH.mode AS 'Dock'
FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      WMPALID PL ON OH.oe_po_no = PL.purchaseorder AND OL.item_no = PL.marco_item_no LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via
WHERE     /* INITIAL WHERE CLAUSE */ ltrim(OH.cus_no) IN ('1575', '20938') AND OH.oe_po_no > '0' AND OH.ord_type = 'O' AND 
                      NOT OH.user_def_fld_4 LIKE '%ON%' AND NOT OH.user_def_fld_4 LIKE '%FX%' AND NOT OH.user_def_fld_4 LIKE '%RP%' AND OH.slspsn_no IN ('011',
                       '047') AND OH.oe_po_no IS NOT NULL AND SH.void_fg IS NULL AND NOT OL.item_no IN ('ADD ON', 'BACKORDER', 'CAP EX', 'FIXTURE REQUEST', 
                      'INITIAL DIV 01', 'INITIAL RM', 'INITIAL SC', 'INITIAL WNM', 'PROTOTYPE METAL', 'PROTOTYPE PLASTIC', 'PROTOTYPE WOOD', 'REVIEW ITEM', 
                      'SAMPLE') AND isnumeric(OH.oe_po_no) = 1 /* ONLY PALLET_MISSING_SHIPPED RECORDS */ AND (OH.ord_no IN
                          (SELECT DISTINCT cast(ord_no AS int)
                            FROM          arshttbl) AND PL.palletid IS NULL AND NOT SH.hand_chg IS NULL) /*	Conditions just for History		*/ AND OH.inv_dt > DATEADD(day, - 7, 
                      getdate())
                       */