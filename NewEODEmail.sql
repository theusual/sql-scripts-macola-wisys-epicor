USE [001]
GO

	DECLARE @tableHTML  NVARCHAR(MAX) ;

	SET @tableHTML =
		N'<p style="font-family:arial; font-size:12px;">' +
		N'Below are all shipments processed through Wisys yesterday. The attached Excel spreadsheet contains the same data.<br><br>' +
		N'<table style="background-color:white; font-family:arial; font-size:12px;" border="1" cellpadding="2" cellspacing="0">' +
		N'<tr><th>Date</th>' +
		N'<th>OrdNo</th>' +
		N'<th>Item</th>' +
		N'<th>Qty</th>' + 
		N'<th>ShipTo</th>' +
		N'<th>Carrier</th>' +
		N'<th>TrackingNo</th>' +
		N'<th>Dock</th></tr>' +
		CAST ( ( SELECT td = [ShippedDt], '',
			            td = [OrdNo], '',
			            td = [Item], '',
			            td = [Qty], '',
				        td = [ShipTo], '',
				        td = [Carrier], '',
				        td = [TrackingNo], '',
						td = [Dock], ''
	              FROM	[001].[dbo].[Z_EOD_DAILY]
	              ORDER BY [DOCK], [OrdNo]
		          FOR XML PATH('tr'), TYPE
	    ) AS NVARCHAR(MAX) ) +
		N'</table></p>' ;

	/* Send the mail */
	EXEC	msdb.dbo.sp_send_dbmail
	
			@profile_name = 'BGREGORY_DBMail',
			@recipients = 'bryan.gregory@marcocompany.com',--'bethany.rogers@marcocompany.com; pat.sien@marcocompany.com; pat.buie@marcocompany.com; steve.jarboe@marcocompany.com; erika.pineda@marcocompany.com; brad.rogers@marcocompany.com; cheryl.little@marcocompany.com; melissa.calhoon@marcocompany.com; mike.sharp@marcocompany.com; plastic.shipping@marcocompany.com; central.shipping@marcocompany.com; rita.walker@marcocompany.com; carl.cunningham@marcocompany.com; joyce.solis@marcocompany.com',
			@copy_recipients = '',--'allen.patterson@marcocompany.com; cit@marcocompany.com; bryan.gregory@marcocompany.com; autumn.armstrong@marcocompany.com; sharon.thomas@marcocompany.com; vicki.lewis@marcocompany.com',
			@file_attachments = 'c:\bin\eod_daily.xls',
			@body_format = 'HTML',
			@body = @tableHTML,
			@subject = 'EOD' ;