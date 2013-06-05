USE [001]
	/* Test to see if there are any records, any reason to send the email */
IF
	(
		select		COUNT(*)
		FROM iminvloc_sql INNER JOIN imitmidx_sql on iminvloc_sql.item_no = imitmidx_sql.item_no
		WHERE len(rtrim(imitmidx_sql.item_no)) > 15 and activity_cd = 'A'
		) > 0

BEGIN
	/* Declare and populate the html table and query */
	DECLARE @tableHTML  NVARCHAR(MAX) ;
	
		SET @tableHTML =
		N'The following items exist with names greater than 15 characters and need to be corrected. <br><br>' + 
		N'<table style="background-color:white; font-family:arial; font-size:12px;" border="1" cellpadding="2" cellspacing="0">' +
		N'<tr><th>Item No</th>' +
			CAST((SELECT td = imitmidx_sql.item_no
				FROM iminvloc_sql INNER JOIN imitmidx_sql on iminvloc_sql.item_no = imitmidx_sql.item_no
				WHERE len(rtrim(imitmidx_sql.item_no)) > 15 and activity_cd = 'A'
            FOR XML PATH('tr'), TYPE 
              ) AS NVARCHAR(MAX) ) +
		N'</table><br><br>Thanks,<br>'+
		N'The Marco Team';

	/* Send the mail */
	EXEC	msdb.dbo.sp_send_dbmail
	
			@profile_name = 'SQL2008_DBMail_IT_General',
			@recipients = 'bethany.rogers@marcocompany.com; pat.sien@marcocompany.com',
			@copy_recipients = 'bryan.gregory@marcocompany.com; gary.walker@marcocompany.com; victor.gandara@marcocompany.com',
			@file_attachments = '',
			@body_format = 'HTML',
			@body = @tableHTML,
			@subject = 'Production Control Alert - Item Length Too Long' ;
END

	    
			
	