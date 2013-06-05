DECLARE @ord AS INT
SET @ord = '  371887'

UPDATE oeordlin_Sql 
SET shipped_dt = '2012-07-03 00:00:00.000'
WHERE ord_no = @ord

UPDATE oeordhdr_Sql 
SET ord_dt_shipped = '2012-07-03 00:00:00.000', status = 7, selection_cd = 'S'
WHERE ord_no = @ord

