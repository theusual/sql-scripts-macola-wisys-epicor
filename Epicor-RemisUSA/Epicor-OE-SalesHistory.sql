USE [epicor905]
GO
CREATE VIEW BG_SalesHistory AS
SELECT  OH.InvoiceDate, OH.OrderNum, OH.PONum, OH.InvoiceNum, CUS.Name, OH.InvoiceAmt, OH.PayAmounts, OH.CreditMemo, OL.InvoiceLine, OL.PartNum, OL.LineDesc, OL.OurShipQty, OL.UnitPrice, OL.ExtPrice, OL.ProdCode, OL.SubUnitCost, OL.BurUnitCost, OL.LbrUnitCost, OL.MtlUnitCost, OH.InvoiceComment
FROM  InvcHead OH INNER JOIN InvcDtl OL ON (OH.Company=OL.Company) AND (OH.InvoiceNum=OL.InvoiceNum) 
				  INNER JOIN Customer CUS ON OH.CustNum=CUS.CustNum


