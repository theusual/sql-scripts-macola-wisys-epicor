SELECT item_no, drawing_release_no + drawing_revision_no, item_desc_1, item_desc_2
FROM dbo.imitmidx_sql AS IM
WHERE activity_cd = 'A'