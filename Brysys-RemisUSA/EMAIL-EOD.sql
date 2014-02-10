USE [msdb]
GO

/****** Object:  Job [EMail_REMIS_EOD]    Script Date: 2/4/2014 1:23:20 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 2/4/2014 1:23:20 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'EMail_REMIS_EOD', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'MARCO\sql2008', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Delete old EOD]    Script Date: 2/4/2014 1:23:20 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Delete old EOD', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'CmdExec', 
		@command=N'del c:\bin\eod_remis_past90days.xls', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Create 90 day attachment]    Script Date: 2/4/2014 1:23:21 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Create 90 day attachment', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'SSIS', 
		@command=N'/SQL "\"\remis_eod_90day\"" /SERVER HQSQL /X86  /CHECKPOINTING OFF /REPORTING E', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Send_Email]    Script Date: 2/4/2014 1:23:21 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Send_Email', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'USE [060]
GO

	DECLARE @tableHTML  NVARCHAR(MAX) ;

	SET @tableHTML =
		N''<p style="font-family:arial; font-size:12px;">'' +
		N''Below are all shipments processed through the Remis Shipping System in the past 7 days, and the attached Excel spreadsheet contains all shipments for the past 90 days.<br><br>'' +
		N''<table style="background-color:white; font-family:arial; font-size:12px;" border="1" cellpadding="2" cellspacing="0">'' +
		N''<tr><th>ShipDate</th>'' +
		N''<th>OrdNo</th>'' +
		N''<th>Item</th>'' +
		N''<th>Qty</th>'' + 
		N''<th>Customer</th>'' +
		N''<th>ShipToAddress</th>'' +
		N''<th>Carrier</th>'' +
		N''<th>TrackingNo</th></tr>'' +
		CAST ( ( SELECT td = [ShipDt], '''',
			            td = [Order], '''',
			            td = [Item_No], '''',
			            td = [Qty], '''',
				        td = [Cus Name], '''',
				        td = [ShipTo], '''',
				        td = [Carrier], '''',
				        td = [TrackingNo], ''''
	              FROM	[060].[dbo].[BG_EOD_7]
	              ORDER BY CONVERT(datetime, [ShipDt],103) DESC,[Order]
		          FOR XML PATH(''tr''), TYPE
	    ) AS NVARCHAR(MAX) ) +
		N''</table></p>'' ;

	/* Send the mail */
	EXEC	msdb.dbo.sp_send_dbmail
	
			@profile_name = ''BGREGORY_DBMail'',
			@recipients = ''employees@remisamerica.com; jacques.noire@remisamerica.com '',
			@copy_recipients = ''misrequests@marcocompany.com'',
			@file_attachments = ''c:\bin\eod_remis_past90days.xls'',
			@body_format = ''HTML'',
			@body = @tableHTML,
			@subject = ''Remis End of Day Shipping Report'' ;', 
		@database_name=N'060', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Daily_0400', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval=125, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20100405, 
		@active_end_date=99991231, 
		@active_start_time=32000, 
		@active_end_time=235959, 
		@schedule_uid=N'f51c0395-b417-4b61-8947-069884b155b7'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO


