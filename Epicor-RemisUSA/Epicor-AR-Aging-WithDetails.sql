--With Details
SELECT DISTINCT DATEDIFF(day,InvH.ShipDate,GETDATE()) AS Age, InvoiceSuffix AS InvoiceType, InvoiceDate, InvD.ShipDate, InvH.InvoiceNum, InvH.OrderNum, InvH.CustNum, CUS.Name, PoNum, InvoiceAmt, InvoiceBal, InvH.InvoiceComment [InvcHeaderCmt], PartNum, LineDesc, UnitPrice, OurOrderQty, ProdCode, InvD.InvoiceComment [InvcLineCmt]
FROM dbo.InvcHead InvH JOIN InvcDtl InvD ON InvD.InvoiceNum = InvH.InvoiceNum
					   JOIN dbo.Customer CUS ON CUS.CustNum = InvH.CustNum
WHERE OpenInvoice = 1 AND Posted = 1 AND InvoiceDate > '1/1/2012'