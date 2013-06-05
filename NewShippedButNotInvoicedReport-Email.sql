USE [001]
GO

	DECLARE @tableHTML  NVARCHAR(MAX) ;

	SET @tableHTML =
		N'<p style="font-family:arial; font-size:12px;">' +
		N'We currently have <u><b>' + 
		rtrim(CAST((
SELECT COUNT(DISTINCT  OEORDHDR_SQL.ord_no)
FROM  dbo.oeordhdr_sql AS OEORDHDR_SQL INNER JOIN
               dbo.oeordlin_sql AS OEORDLIN_SQL ON OEORDHDR_SQL.ord_type = OEORDLIN_SQL.ord_type AND 
               OEORDHDR_SQL.ord_no = OEORDLIN_SQL.ord_no INNER JOIN
               wsPikPak SH ON SH.Ord_no = OEORDHDR_SQL.ord_no INNER JOIN
               arcusfil_sql AR ON AR.cus_no = OEORDHDR_SQL.cus_no 
WHERE (NOT (OEORDLIN_SQL.prod_cat IN ('037', '2', '036', '102', '111', '336'))) AND OEORDHDR_SQL.ord_type = 'O' AND OEORDHDR_SQL.status != 'C' AND OEORDHDR_SQL.status < 9 AND (OEORDHDR_SQL.tot_sls_amt > 0) 
AND shipped = 'Y' AND SH.ship_dt < DATEADD(day,-2,GETDATE()) AND OEORDLIN_SQL.item_no NOT like '%TEST%')
                      as char)) + 
		
		N'</U></b> shipped orders not yet invoiced. <br><br><b><u>' +
				rtrim(CAST((
SELECT COUNT(DISTINCT  OEORDHDR_SQL.ord_no)
FROM  dbo.oeordhdr_sql AS OEORDHDR_SQL INNER JOIN
               dbo.oeordlin_sql AS OEORDLIN_SQL ON OEORDHDR_SQL.ord_type = OEORDLIN_SQL.ord_type AND 
               OEORDHDR_SQL.ord_no = OEORDLIN_SQL.ord_no INNER JOIN
               wsPikPak SH ON SH.Ord_no = OEORDHDR_SQL.ord_no INNER JOIN
               arcusfil_sql AR ON AR.cus_no = OEORDHDR_SQL.cus_no 
WHERE (NOT (OEORDLIN_SQL.prod_cat IN ('037', '2', '036', '102', '111', '336'))) AND OEORDHDR_SQL.ord_type = 'O' AND OEORDHDR_SQL.status != 'C' AND OEORDHDR_SQL.status < 9 AND (OEORDHDR_SQL.tot_sls_amt > 0) 
AND shipped = 'Y' AND SH.ship_dt < DATEADD(day,-2,GETDATE()) AND OEORDLIN_SQL.item_no NOT like '%TEST%'
AND ltrim(oeordhdr_sql.cus_no) = '1575')
                      as char)) + 
		
		N'</b></u> are Wal-Mart US orders (not including AP) and <b><u>' +
				rtrim(CAST((
SELECT COUNT(DISTINCT  OEORDHDR_SQL.ord_no)
FROM  dbo.oeordhdr_sql AS OEORDHDR_SQL INNER JOIN
               dbo.oeordlin_sql AS OEORDLIN_SQL ON OEORDHDR_SQL.ord_type = OEORDLIN_SQL.ord_type AND 
               OEORDHDR_SQL.ord_no = OEORDLIN_SQL.ord_no INNER JOIN
               wsPikPak SH ON SH.Ord_no = OEORDHDR_SQL.ord_no INNER JOIN
               arcusfil_sql AR ON AR.cus_no = OEORDHDR_SQL.cus_no 
WHERE (NOT (OEORDLIN_SQL.prod_cat IN ('037', '2', '036', '102', '111', '336'))) AND OEORDHDR_SQL.ord_type = 'O' AND OEORDHDR_SQL.status != 'C' AND OEORDHDR_SQL.status < 9 AND (OEORDHDR_SQL.tot_sls_amt > 0) 
AND shipped = 'Y' AND SH.ship_dt < DATEADD(day,-2,GETDATE()) AND OEORDLIN_SQL.item_no NOT like '%TEST%' 
AND ltrim(oeordhdr_sql.cus_no) != '1575')
                      as char)) 
                      +
		N'</b></u> are for other customers. <br><br> The details of these orders are attached.' +
		N'<br><br>**<b>NOTE:</b> This report identifies shipped orders not yet invoiced that are more than 2 days past their day of shipment.**' +
		N'<br><br>Please contact misrequests@marcocompany.com with any issues regarding the report. <br>'+
		N'<br><br>Thanks,<br>'+
		N'The Marco Team';

	/* Send the mail */
	EXEC	msdb.dbo.sp_send_dbmail
	
			@profile_name = 'BGREGORY_DBMail',
			@recipients = 'misrequests@marcocompany.com',--'john.quiroz@marcocompany.com; ellen.mathison@marcocompany.com; douglas.pentecost@marcocompany.com',
			@copy_recipients = '',--'misrequests@marcocompany.com; victor.gandara@marcocompany.com; darrell.cooper@marcocompany.com; craig.nickell@marcocompany.com; katrina.little@marcocompany.com; deborah.brennan@marcocompany.com',
			@file_attachments = 'C:\bin\SHIPPED_BUT_NOT_INVOICED.xls',
			@body_format = 'HTML',
			@body = @tableHTML,
			@subject = 'Weekly Shipped But Not Invoiced Report - UPDATED' ;
