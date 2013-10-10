--Created:	07/1/13 			     By:	BG
--Last Updated:	10/01/13	         By:	BG
--Purpose:	For job that auto-updates component QOHs to zero
--Last changes: 

UPDATE dbo.iminvloc_sql
SET qty_on_hand = 0
OUTPUT DELETED.item_no, DELETED.qty_on_hand, DELETED.loc, GETDATE() INTO [JobOutputLogs].dbo.Auto_Set_Components_QOH_To_0
WHERE 
--Negative only
qty_on_hand < 0
--Exclude purchased items
AND item_no NOT IN (SELECT item_no FROM dbo.poordlin_sql WHERE receipt_dt > DATEADD(DAY, -365, GETDATE()))
--Exclude parents
AND item_no NOT IN (SELECT item_no FROM dbo.imitmidx_sql WHERE extra_1 = 'P')
--Exclude subassemblies
AND item_no NOT IN (SELECT item_no FROM dbo.imitmidx_sql WHERE extra_1 = 'S')
--Exclude IT  -- Removed on 4/19 per Brad
--AND loc != 'IT'
--Exclude dot items
AND item_no NOT LIKE '.%'