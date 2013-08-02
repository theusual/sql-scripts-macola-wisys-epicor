 SELECT InvTrx.TranNum, InvTrx.PartNum, InvTrx.TranClass, InvTrx.TranType, InvTrx.InventoryTrans, InvTrx.TranDate, InvTrx.TranQty, InvTrx.UM, InvTrx.ExtCost, InvTrx.PONum, InvTrx.POLine, InvTrx.OrderNum, InvTrx.OrderLine, InvTrx.EntryPerson, InvTrx.PartDescription, InvTrx.VendorNum, InvTrx.POReceiptQty, InvTrx.POUnitCost, InvTrx.PackSlip, InvTrx.InvoiceNum
 FROM   PartTran AS InvTrx
 WHERE  (InvTrx.TranDate>={ts '2013-01-01 00:00:00'} AND InvTrx.TranDate<{ts '2014-01-01 00:00:01'})
 ORDER BY TranDate DESC


