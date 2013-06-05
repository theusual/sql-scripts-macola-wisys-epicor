USE [001]

BEGIN
	/* Declare and populate the html table and query */
	DECLARE @tableHTML  NVARCHAR(MAX) ;
	
		SET @tableHTML =
		N'<p style="font-family:arial; font-size:12px;">' +
		N'Below are estimated lead times and current purchasing volumes for each major China vendor. '+
		N'<table style="background-color:white; font-family:arial; font-size:12px;" border="1" cellpadding="2" cellspacing="0">' +
		N'<tr><th rowspan=2>Vendor</th>' +
		N'<th colspan=2>Estimated Lead Times</th>' +
		N'<th colspan=2>Purchasing Volume</th></tr>' +
		N'<tr><th>Previous 60 days</th>' +
		N'<th>Previous 180 days</th>' +
		N'<th>Current Open POs (Line Items)</th> ' +
		N'<th>Current Open POs ($)</th> ' +

		
N'</tr><tr><td>Aifei (Metal)</td><td>' +
					CAST((SELECT     AVG(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))))
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
WHERE     (PL.qty_received = PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8859')) AND 
					len(PL.extra_8) > 9 and 
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 250) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    (PL.receipt_dt > DATEADD(day, - 60, GETDATE())) and
                    not PL.extra_8 is null and
                    PL.qty_ordered > 9 and
                    PL.item_no in (select PL.item_no 
                                   from dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
                                   where (PL.receipt_dt > DATEADD(day, -360, GETDATE())) and
                                   (LTRIM(PL.vend_no) IN ('9533')))
              ) AS NVARCHAR(MAX) ) +
             N'</td><td>' +      
					CAST((SELECT     AVG(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))))
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
WHERE     (PL.qty_received = PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8859')) AND 
					len(PL.extra_8) > 9 and 
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 250) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    (PL.receipt_dt > DATEADD(day, - 250, GETDATE())) and
                    not PL.extra_8 is null and
                    PL.qty_ordered > 9 and
                    PL.item_no in (select PL.item_no 
                                   from dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
                                   where (PL.receipt_dt > DATEADD(day, -360, GETDATE())) and
                                   (LTRIM(PL.vend_no) IN ('9533')))
              ) AS NVARCHAR(MAX) ) +
               N'</td><td>' +  
               
              CAST((SELECT     COUNT(PL.item_no)
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
				WHERE     (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8859')) AND 
					((PL.extra_8 is null))  and 
                    PL.item_no not in (select PL.item_no 
                                   from dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
                                   where (PL.receipt_dt > DATEADD(day, -360, GETDATE())) and
                                   (LTRIM(PL.vend_no) IN ('9533'))) and
                    ((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))
                    OR
                    (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8859')) AND  
                    PL.item_no not in (select PL.item_no 
                                   from dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
                                   where (PL.receipt_dt > DATEADD(day, -360, GETDATE())) and
                                   (LTRIM(PL.vend_no) IN ('9533'))) and
                    ((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					(PL.extra_8) > CONVERT(VARCHAR(10), GETDATE(), 101) 
                    ) AS NVARCHAR(MAX) ) +
                    
                    
              N'</td><td>' + 
              CAST((SELECT     '$'+ CONVERT(varchar(12), CONVERT(money, (SUM((PL.exp_unit_cost*(PL.qty_ordered-PL.qty_received)))),1), 1)
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
WHERE     (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8859')) AND 
					((PL.extra_8 is null))  and 
                    PL.item_no not in (select PL.item_no 
                                   from dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
                                   where (PL.receipt_dt > DATEADD(day, -360, GETDATE())) and
                                   (LTRIM(PL.vend_no) IN ('9533'))) and
                    ((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))
                    OR
                    (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8859')) AND  
                    PL.item_no not in (select PL.item_no 
                                   from dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
                                   where (PL.receipt_dt > DATEADD(day, -360, GETDATE())) and
                                   (LTRIM(PL.vend_no) IN ('9533'))) and
                    ((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					(PL.extra_8) > CONVERT(VARCHAR(10), GETDATE(), 101) 
                    
                    ) AS NVARCHAR(MAX) ) +
                    
                    
 N'</tr><tr><td>Pafic (Metal)</td><td>' +
	    					CAST((SELECT     AVG(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))))
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
WHERE     (PL.qty_received = PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8830')) AND 
					len(PL.extra_8) > 9 and 
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 250) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    ((PL.receipt_dt > DATEADD(day, - 60, GETDATE()))) and
                    not PL.extra_8 is null and
                    PL.qty_ordered > 9 

              ) AS NVARCHAR(MAX) ) +
            N'</td><td>' +  
                					CAST((SELECT     AVG(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))))
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
WHERE     (PL.qty_received = PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8830')) AND 
					len(PL.extra_8) > 9 and 
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 250) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    ((PL.receipt_dt > DATEADD(day, - 250, GETDATE()))) and
                    not PL.extra_8 is null and
                    PL.qty_ordered > 9 
              ) AS NVARCHAR(MAX) ) +
                                N'</td><td>' + 
              CAST((SELECT    COUNT(PL.item_no)
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
					WHERE     (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8830')) AND 
					((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					((PL.extra_8 is null))  
                    OR
                    (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8830')) AND  
                    ((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					(PL.extra_8) > CONVERT(VARCHAR(10), GETDATE(), 101) 
                    ) AS NVARCHAR(MAX) ) +
                    
                            N'</td><td>' + 
              CAST((SELECT     '$'+ CONVERT(varchar(12), CONVERT(money, (SUM((PL.exp_unit_cost*(PL.qty_ordered-PL.qty_received)))),1), 1)
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
					WHERE     (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8830')) AND 
					((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					((PL.extra_8 is null))  
                    OR
                    (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8830')) AND  
                    ((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					(PL.extra_8) > CONVERT(VARCHAR(10), GETDATE(), 101) 
                    ) AS NVARCHAR(MAX) ) +
                  

N'</tr><tr><td>Aifei (Wood)</td><td>' +
					CAST((SELECT     AVG(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))))
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
WHERE     (PL.qty_received = PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8859')) AND 
					len(PL.extra_8) > 9 and 
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 250) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    (PL.receipt_dt > DATEADD(day, - 60, GETDATE())) and
                    not PL.extra_8 is null and
                    PL.qty_ordered > 9 and
                    PL.item_no in (select PL.item_no 
                                   from dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
                                   where (PL.receipt_dt > DATEADD(day, -360, GETDATE())) and
                                   (LTRIM(PL.vend_no) IN ('9533')))
              ) AS NVARCHAR(MAX) ) +
             N'</td><td>' +      
					CAST((SELECT     AVG(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))))
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
WHERE     (PL.qty_received = PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8859')) AND 
					len(PL.extra_8) > 9 and 
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 250) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    (PL.receipt_dt > DATEADD(day, - 250, GETDATE())) and
                    not PL.extra_8 is null and
                    PL.qty_ordered > 9 and
                    PL.item_no in (select PL.item_no 
                                   from dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
                                   where (PL.receipt_dt > DATEADD(day, -360, GETDATE())) and
                                   (LTRIM(PL.vend_no) IN ('9533')))
              ) AS NVARCHAR(MAX) ) +
               N'</td><td>' +  
               
              CAST((SELECT     COUNT(PL.item_no)
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
WHERE     (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8859')) AND 
					((PL.extra_8 is null))  and 
                    PL.item_no in (select PL.item_no 
                                   from dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
                                   where (PL.receipt_dt > DATEADD(day, -360, GETDATE())) and
                                   (LTRIM(PL.vend_no) IN ('9533'))) and
                    ((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))
                    OR
                    (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8859')) AND  
                    PL.item_no in (select PL.item_no 
                                   from dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
                                   where (PL.receipt_dt > DATEADD(day, -360, GETDATE())) and
                                   (LTRIM(PL.vend_no) IN ('9533'))) and
                    ((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					(PL.extra_8) > CONVERT(VARCHAR(10), GETDATE(), 101) 
                    
                    ) AS NVARCHAR(MAX) ) +
                    
                    
              N'</td><td>' + 
               CAST((SELECT     '$'+ CONVERT(varchar(12), CONVERT(money, (SUM((PL.exp_unit_cost*(PL.qty_ordered-PL.qty_received)))),1), 1)
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
WHERE     (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8859')) AND 
					((PL.extra_8 is null))  and 
                    PL.item_no in (select PL.item_no 
                                   from dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
                                   where (PL.receipt_dt > DATEADD(day, -360, GETDATE())) and
                                   (LTRIM(PL.vend_no) IN ('9533'))) and
                    ((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))
                    OR
                    (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8859')) AND  
                    PL.item_no in (select PL.item_no 
                                   from dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
                                   where (PL.receipt_dt > DATEADD(day, -360, GETDATE())) and
                                   (LTRIM(PL.vend_no) IN ('9533'))) and
                    ((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					(PL.extra_8) > CONVERT(VARCHAR(10), GETDATE(), 101) 
                    
                    ) AS NVARCHAR(MAX) ) +
	  
N'</tr><tr><td>MPW Mfg. (Wood) </td><td>' +
        					CAST((SELECT     AVG(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))))
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
              ) AS NVARCHAR(MAX) ) +
             N'</td><td>' +
              	CAST((SELECT     AVG(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))))
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
WHERE     (PL.qty_received = PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('9533')) AND 
					len(PL.extra_8) > 9 and 
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 250) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    ((PL.receipt_dt > DATEADD(day, - 250, GETDATE()))) and
                    not PL.extra_8 is null and
                    PL.qty_ordered > 9 
                    ) AS NVARCHAR(MAX) ) +
               N'</td><td>' +
              CAST((SELECT     COUNT(PL.item_no)
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
					WHERE     (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('9533')) AND 
					((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					((PL.extra_8 is null))  
                    OR
                    (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('9533')) AND  
                    ((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					(PL.extra_8) > CONVERT(VARCHAR(10), GETDATE(), 101) 
                    ) AS NVARCHAR(MAX) ) +
                    
                                                N'</td><td>' + 
              CAST((SELECT     '$'+ CONVERT(varchar(12), CONVERT(money, (SUM((PL.exp_unit_cost*(PL.qty_ordered-PL.qty_received)))),1), 1)
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
					WHERE     (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('9533')) AND 
					((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					((PL.extra_8 is null))  
                    OR
                    (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('9533')) AND  
                    ((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					(PL.extra_8) > CONVERT(VARCHAR(10), GETDATE(), 101) 
                    ) AS NVARCHAR(MAX) ) +
                    
 N'</tr><tr><td>MPW Trading</td><td>' +
	    					CAST((SELECT     AVG(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))))
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
WHERE     (PL.qty_received = PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('9523')) AND 
					len(PL.extra_8) > 9 and 
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 250) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    ((PL.receipt_dt > DATEADD(day, - 60, GETDATE()))) and
                    not PL.extra_8 is null and
                    PL.qty_ordered > 7 
              ) AS NVARCHAR(MAX) ) +
            N'</td><td>' +  
              	CAST((SELECT     AVG(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))))
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
WHERE     (PL.qty_received = PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('9523')) AND 
					len(PL.extra_8) > 9 and 
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 250) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    ((PL.receipt_dt > DATEADD(day, - 250, GETDATE()))) and
                    not PL.extra_8 is null and
                    PL.qty_ordered > 7 
              ) AS NVARCHAR(MAX) ) +
              N'</td><td>' +  

              CAST((SELECT     COUNT(PL.item_no)
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
					WHERE     (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('9523')) AND 
					((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					((PL.extra_8 is null))  
                    OR
                    (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('9523')) AND  
                    ((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					(PL.extra_8) > CONVERT(VARCHAR(10), GETDATE(), 101) 
                    ) AS NVARCHAR(MAX) ) +
                    
                    
      N'</td><td>' + 
              CAST((SELECT     '$'+ CONVERT(varchar(12), CONVERT(money, (SUM((PL.exp_unit_cost*(PL.qty_ordered-PL.qty_received)))),1), 1)
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
					WHERE     (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('9523')) AND 
					((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					((PL.extra_8 is null))  
                    OR
                    (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('9523')) AND  
                    ((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					(PL.extra_8) > CONVERT(VARCHAR(10), GETDATE(), 101) 
                    ) AS NVARCHAR(MAX) ) +
		N'</table><br><br>Please email any technical questions concerning this report to bryan.gregory@marcocompany.com<br><br>Thanks,<br>'+
		N'The Marco Team';

	/* Send the mail */
	EXEC	msdb.dbo.sp_send_dbmail
	
			@profile_name = 'SQL2008_DBMail_IT_General',
			@recipients = 'judson.griffis@marcocompany.com; darrell.cooper@marcocompany.com; craig.nickell@marcocompany.com; shaunpal.smith@marcocompany.com; frank@mpw.com.cn; victor.gandara@marcocompany.com; laura.russell@marcocompany.com',
			@copy_recipients = 'bryan.gregory@marcocompany.com',
			@file_attachments = '',
			@body_format = 'HTML',
			@body = @tableHTML,
			@subject = 'Weekly China Vendor Report - Current Purchasing Volume and Average Lead Times' ;
END