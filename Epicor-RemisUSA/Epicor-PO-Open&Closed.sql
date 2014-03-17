 USE [epicor905]
 SELECT  PH.OrderDate, PH.PONum, PL.vendornum, Vendor.Name, PL.poline,  PL.partnum, PL.linedesc,    PL.orderqty, PORel.ReceivedQty, PL.unitcost, PH.CommentText, PH.EntryPerson, PL.baseuom, PL.pum
 FROM   POHeader PH INNER JOIN PODetail PL ON PH.Company =PL.company AND PH.PONum = PL.ponum 
	INNER JOIN PORel PORel ON PH.Company=PORel.Company AND PH.PONum=PORel.PONum AND PL.poline = PORel.POLine
	INNER JOIN Vendor Vendor ON PH.Company=Vendor.Company AND PH.VendorNum=Vendor.VendorNum
 WHERE  PH.VoidOrder=0 AND PH.OrderDate >= '01/01/2013' AND PH.OrderDate <= '12/31/2013'
 ORDER BY PH.OrderDate DESC
