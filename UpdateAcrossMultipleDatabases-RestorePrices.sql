 UPDATE
 [001].dbo.iminvloc_sql
 SET
 price = IM2.price
 FROM [001].dbo.iminvloc_sql AS IM INNER JOIN [RESTORE_001].dbo.iminvloc_sql AS IM2 ON IM2.item_no = IM.item_no