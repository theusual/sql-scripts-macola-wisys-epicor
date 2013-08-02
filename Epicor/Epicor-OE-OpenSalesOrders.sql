USE [epicor905]
SELECT OH.RequestDate, OH.OrderNum, OH.PONum, OH.InvoiceNum, CUS.Name, OH.InvoiceAmt, OH.PayAmounts, OH.CreditMemo, OL.InvoiceLine, OL.PartNum, OL.LineDesc, OL.OurShipQty, OL.UnitPrice, OL.ExtPrice, OL.ProdCode, OL.SubUnitCost, OL.BurUnitCost, OL.LbrUnitCost, OL.MtlUnitCost, OH.InvoiceComment 
FROM OrderHed OH JOIN OrderDtl OL ON OL.OrderNum = OH.OrderNum 
WHERE OpenOrder = 1


