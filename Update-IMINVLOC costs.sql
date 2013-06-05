USE [001]
UPDATE iminvloc_sql
SET avg_cost = Z_IMINVLOC_COSTS.avg_cost, std_cost = Z_IMINVLOC_COSTS.std_cost, last_cost = Z_IMINVLOC_COSTS.last_cost
FROM iminvloc_sql, Z_IMINVLOC_COSTS
WHERE iminvloc_sql.item_no = Z_IMINVLOC_COSTS.item_no and NOT (iminvloc_sql.loc = 'FW')
