--Closed AP
SELECT DISTINCT TranDate AS [Paid Date], APTranNo, APtran.CheckNum, APtran.InvoiceNum, APtran.Posted, APtran.Description AS [AP Trx Description], TranAmt, APtran.EntryPerson, APtran.VendorNum, VEND.Name, CHK.Address1, CHK.Address2, CHK.Address3, CHK.City + ', ' + CHK.[State] + ' ' + CHK.Zip AS [City/ST/Zip], APInvDtl.PONum, APInvDtl.POLine, APInvDtl.PartNum, APInvDtl.Description AS [PartDescr.], APInvDtl.VendorQty, APInvDtl.UnitCost
FROM APInvHed JOIN dbo.APInvDtl ON APInvDtl.InvoiceNum = APInvHed.InvoiceNum 
			  LEFT OUTER JOIN APtran ON APInvHed.InvoiceNum = APtran.InvoiceNum
			  LEFT OUTER JOIN dbo.Vendor VEND ON VEND.VendorNum = APtran.VendorNum 
			  LEFT OUTER JOIN dbo.CheckHed CHK ON CHK.HeadNum = APtran.HeadNum
			  LEFT OUTER JOIN POHeader PH ON PH.OrderNum = APInvDtl.PONum
			  LEFT OUTER JOIN dbo.PODetail PL ON PL.ordernum = PH.OrderNum AND PL.poline = APInvDtl.InvoiceLine
WHERE TranAmt > .02 --AND APInvDtl.ponum = 853 AND APtran.Voided = 0