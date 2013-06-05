BEGIN TRANSACTION

UPDATE dbo.iminvloc_sql
SET qty_on_hand = 0
OUTPUT DELETED.item_no, DELETED.qty_on_hand, DELETED.loc, GETDATE() INTO [JobOutputLogs].dbo.Auto_Set_Components_QOH_To_0
WHERE 
--Negative only
qty_on_hand < 0
--Exclude purchased items
AND item_no NOT IN (SELECT item_no FROM dbo.poordlin_sql WHERE receipt_dt > DATEADD(DAY, -730, GETDATE()))
--Exclude parents
AND item_no NOT IN (SELECT item_no FROM dbo.imitmidx_sql WHERE extra_1 = 'P')
--Exclude IT
AND loc != 'IT'
--Exclude dot items
AND item_no NOT LIKE '.%'


