USE [001]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER Proc [dbo].[BG_Wisys_PickRelease_Orders] (@line SMALLINT, @order char(8), @loc varchar(3))
As
Begin
	
Begin Transaction

DECLARE @extra_8 varchar(16)
DECLARE @error VARCHAR(500)

SET @extra_8 = (SELECT extra_8 FROM dbo.oeordlin_sql WHERE @order = LTRIM(ord_no) AND @line = line_no AND ord_type = 'O')

IF EXISTS(SELECT ord_no FROM dbo.oeordlin_sql WHERE ord_type = 'O' AND @order = LTRIM(ord_no) AND @line = line_no AND extra_8 LIKE ('%' + @loc + '%'))
	BEGIN
	SET @error = 'ERROR:  Location ' + @loc + ' has already released the order.  Use unrelease to remove.'
		RAISERROR (@error, -- Message text.
           10, -- Severity,
           1) -- State
		Rollback Transaction
        Goto on_error
	END

IF @extra_8 IS NULL BEGIN
	UPDATE dbo.oeordlin_sql
	SET extra_8 = @loc
	WHERE ord_type = 'O' AND @order = LTRIM(ord_no) AND @line = line_no
END

IF @extra_8 IS NOT NULL BEGIN
	UPDATE dbo.oeordlin_sql
	SET extra_8 =  LTRIM(RTRIM(extra_8)) + ',' + @loc
	WHERE ord_type = 'O' AND @order = LTRIM(ord_no) AND @line = line_no
END

If @@error <> 0 Begin
  Rollback Transaction
  Goto on_error
End

End

COMMIT Transaction

on_error:
	PRINT @@ERROR
	RETURN @@ERROR
GO


