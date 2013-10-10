

--PULL WAITSTATS FOR  *CURRENTLY RUNNING* QUERIES

SELECT dm_ws.wait_duration_ms,
dm_ws.wait_type,
dm_es.status,
dm_t.TEXT,
dm_qp.query_plan,
dm_ws.session_ID,
dm_es.cpu_time,
dm_es.memory_usage,
dm_es.logical_reads,
dm_es.total_elapsed_time,
dm_es.program_name,
DB_NAME(dm_r.database_id) DatabaseName,
-- Optional columns
dm_ws.blocking_session_id,
dm_r.wait_resource,
dm_es.login_name,
dm_r.command,
dm_r.last_wait_type
FROM sys.dm_os_waiting_tasks dm_ws
INNER JOIN sys.dm_exec_requests dm_r ON dm_ws.session_id = dm_r.session_id
INNER JOIN sys.dm_exec_sessions dm_es ON dm_es.session_id = dm_r.session_id
CROSS APPLY sys.dm_exec_sql_text (dm_r.sql_handle) dm_t
CROSS APPLY sys.dm_exec_query_plan (dm_r.plan_handle) dm_qp
WHERE --dm_es.is_user_process = 1 AND
 dm_ws.wait_type NOT IN (
        'CLR_SEMAPHORE', 'LAZYWRITER_SLEEP', 'RESOURCE_QUEUE', 'SLEEP_TASK',
        'SLEEP_SYSTEMTASK', 'SQLTRACE_BUFFER_FLUSH', 'WAITFOR', 'LOGMGR_QUEUE',
        'CHECKPOINT_QUEUE', 'REQUEST_FOR_DEADLOCK_SEARCH', 'XE_TIMER_EVENT', 'BROKER_TO_FLUSH',
        'BROKER_TASK_STOP', 'CLR_MANUAL_EVENT', 'CLR_AUTO_EVENT', 'DISPATCHER_QUEUE_SEMAPHORE',
        'FT_IFTS_SCHEDULER_IDLE_WAIT', 'XE_DISPATCHER_WAIT', 'XE_DISPATCHER_JOIN', 'BROKER_EVENTHANDLER',
        'TRACEWRITE', 'FT_IFTSHC_MUTEX', 'SQLTRACE_INCREMENTAL_FLUSH_SLEEP','SLEEP_BPOOL_FLUSH',
        'CXPACKET','DBMIRROR_EVENTS_QUEUE','DBMIRRORING_CMD')
GO

--PULL QUERY STATS IN THE SERVER CACHE

SELECT text, * from sys.dm_exec_query_stats
CROSS APPLY sys.dm_exec_sql_text (sql_handle) dm_t
ORDER BY total_elapsed_time DESC

KILL 1080


--Clear Wait Stats
DBCC SQLPERF('sys.dm_os_wait_stats', CLEAR);