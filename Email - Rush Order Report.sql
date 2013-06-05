USE [001]
GO
DECLARE @tableHTML  NVARCHAR(MAX) ;
SET @tableHTML =
		N'<p style="font-family:arial; font-size:12px;">' +
		N' In the previous 7 days, <b><u>'+
				rtrim(CAST((
SELECT COUNT (DISTINCT OH.ord_no)
FROM         dbo.oeordlin_sql AS OL INNER JOIN
                      dbo.oeordhdr_sql AS OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      dbo.ARSHTTBL AS SH ON LTRIM(OL.ord_no) = CAST(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      dbo.oecusitm_sql AS CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      dbo.edcshvfl_sql AS XX ON SH.carrier_cd = XX.mac_ship_via
WHERE     (OH.ord_type = 'O') AND(OH.oe_po_no IS NOT NULL) AND (SH.void_fg IS NULL) AND (CONVERT(varchar, 
                      CAST(RTRIM(OH.entered_dt) AS datetime), 101) > CONVERT(varchar, DATEADD(day, - 8, GETDATE()), 101)) AND (OH.shipping_dt - OH.entered_dt < 9))
             as char)) +
             N' </b></u>rush orders shipped. <b><u>'+
				rtrim(CAST((
SELECT COUNT (DISTINCT OH.ord_no)
FROM         dbo.oeordlin_sql AS OL INNER JOIN
                      dbo.oeordhdr_sql AS OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      dbo.ARSHTTBL AS SH ON LTRIM(OL.ord_no) = CAST(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      dbo.oecusitm_sql AS CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      dbo.edcshvfl_sql AS XX ON SH.carrier_cd = XX.mac_ship_via
WHERE     (OH.ord_type = 'O') AND (ltrim(OH.cus_no) IN ('1575', '20938')) AND (OH.oe_po_no IS NOT NULL) AND (SH.void_fg IS NULL) AND (CONVERT(varchar, 
                      CAST(RTRIM(OH.entered_dt) AS datetime), 101) > CONVERT(varchar, DATEADD(day, - 8, GETDATE()), 101)) AND (OH.shipping_dt - OH.entered_dt < 9))
             as char)) +
		
		N'</b></u> are Wal-Mart orders and <b><u>' +
				rtrim(CAST((
SELECT COUNT (DISTINCT OH.ord_no)
FROM         dbo.oeordlin_sql AS OL INNER JOIN
                      dbo.oeordhdr_sql AS OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      dbo.ARSHTTBL AS SH ON LTRIM(OL.ord_no) = CAST(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      dbo.oecusitm_sql AS CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      dbo.edcshvfl_sql AS XX ON SH.carrier_cd = XX.mac_ship_via
WHERE     (OH.ord_type = 'O') AND NOT( ltrim(OH.cus_no) IN ('1575', '20938')) AND (OH.oe_po_no IS NOT NULL) AND (SH.void_fg IS NULL) AND (CONVERT(varchar, 
                      CAST(RTRIM(OH.entered_dt) AS datetime), 101) > CONVERT(varchar, DATEADD(day, - 8, GETDATE()), 101)) AND (OH.shipping_dt - OH.entered_dt < 9))
             as char)) +
		N'</b></u> are for other customers.  The details of these rush orders are attached.' +
		N'<br><br>Rush orders are defined as any order which is entered into the system within 5 days of its ship date.' +
		N'<br><br>Thanks,<br>'+
		N'The Marco Team';

	/* Send the mail */
	EXEC	msdb.dbo.sp_send_dbmail
	
			@profile_name = 'SQL2008_DBMail_IT_General',
			@recipients = '',
			@copy_recipients = 'bryan.gregory@marcocompany.com',
			@file_attachments = 'C:\bin\RUSH ORDER-WEEKLY DETAILED REPORT.xls',
			@body_format = 'HTML',
			@body = @tableHTML,
			@subject = 'Weekly Rush Order Report' ;