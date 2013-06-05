USE [001]
GO

	DECLARE @tableHTML  NVARCHAR(MAX)
																																																									           
	SET @tableHTML =
		N'<p style="font-family:arial; font-size:12px;">' +
		N'The following orders are open in Macola and set to ship from either the Winton or Phoenix consolidation warehouses:'+
		N'' + 
			
		N'<table style="background-color:white; font-family:arial; font-size:12px;" border="1" cellpadding="2" cellspacing="0">' +
		N'<tr><TH>Warehouse</TH><TH>Order #</TH><TH>Ship To</TH><TH>Shipping Dt</TH><TH>Shipping Instr 1</TH><TH>Shipping Instr 2</TH></TR>' +
 + 
		
		CAST ( ( SELECT td = CASE WHEN (ship_instruction_1 like '%WINTON%' OR ship_instruction_2 like '%WINTON%' OR ship_via_cd like '%NC%') THEN 'WINTON' ELSE 'PHX' END, '',
						td = ltrim(ord_no),'',
				        td = (ship_to_name),'',
				        td = CONVERT(VARCHAR(10),shipping_dt,110),'',
				        td = (ship_instruction_1),'',
				        td = (ship_instruction_2)

FROM OEORDHDR_SQL
WHERE ship_instruction_1 like '%WINTON%' OR ship_instruction_2 like '%WINTON%' OR ship_via_cd like '%NC%' OR 
ship_instruction_1 like '%PHOENIX%' OR ship_instruction_2 like '%PHOENIX%' OR ship_via_cd like '%AZ%'
ORDER BY shipping_dt
 FOR XML PATH('tr'), TYPE 
	    ) AS NVARCHAR(MAX) ) +
		N'</td></tr>'+ 
		
		N'</table>' + 
		N'<br><HR><br>If you have any questions about this report, please contact bryan.gregory@marcocompany.com' +
		N'</p>';


	/* Send the mail */
	EXEC	msdb.dbo.sp_send_dbmail
	
			@profile_name = 'SQL2008_DBMail_IT_General',
			@recipients = '',
			@copy_recipients = 'bryan.gregory@marcocompany.com',
			@file_attachments = '',
			@body_format = 'HTML',
			@body = @tableHTML,
			@subject = 'Phoenix and Winton Distribution Warehouses - Open Orders' ;
