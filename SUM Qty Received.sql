USE [001]
SELECT     SUM((PL.qty_received))
FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
WHERE           
                    
                    (PL.receipt_dt > '07/01/2010') and
                    PL.item_no like 'MET-TBL 001 bv%'