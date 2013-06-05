SELECT item_no, drawing_release_no + drawing_revision_no FROM dbo.imitmidx_sql WHERE item_no LIKE '%.' AND REPLACE(item_no, '.','') NOT IN (SELECT item_no FROM dbo.imitmidx_sql)
