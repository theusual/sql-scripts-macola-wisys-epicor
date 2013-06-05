SELECT * FROM iminvloc_Sql WHERE item_no like 'WM 000 ST'

DECLARE @cost AS FLOAT
SET @cost = 28.90

UPDATE dbo.iminvloc_sql
SET std_cost = @cost, last_cost =@cost, avg_cost = @cost
WHERE item_no = 'WM 000 ST' AND loc = 'INF'


SINTRA-538
SINTRA 538-1
SINTRA 538-2-R
SINTRA 538-2-M

SINTRA-538US
SINTRA-538-1US
SINTRA-538-2-RUS
SINTRA-538-2-MUS

RW 000 6W
WM 000 ST
