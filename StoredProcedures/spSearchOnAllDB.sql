ALTER PROC bgSearchTablesForColumn
(
	@ColumnName nvarchar(100)
)
AS
BEGIN
	-- UPDATED:  7/26/11      BY: BG
	-- Purpose: To display all tables where a column is used, requires exact column name to be given.  Use SearchAllTables if searching for part of column name
		SET @columnName = '%' + @columnName + '%'
		
		SELECT SO.NAME, SC.NAME
		FROM SYS.OBJECTS SO INNER JOIN SYS.COLUMNS SC
		ON SO.OBJECT_ID = SC.OBJECT_ID
		WHERE SO.TYPE = 'U' and SC.name like @ColumnName
		ORDER BY SO.NAME, SC.NAME
END