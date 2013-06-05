SELECT     CONVERT(date, PH.ord_dt, 101) AS [Order Dt], (CONVERT(date,PL.extra_8 , 101)) AS [Ship Dt], (CONVERT(date,PL.receipt_dt , 101)) AS [Receipt Dt],  PL.item_no AS Item, PH.ord_no AS [PO #], IM.prod_cat AS Cat, IMC.prod_cat_desc AS CatDesc, PL.qty_ordered AS QTY, PL.exp_unit_cost AS [UnitPrice], (PL.qty_ordered * PL.exp_unit_cost) AS TotCost, vend_name
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd LEFT OUTER JOIN
                      imitmidx_sql IM ON im.item_no = PL.item_no LEFT OUTER JOIN
                      imcatfil_sql IMC ON imc.prod_cat = im.prod_cat
WHERE     (LTRIM(PL.vend_no) IN ('9533','9523','8859','8830')) AND 
					len(PL.extra_8) > 9 and 
                    (YEAR(PH.ord_dt) = '2011') and
                    not PL.extra_8 is null
