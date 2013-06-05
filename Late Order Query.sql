SELECT     TOP (100) PERCENT CONVERT(varchar, CAST(RTRIM(OEORDHDR_SQL.shipping_dt) AS datetime), 101) AS [Shipping Date], OEORDHDR_SQL.ord_no, 
                      OEORDHDR_SQL.bill_to_name, OEORDHDR_SQL.ship_to_name, OEORDHDR_SQL.cus_no, OEORDLIN_SQL.item_no, OEORDLIN_SQL.qty_ordered, 
                      OEORDLIN_SQL.user_def_fld_1 AS [Late Order Comments 1], OEORDLIN_SQL.user_def_fld_2 AS [Late Order Comments 2]
FROM         dbo.oeordhdr_sql AS OEORDHDR_SQL INNER JOIN
                      dbo.oeordlin_sql AS OEORDLIN_SQL ON OEORDHDR_SQL.ord_type = OEORDLIN_SQL.ord_type AND 
                      OEORDHDR_SQL.ord_no = OEORDLIN_SQL.ord_no LEFT OUTER JOIN
                      dbo.ARSHTTBL ON LTRIM(OEORDLIN_SQL.ord_no) = CAST(dbo.ARSHTTBL.ord_no AS int) AND 
                      OEORDLIN_SQL.item_no = dbo.ARSHTTBL.filler_0001 AND dbo.ARSHTTBL.void_fg IS NULL
WHERE     (NOT (OEORDHDR_SQL.oe_po_no = 'BRUCE' OR
                      OEORDHDR_SQL.oe_po_no = 'STOCK' OR
                      OEORDHDR_SQL.oe_po_no = 'WALT')) AND (NOT (OEORDLIN_SQL.item_no = '*EDI-ITEM')) AND (NOT (OEORDLIN_SQL.item_no = 'ADD ON')) AND 
                      (NOT (OEORDLIN_SQL.item_no = 'ARRANGE CUSTOMS')) AND (NOT (OEORDLIN_SQL.item_no = 'DISTRO')) AND 
                      (NOT (OEORDLIN_SQL.item_no = 'FIXTURE REQUEST')) AND (NOT (OEORDLIN_SQL.item_no = 'INITIAL DIV 01')) AND 
                      (NOT (OEORDLIN_SQL.item_no = 'INITIAL RM')) AND (NOT (OEORDLIN_SQL.item_no = 'INITIAL SAMS')) AND 
                      (NOT (OEORDLIN_SQL.item_no = 'INITIAL SC')) AND (NOT (OEORDLIN_SQL.item_no = 'INITIAL WNM')) AND (OEORDHDR_SQL.ord_type = 'O') AND 
                      (CONVERT(varchar, CAST(RTRIM(OEORDHDR_SQL.shipping_dt) AS datetime), 101) < DATEADD(day, - 1, GETDATE())) AND 
                      (NOT (OEORDLIN_SQL.item_no = 'DVD SHELF SET')) AND (NOT (OEORDLIN_SQL.item_no = 'WM PH WHSING')) AND 
                      (NOT (OEORDLIN_SQL.item_no = 'WM-MOVIEDUMPBIN')) AND (NOT (OEORDLIN_SQL.item_no = 'WM-PETITEMOMZONE')) AND 
                      (NOT (RTRIM(OEORDHDR_SQL.cus_no) IN (11575))) AND (NOT (OEORDHDR_SQL.ord_no IN ('920450', '920492', '920505'))) AND 
                      (dbo.ARSHTTBL.ord_no IS NULL) AND (NOT (OEORDLIN_SQL.user_def_fld_2 = 'SHIPPED')) AND NOT (OEORDLIN_SQL.prod_cat in ('037','2','036','102','111','336'))
                      OR
                      (NOT (OEORDHDR_SQL.oe_po_no = 'BRUCE' OR
                      OEORDHDR_SQL.oe_po_no = 'STOCK' OR
                      OEORDHDR_SQL.oe_po_no = 'WALT')) AND (NOT (OEORDLIN_SQL.item_no = '*EDI-ITEM')) AND (NOT (OEORDLIN_SQL.item_no = 'ADD ON')) AND 
                      (NOT (OEORDLIN_SQL.item_no = 'ARRANGE CUSTOMS')) AND (NOT (OEORDLIN_SQL.item_no = 'DISTRO')) AND 
                      (NOT (OEORDLIN_SQL.item_no = 'FIXTURE REQUEST')) AND (NOT (OEORDLIN_SQL.item_no = 'INITIAL DIV 01')) AND 
                      (NOT (OEORDLIN_SQL.item_no = 'INITIAL RM')) AND (NOT (OEORDLIN_SQL.item_no = 'INITIAL SAMS')) AND 
                      (NOT (OEORDLIN_SQL.item_no = 'INITIAL SC')) AND (NOT (OEORDLIN_SQL.item_no = 'INITIAL WNM')) AND (OEORDHDR_SQL.ord_type = 'O') AND 
                      (CONVERT(varchar, CAST(RTRIM(OEORDHDR_SQL.shipping_dt) AS datetime), 101) < DATEADD(day, - 1, GETDATE())) AND 
                      (NOT (OEORDLIN_SQL.item_no = 'DVD SHELF SET')) AND (NOT (OEORDLIN_SQL.item_no = 'WM PH WHSING')) AND 
                      (NOT (OEORDLIN_SQL.item_no = 'WM-MOVIEDUMPBIN')) AND (NOT (OEORDLIN_SQL.item_no = 'WM-PETITEMOMZONE')) AND 
                      (NOT (RTRIM(OEORDHDR_SQL.cus_no) IN (11575))) AND (NOT (OEORDHDR_SQL.ord_no IN ('920450', '920492', '920505'))) AND 
                      (dbo.ARSHTTBL.ord_no IS NULL) AND (OEORDLIN_SQL.user_def_fld_2 IS NULL) AND NOT (OEORDLIN_SQL.prod_cat in ('037','2','036','102','111','336'))
ORDER BY OEORDHDR_SQL.shipping_dt