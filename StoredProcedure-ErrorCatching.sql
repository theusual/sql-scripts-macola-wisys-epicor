-- Verify that the stored procedure does not exist.
IF OBJECT_ID ('uspBG_GetErrorInfo', 'P') IS NOT NULL
    DROP PROCEDURE usp_GetErrorInfo;
GO

-- Create a procedure to retrieve error information.
CREATE PROCEDURE usp_GetErrorInfo
AS
    SELECT 
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_SEVERITY() AS ErrorSeverity,
        ERROR_STATE() as ErrorState,
        ERROR_PROCEDURE() as ErrorProcedure,
        ERROR_LINE() as ErrorLine,
        ERROR_MESSAGE() as ErrorMessage;
GO

BEGIN TRY
    -- Generate divide-by-zero error.
    SELECT 1/0;
END TRY
BEGIN CATCH
    -- Execute the error retrieval routine.
    EXECUTE usp_GetErrorInfo;
END CATCH;
GO