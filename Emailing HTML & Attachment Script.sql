USE [001]
GO

	DECLARE @tableHTML  NVARCHAR(MAX) ;

	SET @tableHTML =
		N'<p style="font-family:arial; font-size:12px;">' +
		N'Attached are all open AIFEI Purchase Orders.<br><br>Please update container info and ship dates in the first 2 columns and highlight in yellow any updates made. Then, save and email the attachment to POManagement@marcocompany.com.' + 
		N'<br><br>Please also contact POManagement@marcocompany.com if any errors in POs are found.' +
		N'<br><br>Xièxiè,<br>'+
		N'The Marco Team';

	/* Send the mail */
	EXEC	msdb.dbo.sp_send_dbmail
	
			@profile_name = 'SQL2008_DBMail_IT_General',
			@recipients = 'judson.griffis@marcocompany.com, darrell.cooper@marcocompany.com, randy.ayers@marcocompany.com',
			@copy_recipients = 'bryan.gregory@marcocompany.com, alan.whited@marcocompany.com',
			@file_attachments = 'C:\bin\CHPOMAIL\CHPO_NIGHTLY_VENDOR_VIEW_AIFEI.xls',
			@body_format = 'HTML',
			@body = @tableHTML,
			@subject = 'OPEN AIFEI PURCHASE ORDERS - UPDATE WITH ANY NEW SHIPPING INFO AND RETURN' ;