SELECT  --CASE WHEN z_iminvloc_usage.usage_ytd > 0
--             THEN CASE WHEN qty_on_hand > 0 THEN CAST((CAST((Z_IMINVLOC_USAGE.usage_ytd / qty_on_hand) AS money)*100) AS varchar(max)) + '%'
--                       ELSE '*NO QOH*' 
--                       END 
--             ELSE 'NO USAGE'
--        END AS [SlsToInv%], 
        --CASE WHEN z_iminvloc_usage.usage_ytd > 0
        --     THEN CASE WHEN qty_on_hand > 0 THEN (qty_on_hand / ((CEILING(dbo.Z_IMINVLOC_USAGE.usage_ytd / (DATEDIFF(day, CONVERT(datetime, '01/01/2011', 103), GETDATE()) / 30.5)))))
        --               ELSE 000 
        --               END 
        --     ELSE 'NO USAGE'
        --END AS [InvTurn],
        z_iminvloc.item_no, Z_IMINVLOC_USAGE.usage_ytd, Z_IMINVLOC.qty_on_hand, 
        CASE WHEN z_iminvloc_usage.usage_ytd > 0 THEN (qty_on_hand / CEILING((z_iminvloc_usage.usage_ytd / (DATEDIFF(day, CONVERT(datetime, '01/01/2011', 103), GETDATE()) / 30.5))))
             ELSE 0
             END AS [InvTurn], 
        CEILING(dbo.Z_IMINVLOC_USAGE.usage_ytd / (DATEDIFF(day, CONVERT(datetime, '01/01/2011', 103), GETDATE()) / 30.5))
FROM  dbo.Z_IMINVLOC AS Z_IMINVLOC INNER JOIN
               dbo.imitmidx_sql AS IMITMIDX_SQL ON Z_IMINVLOC.item_no = IMITMIDX_SQL.item_no LEFT OUTER JOIN
               dbo.Z_IMINVLOC_QALL ON dbo.Z_IMINVLOC_QALL.item_no = Z_IMINVLOC.item_no LEFT OUTER JOIN
               dbo.Z_IMINVLOC_USAGE ON dbo.Z_IMINVLOC_USAGE.item_no = Z_IMINVLOC.item_no LEFT OUTER JOIN
               dbo.BG_WM_Current_Projections PROJ ON Proj.item_no = imitmidx_sql.item_no 
WHERE (IMITMIDX_SQL.item_note_1 LIKE '%ch%')


