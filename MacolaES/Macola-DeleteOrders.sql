DECLARE @beginOrd AS VARCHAR(8)
DECLARE @endOrd AS VARCHAR(8)

--Enter order range to delete
SET @beginOrd = ' 7702202'
SET @endOrd = ' 7702298'

--Find orders to delete
SELECT * FROM oeordhdr_Sql WHERE ord_no >= @beginOrd AND ord_no <= @endOrd
SELECT * FROM oeordlin_Sql WHERE ord_no >= @beginOrd AND ord_no <= @endOrd
SELECT * FROM iminvtrx_Sql WHERE ord_no >= @beginOrd AND ord_no <= @endOrd
SELECT * FROM dbo.oepdshdr_sql WHERE ord_no >= @beginOrd AND ord_no <= @endOrd


--Calc allocations being cleared and update iminvloc to remove them
SELECT SUM(qty_to_ship) FROM dbo.oeordlin_sql WHERE ord_no >= @beginOrd AND ord_no <= @endOrd

UPDATE dbo.iminvloc_sql 
SET qty_allocated = 0
WHERE item_no = 'EZSM-15X23X3 BK' AND loc = 'PS'

--Delete the orders
BEGIN TRANSACTION

DELETE FROM oeordhdr_Sql WHERE ord_no >= @beginOrd AND ord_no <= @endOrd

DELETE FROM oeordlin_Sql WHERE ord_no >= @beginOrd AND ord_no <= @endOrd

DELETE FROM iminvtrx_Sql WHERE ord_no >= @beginOrd AND ord_no <= @endOrd

DELETE FROM dbo.oepdshdr_sql WHERE ord_no >= @beginOrd AND ord_no <= @endOrd

--If okay...
COMMIT TRANSACTION
--If bad....
ROLLBACK TRANSACTION
