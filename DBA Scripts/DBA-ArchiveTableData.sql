--Created:	09/01/11	 By:	BG
--Last Updated:	9/4/13	 By:	BG
--Purpose: Archiving chunks of table data into archival tables stored in BG_Backup, then purging the archived data from the active tables
--Last Change:  --

BEGIN TRAN
--DELETE 
--SELECT *  
--INTO [BG_Backup].dbo.[wspikpak_2011_2012] 
FROM wspikpak
WHERE YEAR(ship_dt) IN ('2011','2012')
COMMIT TRAN