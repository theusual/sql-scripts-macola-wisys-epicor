--ALTER VIEW BG_LATE_ORDERS_NONWM AS 

--Created:	02/01/11	 By:	BG
--Last Updated:	10/10/13	 By:	BG
--Purpose:	View for Late Order Report refreshed each morning by production control
--Last Change:  Adding ship_instruction_1 for WM GO dates.  Added back prod cat #2, added back cus #9999
--Last Change 2: Added the wspikpak table for shipments check
--Last Change 3: Changed wspikpak lookup to only remove lines that have a total qty shipped >= total qty ordered

SELECT TOP (100) PERCENT CONVERT(varchar, CAST(RTRIM(dbo.oeordhdr_sql.shipping_dt) AS datetime), 101) AS [Shipping Date], CONVERT(varchar, 
               CAST(RTRIM(dbo.oeordhdr_sql.entered_dt) AS datetime), 101) AS Entered_Dt, dbo.oeordhdr_sql.ord_no, dbo.oeordlin_sql.loc AS [Ship From], 
               dbo.oeordhdr_sql.bill_to_name, dbo.oeordhdr_sql.ship_to_name, LTRIM(dbo.oeordhdr_sql.cus_no) AS Cus_No, dbo.oeordlin_sql.line_seq_no AS [Ln], 
               dbo.oeordlin_sql.prod_cat AS [CAT], dbo.oeordlin_sql.item_no, CAST (dbo.oeordlin_sql.qty_ordered AS INT) AS [OrdQty], 
               dbo.oeordlin_sql.user_def_fld_1 AS [Late Order Comments 1], 
               dbo.oeordlin_sql.user_def_fld_2 AS [Late Order Comments 2], 
			   dbo.oeordhdr_sql.slspsn_no AS [SALES #], 
               dbo.oeordhdr_sql.cus_alt_adr_cd AS [Store #], 
               dbo.imitmidx_sql.item_note_1 AS NOTE1, 

			   CASE WHEN Z_IMINVLOC_EC.qty_on_hand is null AND Z_IMINVLOC_WC.qty_on_hand is null THEN CAST (dbo.Z_IMINVLOC.qty_on_hand AS INT)
				    WHEN Z_IMINVLOC_EC.qty_on_hand is null AND (dbo.Z_IMINVLOC.qty_on_hand - Z_IMINVLOC_WC.qty_on_hand)  < 0 THEN 0
					WHEN Z_IMINVLOC_EC.qty_on_hand is null THEN CAST ((dbo.Z_IMINVLOC.qty_on_hand - Z_IMINVLOC_WC.qty_on_hand) AS INT)
					WHEN Z_IMINVLOC_WC.qty_on_hand is null AND (dbo.Z_IMINVLOC.qty_on_hand - Z_IMINVLOC_EC.qty_on_hand)  < 0 THEN 0
					WHEN Z_IMINVLOC_WC.qty_on_hand is null THEN CAST ((dbo.Z_IMINVLOC.qty_on_hand - Z_IMINVLOC_EC.qty_on_hand) AS INT)
			        WHEN (dbo.Z_IMINVLOC.qty_on_hand - Z_IMINVLOC_EC.qty_on_hand - Z_IMINVLOC_WC.qty_on_hand)  < 0 THEN 0
			        ELSE CAST ((dbo.Z_IMINVLOC.qty_on_hand - Z_IMINVLOC_EC.qty_on_hand - Z_IMINVLOC_WC.qty_on_hand) AS INT)
			   END AS [QOH FW],
			   CASE  WHEN Z_IMINVLOC_EC.qty_on_hand is null  THEN CAST (dbo.Z_IMINVLOC.qty_on_hand as INT)
			         ELSE CAST (Z_IMINVLOC_EC.qty_on_hand AS INT)
			   END AS [QOH NC],
			   CASE  WHEN Z_IMINVLOC_WC.qty_on_hand is null  THEN CAST (dbo.Z_IMINVLOC.qty_on_hand AS INT)
			         ELSE CAST (Z_IMINVLOC_WC.qty_on_hand AS INT)
			   END AS [QOH AZ],

			   CASE WHEN Z_IMINVLOC_EC.qty_on_ord is null AND Z_IMINVLOC_WC.qty_on_ord is null THEN CAST (dbo.Z_IMINVLOC.qty_on_ord AS INT)
				    WHEN Z_IMINVLOC_EC.qty_on_ord is null AND (dbo.Z_IMINVLOC.qty_on_ord - Z_IMINVLOC_WC.qty_on_ord)  < 0 THEN 0
					WHEN Z_IMINVLOC_EC.qty_on_ord is null THEN CAST ((dbo.Z_IMINVLOC.qty_on_ord - Z_IMINVLOC_WC.qty_on_ord) AS INT)
					WHEN Z_IMINVLOC_WC.qty_on_ord is null AND (dbo.Z_IMINVLOC.qty_on_ord - Z_IMINVLOC_EC.qty_on_ord)  < 0 THEN 0
					WHEN Z_IMINVLOC_WC.qty_on_ord is null THEN CAST ((dbo.Z_IMINVLOC.qty_on_ord - Z_IMINVLOC_EC.qty_on_ord) AS INT)
			        WHEN (dbo.Z_IMINVLOC.qty_on_ord - Z_IMINVLOC_EC.qty_on_ord - Z_IMINVLOC_WC.qty_on_ord)  < 0 THEN 0
			        ELSE CAST ((dbo.Z_IMINVLOC.qty_on_ord - Z_IMINVLOC_EC.qty_on_ord - Z_IMINVLOC_WC.qty_on_ord) AS INT)
			   END AS [QOO FW],
			   CASE  WHEN Z_IMINVLOC_EC.qty_on_ord is null  THEN CAST (dbo.Z_IMINVLOC.qty_on_ord AS INT)
			         ELSE CAST (Z_IMINVLOC_EC.qty_on_ord AS INT)
			   END AS [QOO NC],
			   CASE  WHEN Z_IMINVLOC_WC.qty_on_ord is null  THEN CAST (dbo.Z_IMINVLOC.qty_on_ord AS INT)
			         ELSE CAST (Z_IMINVLOC_WC.qty_on_ord AS INT)
			   END AS [QOO AZ], 

			   CASE WHEN Z_IMINVLOC_EC.qty_allocated is null AND Z_IMINVLOC_WC.qty_allocated is null THEN CAST (dbo.Z_IMINVLOC.qty_allocated AS INT)
				    WHEN Z_IMINVLOC_EC.qty_allocated is null AND (dbo.Z_IMINVLOC.qty_allocated - Z_IMINVLOC_WC.qty_allocated)  < 0 THEN 0
					WHEN Z_IMINVLOC_EC.qty_allocated is null THEN CAST ((dbo.Z_IMINVLOC.qty_allocated - Z_IMINVLOC_WC.qty_allocated) AS INT)
					WHEN Z_IMINVLOC_WC.qty_allocated is null AND (dbo.Z_IMINVLOC.qty_allocated - Z_IMINVLOC_EC.qty_allocated)  < 0 THEN 0
					WHEN Z_IMINVLOC_WC.qty_allocated is null THEN CAST ((dbo.Z_IMINVLOC.qty_allocated - Z_IMINVLOC_EC.qty_allocated) AS INT)
			        WHEN (dbo.Z_IMINVLOC.qty_allocated - Z_IMINVLOC_EC.qty_allocated - Z_IMINVLOC_WC.qty_allocated)  < 0 THEN 0
			        ELSE CAST ((dbo.Z_IMINVLOC.qty_allocated - Z_IMINVLOC_EC.qty_allocated - Z_IMINVLOC_WC.qty_allocated) AS INT)
			   END AS [QALL FW],
			   CASE  WHEN Z_IMINVLOC_EC.qty_allocated is null  THEN CAST (dbo.Z_IMINVLOC.qty_allocated AS INT)
			         ELSE CAST (Z_IMINVLOC_EC.qty_allocated AS INT)
			   END AS [QALL NC],
			   CASE  WHEN Z_IMINVLOC_WC.qty_allocated is null  THEN CAST (dbo.Z_IMINVLOC.qty_allocated AS INT)
			         ELSE CAST (Z_IMINVLOC_WC.qty_allocated AS INT)
			   END AS [QALL AZ], 

               dbo.oeordhdr_sql.user_def_fld_4 AS [WM OrdType], dbo.oeordhdr_sql.oe_po_no, 
               dbo.oeordlin_sql.item_desc_1, dbo.oeordlin_sql.item_desc_2, ship_instruction_1 AS [GO Date-ShipInstr1]
FROM  dbo.oeordlin_sql INNER JOIN
               dbo.imitmidx_sql WITH (NOLOCK) ON dbo.oeordlin_sql.item_no = dbo.imitmidx_sql.item_no 
               LEFT OUTER JOIN (SELECT item_no, CASE WHEN qty_on_hand < 0 THEN 0
			                                    ELSE qty_on_hand
												END AS qty_on_hand,
												CASE WHEN qty_allocated < 0 THEN 0
			                                    ELSE qty_allocated
												END AS qty_allocated,
												CASE WHEN qty_on_ord < 0 THEN 0
			                                    ELSE qty_on_ord
												END AS qty_on_ord
							FROM iminvloc_sql WITH (NOLOCK)
							WHERE loc = 'WC') AS Z_IMINVLOC_WC ON Z_IMINVLOC_WC.item_no = dbo.imitmidx_sql.item_no 
			   LEFT OUTER JOIN (SELECT item_no, CASE WHEN qty_on_hand < 0 THEN 0
			                                    ELSE qty_on_hand
												END AS qty_on_hand,
												CASE WHEN qty_allocated < 0 THEN 0
			                                    ELSE qty_allocated
												END AS qty_allocated,
												CASE WHEN qty_on_ord < 0 THEN 0
			                                    ELSE qty_on_ord
												END AS qty_on_ord
							FROM iminvloc_sql WITH (NOLOCK)
							WHERE loc = 'EC') AS Z_IMINVLOC_EC ON Z_IMINVLOC_EC.item_no = dbo.imitmidx_sql.item_no 
			   INNER JOIN dbo.Z_IMINVLOC WITH (NOLOCK) ON dbo.Z_IMINVLOC.item_no = dbo.imitmidx_sql.item_no INNER JOIN
               dbo.oeordhdr_sql WITH (NOLOCK) ON dbo.oeordhdr_sql.ord_type = dbo.oeordlin_sql.ord_type AND dbo.oeordhdr_sql.ord_no = dbo.oeordlin_sql.ord_no
			   LEFT OUTER JOIN (SELECT SUM(QTY) AS SumQty, ord_no, line_no	
							    FROM wspikpak WITH (NOLOCK)
								WHERE  shipped = 'Y'
								GROUP BY ord_no, line_no) AS PP ON PP.Line_no = oeordlin_sql.line_no AND pp.ord_no = oeordlin_sql.ord_no 
WHERE		   (dbo.oeordhdr_sql.ord_type = 'O') 
			   AND (CONVERT(varchar, CAST(RTRIM(dbo.oeordhdr_sql.shipping_dt) AS datetime),101) < DATEADD(day, - 1, GETDATE())) 
			   AND (NOT (dbo.oeordhdr_sql.ord_no IN ('920450', '920492', '920505'))) 
			   AND (NOT (dbo.oeordlin_sql.user_def_fld_2 LIKE '%SHIPPED%') OR  dbo.oeordlin_sql.user_def_fld_2 IS NULL)
               AND NOT dbo.oeordlin_sql.loc = 'IT' 
               AND NOT dbo.oeordhdr_sql.user_def_fld_5 IS NULL
               AND  (NOT(dbo.oeordlin_sql.user_def_fld_1 LIKE '%PROJECTION%') OR (dbo.oeordlin_sql.user_def_fld_1 IS NULL))
               AND  (NOT(dbo.oeordlin_sql.user_def_fld_1 LIKE '%STOCK%') OR (dbo.oeordlin_sql.user_def_fld_1 IS NULL))
               AND NOT (dbo.oeordhdr_sql.oe_po_no LIKE '%stock%') 
               AND NOT (dbo.oeordlin_sql.item_no LIKE '%TEST%') 
               AND NOT (LTRIM(RTRIM(dbo.oeordhdr_sql.cus_no)) IN ('11575', '23033'))
               AND dbo.oeordlin_sql.shipped_dt IS NULL
			   AND (pp.SumQty is null OR pp.SumQty < oeordlin_sql.tot_qty_ordered)

               --Added Back on 4/26/12 by BG:
               AND (NOT (dbo.oeordlin_sql.prod_cat IN ('037', '036', '102', '111', '336'))) 
            
               --Test Order
               AND dbo.oeordhdr_sql.ord_no = ' 4018111'  
               
               --Added on 6/5/12:
               --AND oeordhdr_sql.ord_no NOT IN (SELECT ord_no FROM oeordlin_sql WHERE prod_cat = '551')
           
--UNION ALL

--SELECT DISTINCT CONVERT(varchar, CAST(RTRIM(dbo.oeordhdr_sql.shipping_dt) AS datetime), 101) AS [Shipping Date], CONVERT(varchar, 
--               CAST(RTRIM(dbo.oeordhdr_sql.entered_dt) AS datetime), 101) AS Entered_Dt, dbo.oeordhdr_sql.ord_no, dbo.oeordhdr_sql.mfg_loc AS [Ship From], 
--               dbo.oeordhdr_sql.bill_to_name, dbo.oeordhdr_sql.ship_to_name, RTRIM(dbo.oeordhdr_sql.cus_no) AS Cus_No, line_seq_no AS line_seq_no,
--               oeordlin_sql.prod_Cat AS [Shop Code], oeordlin_sql.item_no AS item_no, qty_to_ship AS QTY, dbo.oeordhdr_sql.user_def_fld_4 AS [Late Order Comments 1], 
--               dbo.oeordhdr_Sql.user_def_fld_3 AS [Late Order Comments 2], dbo.oeordhdr_sql.slspsn_no AS [SALES #], dbo.oeordhdr_sql.cus_alt_adr_cd AS [Store #], 
--               dbo.imitmidx_sql.item_note_1 AS NOTE1, dbo.Z_IMINVLOC.qty_on_hand AS QOH, dbo.Z_IMINVLOC.qty_on_ord AS QOO, 
--               dbo.oeordhdr_sql.user_def_fld_4 AS [WM OrdType]
--FROM  dbo.oeordlin_sql INNER JOIN
--               dbo.imitmidx_sql ON dbo.oeordlin_sql.item_no = dbo.imitmidx_sql.item_no INNER JOIN
--               dbo.Z_IMINVLOC ON dbo.Z_IMINVLOC.item_no = dbo.imitmidx_sql.item_no INNER JOIN
--               dbo.oeordhdr_sql ON dbo.oeordhdr_sql.ord_type = dbo.oeordlin_sql.ord_type AND dbo.oeordhdr_sql.ord_no = dbo.oeordlin_sql.ord_no 
--WHERE (NOT (dbo.oeordhdr_sql.oe_po_no = 'BRUCE' OR
--               dbo.oeordhdr_sql.oe_po_no = 'STOCK' OR
--               dbo.oeordhdr_sql.oe_po_no = 'WALT')) AND (dbo.oeordhdr_sql.ord_type = 'O') AND (CONVERT(varchar, CAST(RTRIM(dbo.oeordhdr_sql.shipping_dt) AS datetime), 
--               101) < DATEADD(day, - 1, GETDATE()))  
               
--               --Added on 6/5/12:
--               AND oeordhdr_sql.ord_no IN (SELECT ord_no FROM oeordlin_sql WHERE prod_cat = '551')

--               AND (NOT (LTRIM(RTRIM(dbo.oeordhdr_sql.cus_no)) IN ('11575', '23033'))) AND (dbo.oeordlin_sql.shipped_dt IS NULL) AND 
--               (dbo.oeordhdr_sql.oe_po_no NOT IN ('31011784', '31011785', '31011786'))