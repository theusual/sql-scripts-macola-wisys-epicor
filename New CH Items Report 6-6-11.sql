SELECT     TOP (100) PERCENT AP.vend_name AS Vendor, CAST(LTRIM(SUBSTRING(PL.ord_no, 1, 6)) AS int) AS [Order], (CASE WHEN PL.extra_8 IS NULL 
                      THEN (DATEDIFF(day, CONVERT(datetime, PH.ord_dt, 101), GETDATE())) ELSE (DATEDIFF(day, CONVERT(datetime, PH.ord_dt, 101), CONVERT(datetime, 
                      PL.extra_8, 101))) END) AS [DaysInProd.], CONVERT(varchar, PH.ord_dt, 101) AS [Order Date], CONVERT(varchar, PL.request_dt, 101) 
                      AS [Requested Ship Dt], PL.extra_8 AS [Vendor Ship Dt], PL.user_def_fld_2 AS [Marco ETA], PL.line_no AS [Line Number], PL.item_no AS [Item Name], 
                      PL.item_desc_1 AS [Description 1], PL.item_desc_2 AS [Description 2], PL.qty_ordered AS [Quantity on Order], PL.exp_unit_cost AS [Price ($)], 
                      PS.ship_to_desc AS [PO Ship To Location], IM.drawing_release_no AS [Drawing Number], IM.drawing_revision_no, 
                      PL.user_def_fld_3 AS [Container Ship To], PL.user_def_fld_4 AS [Dock Recv Date/Time], PL.user_def_fld_1 AS Container
FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd LEFT OUTER JOIN
                      dbo.imitmidx_sql AS IM ON IM.item_no = PL.item_no
WHERE     (PL.qty_ordered > PL.qty_received) AND (LTRIM(PL.vend_no) IN ('1613', '23877', '91202', '1620', '1697', '9516', '50', '1717', '9703', '216', '2999', 
                      '9441', '8859', '9523', '9533')) AND (NOT (IM.prod_cat IN ('336', '2', '036', '037', '102', '111'))) AND (PL.item_no NOT IN
                          (SELECT     item_no
                            FROM          dbo.poordlin_sql AS PL
                            WHERE      (qty_ordered = qty_received) AND (LTRIM(vend_no) IN ('1613', '23877', '91202', '1620', '1697', '9516', '50', '1717', '9703', '216', '2999', 
                                                   '9441', '8859', '9523', '9533'))))
ORDER BY [DaysInProd.] DESC