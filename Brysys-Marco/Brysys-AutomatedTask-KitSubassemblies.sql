--Created:	10/01/13 			     By:	BG
--Last Updated:	10/01/13	         By:	BG
--Purpose:	For job that auto-updates component QOHs to zero.   This script is for the portion that kits subassemblies
--Last changes: 

--Issue components
DECLARE @sp_batch nvarchar(max)	
SELECT @sp_batch = ''	
SELECT @sp_batch = @sp_batch  + 'EXEC dbo.BG_Brysys_InvTrx_Receipt ''' + item_no +  ''', '''  + loc +  ''', '  + CAST((qty_on_hand*-1) As Varchar) +  ', '''  
							  +  'Brysys'  +  ''', '''  + 'UPDATE_Set_Subassembly_QOH_To_0'', ' + '''AutoKitSubassembliesToZero''' + '; ' 
FROM dbo.iminvloc_sql
WHERE 	--Negative only
		qty_on_hand < 0
		--Exclude purchased items
		AND item_no NOT IN (SELECT item_no FROM dbo.poordlin_sql WHERE receipt_dt > DATEADD(DAY, -365, GETDATE()))
		--Only subassemblies
		AND item_no IN (SELECT item_no FROM dbo.imitmidx_sql WHERE extra_1 = 'S')
		--Exclude IT  -- Removed on 4/19 per Brad
		--AND loc != 'IT'
		--Exclude dot items
		AND item_no NOT LIKE '.%'
		--Test	
		AND item_no LIKE 'TEST%'
SELECT @sp_batch
EXEC(@sp_batch)

--Receive parents
DECLARE @sp_batch nvarchar(max)	
SELECT @sp_batch = ''	
SELECT @sp_batch = @sp_batch  + 'EXEC dbo.BG_Brysys_InvTrx_IssueBOM ''' + item_no +  ''', '''  + loc +  ''', '  + CAST((qty_on_hand*-1) As Varchar) +  ', '''  
							  +  'Brysys'  +  ''', '''  + 'UPDATE_Set_Subassembly_QOH_To_0'', ' + '''AutoKitSubassembliesToZero''' + '; ' 
FROM dbo.iminvloc_sql
WHERE 	--Negative only
		qty_on_hand < 0
		--Exclude purchased items
		AND item_no NOT IN (SELECT item_no FROM dbo.poordlin_sql WHERE receipt_dt > DATEADD(DAY, -365, GETDATE()))
		--Only subassemblies
		AND item_no IN (SELECT item_no FROM dbo.imitmidx_sql WHERE extra_1 = 'S')
		--Exclude IT  -- Removed on 4/19 per Brad
		--AND loc != 'IT'
		--Exclude dot items
		AND item_no NOT LIKE '.%'
		--Test	
		AND item_no LIKE 'TEST%'
SELECT @sp_batch
EXEC(@sp_batch)


/*
For testing:
SELECT * FROM iminvloc_Sql WHERE item_no = 'test item bom'

UPDATE iminvloc_Sql 
SET qty_on_hand = -20 
WHERE item_no = 'test item bom' AND loc = 'fw' 
*/

/* Stored Procedures used for reference:
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
*/