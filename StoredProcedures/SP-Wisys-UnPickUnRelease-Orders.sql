USE [001]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER Proc [dbo].[BG_Wisys_UnPickUnRelease_Orders] (@line SMALLINT, @order char(8), @loc varchar(3))
As
Begin
Begin Transaction

DECLARE @extra_8 varchar(16)
DECLARE @error VARCHAR(500)

IF NOT EXISTS(SELECT ord_no FROM dbo.oeordlin_sql WHERE ord_type = 'O' AND @order = LTRIM(ord_no) AND @line = line_no AND extra_8 LIKE ('%' + @loc + '%'))
	BEGIN
	SET @error = 'ERROR:  Location ' + @loc + ' has not yet released the order.  Cannot unrelease.'
		RAISERROR (@error, -- Message text.
           10, -- Severity,
           1) -- State
		Rollback Transaction
        Goto on_error
	END

IF EXISTS (SELECT ord_no FROM dbo.oeordlin_sql WHERE ord_type = 'O' AND @order = LTRIM(ord_no) AND @line = line_no AND extra_8 LIKE ('%,' + @loc + '%'))
	BEGIN
		UPDATE dbo.oeordlin_sql
		SET extra_8 =  REPLACE(extra_8,','+@loc,'')
		WHERE @order = LTRIM(ord_no) AND @line = line_no
	END

IF EXISTS (SELECT ord_no FROM dbo.oeordlin_sql WHERE ord_type = 'O' AND @order = LTRIM(ord_no) AND @line = line_no AND extra_8 LIKE ('%' + @loc + ',%'))
	BEGIN
		UPDATE dbo.oeordlin_sql
		SET extra_8 =  REPLACE(extra_8,@loc+',','')
		WHERE ord_type = 'O' AND @order = LTRIM(ord_no) AND @line = line_no
	END

IF EXISTS (SELECT ord_no FROM dbo.oeordlin_sql WHERE ord_type = 'O' AND @order = LTRIM(ord_no) AND @line = line_no AND extra_8 LIKE ('%' + @loc + '%'))
	BEGIN
		UPDATE dbo.oeordlin_sql
		SET extra_8 =  REPLACE(extra_8,@loc,null)
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