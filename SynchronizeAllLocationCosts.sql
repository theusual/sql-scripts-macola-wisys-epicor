DECLARE @LOC CHAR(3)
SET @loc = 'MDC'

SELECT IM.item_no, IM.std_cost, IM2.item_no, IM2.std_cost FROM IMINVLOC_SQL AS IM JOIN (SELECT item_no, std_cost FROM iminvloc_sql WHERE loc = 'MDC') AS IM2 ON IM2.item_no = IM.item_no
WHERE loc = @loc AND IM.std_cost != IM2.std_cost

SELECT IM.item_no, IM.std_cost, IM2.item_no, IM2.std_cost FROM IMINVLOC_SQL AS IM JOIN (SELECT item_no, std_cost FROM iminvloc_sql WHERE loc = 'FW') AS IM2 ON IM2.item_no = IM.item_no
WHERE loc = @loc AND IM.std_cost != IM2.std_cost

SELECT IM.item_no, IM.std_cost, IM2.item_no, IM2.std_cost FROM IMINVLOC_SQL AS IM JOIN (SELECT item_no, std_cost FROM iminvloc_sql WHERE loc = 'MS') AS IM2 ON IM2.item_no = IM.item_no
WHERE loc = @loc AND IM.std_cost != IM2.std_cost

SELECT IM.item_no, IM.std_cost, IM2.item_no, IM2.std_cost FROM IMINVLOC_SQL AS IM JOIN (SELECT item_no, std_cost FROM iminvloc_sql WHERE loc = 'WS') AS IM2 ON IM2.item_no = IM.item_no
WHERE loc = @loc AND IM.std_cost != IM2.std_cost

SELECT IM.item_no, IM.std_cost, IM2.item_no, IM2.std_cost FROM IMINVLOC_SQL AS IM JOIN (SELECT item_no, std_cost FROM iminvloc_sql WHERE loc = 'PS') AS IM2 ON IM2.item_no = IM.item_no
WHERE loc = @loc AND IM.std_cost != IM2.std_cost

SELECT IM.item_no, IM.std_cost, IM2.item_no, IM2.std_cost FROM IMINVLOC_SQL AS IM JOIN (SELECT item_no, std_cost FROM iminvloc_sql WHERE loc = 'NE') AS IM2 ON IM2.item_no = IM.item_no
WHERE loc = @loc AND IM.std_cost != IM2.std_cost

SELECT IM.item_no, IM.std_cost, IM2.item_no, IM2.std_cost FROM IMINVLOC_SQL AS IM JOIN (SELECT item_no, std_cost FROM iminvloc_sql WHERE loc = 'IT') AS IM2 ON IM2.item_no = IM.item_no
WHERE loc = @loc AND IM.std_cost != IM2.std_cost