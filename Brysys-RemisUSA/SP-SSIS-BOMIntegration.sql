USE [060]

GO

ALTER Proc [dbo].[BG_Brysys_BOMIntegration] AS

--Created:	2/6/14  	 By:	BG
--Last Updated: --       By:	BG
--Purpose:	Launch SSIS package using the xp_commandshell.  This SP is launched on demand from the BOM Integrator worksheets. 
--Last changes: 

-------------------------------------------------------------------------------------------------------
--NOTES: 
--
--------------------------------------------------------------------------------------------------------

	DECLARE @ssisstr varchar(8000), @packagename varchar(200),@servername varchar(100), @ExcelFilePath varchar(200), @params varchar(500)
	DECLARE @returncode int

	set @ExcelFilePath = '"\\hqsql\c$\BIN\BRYSYS\REMIS\IMPORT\bom_integrator.xlsm"'
	----Package name
	set @packagename = '\SSISDB\Remis\Remis-BOMtoDB\Remis_BOMtoDB.dtsx'
	----Server name
	set @servername = 'HQSQL'
	----package variables, which we are passing in SSIS Package.
	set @params = '/set \Package.Variables[User::ExcelFilePath].Properties[Value];"' + @ExcelFilePath + '"'
	----Create command
	set @ssisstr = 'dtexec /ISSERVER ' + @packagename + ' /SERVER ' + @servername + ' ' + @params
	-----print line for verification 
	--print @ssisstr

	----Execute DOS shell command to launch dtexec
	EXEC @returncode = xp_cmdshell @ssisstr

RETURN @returncode


	