 SELECT    PL.item_no, PL.extra_8
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
					WHERE     (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8830')) AND 
					((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 260, GETDATE())))  and
					((PL.extra_8 is null))  
                    OR
                    (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8830')) AND  
                    ((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 260, GETDATE())))  and
					(PL.extra_8) > CONVERT(VARCHAR(10), GETDATE(), 101) 
