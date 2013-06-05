USE [001]
GO
SET NOCOUNT ON
DECLARE @StartTime datetime, @Timer1 int, @Timer2 int, @Counter int, @V int
SELECT @StartTime = GETDATE(), @Counter = 0, @Timer1 = 0, @Timer2 = 0
WHILE @Counter < 50 -- Run expression outside MAX function 50 times
        BEGIN
        IF @Counter % 30 = 1 -- drop buffers every 30th time to simulate a cache hit ratio of 97%
                BEGIN
                SELECT @Timer1 = @Timer1 + DATEDIFF(ms, @StartTime, GETDATE())
                DBCC DROPCLEANBUFFERS
                SELECT @StartTime = GETDATE()
                END
        --Entere here the select Statement To Be Measured
        SELECT @V = MAX(SickLeaveHours)+1 FROM HumanResources.Employee
        SET @Counter = @Counter + 1
        END
SELECT @Timer1 = @Timer1 + DATEDIFF(ms, @StartTime, GETDATE())

SELECT @StartTime = GETDATE(), @Counter = 0
WHILE @Counter < 50 -- Run expression inside MAX function 50 times
        BEGIN
        IF @Counter % 30 = 1 -- drop buffers every 30th time to simulate a cache hit ratio of 97%
                BEGIN
                SELECT @Timer2 = @Timer2 + DATEDIFF(ms, @StartTime, GETDATE())
                DBCC DROPCLEANBUFFERS
                SELECT @StartTime = GETDATE()
                END
        SELECT @V = MAX(SickLeaveHours+1) FROM HumanResources.Employee
        SET @Counter = @Counter + 1
        END
SELECT @Timer2 = @Timer2 + DATEDIFF(ms, @StartTime, GETDATE())
SELECT @Timer1 AS [Run time of expression outside function],
        @Timer2 AS [Run time of expression inside function],
        (((@Timer2 * 1.00) / @Timer1) - 1) * 100 AS [% Improvement]
GO