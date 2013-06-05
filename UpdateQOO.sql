
SELECT IM.item_no, QOO.qty_on_ord, IM.qty_on_ord
FROM dbo.Z_IMINVLOC_QOO QOO JOIN [001].dbo.iminvloc_sql IM ON QOO.item_no = IM.item_no AND QOO.stk_loc = IM.loc

BEGIN TRANSACTION

UPDATE [001].dbo.iminvloc_sql
SET qty_on_ord = 0
WHERE qty_on_ord > 0

COMMIT TRANSACTION

BEGIN TRANSACTION

UPDATE [001].dbo.iminvloc_sql
SET qty_on_ord = QOO.qty_on_ord
FROM iminvloc_Sql IM , [001].[dbo].z_iminvloc_qoo QOO
WHERE QOO.item_no = IM.item_no AND QOO.stk_loc = IM.loc

COMMIT TRANSACTION