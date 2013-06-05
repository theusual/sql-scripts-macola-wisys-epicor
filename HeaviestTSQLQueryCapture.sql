-- Two level - Self adjusting trace to capture worst performing TSQL statements using a sampling technique
--
-- Output is stored in a table which is finally output once statistical confidence is high enough or sample time expires
-- Note TSQL will run for 15-20 minutes (DONT CANCEL) and should be run on a busy system for best effect.r

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT 20000
SET IMPLICIT_TRANSACTIONS OFF
IF @@TRANCOUNT > 0
        COMMIT TRANSACTION
SET LANGUAGE us_english
SET CURSOR_CLOSE_ON_COMMIT OFF
SET QUERY_GOVERNOR_COST_LIMIT 0
SET NUMERIC_ROUNDABORT OFF
SET NOCOUNT ON

DECLARE @SPID int, @DatabaseID int, @ApplicationName nvarchar(256),
        @TrIDL int, @TrIDS int,
        @TrStatusL int, @TrStatusS int,
        @TracePathL nvarchar(1024), @TracePathS nvarchar(1024),
        @TraceTableLong nvarchar(1024), @TraceTableShort nvarchar(1024),
        @CurrentDuration bigint, @OldDuration bigint,
        @TraceRowsFound int, @MaxTraceFileSize bigint,
        @LastStmtEndTime datetime, @LastSampleTime datetime,
        @LastStmtEndTimeS datetime, @LastSampleTimeS datetime,
        @SecSinceLastCollection int, @BypassCollection bit,
        @ShortTraceExists bit, @Estimated bit, @BitOne bit,
        @GatherWaitTimeInSecs tinyint,
        @NoOfTSQLStmtsPerMinHighWater int, @NoOfTSQLStmtsPerMinLowWater int,
        @MinDurationForLongTrace bigint, @MinDurationForShortTrace bigint,
        @MaxTraceTimeInMinutes smallint, @MinTraceTimeInMinutes smallint,
        @StartTraceTime datetime, @UniqueTSQL int,
        @StatisticalDeviation dec(14,4), @StatisticalLastAverageDuration bigint,
        @StatisticalAverageDuration bigint, @StatisticalSampleSize int, @StatisticalMinimumPopulation int,
        @ExecString varchar(50),
        @TextData nvarchar(4000),
        @Duration bigint, @EndTime datetime,
        @Reads bigint, @Writes bigint, @CPU int,
        @EntryDateBucket int, @MultiplierThisRow int, @Multiplier int,
        @Position int, @ASCIIPosition int,
        @TSQLHashCode bigint,
        @MultiLineSkip tinyint, @SingleLineSkip tinyint,
        @TwoCharacter char(2), @OneCharacterASCII int,
        @PreviousHighDuration bigint  

SELECT @SPID = @@SPID,
        @CurrentDuration = 5000000,
        @MaxTraceFileSize = 25, -- in MB
        @NoOfTSQLStmtsPerMinHighWater = 500, --- (per minute) this number for testing, normally would be perhaps 200
        @NoOfTSQLStmtsPerMinLowWater = 150, --- (per minute) this number for testing, normally would be perhaps 30
        @MinDurationForLongTrace = 80000, -- overlap point between high and low traces (in microseconds)
        @MaxTraceTimeInMinutes = 20, --In Minutes, routine may exit sooner if enough samples have been gathered
        @MinTraceTimeInMinutes = 15, --In Minutes, minimum time to run even if statistics have "settled"
        @MinDurationForShortTrace = 1, -- In Minutes
        @StartTraceTime = GETDATE(),
        @UniqueTSQL = 0,
        @StatisticalDeviation = 100,
        @StatisticalSampleSize = 30,
        @StatisticalMinimumPopulation = 300,
        @BitOne = 1

