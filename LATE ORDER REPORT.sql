SELECT     TOP (100) PERCENT CONVERT(varchar, CAST(RTRIM(dbo.oeordhdr_sql.shipping_dt) AS datetime), 101) AS [Shipping Date], dbo.oeordhdr_sql.ord_no, 
                      dbo.oeordlin_sql.loc AS [Ship From], dbo.oeordhdr_sql.bill_to_name, dbo.oeordhdr_sql.ship_to_name, RTRIM(dbo.oeordhdr_sql.cus_no) AS Cus_No, 
                      dbo.oeordlin_sql.line_seq_no, dbo.oeordlin_sql.prod_cat AS [Shop Code], dbo.oeordlin_sql.item_no, dbo.oeordlin_sql.qty_ordered, 
                      dbo.oeordlin_sql.user_def_fld_1 AS [Late Order Comments 1], dbo.oeordlin_sql.user_def_fld_2 AS [Late Order Comments 2], 
                      dbo.oeordhdr_sql.slspsn_no AS [SALES #], dbo.oeordhdr_sql.cus_alt_adr_cd AS [Store #], dbo.imitmidx_sql.item_note_1 AS NOTE1
FROM         dbo.oeordlin_sql INNER JOIN
                      dbo.imitmidx_sql ON dbo.oeordlin_sql.item_no = dbo.imitmidx_sql.item_no INNER JOIN
                      dbo.oeordhdr_sql ON dbo.oeordhdr_sql.ord_type = dbo.oeordlin_sql.ord_type AND 
                      dbo.oeordhdr_sql.ord_no = dbo.oeordlin_sql.ord_no LEFT OUTER JOIN
                      dbo.ARSHTTBL ON LTRIM(dbo.oeordlin_sql.ord_no) = CAST(dbo.ARSHTTBL.ord_no AS int) AND 
                      dbo.oeordlin_sql.item_no = dbo.ARSHTTBL.filler_0001 AND dbo.ARSHTTBL.void_fg IS NULL
WHERE     (NOT (dbo.oeordhdr_sql.oe_po_no = 'BRUCE' OR
                      dbo.oeordhdr_sql.oe_po_no = 'STOCK' OR
                      dbo.oeordhdr_sql.oe_po_no = 'WALT')) AND (dbo.oeordhdr_sql.ord_type = 'O') AND (CONVERT(varchar, CAST(RTRIM(dbo.oeordhdr_sql.shipping_dt) 
                      AS datetime), 101) < DATEADD(day, - 1, GETDATE())) AND (NOT (LTRIM(RTRIM(dbo.oeordhdr_sql.cus_no)) IN ('11575', '23033', '9999'))) AND 
                      (NOT (dbo.oeordhdr_sql.ord_no IN ('920450', '920492', '920505'))) AND (NOT (dbo.oeordlin_sql.user_def_fld_2 LIKE '%SHIPPED%') OR
                      dbo.oeordlin_sql.user_def_fld_2 IS NULL) AND (NOT (dbo.oeordlin_sql.prod_cat IN ('037', '2', '036', '102', '111', '336'))) AND 
                      (NOT (dbo.oeordlin_sql.loc = 'CAN')) AND (dbo.ARSHTTBL.ord_no IS NULL) AND (NOT (dbo.oeordhdr_sql.user_def_fld_5 IS NULL)) AND 
                      (NOT (dbo.oeordlin_sql.user_def_fld_1 LIKE '%PROJECTION%') AND NOT (dbo.oeordlin_sql.user_def_fld_1 LIKE '%STOCK%') OR
                      dbo.oeordlin_sql.user_def_fld_1 IS NULL) AND (NOT (dbo.oeordhdr_sql.oe_po_no LIKE '%stock%')) AND 
                      (NOT (dbo.oeordlin_sql.item_no LIKE '%TEST%')) OR
                      (NOT (dbo.oeordlin_sql.user_def_fld_2 LIKE '%SHIPPED%') OR
                      dbo.oeordlin_sql.user_def_fld_2 IS NULL) AND (NOT (dbo.oeordlin_sql.item_no LIKE '%TEST%')) AND (dbo.oeordlin_sql.ord_no IN
                          (SELECT     ord_no
                            FROM          dbo.oehdrhst_sql))
ORDER BY dbo.oeordhdr_sql.shipping_dt, dbo.oeordhdr_sql.ord_no