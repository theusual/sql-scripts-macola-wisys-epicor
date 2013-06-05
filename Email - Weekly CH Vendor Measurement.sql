USE [001]

BEGIN
	/* Declare and populate the html table and query */
	DECLARE @tableHTML  NVARCHAR(MAX) ;
	
		SET @tableHTML =
		N'<p style="font-family:arial; font-size:12px;">' +
		N'Below are average lead times and current purchasing volumes for each major China vendor. '+
		N'<table style="background-color:white; font-family:arial; font-size:12px;" border="1" cellpadding="2" cellspacing="0">' +
		N'<tr><th rowspan=2>Vendor</th>' +
		N'<th colspan=6>Lead Times</th>' +
		N'<th colspan=4>Purchasing Volume</th></tr>' +
		N'<tr><th>Past 60 days (Line Items)</th>' +
		N'<th>Past 180 days (Line Items)</th>' +
		N'<th>Past 60 days (Line Items < $5,000)</th>' +
		N'<th>Past 60 days (Line Items > $5,000)</th>' +
		N'<th>Past 180 days (Line Items < $5,000)</th>' +
		N'<th>Past 180 days (Line Items > $5,000)</th>' +
		N'<th>Total Open (Line Items)</th> ' +
		N'<th>Shipping in 60 days ($)</th> ' +

		N'<th>Total Open ($)</th> ' +

		
		N'</tr><tr><td>Aifei</td><td>' +
					CAST((SELECT     AVG(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))))
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
WHERE     (PL.qty_received = PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8859')) AND 
					len(PL.extra_8) > 9 and 
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 180) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    ((PL.receipt_dt > DATEADD(day, - 60, GETDATE()))) and
                    not PL.extra_8 is null
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
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 180) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    ((CONVERT(date,PL.extra_8 , 101) > DATEADD(day, - 180, GETDATE()))) and
                    not PL.extra_8 is null

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
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 180) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    ((PL.receipt_dt > DATEADD(day, - 60, GETDATE()))) and
                    not PL.extra_8 is null
                    and
                    (PL.act_unit_cost*PL.qty_ordered) < 4000
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
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 180) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    ((CONVERT(date,PL.extra_8 , 101) > DATEADD(day, - 60, GETDATE()))) and
                    not PL.extra_8 is null
                    and
                    (PL.act_unit_cost*PL.qty_ordered) > 4000

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
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 180) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    ((PL.receipt_dt > DATEADD(day, - 180, GETDATE()))) and
                    not PL.extra_8 is null
                    and
                    (PL.act_unit_cost*PL.qty_ordered) < 4000
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
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 180) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    ((CONVERT(date,PL.extra_8 , 101) > DATEADD(day, - 180, GETDATE()))) and
                    not PL.extra_8 is null
                    and
                    (PL.act_unit_cost*PL.qty_ordered) > 4000

              ) AS NVARCHAR(MAX) ) +
              
              N'</td><td>' + 
              CAST((SELECT     COUNT(PL.item_no)
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
					WHERE     (PL.qty_received = PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8859')) AND 
					len(PL.extra_8) > 9 and 
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 180) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    not PL.extra_8 is null and
                    ((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 150, GETDATE())))
                    ) AS NVARCHAR(MAX) ) +
                    
                    
              N'</td><td>' + 
              CAST((SELECT     '$'+ CONVERT(varchar(12), CONVERT(money, (SUM((PL.act_unit_cost*PL.qty_ordered))),1), 1)
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
					WHERE     (PL.qty_received = PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8859')) AND 
					len(PL.extra_8) > 9 and 
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 180) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    ((PL.request_dt > DATEADD(day, - 60, GETDATE()))) and
                    not PL.extra_8 is null and
                    ((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 180, GETDATE())))
                    
                    ) AS NVARCHAR(MAX) ) +
                    
                                  N'</td><td>' + 
              CAST((SELECT     '$'+ CONVERT(varchar(12), CONVERT(money, (SUM((PL.act_unit_cost*PL.qty_ordered))),1), 1)
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
					WHERE     (PL.qty_received = PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8859')) AND 
					len(PL.extra_8) > 9 and 
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 180) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    not PL.extra_8 is null and
                    ((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 150, GETDATE())))
                    ) AS NVARCHAR(MAX) ) +
                    
	    N'</tr><tr><td>Pafic</td><td>' +
	    					CAST((SELECT     AVG(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))))
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
WHERE     (PL.qty_received = PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8830')) AND 
					len(PL.extra_8) > 9 and 
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 180) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    ((PL.receipt_dt > DATEADD(day, - 60, GETDATE()))) and
                    not PL.extra_8 is null

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
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 180) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    ((PL.receipt_dt > DATEADD(day, - 180, GETDATE()))) and
                    not PL.extra_8 is null
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
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 180) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    ((PL.receipt_dt > DATEADD(day, - 60, GETDATE()))) and
                    not PL.extra_8 is null and
                    (PL.act_unit_cost*PL.qty_ordered) < 4000
                    

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
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 180) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    ((PL.receipt_dt > DATEADD(day, - 60, GETDATE()))) and
                    not PL.extra_8 is null and
                    (PL.act_unit_cost*PL.qty_ordered) > 4000
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
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 180) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    ((PL.receipt_dt > DATEADD(day, - 180, GETDATE()))) and
                    not PL.extra_8 is null and
                    (PL.act_unit_cost*PL.qty_ordered) < 4000
                    

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
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 180) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    ((PL.receipt_dt > DATEADD(day, - 180, GETDATE()))) and
                    not PL.extra_8 is null and
                    (PL.act_unit_cost*PL.qty_ordered) > 4000
              ) AS NVARCHAR(MAX) ) +
              
                                N'</td><td>' + 
              CAST((SELECT    COUNT(PL.item_no)
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
					WHERE     (PL.qty_received = PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8830')) AND 
					len(PL.extra_8) > 9 and 
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 180) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    ((PL.request_dt > DATEADD(day, - 60, GETDATE()))) and
                    not PL.extra_8 is null and
                    ((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 180, GETDATE())))
                    ) AS NVARCHAR(MAX) ) +
                    
                            N'</td><td>' + 
              CAST((SELECT     '$'+ CONVERT(varchar(12), CONVERT(money, (SUM((PL.act_unit_cost*PL.qty_ordered))),1), 1)
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
					WHERE     (PL.qty_received = PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8830')) AND 
					len(PL.extra_8) > 9 and 
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 180) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    not PL.extra_8 is null and
                    ((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 180, GETDATE())))
                    ) AS NVARCHAR(MAX) ) +
                    
                  N'</td><td>' + 
              CAST((SELECT     '$'+ CONVERT(varchar(12), CONVERT(money, (SUM((PL.act_unit_cost*PL.qty_ordered))),1), 1)
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
					WHERE     (PL.qty_received = PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8830')) AND 
					len(PL.extra_8) > 9 and 
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 180) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    ((PL.request_dt > DATEADD(day, - 60, GETDATE()))) and
                    not PL.extra_8 is null and
                    ((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 180, GETDATE())))
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
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 180) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    ((PL.receipt_dt > DATEADD(day, - 60, GETDATE()))) and
                    not PL.extra_8 is null
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
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 180) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    ((PL.receipt_dt > DATEADD(day, - 180, GETDATE()))) and
                    not PL.extra_8 is null
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
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 180) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    ((PL.receipt_dt > DATEADD(day, - 60, GETDATE()))) and
                    not PL.extra_8 is null and
                    (PL.act_unit_cost*PL.qty_ordered) < 4000
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
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 180) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    ((PL.receipt_dt > DATEADD(day, - 60, GETDATE()))) and
                    not PL.extra_8 is null and
                    (PL.act_unit_cost*PL.qty_ordered) > 4000
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
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 180) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    ((PL.receipt_dt > DATEADD(day, - 180, GETDATE()))) and
                    not PL.extra_8 is null and
                    (PL.act_unit_cost*PL.qty_ordered) < 4000
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
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 180) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    ((PL.receipt_dt > DATEADD(day, - 180, GETDATE()))) and
                    not PL.extra_8 is null and
                    (PL.act_unit_cost*PL.qty_ordered) > 4000
              ) AS NVARCHAR(MAX) ) +
              
                                                              N'</td><td>' + 
              CAST((SELECT     COUNT(PL.item_no)
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
					WHERE     (PL.qty_received = PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('9523')) AND 
					len(PL.extra_8) > 9 and 
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 180) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    not PL.extra_8 is null and
                    ((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 180, GETDATE())))
                    ) AS NVARCHAR(MAX) ) +
                    
                            N'</td><td>' + 
              CAST((SELECT     '$'+ CONVERT(varchar(12), CONVERT(money, (SUM((PL.act_unit_cost*PL.qty_ordered))),1), 1)
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
					WHERE     (PL.qty_received = PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('9523')) AND 
					len(PL.extra_8) > 9 and 
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 180) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    ((PL.request_dt > DATEADD(day, - 60, GETDATE()))) and
                    not PL.extra_8 is null and
                    ((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 180, GETDATE())))
                    ) AS NVARCHAR(MAX) ) +
                    
                                                N'</td><td>' + 
              CAST((SELECT     '$'+ CONVERT(varchar(12), CONVERT(money, (SUM((PL.act_unit_cost*PL.qty_ordered))),1), 1)
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
					WHERE     (PL.qty_received = PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('9523')) AND 
					len(PL.extra_8) > 9 and 
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 180) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    not PL.extra_8 is null and
                    ((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 180, GETDATE())))
                    ) AS NVARCHAR(MAX) ) +
        N'</tr><tr><td>MPW Mfg.</td><td>' +
        					CAST((SELECT     AVG(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))))
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
WHERE     (PL.qty_received = PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('9533')) AND 
					len(PL.extra_8) > 9 and 
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 180) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    ((PL.receipt_dt > DATEADD(day, - 60, GETDATE()))) and
                    not PL.extra_8 is null
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
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 180) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    ((PL.receipt_dt > DATEADD(day, - 180, GETDATE()))) and
                    not PL.extra_8 is null
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
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 180) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    ((PL.receipt_dt > DATEADD(day, - 60, GETDATE()))) and
                    not PL.extra_8 is null and
                    (PL.act_unit_cost*PL.qty_ordered) < 4000
                    
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
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 180) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    ((PL.receipt_dt > DATEADD(day, - 60, GETDATE()))) and
                    not PL.extra_8 is null and
                    (PL.act_unit_cost*PL.qty_ordered) > 4000
                    
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
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 180) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    ((PL.receipt_dt > DATEADD(day, - 180, GETDATE()))) and
                    not PL.extra_8 is null and
                    (PL.act_unit_cost*PL.qty_ordered) < 4000
                    
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
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 180) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    ((PL.receipt_dt > DATEADD(day, - 180, GETDATE()))) and
                    not PL.extra_8 is null and
                    (PL.act_unit_cost*PL.qty_ordered) > 4000
                    
              ) AS NVARCHAR(MAX) ) +
              
                                                             N'</td><td>' + 
              CAST((SELECT     COUNT(PL.item_no)
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
					WHERE     (PL.qty_received = PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('9533')) AND 
					len(PL.extra_8) > 9 and 
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 180) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    not PL.extra_8 is null and
                    ((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 180, GETDATE())))
                    ) AS NVARCHAR(MAX) ) +
                    
                            N'</td><td>' + 
              CAST((SELECT     '$'+ CONVERT(varchar(12), CONVERT(money, (SUM((PL.act_unit_cost*PL.qty_ordered))),1), 1)
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
					WHERE     (PL.qty_received = PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('9533')) AND 
					len(PL.extra_8) > 9 and 
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 180) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    ((PL.request_dt > DATEADD(day, - 60, GETDATE()))) and
                    not PL.extra_8 is null and
                    ((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 180, GETDATE())))
                    ) AS NVARCHAR(MAX) ) +
                                                N'</td><td>' + 
              CAST((SELECT     '$'+ CONVERT(varchar(12), CONVERT(money, (SUM((PL.act_unit_cost*PL.qty_ordered))),1), 1)
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
					WHERE     (PL.qty_received = PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('9533')) AND 
					len(PL.extra_8) > 9 and 
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 180) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    not PL.extra_8 is null and
                    ((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 180, GETDATE())))
                    ) AS NVARCHAR(MAX) ) +
		N'</table><br><br>Thanks,<br>'+
		N'The Marco Team';

	/* Send the mail */
	EXEC	msdb.dbo.sp_send_dbmail
	
			@profile_name = 'SQL2008_DBMail_IT_General',
			@recipients = '',
			@copy_recipients = 'bryan.gregory@marcocompany.com',
			@file_attachments = '',
			@body_format = 'HTML',
			@body = @tableHTML,
			@subject = 'Weekly China Vendor Report - Current Purchasing Volume and Average Lead Times' ;
END