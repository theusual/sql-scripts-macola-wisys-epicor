SELECT IM.std_cost, IM.avg_cost, IM.last_cost, IMINF.std_cost, IMINF.avg_cost, IMINF.last_cost, * FROM iminvloc_Sql IM JOIN [020].dbo.iminvloc_sql IMINF ON IMINF.item_no = IM.item_no AND IMINF.loc = IM.loc

UPDATE [020].dbo.iminvloc_sql
SET std_cost = IM.std_cost, avg_cost = IM.avg_cost, last_cost = IM.last_cost
FROM iminvloc_Sql IM , [020].dbo.iminvloc_sql IMINF
WHERE IMINF.item_no = IM.item_no AND IMINF.loc = IM.loc