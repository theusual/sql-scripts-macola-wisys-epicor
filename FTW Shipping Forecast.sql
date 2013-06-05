SELECT     TOP (100) PERCENT CONVERT(varchar, CAST(RTRIM(OEORDHDR_SQL.shipping_dt) AS datetime), 101) AS [Shipping Dt], 
                      OEORDHDR_SQL.ord_no AS [Order #], OEORDHDR_SQL.ship_instruction_1 AS MABD, OEORDHDR_SQL.cus_no AS [Cus #], 
                      OEORDHDR_SQL.bill_to_name, OEORDHDR_SQL.ship_to_name, OEORDHDR_SQL.ship_to_addr_4 AS [City/ST/Zip], 
                      OEORDHDR_SQL.ship_via_cd AS Carrier, OEORDLIN_SQL.item_no AS [Item #], OEORDLIN_SQL.qty_ordered AS Qty, 
                      imitmidx_sql.item_weight * OEORDLIN_SQL.qty_ordered AS [Total Item Weight (lbs)]
FROM         dbo.imitmidx_sql AS imitmidx_sql INNER JOIN
                      dbo.oeordhdr_sql AS OEORDHDR_SQL INNER JOIN
                      dbo.oeordlin_sql AS OEORDLIN_SQL ON OEORDHDR_SQL.ord_type = OEORDLIN_SQL.ord_type AND 
                      OEORDHDR_SQL.ord_no = OEORDLIN_SQL.ord_no ON imitmidx_sql.item_no = OEORDLIN_SQL.item_no
WHERE     (OEORDHDR_SQL.ord_type = 'O') AND (NOT (OEORDHDR_SQL.bill_to_name LIKE 'Butt%' OR
                      OEORDHDR_SQL.bill_to_name LIKE 'HEB%' OR
                      OEORDHDR_SQL.bill_to_name LIKE 'INFINITI%' OR
                      OEORDHDR_SQL.bill_to_name LIKE 'WAL-MART%' OR
                      OEORDHDR_SQL.bill_to_name LIKE 'HUBERT%' OR
                      OEORDHDR_SQL.bill_to_name LIKE 'NATIONAL REFRIGERATION%' OR
                      OEORDHDR_SQL.bill_to_name LIKE 'Winn%')) AND (NOT (OEORDLIN_SQL.item_no = '*EDI-ITEM' OR
                      OEORDLIN_SQL.item_no = 'WM PH WHSING' OR
                      OEORDLIN_SQL.item_no = 'WM-MOVIEDUMPBIN' OR
                      OEORDLIN_SQL.item_no = 'WM-PETITEMOMZONE')) AND (NOT (OEORDHDR_SQL.ship_via_cd = 'FDX' OR
                      OEORDHDR_SQL.ship_via_cd = 'FED' OR
                      OEORDHDR_SQL.ship_via_cd = 'FEX' OR
                      OEORDHDR_SQL.ship_via_cd = 'FXG' OR
                      OEORDHDR_SQL.ship_via_cd = 'UPS')) AND (CONVERT(varchar, CAST(RTRIM(OEORDHDR_SQL.shipping_dt) AS datetime), 101) < DATEADD (d,14,GETDATE())) AND 
                      (CONVERT(varchar, CAST(RTRIM(OEORDHDR_SQL.shipping_dt) AS datetime), 101) > GETDATE()))
ORDER BY [Order #]