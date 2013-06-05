UPDATE [001].dbo.imitmidx_sql
SET imitmidx_sql.search_desc = IM.search_desc
FROM [BACKUP_TEMP].dbo.imitmidx_sql AS IM INNER JOIN [001].dbo.imitmidx_sql ON [001].dbo.imitmidx_sql.item_no = IM.item_no
WHERE imitmidx_sql.search_desc = 'OBSOLETE ITEM'