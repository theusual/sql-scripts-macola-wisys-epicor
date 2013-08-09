--Show active server sessions and show their blocks and running status (runnable, running, waiting, suspended)
SELECT
    SPID                = er.session_id
    ,Status             = ses.status
    ,[Login]            = ses.login_name
    ,Host               = ses.host_name
    ,BlkBy              = er.blocking_session_id
    ,DBName             = DB_Name(er.database_id)
    ,CommandType        = er.command
    ,SQLStatement       = st.text
    ,ObjectName         = OBJECT_NAME(st.objectid)
    ,ElapsedMS          = er.total_elapsed_time
    ,CPUTime            = er.cpu_time
    ,IOReads            = er.logical_reads + er.reads
    ,IOWrites           = er.writes
    ,LastWaitType       = er.last_wait_type
    ,StartTime          = er.start_time
    ,Protocol           = con.net_transport
    ,ConnectionWrites   = con.num_writes
    ,ConnectionReads    = con.num_reads
    ,ClientAddress      = con.client_net_address
    ,Authentication     = con.auth_scheme
FROM sys.dm_exec_requests er
OUTER APPLY sys.dm_exec_sql_text(er.sql_handle) st
LEFT JOIN sys.dm_exec_sessions ses
ON ses.session_id = er.session_id
LEFT JOIN sys.dm_exec_connections con
ON con.session_id = ses.session_id
WHERE ses.[status] != 'sleeping'


--Show wait stats grouped by program
SELECT
     CPU            = SUM(cpu_time)
    ,WaitTime       = SUM(total_scheduled_time)
    ,ElapsedTime    = SUM(total_elapsed_time)
    ,Reads          = SUM(num_reads)
    ,Writes         = SUM(num_writes)
    ,Connections    = COUNT(1)
    ,Program        = program_name
FROM sys.dm_exec_connections con
LEFT JOIN sys.dm_exec_sessions ses
    ON ses.session_id = con.session_id
GROUP BY program_name
ORDER BY cpu DESC

-- Group By User
SELECT
     CPU            = SUM(cpu_time)
    ,WaitTime       = SUM(total_scheduled_time)
    ,ElapsedTime    = SUM(total_elapsed_time)
    ,Reads          = SUM(num_reads)
    ,Writes         = SUM(num_writes)
    ,Connections    = COUNT(1)
    ,[login]        = original_login_name
    ,MAX(ses.session_id)
from sys.dm_exec_connections con
LEFT JOIN sys.dm_exec_sessions ses
ON ses.session_id = con.session_id
GROUP BY original_login_name

--Find Current Session for myself
SELECT @@SPID

--Kill offending/blocking SPIDs
KILL 69

--Find Macola Locks
SELECT  mac.SessionID, mac.DBName, mac.TableName, mac.RowID, ses.host_name, ses.program_name, ses.login_name, ses.status
FROM    MSLLockDB.dbo.MacLocks MAC LEFT JOIN sys.dm_exec_sessions ses ON ses.session_id = MAC.SessionID

--Clear Macola Locks
delete from MSLLockDB.dbo.MacLocks

--Find Wisys Lock
SELECT  *
FROM    MSLLockDB.dbo.WiSysConcurrency

--Clear Macola Locks
DELETE FROM MSLLockDB.dbo.WiSysConcurrency

--Clear inventory posting table

DELETE BacoSettings WHERE
SettingGroup = 'Physical_Or_Cycle_Count' AND
SettingName = 'Tag_Numbers'


-----SQL 2005------
-------------------

EXEC sp_who
