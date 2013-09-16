SELECT     TOP (100) PERCENT CAST(LTRIM(SUBSTRING(PL.ord_no, 1, 6)) AS int) AS [PO #], PL.line_no AS [Line Number], PL.item_no AS [Item Name], 
                      PL.qty_ordered AS [Quantity on Order], PL.qty_received, PL.extra_8 AS [US Ship Date], PL.user_def_fld_1 AS Container, PL.user_def_fld_2 AS [CH ETA], 
                      PL.exp_unit_cost AS [Price ($)], CONVERT(varchar, PH.ord_dt, 101) AS [Order Date], PL.item_desc_1 AS [Description 1], PL.item_desc_2 AS [Description 2]
FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no LEFT OUTER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd LEFT OUTER JOIN
                      dbo.imitmidx_sql AS IM ON IM.item_no = PL.item_no
WHERE     (LTRIM(PH.vend_no) = '1556') AND (PH.ship_to_cd = 'DS') AND (NOT (LTRIM(PH.ord_no) = '7977700')) AND YEAR(ord_Dt) = '2013'
ORDER BY PL.qty_received