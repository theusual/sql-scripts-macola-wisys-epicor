SELECT TOP (100) PERCENT bkjrcode AS [Financial Year], periode AS Period, dagbknr AS [Journal(Offset Ledger Acct)], volgnr5 AS [Sequ Number], 
   beginsaldo AS [Opening Balance], eindsaldo AS [Closing Balance], bkstnr AS [Entry Number], oms25 AS Description, datum AS Date, 
   betwijze AS [Payment Method], kredbep AS [CS/SD amount], reknr AS [GL Account], oorsprong AS [Package of origin transaction], 
   CASE entryorigin WHEN 'N' THEN 'NONE' WHEN 'I' THEN 'Invoice' WHEN 'P' THEN 'Payment' ELSE entryorigin END AS [Transaction origin], 
   faktuurnr AS [Our Ref. (PO = Vchr #, OE = Inv #)], bankacc AS [Bank Account], entrytype AS Type, freefield1, freefield2, freefield3, freefield4, freefield5, syscreated, 
   syscreator, sysmodified, sysmodifier, sysguid, ID, 'BEGIN UNUSED FIELDS' AS [UNUSED FIELDS], debnr AS [Debtor Number], crdnr AS [Creditor Number], 
   bedrag AS Amount, valcode AS [Currency Code], koers AS [Exchange Rate], val_bdr AS [Currency Amount], weeknummer AS [Week Number], 
   transreknr AS [Transit Account], transper AS [Transit Period], betaalref AS [Payment Reference], betcond AS [Payment Condition], 
   bdrkredbep AS [CS/SD amount 1], bdrkredbp2 AS [CS/SD amount 2], vervdatfak AS [Invoice Due Date], vervdatkrd AS [CS/SD Due Date], 
   vervdtkrd2 AS [CS/SD due date 2], percentag AS Percentage, percentag2 AS [Percentage 2], grek_bdr AS [Blocked Account], storno AS [Reversal Entry], 
   match_fakt AS [Invoice Number], banksubtyp AS [Bank Entry sub-type], struct_m AS [Structured Announcement], btw_nummer AS [VAT Number], 
   adres_cd AS [Address Code], adres_nr AS [Address Number], afldat AS [Delivery Date], guids AS GUID, status, docnumber AS [Your Ref (PO = Inv #, OE = PO #)], 
   docdate AS [Doc Date], DEL_res_identry AS Resource, crdnote AS [Credit Note], match_nr AS [Match Number], amktext AS Notes, 
   bedr_vvaf1 AS [Foreign Current Amt Write-Off code 1], bedr_vvaf2 AS [Foreign Current Amt Write-Off code 2], 
   bedr_vvaf3 AS [Foreign Current Amt Write-Off code 3], bedr_vvaf4 AS [Foreign Current Amt Write-Off code 4], 
   bedr_vvaf5 AS [Foreign Current Amt Write-Off code 5], wisselkrs AS [Cross-currency exchange rate], kstplcode AS [Cost Center], kstdrcode AS [Cost Unit], 
   DocumentID AS [Document], cmp_wwn AS Account, project AS [Project code], BlockOutstandingItem AS Block, orderdebtor AS [Sales Order Debtor], 
   CashRegisterAccount AS [Cash Register], Selcode AS [Selection Code], DocAttachmentID AS Attachments, Division
FROM  dbo.amutak
WHERE bkstnr LIKE '13902727%'
ORDER BY syscreated