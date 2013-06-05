--Find the correct invoice # to update, if needed
SELECT inv_no FROM dbo.oehdrhst_sql AS OS WHERE ord_no = '  687968'

--Update the order header history with the correct PO, using the invoice #
UPDATE dbo.oehdrhst_sql SET oe_po_no = '12736 IN3' WHERE inv_no = '  474802'
UPDATE dbo.oehdrhst_sql SET oe_po_no = '12736 642' WHERE inv_no = '  479090'
UPDATE dbo.oehdrhst_sql SET oe_po_no = '12736 783' WHERE inv_no = '  479582'
UPDATE dbo.oehdrhst_sql SET oe_po_no = '12736 KS' WHERE inv_no = '  479583'
UPDATE dbo.oehdrhst_sql SET oe_po_no = '12736 OH522' WHERE inv_no = '  480024'
UPDATE dbo.oehdrhst_sql SET oe_po_no = '12736 OH569' WHERE inv_no = '  480025'
UPDATE dbo.oehdrhst_sql SET oe_po_no = '12736 OH820' WHERE inv_no = '  480027'
UPDATE dbo.oehdrhst_sql SET oe_po_no = '12736 OH623' WHERE inv_no = '  480026'

--Find the correct docnumber to update
SELECT docnumber, betwijze, * FROM amutas WHERE faktuurnr = '  474802'
SELECT docnumber, * FROM amutas WHERE faktuurnr = '  475324' --a "good" invoice

--Update the amutas table with the correct PO, using the docnumber
UPDATE dbo.amutas SET docnumber = '12736 IN3' WHERE faktuurnr = '  474802' AND betwijze = 'C'
UPDATE dbo.amutas SET docnumber = '12736 642' WHERE faktuurnr = '  479090' AND betwijze = 'C'
UPDATE dbo.amutas SET docnumber = '12736 783' WHERE faktuurnr = '  479582' AND betwijze = 'C'
UPDATE dbo.amutas SET docnumber = '12736 KS' WHERE faktuurnr = '  479583' AND betwijze = 'C'
UPDATE dbo.amutas SET docnumber = '12736 OH522' WHERE faktuurnr = '  480024' AND betwijze = 'C'
UPDATE dbo.amutas SET docnumber = '12736 OH569' WHERE faktuurnr = '  480025' AND betwijze = 'C'
UPDATE dbo.amutas SET docnumber = '12736 OH820' WHERE faktuurnr = '  480027' AND betwijze = 'C'
UPDATE dbo.amutas SET docnumber = '12736 OH623' WHERE faktuurnr = '  480026' AND betwijze = 'C'    
    
--Update BankTransactions table with the correct PO, using InvoiceNumber
UPDATE BankTransactions SET SupplierInvoiceNumber = '12736 IN3' WHERE InvoiceNumber = '  474802'
UPDATE BankTransactions SET SupplierInvoiceNumber = '12736 642' WHERE InvoiceNumber = '  479090'
UPDATE BankTransactions SET SupplierInvoiceNumber = '12736 783' WHERE InvoiceNumber = '  479582'
UPDATE BankTransactions SET SupplierInvoiceNumber = '12736 KS' WHERE InvoiceNumber = '  479583'
UPDATE BankTransactions SET SupplierInvoiceNumber = '12736 OH522' WHERE InvoiceNumber = '  480024'
UPDATE BankTransactions SET SupplierInvoiceNumber = '12736 OH569' WHERE InvoiceNumber = '  480025'
UPDATE BankTransactions SET SupplierInvoiceNumber = '12736 OH623' WHERE InvoiceNumber = '  480026'
UPDATE BankTransactions SET SupplierInvoiceNumber = '12736 OH820' WHERE InvoiceNumber = '  480027'

--Update GBKMUT table with the correct PO, PO number (faktuurnr)
UPDATE dbo.gbkmut SET docnumber = '12736 IN3' WHERE faktuurnr = '  474802' AND PaymentMethod = 'C'
UPDATE dbo.gbkmut SET docnumber = '12736 642' WHERE faktuurnr = '  479090' AND PaymentMethod = 'C'
UPDATE dbo.gbkmut SET docnumber = '12736 783' WHERE faktuurnr = '  479582' AND PaymentMethod = 'C'
UPDATE dbo.gbkmut SET docnumber = '12736 KS' WHERE faktuurnr = '  479583' AND PaymentMethod = 'C'
UPDATE dbo.gbkmut SET docnumber = '12736 OH522' WHERE faktuurnr = '  480024' AND PaymentMethod = 'C'
UPDATE dbo.gbkmut SET docnumber = '12736 OH569' WHERE faktuurnr = '  480025' AND PaymentMethod = 'C'
UPDATE dbo.gbkmut SET docnumber = '12736 OH820' WHERE faktuurnr = '  480027'AND PaymentMethod = 'C'
UPDATE dbo.gbkmut SET docnumber = '12736 OH623' WHERE faktuurnr = '  480026' AND PaymentMethod = 'C'