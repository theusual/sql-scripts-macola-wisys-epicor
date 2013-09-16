USE [epicor905]
SELECT OH.CustNum, CUS.Name, OH.RequestDate, OH.OrderNum, OH.PONum, OL.PartNum, OL.LineDesc, OL.OrderQty, OL.UnitPrice,OL.ProdCode, OH.InvoiceComment 
FROM OrderHed OH JOIN OrderDtl OL ON OL.OrderNum = OH.OrderNum JOIN dbo.Customer CUS ON CUS.CustNum = OH.CustNum
WHERE OpenOrder = 1


