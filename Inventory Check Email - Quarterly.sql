USE [001]

GO

DECLARE @ITEM NVARCHAR(MAX)
DECLARE @Sold NVARCHAR(MAX)
DECLARE @Received NVARCHAR(MAX)
DECLARE @QOH NVARCHAR(MAX)
DECLARE @PQOH NVARCHAR(MAX)

DECLARE @tableHTML  NVARCHAR(MAX)

SET @ITEM =
('MET-TBL 001 BV')
	      
SET @Sold = 
	CAST((CAST((SELECT     SUM((OELINHST_sql.qty_ordered))
	FROM         dbo.OEHDRHST_sql AS OEHDRHST_SQL INNER JOIN
                      dbo.OELINHST_sql AS OELINHST_SQL ON OEHDRHST_SQL.ord_type = OELINHST_SQL.ord_type AND 
                      OEHDRHST_SQL.ord_no = OELINHST_SQL.ord_no LEFT OUTER JOIN
                      dbo.ARSHTTBL ON LTRIM(OELINHST_SQL.ord_no) = CAST(dbo.ARSHTTBL.ord_no AS int) AND 
                      OELINHST_SQL.item_no = dbo.ARSHTTBL.filler_0001 AND dbo.ARSHTTBL.void_fg IS NULL
	WHERE           
                    
                    (OEHDRHST_SQL.shipping_dt > '07/01/2010') and
                    OELINHST_SQL.item_no = @ITEM and
                    OELINHST_SQL.unit_price > 0
                   ) AS DECIMAL)) as NVARCHAR(MAX))

SET @Received = 
	CAST((CAST((SELECT     SUM((PL.qty_received))
FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
WHERE           
                    
                    (PL.receipt_dt > '07/01/2010') and
                    PL.item_no = @ITEM
                    ) AS DECIMAL)) as NVARCHAR(MAX))

SET @QOH =
	CAST((CAST((SELECT iminvloc_sql.qty_on_hand
	      FROM iminvloc_sql
	      WHERE iminvloc_sql.item_no = @ITEM
	      ) AS DECIMAL)) as NVARCHAR(MAX))

SET @PQOH =
    CAST((CAST(( CAST((100) AS DECIMAL) + CAST((@RECEIVED) AS DECIMAL) - CAST((@SOLD) AS DECIMAL)
    ) AS DECIMAL)) as NVARCHAR(MAX))
SET @tableHTML =
		N'<p style="font-family:arial; font-size:12px;">' +
		N'<table style="background-color:white; font-family:arial; font-size:12px;" border="1" cellpadding="2" cellspacing="0">' +
		N'<tr><th>Item No</TH><th>Dec 2009 Count</th><th>Qty Received</th><th>Qty Sold</th><th>Projected Current QOH</TH></tr>' + 
		N'<tr><td>' + @ITEM + '</td><td>' + '100' + '</td><td>+ ' + @Received + '</td><td> - ' + @Sold + '</td><td> = ' +  @PQOH   +  '</Td></table>'               
	
EXEC	msdb.dbo.sp_send_dbmail
	
			@profile_name = 'SQL2008_DBMail_IT_General',
			@recipients = '',
			@copy_recipients = 'bryan.gregory@marcocompany.com',
			@file_attachments = '',
			@body_format = 'HTML',
			@body = @tableHTML,
			@subject = 'Inventory Check' ;