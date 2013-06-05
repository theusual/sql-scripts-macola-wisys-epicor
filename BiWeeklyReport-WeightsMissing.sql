USE [001]
GO

	/* Test to see if there are any records, any reason to send the email */
IF
	(
		select		COUNT(*)
		FROM oeordhdr_sql AS OH INNER JOIN oeordlin_sql AS OL ON OH.ord_no = OL.ord_no INNER JOIN imitmidx_sql AS IM ON IM.item_no = OL.item_no
        WHERE IM.item_weight = 0 AND OH.shipping_dt > (CONVERT(datetime, GETDATE(), 103) - 2) AND OH.shipping_dt < (CONVERT(datetime, GETDATE(), 103) + 2) AND OH.status < 8 AND OH.ord_type = 'O' AND not(OH.status = 1)

	)
	
	> 0

BEGIN
	/* Declare and populate the html table and query */
	DECLARE @tableHTML  NVARCHAR(MAX) ;
	SET @tableHTML =
		N'<p style="font-family:arial; font-size:12px;">' +
	    N'Hello, <br><br>' +
	    N'The following  items are shipping in the next 3 days and need to have weights setup in the system.  Please contact Production Control to have the weights entered.<br><br>' +
		N'<table style="background-color:white; font-family:arial; font-size:12px;" border="1" cellpadding="2" cellspacing="0">' +
		N'<tr><th>Item No</th>' +
		N'<th>Item Desc 1</th>' +
		N'<th>Item Desc 2</th>' +

		CAST ( ( SELECT DISTINCT TD = IM.item_no, '', 
		                          TD = IM.item_desc_1,  '', 
		                          TD = IM.item_desc_2,  ''
	              FROM oeordhdr_sql AS OH INNER JOIN oeordlin_sql AS OL ON OH.ord_no = OL.ord_no INNER JOIN imitmidx_sql AS IM ON IM.item_no = OL.item_no
		          WHERE IM.item_weight = 0 AND OH.shipping_dt > (CONVERT(datetime, GETDATE(), 103) - 2) AND OH.shipping_dt < (CONVERT(datetime, GETDATE(), 103) + 2) AND OH.status < 8 AND OH.ord_type = 'O' AND not(OH.status = 1)
				  ORDER BY IM.item_no
				  
		          FOR XML PATH('tr'), TYPE 
	    ) AS NVARCHAR(MAX) ) +
		N'</table><br><br>'  +
	    N'Thank you.</p>' ;

	/* Send the mail */
	EXEC	msdb.dbo.sp_send_dbmail
	
			@profile_name = 'SQL2008_DBMail_IT_General',
			@recipients = 'pat.buie@marcocompany.com; darin.dougherty@marcocompany.com; darrell.cooper@marcocompany.com; allen.patterson@marcocompany.com; woodshop.shipping@marcocompany.com; central.shipping@marcocompany.com; rita.walker@marcocompany.com',
			@copy_recipients = 'victor.gandara@marcocompany.com; bryan.gregory@marcocompany.com',			
			@body_format = 'HTML',
			@body = @tableHTML,
			@subject = 'Email Report - Items Shipping Soon That Are Missing Weights'

END