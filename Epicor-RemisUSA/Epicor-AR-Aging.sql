--Just header
SELECT DATEDIFF(day,InvH.ShipDate,GETDATE()) AS Age, InvoiceSuffix AS InvoiceType, InvoiceDate, InvH.ShipDate, InvH.InvoiceNum, InvH.OrderNum, InvH.CustNum, CUS.Name, PoNum, InvoiceAmt, InvoiceBal, InvH.InvoiceComment
FROM dbo.InvcHead InvH JOIN dbo.Customer CUS ON CUS.CustNum = InvH.CustNum--JOIN InvcDtl InvD ON InvD.InvoiceNum = InvH.InvoiceNum AND InvD.Company = InvH.Company
WHERE OpenInvoice = 1 AND Posted = 1 AND InvoiceDate > '01/01/2012'

