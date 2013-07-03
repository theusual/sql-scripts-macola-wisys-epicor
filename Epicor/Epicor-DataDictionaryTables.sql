DECLARE @tableID AS VARCHAR(MAX)
SET @tableID = 'APInvHed'

SELECT * FROM zKey WHERE datatableID = @tableID --Key list for all tables
SELECT * FROM zKeyField  WHERE datatableID = @tableID --List of all fields that make up a key for various relations with other tables
SELECT * FROM zDataField WHERE datatableID = @tableID--Complete list of every field in every table with descriptions
SELECT * FROM zDataTable WHERE datatableID = @tableID --Complete list of every table with descriptions
SELECT * FROM zDataSet --data set definitions
SELECT * FROM zRelation WHERE datatableID = 'APInvHed'
SELECT * FROM zlinkcolumn WHERE datatableID = 'APInvHed'


SELECT * FROM zDataField WHERE FieldName = 'InvoiceNum'
SELECT * FROM APInvExp