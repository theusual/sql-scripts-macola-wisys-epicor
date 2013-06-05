USE [001]
	/* Test to see if there are any records, any reason to send the email */
IF
	(
		select		COUNT(*)
		 FROM   (OEORDHDR_SQL OEORDHDR_SQL INNER JOIN OEORDLIN_SQL OEORDLIN_SQL ON OEORDHDR_SQL.ord_no=OEORDLIN_SQL.ord_no) INNER JOIN iminvloc_sql IMINVLOC_SQL ON (OEORDLIN_SQL.item_no=IMINVLOC_SQL.item_no) AND (OEORDLIN_SQL.loc=IMINVLOC_SQL.loc)
			WHERE (unit_price  < std_cost OR unit_price < last_cost) and
(CONVERT(varchar, CAST(RTRIM(entered_dt) AS datetime), 101) > DATEADD(day, - 8, GETDATE())) and
oe_po_no IS NOT NULL  and
unit_price > 0 and
not OEORDLIN_SQL.item_no in ('ADD ON', 'BACKORDER', 'FIXTURE REQUEST', 'INITIAL DIV 01', 'INITIAL RM', 'INITIAL SC', 'PROTOTYPE METAL', 'PROTOTYPE PLASTIC', 'PROTOTYPE WOOD', 'REVIEW ITEM', 'SAMPLE', 'CAP EX','INITIAL WNM') and
not OEORDLIN_SQL.item_no like 'et finish%'
		) > 0

BEGIN
	/* Declare and populate the html table and query */
	DECLARE @tableHTML  NVARCHAR(MAX) ;
	
		SET @tableHTML =
		N'<p style="font-family:arial; font-size:12px;">' +
		N'In the past 7 days,  <b><u>'+
		rtrim(CAST((
		select COUNT(oeordlin_sql.item_no)
		 FROM (OEORDHDR_SQL OEORDHDR_SQL INNER JOIN OEORDLIN_SQL OEORDLIN_SQL ON OEORDHDR_SQL.ord_no=OEORDLIN_SQL.ord_no) INNER JOIN iminvloc_sql IMINVLOC_SQL ON (OEORDLIN_SQL.item_no=IMINVLOC_SQL.item_no) AND (OEORDLIN_SQL.loc=IMINVLOC_SQL.loc)
			WHERE (unit_price  < std_cost OR unit_price < last_cost) and
(CONVERT(varchar, CAST(RTRIM(entered_dt) AS datetime), 101) > DATEADD(day, - 8, GETDATE())) and
oe_po_no IS NOT NULL  and
unit_price > 0 and
not OEORDLIN_SQL.item_no in ('ADD ON', 'BACKORDER', 'FIXTURE REQUEST', 'INITIAL DIV 01', 'INITIAL RM', 'INITIAL SC', 'PROTOTYPE METAL', 'PROTOTYPE PLASTIC', 'PROTOTYPE WOOD', 'REVIEW ITEM', 'SAMPLE', 'CAP EX','INITIAL WNM') and
not OEORDLIN_SQL.item_no like 'et finish%'
		) AS CHAR )) + 
		N' </u></B> items were sold with a unit price less than either the "standard cost" or the "last cost" in Macola.  <br><br>Below is a summary of these items and attached is a detailed report (including order numbers) for further researching .<br><br><u>Action items:</u><ul><li><p style="font-family:arial; font-size:12px;">If the item is appearing on the report due to incorrect costs entered in the system, please contact Gary Walker with the item # so that correct costs can be entered. <br><li><p style="font-family:arial; font-size:12px;"> If the item appears on the report due to the item being a fake item or a special situation, please contact Bryan with the item # so that it can be excluded from future reports.  <li><p style="font-family:arial; font-size:12px;">Any remaining items which are legitimately being sold less than costs will be reviewed by Craig and Jon.</ul><br>' + 
		N'<table style="background-color:white; font-family:arial; font-size:12px;" border="1" cellpadding="2" cellspacing="0">' +
		N'<tr><th>Item No</th>' +
			CAST((SELECT distinct oeordlin_sql.item_no as "td"
				FROM   (OEORDHDR_SQL OEORDHDR_SQL INNER JOIN OEORDLIN_SQL OEORDLIN_SQL ON OEORDHDR_SQL.ord_no=OEORDLIN_SQL.ord_no) INNER JOIN iminvloc_sql IMINVLOC_SQL ON (OEORDLIN_SQL.item_no=IMINVLOC_SQL.item_no) AND (OEORDLIN_SQL.loc=IMINVLOC_SQL.loc)
			WHERE (unit_price  < std_cost OR unit_price < last_cost) and
(CONVERT(varchar, CAST(RTRIM(entered_dt) AS datetime), 101) > DATEADD(day, - 8, GETDATE())) and
oe_po_no IS NOT NULL  and
unit_price > 0 and
not OEORDLIN_SQL.item_no in ('ADD ON', 'BACKORDER', 'FIXTURE REQUEST', 'INITIAL DIV 01', 'INITIAL RM', 'INITIAL SC', 'PROTOTYPE METAL', 'PROTOTYPE PLASTIC', 'PROTOTYPE WOOD', 'REVIEW ITEM', 'SAMPLE', 'CAP EX','INITIAL WNM') and
not OEORDLIN_SQL.item_no like 'et finish%'
order by oeordlin_sql.item_no
            FOR XML PATH('tr'), TYPE 
              ) AS NVARCHAR(MAX) ) +
		N'</table><br><br>Thanks,<br>'+
		N'The Marco Team';

	/* Send the mail */
	EXEC	msdb.dbo.sp_send_dbmail
	
			@profile_name = 'SQL2008_DBMail_IT_General',
			@recipients = 'jon.stewart@marcocompany.com',
			@copy_recipients = 'bryan.gregory@marcocompany.com',
			@file_attachments = 'c:\bin\unit_price_less_than_cost.xls',
			@body_format = 'HTML',
			@body = @tableHTML,
			@subject = 'Weekly Order Entry Alert - Items Sold Less Than Cost' ;
END