--The IO path to tempdb on high-end systems will be SAN, hence we should put the trace data files there too rather than on a local drive
USE tempdb
SELECT @TracePathL = LEFT(physical_name, LEN(physical_name) -
CHARINDEX('\',REVERSE(physical_name))) + '\'
        FROM sys.database_files
        WHERE file_id = 1
SELECT @TracePathS = @TracePathL + 'HeaviestShortTrace'
SELECT @TracePathL = @TracePathL + 'HeaviestLongTrace'

Gather:

SELECT @BypassCollection = 0,
        @LastStmtEndTime  = GETDATE(),
        @LastSampleTime = GETDATE(),
        @LastStmtEndTimeS = GETDATE(),
        @LastSampleTimeS = GETDATE(),
        @GatherWaitTimeInSecs = 30

SELECT @TrIDS = traceid
        FROM sys.fn_trace_getinfo(0)
        WHERE property = 2 AND CONVERT(nvarchar(1024),value) LIKE '%\HeaviestShortTrace%'
IF @@ROWCOUNT <> 0
        SELECT @ShortTraceExists = 1
ELSE
        SELECT @ShortTraceExists = 0

SELECT @TrIDL = traceid
        FROM sys.fn_trace_getinfo(0)
        WHERE property = 2 AND CONVERT(nvarchar(1024),value) LIKE '%\HeaviestLongTrace%'
IF @@ROWCOUNT <> 0
        GOTO LongTraceExists

CreateLongTrace:
SELECT @BypassCollection = 1
EXEC sp_trace_create @TrIDL output, 2, @TracePathL, @MaxTraceFileSize, NULL, 10 IF @ShortTraceExists = 0
        EXEC sp_trace_create @TrIDS output, 2, @TracePathS, @MaxTraceFileSize, NULL, 10 

--Select trace columns to show for completed statements on Long trace
EXEC sp_trace_setevent @TrIDL, 41, 1, @BitOne -- TextData
EXEC sp_trace_setevent @TrIDL, 41, 3, @BitOne -- DBID
EXEC sp_trace_setevent @TrIDL, 41, 10, @BitOne -- ApplicationName
EXEC sp_trace_setevent @TrIDL, 41, 12, @BitOne --SPID
EXEC sp_trace_setevent @TrIDL, 41, 13, @BitOne -- Duration in microseconds
EXEC sp_trace_setevent @TrIDL, 41, 15, @BitOne -- EndTime
EXEC sp_trace_setevent @TrIDL, 41, 16, @BitOne --DiskReadsLogical
EXEC sp_trace_setevent @TrIDL, 41, 17, @BitOne --DiskWritesPhysical
EXEC sp_trace_setevent @TrIDL, 41, 18, @BitOne --CPU Time

--Select trace columns to show for completed SP statements on Long trace
EXEC sp_trace_setevent @TrIDL, 45, 1, @BitOne -- TextData
EXEC sp_trace_setevent @TrIDL, 45, 3, @BitOne -- DBID
EXEC sp_trace_setevent @TrIDL, 45, 10, @BitOne -- ApplicationName
EXEC sp_trace_setevent @TrIDL, 45, 12, @BitOne --SPID
EXEC sp_trace_setevent @TrIDL, 45, 13, @BitOne -- Duration in microseconds
EXEC sp_trace_setevent @TrIDL, 45, 15, @BitOne -- EndTime
EXEC sp_trace_setevent @TrIDL, 45, 16, @BitOne --DiskReadsLogical
EXEC sp_trace_setevent @TrIDL, 45, 17, @BitOne --DiskWritesPhysical
EXEC sp_trace_setevent @TrIDL, 45, 18, @BitOne --CPU Time

IF @ShortTraceExists = 0
        BEGIN
        --Select trace columns to show for completed statements on Short trace
        EXEC sp_trace_setevent @TrIDS, 41, 1, @BitOne -- TextData
        EXEC sp_trace_setevent @TrIDS, 41, 3, @BitOne -- DBID
        EXEC sp_trace_setevent @TrIDS, 41, 10, @BitOne -- ApplicationName
        EXEC sp_trace_setevent @TrIDS, 41, 12, @BitOne --SPID
        EXEC sp_trace_setevent @TrIDS, 41, 13, @BitOne -- Duration in microseconds
        EXEC sp_trace_setevent @TrIDS, 41, 15, @BitOne -- EndTime
        EXEC sp_trace_setevent @TrIDS, 41, 16, @BitOne --DiskReadsLogical
        EXEC sp_trace_setevent @TrIDS, 41, 17, @BitOne --DiskWritesPhysical
        EXEC sp_trace_setevent @TrIDS, 41, 18, @BitOne --CPU Time
        --Select trace columns to show for completed SP statements on Short trace
        EXEC sp_trace_setevent @TrIDS, 45, 1, @BitOne -- TextData
        EXEC sp_trace_setevent @TrIDS, 45, 3, @BitOne -- DBID
        EXEC sp_trace_setevent @TrIDS, 45, 10, @BitOne -- ApplicationName
        EXEC sp_trace_setevent @TrIDS, 45, 12, @BitOne --SPID
        EXEC sp_trace_setevent @TrIDS, 45, 13, @BitOne -- Duration in microseconds
        EXEC sp_trace_setevent @TrIDS, 45, 15, @BitOne -- EndTime
        EXEC sp_trace_setevent @TrIDS, 45, 16, @BitOne --DiskReadsLogical
        EXEC sp_trace_setevent @TrIDS, 45, 17, @BitOne --DiskWritesPhysical
        EXEC sp_trace_setevent @TrIDS, 45, 18, @BitOne --CPU Time
        END

--Set filters
EXEC sp_trace_setfilter @TrIDL, 13, 0, 4, @CurrentDuration  -- set duration of long trace >=
EXEC sp_trace_setfilter @TrIDL, 12, 0, 1, @SPID  -- Dont trace this SPID's actions
IF @ShortTraceExists = 0
        BEGIN
        EXEC sp_trace_setfilter @TrIDS, 13, 0, 3, @MinDurationForLongTrace -- set duration of short trace < long trace
        EXEC sp_trace_setfilter @TrIDS, 13, 0, 4, @MinDurationForShortTrace -- set duration of short trace >=1
        EXEC sp_trace_setfilter @TrIDS, 12, 0, 1, @SPID  -- Dont trace this SPID's actions
        END
LongTraceExists:
IF  (SELECT COUNT(*) FROM tempdb..sysobjects WHERE name LIKE '%HeaviestTraceSave%') <> 0
        BEGIN
        SELECT @LastStmtEndTime = LastStmtEndTime,
                @LastSampleTime = LastSampleTime,
                @LastStmtEndTimeS = LastStmtEndTimeS,
                @LastSampleTimeS = LastSampleTimeS
                FROM ##HeaviestTraceSave
        END
ELSE
        BEGIN
        CREATE TABLE ##HeaviestTraceSave(LastStmtEndTime datetime, LastSampleTime datetime, LastStmtEndTimeS datetime, LastSampleTimeS datetime)
        INSERT INTO ##HeaviestTraceSave values (GETDATE(), GETDATE(), GETDATE(), GETDATE())
        END

IF @BypassCollection = 1
        GOTO BypassCollection

-- Process deep infrequent "short" trace
EXEC sp_trace_setstatus @TrIDS, 1  -- start the short trace
WAITFOR DELAY '00:00:01' -- give the short trace exactly a second to run
EXEC sp_trace_setstatus @TrIDS, 0 -- stop the short trace

-- trace file processing and consolidation starts here

IF  (SELECT COUNT(*) FROM tempdb..sysobjects WHERE name LIKE '%HeaviestTraceUsage%') = 0
        CREATE TABLE ##HeaviestTraceUsage(
                [TSQLHashCode] [bigint] NOT NULL,
                [DatabaseID] [int] NOT NULL,
                [NoOfRuns] [int] NOT NULL,
                [Estimated] [bit] NOT NULL,
                [TotCPU] [bigint] NOT NULL,
                [TotIO] [bigint] NOT NULL,
                [TotDuration] [bigint] NOT NULL,
                [HighDuration] [bigint] NOT NULL,
                [ApplicationName] [nvarchar] (256) NULL,
                [TSQLText] [nvarchar](4000) NOT NULL,
        CONSTRAINT [PK_TraceUsage] PRIMARY KEY CLUSTERED
        (       [TSQLHashCode] ASC, [DatabaseID] ASC))
--      WITH (DATA_COMPRESSION = PAGE) SQL 2008 only

SELECT @Multiplier = DATEDIFF(second, @LastSampleTimeS, GETDATE())
IF @Multiplier < 1
        SELECT @Multiplier = 1

SELECT @TraceRowsFound = 0

SELECT @TraceTableLong = @TracePathL + '.trc',
        @TraceTableShort = @TracePathS + '.trc'     

DECLARE TraceOutput CURSOR FAST_FORWARD FOR
        SELECT 0, TextData, DatabaseID, ApplicationName, Duration, EndTime, Reads, Writes, CPU
                FROM fn_trace_gettable(@TraceTableLong, default)
                WHERE Duration > @MinDurationForLongTrace AND
                        EndTime > @LastStmtEndTime AND
                        TextData IS NOT NULL
        UNION ALL
        SELECT 1, TextData, DatabaseID, ApplicationName, Duration, EndTime, Reads, Writes, CPU
                FROM fn_trace_gettable(@TraceTableShort, default)
                WHERE Duration > 0 AND
                        EndTime > @LastStmtEndTimeS AND
                        TextData IS NOT NULL 

OPEN TraceOutput

FETCH NEXT FROM TraceOutput INTO @Estimated, @TextData, @DatabaseID, @ApplicationName, @Duration, @EndTime, @Reads, @Writes, @CPU

WHILE @@FETCH_STATUS = 0
        BEGIN
        -- I have used a simple checksum hash for the TSQLHashCode col after stripping off the parameters
        -- but the actual TSQL is saved in the TraceTSQL table with parameters for easy evaluation
        SELECT @TextData = LTRIM(RTRIM(@TextData)), @Position = 1, @ASCIIPosition = 1, @TSQLHashCode = 0, @MultiLineSkip = 0, @SingleLineSkip = 0
        WHILE @Position <= LEN(@TextData)
                BEGIN
                SELECT @TwoCharacter = SUBSTRING(@TextData, @Position, 2)
                IF @TwoCharacter = '/*' COLLATE SQL_Latin1_General_CP1_CI_AS AND @SingleLineSkip = 0
                        BEGIN
                        SET @MultiLineSkip = 1
                        SET @Position = @Position + 2
                        CONTINUE
                        END
                IF @TwoCharacter = '*/' COLLATE SQL_Latin1_General_CP1_CI_AS AND @SingleLineSkip = 0
                        BEGIN
                        SET @MultiLineSkip = 0
                        SET @Position = @Position + 2
                        CONTINUE
                        END
                IF @TwoCharacter = '--' COLLATE SQL_Latin1_General_CP1_CI_AS AND @MultiLineSkip = 0
                        BEGIN
                        SET @SingleLineSkip = 1
                        SET @Position = @Position + 2
                        CONTINUE
                        END
                SELECT @OneCharacterASCII = ASCII(SUBSTRING(UPPER(@TwoCharacter), 1, 1))
                IF (@OneCharacterASCII BETWEEN 10 AND 13) AND @MultiLineSkip = 0
                        BEGIN
                        SET @SingleLineSkip = 0
                        SET @Position = @Position + 1
                        CONTINUE
                        END
                IF @MultiLineSkip = 0 AND @SingleLineSkip = 0 AND @OneCharacterASCII <> 32
                        SELECT @TSQLHashCode = @TSQLHashCode + (@OneCharacterASCII * @ASCIIPosition)
                SET @Position = @Position + 1
                IF @OneCharacterASCII <> 32
                        SET @ASCIIPosition = @ASCIIPosition + 1
                END
        IF @Estimated = 0
                BEGIN
                SELECT @MultiplierThisRow = 1
                SELECT @TraceRowsFound = @TraceRowsFound + 1
                IF @EndTime > @LastStmtEndTime
                        SELECT @LastStmtEndTime = @EndTime
                END
        ELSE
                SELECT @MultiplierThisRow = @Multiplier
        IF @EndTime > @LastStmtEndTimeS
                SELECT @LastStmtEndTimeS = @EndTime
        SELECT @PreviousHighDuration = HighDuration
                FROM ##HeaviestTraceUsage
                WHERE TSQLHashCode = @TSQLHashCode AND
                        DatabaseID = @DatabaseID
        IF @@ROWCOUNT = 0
                BEGIN
                INSERT INTO ##HeaviestTraceUsage VALUES (@TSQLHashCode, @DatabaseID, @MultiplierThisRow, @Estimated, (@CPU * @MultiplierThisRow), ((@Reads + @Writes) * @MultiplierThisRow), (@Duration * @MultiplierThisRow), @Duration, @ApplicationName, @TextData)
                SELECT @UniqueTSQL = @UniqueTSQL + 1
                END
        ELSE
                IF @Duration > @PreviousHighDuration
                        BEGIN
                        UPDATE ##HeaviestTraceUsage
                                SET NoOfRuns = ##HeaviestTraceUsage.NoOfRuns + @MultiplierThisRow,
                                        TotCPU = TotCPU + (@CPU * @MultiplierThisRow),
                                        TotIO = TotIO + ((@Reads + @Writes) * @MultiplierThisRow),
                                        TotDuration = TotDuration + (@Duration * @MultiplierThisRow),
                                        HighDuration = @Duration,
                                        TSQLText = @TextData
                                WHERE TSQLHashCode = @TSQLHashCode AND
                                        DatabaseID = @DatabaseID
                        END
                ELSE
                        UPDATE ##HeaviestTraceUsage
                                SET NoOfRuns = ##HeaviestTraceUsage.NoOfRuns + @MultiplierThisRow,
                                        TotCPU = TotCPU + (@CPU * @MultiplierThisRow),
                                        TotIO = TotIO + ((@Reads + @Writes) * @MultiplierThisRow),
                                        TotDuration = TotDuration + (@Duration * @MultiplierThisRow)
                                WHERE TSQLHashCode = @TSQLHashCode  AND
                                        DatabaseID = @DatabaseID

        FETCH NEXT FROM TraceOutput INTO @Estimated, @TextData, @DatabaseID, @ApplicationName, @Duration, @EndTime, @Reads, @Writes, @CPU
        END 

CLOSE TraceOutput
DEALLOCATE TraceOutput

UPDATE ##HeaviestTraceSave
        SET LastStmtEndTime = @LastStmtEndTime,
                LastSampleTime = GETDATE(),
                LastStmtEndTimeS = @LastStmtEndTimeS,
                LastSampleTimeS = GETDATE()

SELECT @CurrentDuration = CONVERT(int,value)
        FROM fn_trace_getfilterinfo(@TrIDL)
        WHERE columnid = 13 ;  -- get current duration
SELECT @SecSinceLastCollection = DATEDIFF (ss, @LastSampleTime, GETDATE())
If (@TraceRowsFound / (@SecSinceLastCollection / 60.00) > @NoOfTSQLStmtsPerMinHighWater) OR
        ((@TraceRowsFound / (@SecSinceLastCollection / 60.00) < @NoOfTSQLStmtsPerMinLowWater) AND
        (@CurrentDuration > @MinDurationForLongTrace)) --too many or too few rows collected, adjust filter
        BEGIN
        EXEC sp_trace_setstatus @TrIDL, 0 -- stop the trace
        EXEC sp_trace_setstatus @TrIDL, 2 -- close the trace
        SELECT @OldDuration = @CurrentDuration
        IF @TraceRowsFound / (@SecSinceLastCollection / 60.00) > @NoOfTSQLStmtsPerMinHighWater
                BEGIN
                SELECT @GatherWaitTimeInSecs = @GatherWaitTimeInSecs / 5
                SELECT @CurrentDuration = (((@TraceRowsFound / (@SecSinceLastCollection / 60.00)) / @NoOfTSQLStmtsPerMinHighWater) * 0.25 * @CurrentDuration) + @CurrentDuration
                END
        ELSE
                BEGIN
                SELECT @GatherWaitTimeInSecs = @GatherWaitTimeInSecs / 4 -- should be 3
                SELECT @CurrentDuration = @CurrentDuration / 1.5
                IF @CurrentDuration < @MinDurationForLongTrace
                        SELECT @CurrentDuration = @MinDurationForLongTrace
                END
        GOTO CreateLongTrace
        END

BypassCollection:
EXEC sp_trace_setstatus @TrIDL, 1 -- re-start the trace as it may have been stopped manually or automatically 

SELECT @ExecString = 'waitfor delay ''00:00:' + CONVERT(varchar(2), @GatherWaitTimeInSecs) + ''''
EXEC (@ExecString)
---derive statistical deviation
IF  (SELECT COUNT(*) FROM tempdb..sysobjects WHERE name LIKE '%HeaviestTraceUsage%') <> 0
        SELECT @StatisticalAverageDuration = AVG(TotDuration/NoOfRuns)
                FROM ##HeaviestTraceUsage
                WHERE TSQLHashCode IN (SELECT TOP (@StatisticalSampleSize) WITH TIES TSQLHashCode
                                                                                        FROM ##HeaviestTraceUsage
                                                                                        ORDER BY TotDuration/NoOfRuns DESC)
IF @StatisticalLastAverageDuration IS NOT NULL
        SELECT @StatisticalDeviation = ABS(1 - ((@StatisticalAverageDuration * 1.0000) / (@StatisticalLastAverageDuration * 1.0000)))
        SELECT @StatisticalLastAverageDuration = @StatisticalAverageDuration

IF (DATEDIFF(MINUTE,@StartTraceTime, GETDATE()) >= @MinTraceTimeInMinutes) AND
        ((DATEDIFF(MINUTE,@StartTraceTime, GETDATE()) >= @MaxTraceTimeInMinutes) OR
        ((@UniqueTSQL > @StatisticalMinimumPopulation) AND (@StatisticalDeviation < 0.03))) -- less than 3% deviation
        GOTO ExitRoutine
GOTO Gather

ExitRoutine:
EXEC sp_trace_setstatus @TrIDL, 0 -- stop the long trace
EXEC sp_trace_setstatus @TrIDL, 2 -- close the long trace
EXEC sp_trace_setstatus @TrIDS, 0 -- stop the short trace
EXEC sp_trace_setstatus @TrIDS, 2 -- close the short trace

IF  (SELECT COUNT(*) FROM tempdb..sysobjects WHERE name LIKE '%HeaviestTraceSave%') <> 0
        DROP TABLE ##HeaviestTraceSave

-- Give statistical confidence indicator as a percentage
SELECT 100-(@StatisticalDeviation*100) AS [Confidence %]

-- Show heaviest TSQL (all runs)
SELECT NoOfRuns AS [Number of Executions],
                TotCPU,
                TotIO,
                TotDuration AS [Total Duration (microseconds)],
                HighDuration AS [Longest Duration (microseconds)],
                TotDuration/NoOfRuns AS [Ave Duration (microseconds)],
                DB_NAME(DatabaseID) AS [Database],
                TSQLText,
                ApplicationName
        FROM ##HeaviestTraceUsage
        ORDER BY 4 DESC

DROP TABLE ##HeaviestTraceUsage
GO
