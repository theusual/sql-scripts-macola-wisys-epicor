SELECT     CONVERT(date, PH.ord_dt, 101) AS [Order Dt], (CONVERT(date,PL.extra_8 , 101)) AS [Ship Dt], (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101)))) AS [Difference], PH.ord_no, PL.line_no, PL.item_no
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
WHERE     (PL.qty_received = PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('9533')) AND 
					len(PL.extra_8) > 9 and 
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 250) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    ((PL.receipt_dt > DATEADD(day, - 60, GETDATE()))) and
                    not PL.extra_8 is null and
                    PL.qty_ordered > 9 
