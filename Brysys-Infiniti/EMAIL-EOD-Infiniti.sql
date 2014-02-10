USE [msdb]
GO

/****** Object:  Job [EMail_EOD]    Script Date: 02/11/2013 09:14:16 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 02/11/2013 09:14:17 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'EMail_EOD_Infiniti', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'MARCO\bgregory', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Delete old and copy EOD]    Script Date: 02/11/2013 09:14:17 ******/
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
		@command=N'del c:\bin\eod_inf_past90days.xls', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Refresh_Excel_EOD_MALVERN]    Script Date: 02/11/2013 09:14:17 ******/
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
		@command=N'/SQL "\eod_90day_infiniti" /SERVER HQSQL /CHECKPOINTING OFF /REPORTING E', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Send_Email]    Script Date: 02/11/2013 09:14:17 ******/
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
		@command=N'USE [020]
GO

	DECLARE @tableHTML  NVARCHAR(MAX) ;

	SET @tableHTML =
		N''<p style="font-family:arial; font-size:12px;">'' +
		N''Below are all shipments processed through the Infiniti Shipping System yesterday, and the attached Excel spreadsheet contains all shipments for the past 90 days.<br><br>'' +
		N''<table style="background-color:white; font-family:arial; font-size:12px;" border="1" cellpadding="2" cellspacing="0">'' +
		N''<tr><th>ShipDate</th>'' +
		N''<th>OrdNo</th>'' +
		N''<th>JobNo</th>'' +
		N''<th>Item</th>'' +
		N''<th>Qty</th>'' + 
		N''<th>Customer</th>'' +
		N''<th>Carrier</th>'' +
		N''<th>TrackingNo</th>'' +
		N''<th>Store</th></tr>'' +
		CAST ( ( SELECT td = [ActualShipDt], '''',
			            td = [Order], '''',
			            td = [Job_No],'''',
			            td = [Item_No], '''',
			            td = [Qty], '''',
				        td = [CusName], '''',
				        td = [Store #], '''',
				        td = [Carrier], '''',
				        td = [Tracking#], ''''
	              FROM	[020].[dbo].[BG_EOD_DAILY]
	              ORDER BY [DOCK], [OrdNo]
		          FOR XML PATH(''tr''), TYPE
	    ) AS NVARCHAR(MAX) ) +
		N''</table></p>'' ;

	/* Send the mail */
	EXEC	msdb.dbo.sp_send_dbmail
	
			@profile_name = ''BGREGORY_DBMail'',
			@recipients = ''aaron.bennett@marcocompany.com; cskroger@marcocompany.com;'',
			@copy_recipients = ''misrequests@marcocompany.com'',
			@file_attachments = ''c:\bin\eod_inf_past90days.xls'',
			@body_format = ''HTML'',
			@body = @tableHTML,
			@subject = ''EOD'' ;', 
		@database_name=N'020', 
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


