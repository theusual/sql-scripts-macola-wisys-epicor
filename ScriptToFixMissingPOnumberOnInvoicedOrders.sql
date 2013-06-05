--Find the correct invoice # to update, if needed
SELECT inv_no FROM dbo.oehdrhst_sql AS OS WHERE ord_no = '  687968'

--Update the order header history with the correct PO, using the invoice #
UPDATE dbo.oehdrhst_sql 
SET oe_po_no = '31131547'
WHERE inv_no = '  475975'

--Find the correct docnumber to update
SELECT docnumber, * FROM amutas WHERE faktuurnr = '  475975'
SELECT docnumber, * FROM amutas WHERE faktuurnr = '  475324' --a "good" invoice

--Update the amutas table with the correct PO, using the docnumber
UPDATE dbo.amutas
SET  docnumber = '31131547'
WHERE faktuurnr = '  475975' AND betwijze = 'C'

    
EXEC dbo.efwGetDDInfo @tablename = 'amutas' -- char(30)

