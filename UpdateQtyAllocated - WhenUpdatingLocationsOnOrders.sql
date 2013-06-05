DECLARE @item AS varchar(15)
DECLARE @newloc AS varchar(3)
DECLARE @oldloc AS varchar(3)
DECLARE @totordqtychg AS int
DECLARE @currentqalloldloc AS int
DECLARE @currentqallnewloc AS int

--Oldloc = Old location of orders changed from, NewLoc = New location of orders changed to, @item = Item changed on orders, 
--@totordqtychg = Total quantity changed on the orders (ex. - if 10 orders of 2 each were changed, then set to 20)
SET @oldloc = 'NE'
SET @newloc = 'MDC'
SET @item = 'WM-MOVIEDUMPBIN'
SET @totordqtychg = '0'

SET @currentqallnewloc = (SELECT qty_allocated FROM iminvloc_sql WHERE loc = @newloc AND item_no  = @item)
SET @currentqalloldloc = (SELECT qty_allocated FROM iminvloc_sql WHERE loc = @oldloc AND item_no  = @item)

--Increase the new location's allocations by total qty changed
UPDATE IMINVLOC_SQL
SET qty_allocated = (@currentqallnewloc + @totordqtychg)
WHERE loc = @newloc and item_no = @item

--Reduce the old location's allocations by total qty changed
UPDATE IMINVLOC_SQL
SET qty_allocated = (@currentqalloldloc - @totordqtychg)
WHERE loc = @oldloc and item_no = @item

--Check changes occurred correctly

DECLARE @item AS varchar(15)

SET @item = 'WM-MOVIEDUMPBIN'

SELECT  *
FROM    iminvloc_sql
where item_no = @item