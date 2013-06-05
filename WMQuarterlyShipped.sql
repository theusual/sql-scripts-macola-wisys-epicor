SELECT     OH.cus_alt_adr_cd AS Store, OH.ord_no, CASE WHEN ISNUMERIC(OH.oe_po_no) = 1 THEN CAST(CAST(OH.oe_po_no AS int) AS char) 
                      ELSE OH.oe_po_no END AS PO_No, IM.prod_cat AS Prod_Cat, OL.item_no AS Marco_Item, OL.cus_item_no AS WM_Item, OL.item_desc_1 AS Desc_1, 
                      OL.qty_ordered AS Qty, OH.user_def_fld_4 AS Ord_Typ, OH.ship_instruction_1 AS Ship_N1, OH.ship_instruction_2 AS Ship_N2, 
                      OH.ship_via_cd AS Ship_Via, CONVERT(varchar, OH.shipping_dt, 1) AS Est_Ship_Dt, CONVERT(varchar,
                          (SELECT     MIN(entered_dt) AS Expr1
                            FROM          dbo.Z_ALLORDHDR AS ah
                            WHERE      (oe_po_no = OH.oe_po_no)), 1) AS Entered_Dt, 
                      CONVERT(varchar, OH.user_def_fld_5, 1) AS Initials, CONVERT(varchar, OL.promise_dt, 1) AS Promise_Dt, CONVERT(varchar, 
                      CAST(RTRIM(SH.ship_dt) AS datetime), 1) AS Dt_Shipped, SH.carrier_cd + ', ' + SH.extra_1 AS Malvern_Dtl, OL.unit_price AS Unit_Price
FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no INNER JOIN
                      Z_ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS bigint) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      WMPALID PL ON ltrim(OH.ord_no) = PL.[order] AND OL.item_no = PL.marco_item_no LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via LEFT OUTER JOIN
                      imitmidx_sql IM ON OL.item_no = IM.item_no
WHERE                 ltrim(OH.cus_no) IN ('1575','25000', '35000') 
                       AND OH.oe_po_no > '0' 
                       AND OH.ord_type = 'O' 
                       AND NOT OL.item_no IN ('ADD ON', 'BACKORDER', 'CAP EX', 'FIXTURE REQUEST', 'INITIAL DIV 01', 'INITIAL RM', 
                           'INITIAL SC', 'INITIAL WNM', 'PROTOTYPE METAL', 'PROTOTYPE PLASTIC', 'PROTOTYPE WOOD', 'REVIEW ITEM', 'SAMPLE') 
                       AND OH.slspsn_no IN ('011', '047') 
                       AND NOT shipping_dt IS NULL 
                       AND isnumeric(OH.oe_po_no) = 1 
                       AND unit_price > 0.00
                     /*	Conditions just for ack script			*/ 
                       AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > DATEADD(day, - 91, GETDATE()))
UNION ALL

SELECT     OH.cus_alt_adr_cd AS Store, OH.ord_no, CASE WHEN ISNUMERIC(OH.oe_po_no) = 1 THEN CAST(CAST(OH.oe_po_no AS int) AS char) 
                      ELSE OH.oe_po_no END AS PO_No, IM.prod_cat AS Prod_Cat, OL.item_no AS Marco_Item, OL.cus_item_no AS WM_Item, OL.item_desc_1 AS Desc_1, 
                      OL.qty_ordered AS Qty, OH.user_def_fld_4 AS Ord_Typ, OH.ship_instruction_1 AS Ship_N1, OH.ship_instruction_2 AS Ship_N2, 
                      OH.ship_via_cd AS Ship_Via, CONVERT(varchar, OH.shipping_dt, 1) AS Est_Ship_Dt, CONVERT(varchar,
                          (SELECT     MIN(entered_dt) AS Expr1
                            FROM          dbo.Z_ALLORDHDR AS ah
                            WHERE      (oe_po_no = OH.oe_po_no)), 1) AS Entered_Dt, 
                      CONVERT(varchar, OH.user_def_fld_5, 1) AS Initials, CONVERT(varchar, OL.promise_dt, 1) AS Promise_Dt, CONVERT(varchar, 
                      CAST(RTRIM(SH.ship_dt) AS datetime), 1) AS Dt_Shipped, SH.carrier_cd + ', ' + SH.extra_1 AS Malvern_Dtl, OL.unit_price AS Unit_Price
FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no INNER JOIN
                      Z_ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      WMPALID PL ON ltrim(OH.ord_no) = PL.[order] AND OL.item_no = PL.marco_item_no LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via LEFT OUTER JOIN
                      imitmidx_sql IM ON OL.item_no = IM.item_no
WHERE     ltrim(OH.cus_no) IN ('1575','25000', '35000') 
                       AND OH.oe_po_no > '0' 
                       AND OH.ord_type = 'O' 
                       AND NOT OL.item_no IN ('ADD ON', 'BACKORDER', 'CAP EX', 'FIXTURE REQUEST', 'INITIAL DIV 01', 'INITIAL RM', 
                           'INITIAL SC', 'INITIAL WNM', 'PROTOTYPE METAL', 'PROTOTYPE PLASTIC', 'PROTOTYPE WOOD', 'REVIEW ITEM', 'SAMPLE') 
                       AND OH.slspsn_no IN ('011', '047') 
                       AND NOT shipping_dt IS NULL 
                       AND isnumeric(OH.oe_po_no) = 1
                       AND unit_price > 0.00
					/*	Conditions just for Open Order Shipped	- Pull orders shipped in last 90 days from Malvern*/ 
					   AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > DATEADD(day, - 91, GETDATE()))