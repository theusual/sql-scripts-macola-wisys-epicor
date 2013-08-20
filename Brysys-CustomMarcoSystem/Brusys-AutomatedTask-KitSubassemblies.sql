EXEC dbo.BG_Brysys_InvTrx_IssueBOM @ParentItem = '', -- varchar(30)
    @InvLoc = '', -- varchar(3)
    @ParentQty = NULL, -- decimal
    @UserName = '', -- varchar(30)
    @Comment1 = '', -- varchar(30)
    @Comment2 = '', -- varchar(30)
    @OrdNo = '' -- char(8)

EXEC dbo.BG_Brysys_InvTrx_Receipt @ParentItem = '', -- varchar(30)
    @InvLoc = '', -- varchar(3)
    @ParentQty = NULL, -- decimal
    @UserName = '', -- varchar(30)
    @Comment1 = '', -- varchar(30)
    @Comment2 = '', -- varchar(30)
    @OrdNo = '' -- char(8)

--OUTPUT DELETED.item_no, DELETED.qty_on_hand, DELETED.loc, GETDATE() INTO [JobOutputLogs].dbo.Auto_Set_Components_QOH_To_0

SELECT * 
FROM dbo.iminvloc_sql
WHERE 
--Negative only
qty_on_hand < 0
--Exclude purchased items
AND item_no NOT IN (SELECT item_no FROM dbo.poordlin_sql WHERE receipt_dt > DATEADD(DAY, -365, GETDATE()))
--Only subassemblies
AND item_no IN (SELECT item_no FROM dbo.imitmidx_sql WHERE extra_1 = 'S')
--Exclude IT  -- Removed on 4/19 per Brad
--AND loc != 'IT'
--Exclude dot items
AND item_no NOT LIKE '.%'

SELECT * FROM imitmidx_sql WHERE item_no = 'test item bom'

SELECT * FROM iminvloc_Sql WHERE item_no = 'test item bom'

UPDATE iminvloc_Sql 
SET qty_on_hand = -20
WHERE item_no = 'test item bom' AND loc = 'FW'

BEGIN TRAN
UPDATE oeordlin_Sql
SET user_Def_fld_4 = 'TEST'
WHERE ord_no = '    1234'


SELECT * FROM oeordlin_Sql WHERE ord_no = '    1234'