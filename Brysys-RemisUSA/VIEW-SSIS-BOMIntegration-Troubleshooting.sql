select * 
FROM [JobOutputLogs].dbo.[Brysys_Log_060_SSIS_BOM_Integration]

select *
FROM [060].dbo.[BG_BOM_TEMPLATE]

select *
FROM [BG_BACKUP].dbo.[BG_BOM_STAGING]

DELETE FROM [060].dbo.[BG_BOM_TEMPLATE]
DELETE FROM [JobOutputLogs].dbo.[Brysys_Log_060_SSIS_BOM_Integration]

EXEC [060].dbo.BG_Brysys_BOMIntegration

exec sp_xp_cmdshell_proxy_account 'MARCO\bgregory', 'Penny2010!';

GRANT Execute ON xp_cmdshell
	  TO access_user_remis