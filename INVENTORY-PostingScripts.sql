-----------DISABLE THOSE DAMN TRIGGERS!!!!!----------------
-----------------------------------------------------------

--Verify load was correct
SELECT *
from [BG_BACKUP].[dbo].[inventory_010114_update_frzqty] AS INV 

--Backup pre-post values from IMINVLOC
SELECT * 
INTO [BG_BACKUP].dbo.iminvloc_prepost_01062014
FROM dbo.iminvloc_sql WITH (NOLOCK)

--Zero out all qty, frz
--AVG TIME: 3mins on RDP to 001

UPDATE iminvloc_sql
SET frz_dt = '2013-12-31 00:00:00.000'
--, qty_on_hand = 0, frz_qty = 0

select * from iminvloc_sql 
--WHERE loc != 'CAN'

/*Set all live qty's to qty's in Inventory table AND set freeze date and frozen qty*/

/*Old Query for when items at locations are not grouped in pivot table:

UPDATE iminvloc_sql
SET iminvloc_sql.qty_on_hand = Inventory.Qty, iminvloc_Sql.frz_qty = Inventory.Qty--, iminvloc_sql.frz_dt = '2011-12-30 00:00:00.000'
FROM  iminvloc_Sql, 
   (SELECT [001].[dbo].[inv_upload_inf_100112].item, SUM(qty) AS QTY, dept
    FROM  [001].[dbo].[inv_upload_inf_100112] JOIN iminvloc_sql ON iminvloc_sql.item = [001].[dbo].[inv_upload_inf_100112].item AND iminvloc_sql.loc = [001].[dbo].[inv_upload_inf_100112].dept
    
    GROUP BY [001].[dbo].[inv_upload_inf_100112].item, dept) AS Inventory 
WHERE iminvloc_sql.loc = Inventory.Dept AND iminvloc_sql.item = Inventory.item
*/

/*NEW Query for uploading when items at each loc are summed in a pivot table*/
/*MAKE SURE TO UPDATE THE INV TABLE REFERENCE TO THIS QUARTER'S INV UPLOAD*/
BEGIN TRAN
    UPDATE IMINVLOC_SQL
    SET iminvloc_Sql.frz_qty = Inv.[qty]--, iminvloc_sql.qty_on_hand = Inv.[qty] --, frz_dt = '2012-10-01 00:00:00.000'
    FROM  [BG_BACKUP].[dbo].[inventory_010114_update_frzqty] AS INV  
		JOIN iminvloc_sql ON iminvloc_sql.item_no = Inv.item AND iminvloc_sql.loc = INV.loc

/*Pull all items that do not match and will not upload*/
SELECT Inv.item, INV.[qty], INV.Loc
FROM iminvloc_sql IM RIGHT outer join [BG_BACKUP].[dbo].[inv_upload_010614] INV ON Inv.item = IM.item_no AND INV.Loc = IM.loc
WHERE IM.item_no is null
    
/*Check for items that contain no qty_on_hand in the upload file*/

SELECT Inv.Item,  INV.[qty], INV.Loc, qty_on_hand
FROM  [BG_BACKUP].[dbo].[inv_upload_010614] AS INV  JOIN iminvloc_sql ON iminvloc_sql.item_no = Inv.item AND iminvloc_sql.loc = INV.Loc
WHERE iminvloc_Sql.qty_on_hand IS NULL

		--Correct any nulls found in the qty_on_hand field, means that somethign got uploaded with a blank qty
		UPDATE dbo.iminvloc_sql
		SET qty_on_hand = 0
		WHERE item = 'SW00747'

/*Check for items that have a new qty not matching the upload*/

SELECT IM.item, qty_on_hand, qty
FROM IMINVLOC_SQL IM JOIN 
   (SELECT Inv.Item, SUM([TOTAL]) AS QTY, inv.Dept
    FROM  [001].[dbo].[inv_upload_092813] AS INV JOIN iminvloc_sql ON iminvloc_sql.item = Inv.Item AND iminvloc_sql.loc = inv.Dept
    GROUP BY Inv.Item, inv.Dept) AS INVENTORY ON INVENTORY.Item = IM.item AND INVENTORY.Dept = IM.loc
WHERE IM.qty_on_hand != INVENTORY.[Total]

/*Check Counts*/

SELECT '1111111111', '----BELOW IS DB----'
UNION ALL 
SELECT COUNT(*), loc
FROM iminvloc_sql
WHERE frz_qty > 0
GROUP BY loc
UNION ALL
SELECT '1111111111', '----BELOW IS FILE----'
UNION ALL 
SELECT COUNT(*), Inv.Dept
FROM [001].[dbo].[inv_upload_092813] INV
WHERE [TOTAL] > 0
GROUP BY Dept

--IF ALL THE CHECKS ABOVE ARE GOOD, COMMIT THE TRAN!
COMMIT TRANSACTION

--REMEMBER TO ENABLE TRIGGERS!!!!!!!!!******************************----------------------%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
--AND COMMIT THE TRAN!


select * from iminvloc_sql