SELECT TOP (100) PERCENT --@ordernum AS PO#,
                         PL.item_no AS MarcoItem,
                         PL.item_desc_1 AS [Description 1],
                         PL.item_desc_2 AS [Description 2],
                         IM.uom,
                         Cast(PL.qty_ordered AS INT) AS Quantity,
                         CAST(DATEPART(year, GETDATE()) AS VARCHAR) + CAST(DATEPART(month, GETDATE()) AS VARCHAR) + CAST(DATEPART(day, GETDATE()) AS VARCHAR) AS [MPW Batch ID]
                         
FROM   POORDLIN_SQL PL
       JOIN IMITMIDX_SQL IM
         ON IM.item_no = PL.item_no
WHERE  --@ordernum = LEFT(PL.ord_no, Len(PL.ord_no) - 2)       AND 
		PL.qty_ordered > 0 