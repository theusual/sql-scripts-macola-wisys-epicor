SELECT CAST(LTRIM(SUBSTRING(PL.ord_no, 1, 6)) AS int) AS [PO #], AP.vend_name AS [VENDOR NAME], PL.item_no AS [ITEM NAME], 
               PL.item_desc_1 AS [ITEM DESCRIPTION], PL.qty_ordered AS [QTY ORDERED], PL.extra_8 AS [SHIP DATE], PL.user_def_fld_2 AS [DALLAS ETA], 
               PL.receipt_dt AS [RECEIPT DT], PL.user_def_fld_1 AS [CONTAINER INFO], PL.user_def_fld_3 AS [Container Ship To], PS.ship_to_desc AS [TRANSFER TO], 
               PL.line_no AS [LINE #], PL.user_def_fld_4 AS [Dock Recv Date/Time], PH.ord_dt AS [Order Date], PL.promise_dt AS [Expected Ship Dt], DATEDIFF(day, PL.request_dt, 
               PL.promise_dt) AS [Expected Prod Time], 
               CASE WHEN PL.extra_8 IS NULL THEN DATEDIFF(day, PH.ord_dt, GETDATE()) 
                    WHEN LEN(PL.extra_8) != 10 THEN DATEDIFF(day, PH.ord_dt, GETDATE()) 
                    ELSE  DATEDIFF(day, PH.ord_dt, CONVERT(varchar(10),PL.extra_8, 101))
               END AS [Days In Prod]
FROM  dbo.apvenfil_sql AS AP INNER JOIN
               dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
               dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
               dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
               dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
WHERE ((PL.qty_received <= PL.qty_ordered) AND (PL.qty_ordered <> PL.qty_received) OR (PL.receipt_dt > DATEADD(day, - 60, GETDATE())) 
      AND (PH.ord_status <> 'X'))AND (LTRIM(PL.vend_no) IN (SELECT vend_no FROM dbo.BG_CH_Vendors))
              