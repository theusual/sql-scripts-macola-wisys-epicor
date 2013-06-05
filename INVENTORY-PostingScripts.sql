/*Verify load was correct*/

SELECT *
from [BG_BACKUP].[dbo].[inv_upload_040813_dlc] AS INV 

SELECT * FROM iminvloc_Sql

/*Zero out all QOH, frz
NOTE: Disable trigger
AVG TIME: 3mins on RDP to HQSQL
*/
USE [001]
--USE [020]
UPDATE iminvloc_sql
SET qty_on_hand = 0, frz_dt = '2013-03-30 00:00:00.000', frz_qty = 0

--WHERE loc != 'CAN'

/*Set all live QOH's to QOH's in Inventory table AND set freeze date and frozen qty*/

/*Old Query for when items at locations are not grouped in pivot table:

UPDATE iminvloc_sql
SET iminvloc_sql.qty_on_hand = Inventory.Qty, iminvloc_Sql.frz_qty = Inventory.Qty--, iminvloc_sql.frz_dt = '2011-12-30 00:00:00.000'
FROM  iminvloc_Sql, 
   (SELECT [BG_BACKUP].[dbo].[inv_upload_inf_100112].item_no, SUM(qty) AS QTY, dept
    FROM  [BG_BACKUP].[dbo].[inv_upload_inf_100112] JOIN iminvloc_sql ON iminvloc_sql.item_no = [BG_BACKUP].[dbo].[inv_upload_inf_100112].item_no AND iminvloc_sql.loc = [BG_BACKUP].[dbo].[inv_upload_inf_100112].dept
    
    GROUP BY [BG_BACKUP].[dbo].[inv_upload_inf_100112].item_no, dept) AS Inventory 
WHERE iminvloc_sql.loc = Inventory.Dept AND iminvloc_sql.item_no = Inventory.item_no
*/

/*NEW Query for uploading when items at each loc are summed in a pivot table*/
/*MAKE SURE TO UPDATE THE INV TABLE REFERENCE TO THIS QUARTER'S INV UPLOAD*/
BEGIN TRAN
    UPDATE IMINVLOC_SQL
    SET iminvloc_sql.qty_on_hand = Inv.[qty], iminvloc_Sql.frz_qty = Inv.[qty]--, frz_dt = '2012-10-01 00:00:00.000'
    FROM  [BG_BACKUP].[dbo].[inv_upload_040813_dlc] AS INV  
		JOIN iminvloc_sql ON iminvloc_sql.item_no = Inv.Item_no AND iminvloc_sql.loc = Inv.Dept

/*Pull all items that do not match and will not upload*/
SELECT Inv.Item, INV.[TOTAL], INV.Dept
FROM iminvloc_sql IM RIGHT outer join [BG_BACKUP].[dbo].[inv_upload_04032013] INV ON Inv.Item = IM.item_no AND INV.Dept = IM.loc
WHERE IM.item_no is null
    
/*Check for items that contain no qty_on_hand in the upload file*/

SELECT Inv.Item,  INV.[TOTAL], INV.Dept, qty_on_hand
FROM  [BG_BACKUP].[dbo].[inv_upload_04032013] AS INV  JOIN iminvloc_sql ON iminvloc_sql.item_no = Inv.Item AND iminvloc_sql.loc = INV.Dept
WHERE iminvloc_Sql.qty_on_hand IS NULL

		--Correct any nulls found in the qty_on_hand field, means that somethign got uploaded with a blank qty
		UPDATE dbo.iminvloc_sql
		SET qty_on_hand = 0
		WHERE item_no = 'SW00747'

/*Check for items that have a new QOH not matching the upload*/

SELECT IM.item_no, qty_on_hand, qty
FROM IMINVLOC_SQL IM JOIN 
   (SELECT Inv.Item, SUM([TOTAL]) AS QTY, inv.Dept
    FROM  [BG_BACKUP].[dbo].[inv_upload_04032013] AS INV JOIN iminvloc_sql ON iminvloc_sql.item_no = Inv.Item AND iminvloc_sql.loc = inv.Dept
    GROUP BY Inv.Item, inv.Dept) AS INVENTORY ON INVENTORY.Item = IM.item_no AND INVENTORY.Dept = IM.loc
WHERE IM.qty_on_hand != INVENTORY.[qty]

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
FROM [BG_BACKUP].[dbo].[inv_upload_04032013] INV
WHERE [TOTAL] > 0
GROUP BY Dept

--IF ALL THE CHECKS ABOVE ARE GOOD, COMMIT THE TRAN!
COMMIT TRANSACTION

--REMEMBER TO ENABLE TRIGGERS!!!!!!!!!******************************----------------------%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
--AND COMMIT THE TRAN!
