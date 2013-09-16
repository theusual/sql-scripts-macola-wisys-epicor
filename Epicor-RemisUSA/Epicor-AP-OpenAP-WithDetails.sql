--Open AP With Details
SELECT DISTINCT APInvHed.InvoiceDate, APInvHed.InvoiceNum, APInvHed.Description AS [AP Header Description], APInvHed.InvoiceAmt, APInvHed.EntryPerson, APInvHed.VendorNum, VEND.Name, APInvDtl.PONum, APInvDtl.POLine, APInvDtl.PartNum, APInvDtl.Description AS [PartDescr], APInvDtl.VendorQty, APInvDtl.UnitCost, APInvHed.ApplyDate, APInvHed.InvoiceBal, APInvHed.PayAmounts, APInvHed.Posted
FROM APInvHed JOIN dbo.APInvDtl ON APInvDtl.InvoiceNum = APInvHed.InvoiceNum 
			  --LEFT OUTER JOIN APtran ON APInvHed.InvoiceNum = APtran.InvoiceNum
			  LEFT OUTER JOIN dbo.Vendor VEND ON VEND.VendorNum = APInvDtl.VendorNum 
			  --LEFT OUTER JOIN dbo.CheckHed CHK ON CHK.HeadNum = APtran.HeadNum
			  LEFT OUTER JOIN POHeader PH ON PH.OrderNum = APInvDtl.PONum
			  LEFT OUTER JOIN dbo.PODetail PL ON PL.ordernum = PH.OrderNum AND PL.poline = APInvDtl.InvoiceLine
WHERE  APInvHed.OpenPayable = 1