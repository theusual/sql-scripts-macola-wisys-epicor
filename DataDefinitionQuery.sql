--Stored Procedure to pull all references to data definition tables (DD* tables)
exec efwGetDDInfo 'gbkmut'

--Specific column DD table
SELECT  *
FROM    DDColumns
