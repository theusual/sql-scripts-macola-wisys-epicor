--Created:	3/15/2011	By:	BG
--Last Updated:	2/2/2012	By:	BG
--Purpose:	Table that estimates lead time & current purchasing volume for each major China vendor

USE [001]

BEGIN
	/* Declare and populate the html table and query */
	DECLARE @tableHTML  NVARCHAR(MAX) ;
	
		SET @tableHTML =
		N'<p style="font-family:arial; font-size:12px;">' +
		N'Below are estimated lead times and current purchasing volumes for each major China vendor. '+
		N'<table style="background-color:white; font-family:arial; font-size:12px;" border="1" cellpadding="2" cellspacing="0">' +
		N'<tr><th rowspan=2>Prod Cat.</th>' +
		N'<th rowspan=2>Vendor</th>' +
		N'<th colspan=2>Estimated Lead Times</th>' +
		N'<th colspan=2>Purchasing Volume</th></tr>' +
		N'<tr><th>Previous 60 days</th>' +
		N'<th>Previous 180 days</th>' +
		N'<th>Current Open POs (Line Items)</th> ' +
		N'<th>Current Open POs ($)</th> ' +

N'</tr><tr>
<TH rowspan = 3>METAL</TH> ' + 
N'<td>Aifei</td><td>' +
					CAST((SELECT  CASE WHEN AVG(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101)))) IS NULL 
        					                      THEN '--' 
        					                      ELSE CAST(AVG(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101)))) AS VARCHAR )
                                   END
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.imitmidx_sql AS IM ON IM.item_no = PL.item_no JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
WHERE     --Received Items Only
            (PL.qty_received = PL.qty_ordered) AND 
          --Vendor
          (LTRIM(PL.vend_no) IN ('8859')) AND 
		  --Filter out bad dates with typos
		  len(PL.extra_8) > 9 and 
          --Filter out orders with extreme date differences (outliers)
          (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 250) and
          (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) AND
          --Orders received in last 60 days
                    (PL.receipt_dt > DATEADD(day, - 60, GETDATE())) AND
          --Pull only orders with a "shipped from China" date
                    not PL.extra_8 is null AND
          --Filter out orders with small qty's
                    PL.qty_ordered > 9 AND
          --Filter out non-metal
					IM.prod_cat NOT IN ('301','351','051','1','028','101','328','w01','4','028')
              ) AS NVARCHAR(MAX) ) +
             N'</td><td>' +      
					CAST((SELECT     CAST(AVG(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101)))) AS VARCHAR )
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.imitmidx_sql AS IM ON IM.item_no = PL.item_no JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
WHERE     --Received Items Only
            (PL.qty_received = PL.qty_ordered) AND 
          --Vendor
          (LTRIM(PL.vend_no) IN ('8859')) AND 
		  --Filter out bad dates with typos
		  len(PL.extra_8) > 9 and 
          --Filter out orders with extreme date differences (outliers)
          (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 250) and
          (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) AND
          --Orders received in last 60 days
                    (PL.receipt_dt > DATEADD(day, - 180, GETDATE())) AND
          --Pull only orders with a "shipped from China" date
                    not PL.extra_8 is null AND
          --Filter out orders with small qty's
                    PL.qty_ordered > 9 AND
          --Filter out non-metal
					IM.prod_cat NOT IN ('301','351','051','1','028','101','328','w01','4','028') 
              ) AS NVARCHAR(MAX) ) +
               N'</td><td>' +  
               
              CAST((SELECT     COUNT(PL.item_no)
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.imitmidx_sql AS IM ON IM.item_no = PL.item_no JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
			    WHERE     (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8859')) AND 
					IM.prod_cat NOT IN ('301','351','051','1','028','101','328','w01','4','028') AND
					
					((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					((PL.extra_8 is null))  
                    OR
                    (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8859')) AND  
                    IM.prod_cat NOT IN ('301','351','051','1','028','101','328','w01','4','028') AND
                    ((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					(CONVERT(date,PL.extra_8 , 101) > CONVERT(VARCHAR(10), GETDATE(), 101) )
                    ) AS NVARCHAR(MAX) ) +
                    
                    
              N'</td><td>' + 
              CAST((SELECT     '$'+ CONVERT(varchar(12), CONVERT(money, (SUM((PL.exp_unit_cost*(PL.qty_ordered-PL.qty_received)))),1), 1)
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.imitmidx_sql AS IM ON IM.item_no = PL.item_no JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
			    WHERE     (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8859')) AND 
					IM.prod_cat NOT IN ('301','351','051','1','028','101','328','w01','4','028') AND
					((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					((PL.extra_8 is null))  
                    OR
                    (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8859')) AND  
                    IM.prod_cat NOT IN ('301','351','051','1','028','101','328','w01','4','028') AND
                    ((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					(CONVERT(date,PL.extra_8 , 101) > CONVERT(VARCHAR(10), GETDATE(), 101) )                    
                    ) AS NVARCHAR(MAX) ) +
                    
                    
 N'</tr><tr><td>Pafic</td><td>' +
	    					CAST((SELECT     CASE WHEN AVG(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101)))) IS NULL 
        					                      THEN '--' 
        					                      ELSE CAST(AVG(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101)))) AS VARCHAR )
                                   END
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.imitmidx_sql AS IM ON IM.item_no = PL.item_no JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
WHERE     --Received Items Only
            (PL.qty_received = PL.qty_ordered) AND 
          --Vendor
          (LTRIM(PL.vend_no) IN ('8830')) AND 
		  --Filter out bad dates with typos
		  len(PL.extra_8) > 9 and 
          --Filter out orders with extreme date differences (outliers)
          (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 250) and
          (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) AND
          --Orders received in last 60 days
                    (PL.receipt_dt > DATEADD(day, - 60, GETDATE())) AND
          --Pull only orders with a "shipped from China" date
                    not PL.extra_8 is null AND
          --Filter out orders with small qty's
                    PL.qty_ordered > 9 AND
          --Filter out non-metal
                   IM.prod_cat NOT IN ('301','351','051','1','028','101','328','w01','4','028') 

              ) AS NVARCHAR(MAX) ) +
            N'</td><td>' +  
                					CAST((SELECT     CAST(AVG(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101)))) AS VARCHAR)
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.imitmidx_sql AS IM ON IM.item_no = PL.item_no JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
WHERE     --Received Items Only
            (PL.qty_received = PL.qty_ordered) AND 
          --Vendor
          (LTRIM(PL.vend_no) IN ('8830')) AND 
		  --Filter out bad dates with typos
		  len(PL.extra_8) > 9 and 
          --Filter out orders with extreme date differences (outliers)
          (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 250) and
          (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) AND
          --Orders received in last 60 days
                    (PL.receipt_dt > DATEADD(day, - 180, GETDATE())) AND
          --Pull only orders with a "shipped from China" date
                    not PL.extra_8 is null AND
          --Filter out orders with small qty's
                    PL.qty_ordered > 9 AND
           --Filter out non-metal
                   IM.prod_cat NOT IN ('301','351','051','1','028','101','328','w01','4','028')
              ) AS NVARCHAR(MAX) ) +
                                N'</td><td>' + 
              CAST((SELECT    COUNT(PL.item_no)
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.imitmidx_sql AS IM ON IM.item_no = PL.item_no JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
			    WHERE     (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8830')) AND 
			      --Filter out non-metal
                   IM.prod_cat NOT IN ('301','351','051','1','028','101','328','w01','4','028') AND
					((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					((PL.extra_8 is null))  
                    OR
                    (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8830')) AND  
                  --Filter out non-metal
                   IM.prod_cat NOT IN ('301','351','051','1','028','101','328','w01','4','028') AND
                    ((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					(CONVERT(date,PL.extra_8 , 101) > CONVERT(VARCHAR(10), GETDATE(), 101) ) 
                    ) AS NVARCHAR(MAX) ) +
                    
                            N'</td><td>' + 
              CAST((SELECT     CASE WHEN SUM(PL.exp_unit_cost * PL.qty_ordered) IS NULL THEN '$0.00' ELSE  '$'+ CONVERT(varchar(12), CONVERT(money, (SUM((PL.exp_unit_cost*(PL.qty_ordered-PL.qty_received)))),1), 1)
									END 
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.imitmidx_sql AS IM ON IM.item_no = PL.item_no JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
			    WHERE     (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8830')) AND 
					IM.prod_cat NOT IN ('301','351','051','1','028','101','328','w01','4','028') AND
					((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					((PL.extra_8 is null))  
                    OR
                    (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8830')) AND  
                    IM.prod_cat NOT IN ('301','351','051','1','028','101','328','w01','4','028') AND
                    ((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					(CONVERT(date,PL.extra_8 , 101) > CONVERT(VARCHAR(10), GETDATE(), 101) ) 
                    ) AS NVARCHAR(MAX) ) +
                  
 N'</tr><tr><td>MPW Mfg.</td><td>' +
        					CAST((SELECT     CASE WHEN AVG(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101)))) IS NULL 
        					                      THEN '--' 
        					                      ELSE CAST(AVG(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101)))) AS VARCHAR )
                                   END
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.imitmidx_sql AS IM ON IM.item_no = PL.item_no JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
WHERE     --Received Items Only
            (PL.qty_received = PL.qty_ordered) AND 
          --Vendor
          (LTRIM(PL.vend_no) IN ('9533', '9535')) AND 
		  --Filter out bad dates with typos
		  len(PL.extra_8) > 9 and 
          --Filter out orders with extreme date differences (outliers)
          (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 250) and
          (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) AND
          --Orders received in last 60 days
                    (PL.receipt_dt > DATEADD(day, - 60, GETDATE())) AND
          --Pull only orders with a "shipped from China" date
                    not PL.extra_8 is null AND
          --Filter out orders with small qty's
                    PL.qty_ordered > 9 AND
          --Only pull Metal and Other
					IM.prod_cat NOT IN ('301','351','051','1','028','101','328','w01','4','028') 
              ) AS NVARCHAR(MAX) ) +
             N'</td><td>' +
              	CAST((SELECT     CASE WHEN  AVG(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101)))) IS NULL THEN '--' ELSE CAST(AVG(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101)))) AS VARCHAR)
									END
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.imitmidx_sql AS IM ON IM.item_no = PL.item_no JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
WHERE     --Received Items Only
            (PL.qty_received = PL.qty_ordered) AND 
          --Vendor
          (LTRIM(PL.vend_no) IN ('9533', '9535')) AND 
		  --Filter out bad dates with typos
		  len(PL.extra_8) > 9 and 
          --Filter out orders with extreme date differences (outliers)
          (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 250) and
          (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) AND
          --Orders received in last 60 days
                    (PL.receipt_dt > DATEADD(day, - 180, GETDATE())) AND
          --Pull only orders with a "shipped from China" date
                    not PL.extra_8 is null AND
          --Filter out orders with small qty's
                    PL.qty_ordered > 9 AND
          --Only pull Metal and Other
					IM.prod_cat NOT IN ('301','351','051','1','028','101','328','w01','4','028')
                    ) AS NVARCHAR(MAX) ) +
               N'</td><td>' +
          CAST((SELECT    CASE WHEN COUNT(PL.item_no) IS  NULL THEN '0' ELSE COUNT(PL.item_no)
							END
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.imitmidx_sql AS IM ON IM.item_no = PL.item_no JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
			    WHERE     (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('9533', '9535')) AND 
					IM.prod_cat NOT IN ('301','351','051','1','028','101','328','w01','4','028') AND
					((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					((PL.extra_8 is null))  
                    OR
                    (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('9533', '9535')) AND  
					IM.prod_cat NOT IN ('301','351','051','1','028','101','328','w01','4','028') AND
                    ((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					(CONVERT(date,PL.extra_8 , 101) > CONVERT(VARCHAR(10), GETDATE(), 101) ) 
                    ) AS NVARCHAR(MAX) ) +
                    
                                                N'</td><td>' + 
              CAST((SELECT     CASE WHEN SUM(PL.exp_unit_cost * PL.qty_ordered) IS NULL THEN '$0.00' ELSE  '$'+ CONVERT(varchar(12), CONVERT(money, (SUM((PL.exp_unit_cost*(PL.qty_ordered-PL.qty_received)))),1), 1)
									END 
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.imitmidx_sql AS IM ON IM.item_no = PL.item_no JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
					WHERE     (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('9533', '9535')) AND 
					IM.prod_cat NOT IN ('301','351','051','1','028','101','328','w01','4','028') AND

					((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					((PL.extra_8 is null))  
                    OR
                    (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('9533', '9535')) AND
                    IM.prod_cat NOT IN ('301','351','051','1','028','101','328','w01','4','028') AND
                    ((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					(CONVERT(date,PL.extra_8 , 101) > CONVERT(VARCHAR(10), GETDATE(), 101) ) 
                    ) AS NVARCHAR(MAX) ) +
                    
N'</tr><tr><th rowspan=2>WOOD</th>' +	  
N'<td>Aifei</td><td>' +
        					CAST((SELECT     CASE WHEN AVG(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101)))) IS NULL 
        					                      THEN '--' 
        					                      ELSE CAST(AVG(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101)))) AS VARCHAR )
                                   END
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.imitmidx_sql AS IM ON IM.item_no = PL.item_no JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
WHERE     (PL.qty_received = PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8859')) AND 
					IM.prod_cat IN ('351','051') and
					len(PL.extra_8) > 9 and 
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 250) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    ((PL.receipt_dt > DATEADD(day, - 60, GETDATE()))) and
                    not PL.extra_8 is null and
                    PL.qty_ordered > 9 
              ) AS NVARCHAR(MAX) ) +
             N'</td><td>' +
              	CAST((SELECT     CAST(AVG(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))))  AS VARCHAR)
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.imitmidx_sql AS IM ON IM.item_no = PL.item_no JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
WHERE     (PL.qty_received = PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8859')) AND 
					IM.prod_cat IN ('351','051') and
					len(PL.extra_8) > 9 and 
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 250) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    ((PL.receipt_dt > DATEADD(day, - 180, GETDATE()))) and
                    not PL.extra_8 is null and
                    PL.qty_ordered > 9 
                    ) AS NVARCHAR(MAX) ) +
               N'</td><td>' +
              CAST((SELECT     COUNT(PL.item_no)
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.imitmidx_sql AS IM ON IM.item_no = PL.item_no JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
					WHERE     (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8859')) AND 
					IM.prod_cat IN ('351','051') and
					((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					((PL.extra_8 is null))  
                    OR
                    (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8859')) AND  
                    IM.prod_cat IN ('351','051') and
                    ((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					(CONVERT(date,PL.extra_8 , 101) > CONVERT(VARCHAR(10), GETDATE(), 101) )  
                    ) AS NVARCHAR(MAX) ) +
                    
                                                N'</td><td>' + 
              CAST((SELECT     '$'+ CONVERT(varchar(12), CONVERT(money, (SUM((PL.exp_unit_cost*(PL.qty_ordered-PL.qty_received)))),1), 1)
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.imitmidx_sql AS IM ON IM.item_no = PL.item_no JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
					WHERE     (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8859')) AND 
					IM.prod_cat IN ('351','051') and
					((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					((PL.extra_8 is null))  
                    OR
                    (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8859')) AND  
                    IM.prod_cat IN ('351','051') and
                    ((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					(CONVERT(date,PL.extra_8 , 101) > CONVERT(VARCHAR(10), GETDATE(), 101) )  
                    ) AS NVARCHAR(MAX) ) +
                    
	  
N'</tr><tr><td>MPW Mfg.</td><td>' +
        					CAST((SELECT     CASE WHEN AVG(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101)))) IS NULL 
        					                      THEN '--' 
        					                      ELSE CAST(AVG(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101)))) AS VARCHAR )
                                   END
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.imitmidx_sql AS IM ON IM.item_no = PL.item_no JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
WHERE     (PL.qty_received = PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('9533', '9535')) AND 
					IM.prod_cat IN ('351','051') and
					len(PL.extra_8) > 9 and 
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 250) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    ((PL.receipt_dt > DATEADD(day, - 60, GETDATE()))) and
                    not PL.extra_8 is null and
                    PL.qty_ordered > 9 
              ) AS NVARCHAR(MAX) ) +
             N'</td><td>' +
              	CAST((SELECT     CASE WHEN  AVG(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101)))) IS NULL THEN '--' ELSE CAST(AVG(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101)))) AS VARCHAR)
									END
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.imitmidx_sql AS IM ON IM.item_no = PL.item_no JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
WHERE     (PL.qty_received = PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('9533', '9535')) AND 
					IM.prod_cat IN ('351','051') and
					len(PL.extra_8) > 9 and 
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 250) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    ((PL.receipt_dt > DATEADD(day, -180, GETDATE()))) and
                    not PL.extra_8 is null and
                    PL.qty_ordered > 9 
                    ) AS NVARCHAR(MAX) ) +
               N'</td><td>' +
              CAST((SELECT     COUNT(PL.item_no)
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.imitmidx_sql AS IM ON IM.item_no = PL.item_no JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
					WHERE     (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('9533', '9535')) AND 
					IM.prod_cat IN ('351','051') and
					((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					((PL.extra_8 is null))  
                    OR
                    (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('9533', '9535')) AND  
                    IM.prod_cat IN ('351','051') and
                    ((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					(CONVERT(date,PL.extra_8 , 101) > CONVERT(VARCHAR(10), GETDATE(), 101) )  
                    ) AS NVARCHAR(MAX) ) +
                    
                                                N'</td><td>' + 
              CAST((SELECT     '$'+ CONVERT(varchar(12), CONVERT(money, (SUM((PL.exp_unit_cost*(PL.qty_ordered-PL.qty_received)))),1), 1)
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.imitmidx_sql AS IM ON IM.item_no = PL.item_no JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
					WHERE     (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('9533', '9535')) AND 
					IM.prod_cat IN ('351','051') and
					((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					((PL.extra_8 is null))  
                    OR
                    (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('9533', '9535')) AND  
                    IM.prod_cat IN ('351','051') and
                    ((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					(CONVERT(date,PL.extra_8 , 101) > CONVERT(VARCHAR(10), GETDATE(), 101) ) 
                    ) AS NVARCHAR(MAX) ) +
 N'</tr><tr><th rowspan=3>PLASTIC</th>' +	                   
 N'<td>Aifei</td><td>' +
        					CAST((SELECT     CASE WHEN AVG(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101)))) IS NULL 
        					                      THEN '--' 
        					                      ELSE CAST(AVG(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101)))) AS VARCHAR )
                                   END
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.imitmidx_sql AS IM ON IM.item_no = PL.item_no JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
WHERE     (PL.qty_received = PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8859')) AND 
					--Only pull Plastic product cat
					IM.prod_cat IN ('301','1','028','101','328','w01','4','028') AND
					
					len(PL.extra_8) > 9 and 
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 250) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    ((PL.receipt_dt > DATEADD(day, - 60, GETDATE()))) and
                    not PL.extra_8 is null and
                    PL.qty_ordered > 9 
              ) AS NVARCHAR(MAX) ) +
             N'</td><td>' +
              	CAST((SELECT     CAST(AVG(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101)))) AS VARCHAR)
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.imitmidx_sql AS IM ON IM.item_no = PL.item_no JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
WHERE     (PL.qty_received = PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8859')) AND 
					--Only pull Plastic product cat
					IM.prod_cat IN ('301','1','028','101','328','w01','4','028') AND
					
					len(PL.extra_8) > 9 and 
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 250) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    ((PL.receipt_dt > DATEADD(day, -180, GETDATE()))) and
                    not PL.extra_8 is null and
                    PL.qty_ordered > 9 
                    ) AS NVARCHAR(MAX) ) +
               N'</td><td>' +
              CAST((SELECT     CASE WHEN COUNT(PL.item_no) IS NULL THEN '0' ELSE COUNT(PL.item_no)
                                END
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.imitmidx_sql AS IM ON IM.item_no = PL.item_no JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
					WHERE     (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8859')) AND 
					--Only pull Plastic product cat
					IM.prod_cat IN ('301','1','028','101','328','w01','4','028') AND
					
					((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					((PL.extra_8 is null))  
                    OR
                    (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8859')) AND  
					--Only pull Plastic product cat
					IM.prod_cat IN ('301','1','028','101','328','w01','4','028')  AND
					
                    ((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					(CONVERT(date,PL.extra_8 , 101) > CONVERT(VARCHAR(10), GETDATE(), 101) )  
                    ) AS NVARCHAR(MAX) ) +
                    
                                                N'</td><td>' + 
              CAST((SELECT     CASE WHEN SUM(PL.exp_unit_cost * PL.qty_ordered) IS NULL THEN '$0.00' 
                                    ELSE   '$'+ CONVERT(varchar(12), CONVERT(money, (SUM((PL.exp_unit_cost*(PL.qty_ordered-PL.qty_received)))),1), 1)
                                END
                     FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.imitmidx_sql AS IM ON IM.item_no = PL.item_no JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
					WHERE     (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8859')) AND 
					--Only pull Plastic product cat
					IM.prod_cat IN ('301','1','028','101','328','w01','4','028')  AND
					
					((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					((PL.extra_8 is null))  
                    OR
                    (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8859')) AND  
					--Only pull Plastic product cat
					IM.prod_cat IN ('301','1','028','101','328','w01','4','028')  AND
					
                    ((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					(CONVERT(date,PL.extra_8 , 101) > CONVERT(VARCHAR(10), GETDATE(), 101) ) 
                    ) AS NVARCHAR(MAX) ) +
                    
                    
N'</tr><tr><td>Pafic</td><td>' +
        					CAST((SELECT     CASE WHEN AVG(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101)))) IS NULL 
        					                      THEN '--' 
        					                      ELSE CAST(AVG(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101)))) AS VARCHAR )
                                   END
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.imitmidx_sql AS IM ON IM.item_no = PL.item_no JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
WHERE     (PL.qty_received = PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8830')) AND 
					--Only pull Plastic product cat
					IM.prod_cat IN ('301','1','028','101','328','w01','4','028')  AND
					
					len(PL.extra_8) > 9 and 
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 250) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    ((PL.receipt_dt > DATEADD(day, - 60, GETDATE()))) and
                    not PL.extra_8 is null and
                    PL.qty_ordered > 9 
              ) AS NVARCHAR(MAX) ) +
             N'</td><td>' +
              	CAST((SELECT     CASE WHEN  AVG(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101)))) IS NULL THEN '--' ELSE CAST(AVG(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101)))) AS VARCHAR)
									END
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.imitmidx_sql AS IM ON IM.item_no = PL.item_no JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
WHERE     (PL.qty_received = PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8830')) AND 
					--Only pull Plastic product cat
					IM.prod_cat IN ('301','1','028','101','328','w01','4','028')  AND
					
					len(PL.extra_8) > 9 and 
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 250) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    ((PL.receipt_dt > DATEADD(day, -180, GETDATE()))) and
                    not PL.extra_8 is null and
                    PL.qty_ordered > 9 
                    ) AS NVARCHAR(MAX) ) +
               N'</td><td>' +
              CAST((SELECT     CASE WHEN COUNT(PL.item_no) IS NULL THEN '0' ELSE COUNT(PL.item_no)
                                END
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.imitmidx_sql AS IM ON IM.item_no = PL.item_no JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
					WHERE     (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8830')) AND 
					--Only pull Plastic product cat
					IM.prod_cat IN ('301','1','028','101','328','w01','4','028')  AND
					
					((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					((PL.extra_8 is null))  
                    OR
                    (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8830')) AND  
					--Only pull Plastic product cat
					IM.prod_cat IN ('301','1','028','101','328','w01','4','028')  AND
					
                    ((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					(CONVERT(date,PL.extra_8 , 101) > CONVERT(VARCHAR(10), GETDATE(), 101) )  
                    ) AS NVARCHAR(MAX) ) +
                    
                                                N'</td><td>' + 
              CAST((SELECT     CASE WHEN (SUM((PL.exp_unit_cost*(PL.qty_ordered-PL.qty_received)))) IS NULL THEN '$0.00' ELSE   '$'+ CONVERT(varchar(12), CONVERT(money, (SUM((PL.exp_unit_cost*(PL.qty_ordered-PL.qty_received)))),1), 1)
                    END
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.imitmidx_sql AS IM ON IM.item_no = PL.item_no JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
					WHERE     (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8830')) AND 
					--Only pull Plastic product cat
					IM.prod_cat IN ('301','1','028','101','328','w01','4','028')  AND
					
					((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					((PL.extra_8 is null))  
                    OR
                    (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('8830')) AND  
					--Only pull Plastic product cat
					IM.prod_cat IN ('301','1','028','101','328','w01','4','028')  AND
					
                    ((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					(CONVERT(date,PL.extra_8 , 101) > CONVERT(VARCHAR(10), GETDATE(), 101) ) 
                    ) AS NVARCHAR(MAX) ) +
                    
                    
N'</tr><tr><td>MPW Mfg.</td><td>' +
        					CAST((SELECT     CASE WHEN AVG(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101)))) IS NULL 
        					                      THEN '--' 
        					                      ELSE CAST(AVG(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101)))) AS VARCHAR )
                                   END
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.imitmidx_sql AS IM ON IM.item_no = PL.item_no JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
WHERE     (PL.qty_received = PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('9533', '9535')) AND 
					--Only pull Plastic product cat
					IM.prod_cat IN ('301','1','028','101','328','w01','4','028')  AND
					
					len(PL.extra_8) > 9 and 
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 250) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    ((PL.receipt_dt > DATEADD(day, - 60, GETDATE()))) and
                    not PL.extra_8 is null and
                    PL.qty_ordered > 9 
              ) AS NVARCHAR(MAX) ) +
             N'</td><td>' +
              	CAST((SELECT     CASE WHEN  AVG(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101)))) IS NULL THEN '--' ELSE CAST(AVG(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101)))) AS VARCHAR)
									END
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.imitmidx_sql AS IM ON IM.item_no = PL.item_no JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
WHERE     (PL.qty_received = PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('9533', '9535')) AND 
					--Only pull Plastic product cat
					IM.prod_cat IN ('301','1','028','101','328','w01','4','028') AND
					
					len(PL.extra_8) > 9 and 
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 250) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    ((PL.receipt_dt > DATEADD(day, -180, GETDATE()))) and
                    not PL.extra_8 is null and
                    PL.qty_ordered > 9 
                    ) AS NVARCHAR(MAX) ) +
               N'</td><td>' +
              CAST((SELECT     CASE WHEN (COUNT(PL.item_no)) IS NULL THEN 0 ELSE COUNT(PL.item_no)
									 END
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.imitmidx_sql AS IM ON IM.item_no = PL.item_no JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
					WHERE     (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('9533', '9535')) AND 
					--Only pull Plastic product cat
					IM.prod_cat IN ('301','1','028','101','328','w01','4','028')  AND
					
					((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					((PL.extra_8 is null))  
                    OR
                    (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('9533', '9535')) AND  
					--Only pull Plastic product cat
					IM.prod_cat IN ('301','1','028','101','328','w01','4','028')  AND
					
                    ((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					(CONVERT(date,PL.extra_8 , 101) > CONVERT(VARCHAR(10), GETDATE(), 101) )  
                    ) AS NVARCHAR(MAX) ) +
                    
                                                N'</td><td>' + 
              CAST((SELECT     CASE WHEN SUM(PL.exp_unit_cost * PL.qty_ordered) IS NULL THEN '$0.00' ELSE  '$'+ CONVERT(varchar(12), CONVERT(money, (SUM((PL.exp_unit_cost*(PL.qty_ordered-PL.qty_received)))),1), 1)
									END  
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.imitmidx_sql AS IM ON IM.item_no = PL.item_no JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
					WHERE     (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('9533', '9535')) AND 
					--Only pull Plastic product cat
					IM.prod_cat IN ('301','1','028','101','328','w01','4','028')  AND
					
					((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					((PL.extra_8 is null))  
                    OR
                    (PL.qty_received < PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('9533', '9535')) AND  
					--Only pull Plastic product cat
					IM.prod_cat IN ('301','1','028','101','328','w01','4','028')  AND
					
                    ((CONVERT(date,PH.ord_dt , 101) > DATEADD(day, - 250, GETDATE())))  and
					(CONVERT(date,PL.extra_8 , 101) > CONVERT(VARCHAR(10), GETDATE(), 101) ) 
                    ) AS NVARCHAR(MAX) ) +
                    
 N'</tr><tr><th rowspan=2>MISC</th>' +	                  
 N'<td>MPW Trading</td><td>' +
 
	    	CAST((SELECT     CASE WHEN AVG(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101)))) IS NULL THEN '--' ELSE  CAST(AVG(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101)))) AS VARCHAR)
								  END
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
              	CAST((SELECT     CAST(AVG(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101)))) AS VARCHAR)
                    FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
WHERE     (PL.qty_received = PL.qty_ordered) AND (LTRIM(PL.vend_no) IN ('9523')) AND 
					len(PL.extra_8) > 9 and 
					(datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) < 250) and
                    (datediff(day,(CONVERT(date, PH.ord_dt, 101)),(CONVERT(date,PL.extra_8 , 101))) > 5) and
                    ((PL.receipt_dt > DATEADD(day, - 180, GETDATE()))) and
                    not PL.extra_8 is null and
                    PL.qty_ordered > 7 
              ) AS NVARCHAR(MAX) ) +
              N'</td><td>' +  

              CAST((SELECT     CASE WHEN COUNT(PL.item_no) IS NULL THEN '0' ELSE COUNT(PL.item_no)
                               END
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
					(CONVERT(date,PL.extra_8 , 101) > CONVERT(VARCHAR(10), GETDATE(), 101) ) 
                    ) AS NVARCHAR(MAX) ) +
                    
                    
      N'</td><td>' + 
              CAST((SELECT     CASE WHEN SUM(PL.exp_unit_cost * PL.qty_ordered) IS NULL THEN '$0.00' ELSE  '$'+ CONVERT(varchar(12), CONVERT(money, (SUM((PL.exp_unit_cost*(PL.qty_ordered-PL.qty_received)))),1), 1)
									END 
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
					(CONVERT(date,PL.extra_8 , 101) > CONVERT(VARCHAR(10), GETDATE(), 101) ) 
                    ) AS NVARCHAR(MAX) ) +
		N'</table><br><br>This report excludes the following:  <br><ul><li>Orders older than 250 days
		                                                               <li>Outliers (a shipping time of greater than 250 days or less than 5 days)
		                                                               <li>Small quantity orders (less than 9 qty ordered)
		                                                               <li>Orders with typos in the extra_8 field on order line (China shipped date)
		   <br><br>And "open" within the scope of this report is defined as items that have not yet shipped from the China vendor according to the China shipped date (extra_8 field on order line).<br><br>                                                            
		 </ul>Please email any technical questions concerning this report to bryan.gregory@marcocompany.com<br><br>Thanks,<br>'+
		N'The Marco Team';

	/* Send the mail */
	EXEC	msdb.dbo.sp_send_dbmail
	
			@profile_name = 'BGREGORY_DBMail',
			@recipients = '',--darrell.cooper@marcocompany.com; craig.nickell@marcocompany.com; shaunpal.smith@marcocompany.com; frank@mpw.com.cn; victor.gandara@marcocompany.com; laura.russell@marcocompany.com',
			@copy_recipients = 'misrequests@marcocompany.com',
			@file_attachments = '',
			@body_format = 'HTML',
			@body = @tableHTML,
			@subject = 'Weekly China Vendor Report - Current Purchasing Volume and Average Lead Times' ;
END