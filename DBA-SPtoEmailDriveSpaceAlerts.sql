SET ANSI_NULLS ON
GO
 
SET QUOTED_IDENTIFIER ON
GO
 
/*----------------------------------------------------------------------------------------------------------
--Created:	01/14/13		 By:	BG
--Last Updated:	01/14/13	 By:	BG
--Purpose:	Email disk space alert with free space details in each drive
------------------------------------------------------------------------------------------------------------
input: @mailto - recepients list
         @mailProfile - DBMail Profile.
         @threshold - Threshold Free space in MB below which you need the alert to be sent.
         @logfile - Log file to hold the file size details and send it as attachment.
output: Send Mail
Warnings: None.
------------------------------------------------------------------------------------------------------------
Example: EXEC [DiskSpaceMntr]
                          @mailProfile = 'SQL_Profile',
                          @mailto = 'mymailid@mymail.com',
                          @threshold = 10240,
                          @logfile = 'L:\DBA\DiskSpaceLog.txt'
------------------------------------------------------------------------------------------------------------*/
 
CREATE PROCEDURE [dbo].[BG_DiskSpaceMntr]
@mailProfile nvarchar(500),
@mailto nvarchar(4000),
@threshold INT,
@logfile nvarchar(4000)
AS
 
BEGIN
 
declare @count int;
declare @tempfspace int;
declare @tempdrive char(1);
declare @mailbody nvarchar(4000);
declare @altflag bit;
declare @sub nvarchar(4000);
declare @cmd nvarchar(4000);
 
SET @count = 0;
SET @mailbody = '';
SET @cmd = '';
 
SET NOCOUNT ON
 
--Create temp table to hold drive free space info
IF EXISTS(select * from sys.sysobjects where id = object_id('#driveinfo'))
drop table #driveinfo
 
create table #driveinfo(id int identity(1,1),drive char(1), fspace int)
 
insert into #driveinfo EXEC master..xp_fixeddrives
 
--Loop through each drive to check for drive threshold
while (select count(*) from #driveinfo) >= @count
begin
 
set @tempfspace = (select fspace from #driveinfo where id = @count)
set @tempdrive = (select drive from #driveinfo where id = @count)
 
--If free space is lower than threshold appends details to mail body and dumps the file size details into the logfile.
if @tempfspace < @threshold
BEGIN
 
SET @altflag = 1;
SET @mailbody = @mailbody + '<p>Drive ' + CAST(@tempdrive AS NVARCHAR(10)) + ' has ' + CAST(@tempfspace AS NVARCHAR(10)) + ' MB free</br>'
 
SET @cmd = 'dir /s /-c ' + @tempdrive + ':\ > ' + @logfile
 
EXEC xp_cmdshell @cmd
 
END
 
set @count = @count + 1
 
end
 
--If atleast one drive is below threshold level sends the mail with attachment
IF (@altflag = 1)
BEGIN
 
SET @sub = 'Monitor Space on ' + CAST(@@SERVERNAME AS NVARCHAR(30))
 
EXEC msdb.dbo.sp_send_dbmail
@profile_name = @mailProfile,
@recipients= @mailto,
@subject = @sub,
@body = @mailbody,
@file_attachments = @logfile,
@body_format = 'HTML'
 
END
 
drop table #driveinfo
 
set nocount off
 
END



/*  To configure xp command shell:

EXEC

sp_configure 'show advanced options', 1

GO

-- To update the currently configured value for advanced options.

RECONFIGURE

GO

-- To enable the feature.

EXEC

 

sp_configure 'xp_cmdshell', 1

GO

-- To update the currently configured value for this feature.

RECONFIGURE

GO


*/