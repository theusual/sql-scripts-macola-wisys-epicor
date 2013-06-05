USE [001]
GO

	DECLARE @tableHTML  NVARCHAR(MAX)
																																																									           
	SET @tableHTML =
		N'<p style="font-family:arial; font-size:12px;">' +
		N'Orders have been found in Macola with a ship-from location of "FW".  These orders need to be updated to a correct ship from location and removed from FW:'+
		N'' + 
			
		N'<table style="background-color:white; font-family:arial; font-size:12px;" border="1" cellpadding="2" cellspacing="0">' +
		N'<tr><TH>Entered Dt</TH><TH>Order #</TH><TH>Cus. Name</TH><TH>Shipping Dt</TH><TH>Ship To</TH><TH>CS Initials</TH></TR>' +
 + 
		
		CAST ( ( SELECT DISTINCT td = CONVERT(VARCHAR(10),entered_dt ,110), '',
						td = ltrim(OEORDHDR_SQL.ord_no),'',
				        td = (bill_to_name),'',
				        td = CONVERT(VARCHAR(10),shipping_dt,110),'',
				        td = (ship_to_name),'',
				        td = (oeordhdr_sql.user_def_fld_5)

FROM OEORDHDR_SQL INNER JOIN OEORDLIN_SQL ON OEORDHDR_SQL.ord_no = oeordlin_sql.ord_no
WHERE oeordlin_sql.loc = 'FW' AND NOT(oeordhdr_sql.user_def_fld_5 is null) AND oeordhdr_sql.ord_type = 'O' AND NOT(oeordhdr_sql.user_def_fld_5 = 'BG') AND NOT(ltrim(oeordhdr_sql.cus_no) = '23033')
AND NOT(ltrim(rtrim(oeordhdr_sql.ord_no)) IN (6001706, 6001708, 6001669, 6001671, 6001673, 6001674))

ORDER BY CONVERT(VARCHAR(10),entered_dt ,110) DESC
 FOR XML PATH('tr'), TYPE 
	    ) AS NVARCHAR(MAX) ) +
		N'</td></tr>'+ 
		
		N'</table>' + 
		N'<br><HR><br>If you have any questions about this report, please contact bryan.gregory@marcocompany.com' +
		N'</p>';


	/* Send the mail */
	EXEC	msdb.dbo.sp_send_dbmail
	
			@profile_name = 'SQL2008_DBMail_IT_General',
			@recipients = 'cs@marcocompany.com',
			@copy_recipients = 'bryan.gregory@marcocompany.com; victor.gandara@marcocompany.com; bethany.rogers@marcocompany.com; stefanie.weidner@marcocompany.com',
			@file_attachments = '',
			@body_format = 'HTML',
			@body = @tableHTML,
			@subject = 'FW Open Order Report' ;
