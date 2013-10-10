-----------DISABLE THOSE DAMN TRIGGERS!!!!!----------------
-----------------------------------------------------------

--Verify load was correct
SELECT *
from [001].[dbo].[inv_upload_092813] AS INV 

--Backup pre-post values from IMINVLOC
SELECT * 
INTO [BG_BACKUP].dbo.iminvloc_prepost_092813
FROM dbo.iminvloc_sql 

--Zero out all QOH, frz
--AVG TIME: 3mins on RDP to 001

UPDATE iminvloc_sql
SET qty_on_hand = 0, frz_dt = '2013-09-28 00:00:00.000', frz_qty = 0

--WHERE loc != 'CAN'

/*Set all live QOH's to QOH's in Inventory table AND set freeze date and frozen qty*/

/*Old Query for when items at locations are not grouped in pivot table:

UPDATE iminvloc_sql
SET iminvloc_sql.qty_on_hand = Inventory.Qty, iminvloc_Sql.frz_qty = Inventory.Qty--, iminvloc_sql.frz_dt = '2011-12-30 00:00:00.000'
FROM  iminvloc_Sql, 
   (SELECT [001].[dbo].[inv_upload_inf_100112].item_no, SUM(qty) AS QTY, dept
    FROM  [001].[dbo].[inv_upload_inf_100112] JOIN iminvloc_sql ON iminvloc_sql.item_no = [001].[dbo].[inv_upload_inf_100112].item_no AND iminvloc_sql.loc = [001].[dbo].[inv_upload_inf_100112].dept
    
    GROUP BY [001].[dbo].[inv_upload_inf_100112].item_no, dept) AS Inventory 
WHERE iminvloc_sql.loc = Inventory.Dept AND iminvloc_sql.item_no = Inventory.item_no
*/

/*NEW Query for uploading when items at each loc are summed in a pivot table*/
/*MAKE SURE TO UPDATE THE INV TABLE REFERENCE TO THIS QUARTER'S INV UPLOAD*/
BEGIN TRAN
    UPDATE IMINVLOC_SQL
    SET iminvloc_sql.qty_on_hand = Inv.[QOH], iminvloc_Sql.frz_qty = Inv.[QOH]--, frz_dt = '2012-10-01 00:00:00.000'
    FROM  [001].[dbo].[inv_upload_092813] AS INV  
		JOIN iminvloc_sql ON iminvloc_sql.item_no = Inv.Item_no AND iminvloc_sql.loc = Inv.Loc

/*Pull all items that do not match and will not upload*/
SELECT Inv.Item_No, INV.[QOH], INV.Loc
FROM iminvloc_sql IM RIGHT outer join [001].[dbo].[inv_upload_092813] INV ON Inv.Item_No = IM.item_no AND INV.Loc = IM.loc
WHERE IM.item_no is null
    
/*Check for items that contain no qty_on_hand in the upload file*/

SELECT Inv.Item,  INV.[QOH], INV.Loc, qty_on_hand
FROM  [001].[dbo].[inv_upload_092813] AS INV  JOIN iminvloc_sql ON iminvloc_sql.item_no = Inv.Item_No AND iminvloc_sql.loc = INV.Loc
WHERE iminvloc_Sql.qty_on_hand IS NULL

		--Correct any nulls found in the qty_on_hand field, means that somethign got uploaded with a blank qty
		UPDATE dbo.iminvloc_sql
		SET qty_on_hand = 0
		WHERE item_no = 'SW00747'

/*Check for items that have a new QOH not matching the upload*/

SELECT IM.item_no, qty_on_hand, qty
FROM IMINVLOC_SQL IM JOIN 
   (SELECT Inv.Item, SUM([TOTAL]) AS QTY, inv.Dept
    FROM  [001].[dbo].[inv_upload_092813] AS INV JOIN iminvloc_sql ON iminvloc_sql.item_no = Inv.Item AND iminvloc_sql.loc = inv.Dept
    GROUP BY Inv.Item, inv.Dept) AS INVENTORY ON INVENTORY.Item = IM.item_no AND INVENTORY.Dept = IM.loc
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


select * from iminvloc_sql WHERE item_no = 'MDWM-0009 SB'