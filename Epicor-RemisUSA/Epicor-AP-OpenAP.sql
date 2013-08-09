--Open AP Header Only
SELECT DISTINCT APInvHed.InvoiceDate, APInvHed.InvoiceNum, APInvHed.Description AS [AP Header Description], APInvHed.InvoiceAmt, APInvHed.EntryPerson, APInvHed.VendorNum, VEND.Name
FROM APInvHed --JOIN dbo.APInvDtl ON APInvDtl.InvoiceNum = APInvHed.InvoiceNum 
			  --LEFT OUTER JOIN APtran ON APInvHed.InvoiceNum = APtran.InvoiceNum
			  LEFT OUTER JOIN dbo.Vendor VEND ON VEND.VendorNum = APInvHed.VendorNum 
			  --LEFT OUTER JOIN dbo.CheckHed CHK ON CHK.HeadNum = APtran.HeadNum
			  --LEFT OUTER JOIN POHeader PH ON PH.OrderNum = APInvHed.InvoiceRef
			  --LEFT OUTER JOIN dbo.PODetail PL ON PL.ordernum = PH.OrderNum AND PL.poline = APInvDtl.InvoiceLine
WHERE  APInvHed.OpenPayable = 1