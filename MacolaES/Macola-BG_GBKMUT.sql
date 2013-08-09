SELECT TOP (100) PERCENT ID, bkjrcode AS [Financial year], reknr AS [General ledger account], datum AS Date, periode AS Period, bkstnr AS [Entry number], 
       dagbknr AS [Journal(Offset Ledger Acct)], oms25 AS Description, bdr_hfl AS [Amount in default currency], AmountCentral, tegreknr AS [Offset account], 
       debnr AS [Debtor number (Cus #)], crdnr AS [Creditor number], kstdrcode AS [Cost unit], aantal AS Quantity, bdr_val AS [FC amount], 
       dbk_verwnr AS [Unique posting number journal], verwerknrl AS [Unique posting number], volgnr5 AS [Sequence number], regel AS [Line number], 
       regelcode AS [Code generated lines], bkstnr_sub AS [PO/Sales Order #], betcond AS [Payment condition], 
       CASE oorsprong WHEN 'F' THEN 'PO Invoice (AP)' WHEN 'R' THEN 'Purchases (PO)' WHEN 'B' THEN 'Payments' WHEN 'D' THEN 'Matching' WHEN 'A' THEN 'Accounting'
        ELSE oorsprong END AS [Package of origin of transaction], docnumber AS [Your Ref (PO = Inv #, OE = PO #)], docdate AS [Doc. date], 
       exvalbdr AS [Extra currency amount], CASE entryorigin WHEN 'N' THEN 'NONE' WHEN 'I' THEN 'Payment' ELSE entryorigin END AS [Transaction origin], 
       vervdatkrd AS [CS/SD due date], vervdatfak AS [Invoice due date], kredbep AS [CS/SD amount], betaalref AS [Payment reference], artcode AS [Item code], 
       faktuurnr AS [Our Ref. (PO = Vchr #, OE = Inv #)], PaymentMethod AS [Payment method], res_id AS Resource, DocumentID AS [Document], transtype, 
       CASE transsubtype WHEN 'N' THEN 'Other' WHEN 'K' THEN 'Sales Invoice' WHEN 'T' THEN 'Purchase Invoice' ELSE transsubtype END AS [Transaction subtype], 
       freefield1 AS [General ledger transactions: free field 1], freefield2 AS [General ledger transactions: free field 2], 
       freefield3 AS [General ledger transactions: free field 3], freefield4 AS [General ledger transactions: free field 4], 
       freefield5 AS [General ledger transactions: free field 5], warehouse AS [Warehouse code], BankTransactionGUID, Discount AS [Discount percentage], 
       ReconcileNumber AS [Match ID], DocAttachmentID AS Attachments, EntryGuid AS [entry guid], TransactionGuid AS [Transaction guid], syscreated, syscreator, 
       sysmodified, sysmodifier, sysguid, 'BEGIN UNUSED FIELDS' AS [Unused Fields], btw_code AS [VAT code], btw_bdr_3 AS [VAT amount], 
       btw_grond AS [VAT basis amount], kstplcode AS [Cost center], valcode AS [Currency code], exvalcode AS [Extra currency code], koers AS XRate, 
       wisselkrs AS [Cross-currency exchange rate], koers3 AS [Exchange rate outstanding items], CurrencyCode AS [Default currency], Rate AS [Default currency rate], 
       VatBaseAmountCentral AS [VAT basis amount in default currency], VatAmountCentral AS [VAT amount in default currency], CurrencyAliasAc AS [Local currency], 
       btwper AS [VAT percentage], btw_grval AS [VAT basis amount in foreign currency], afldat AS [Delivery date], vervdtkrd2 AS [CS/SD due date 2], 
       bud_vers AS [Budget version], ReminderCount AS [Number of reminders], ReminderLayout AS [Reminder layout], LastReminderDate AS [Last reminder date], 
       BlockItem AS Block, bankacc AS [Bank account], CompanyCode AS [Company code], TransactionType AS [Transaction type], 
       vlgn_gbk2 AS [Second GBKMUT sequence number], storno AS [Reversal entry], bdrkredbep AS [CS/SD amount 1], bdrkredbp2 AS [CS/SD amount 2], 
       stat_nr AS [Statement number], btw_nummer AS [VAT number], rapnr AS [Reporting number], raplist AS [Report number listing], facode AS [Serial number], 
       project AS [Project code], cmp_wwn AS Account, orderdebtor AS [Sales order debtor], PayrollSubtype AS [Sub type], 
       warehouse_location AS [Warehouse location], TransactionGuid2 AS [Second GBKMUT transaction guid], StockTrackingNumber AS [Tracking number], 
       StartTime AS [Start time], EndTime AS [End time], ReportingDate AS [Not used], CashRegisterAccount AS [Cash register], Original_Quantity AS [Original quantity], 
       comp_code AS Component, Selcode AS [Selection code], Unitcode AS Unit, Pricelist AS [Price list], IntTransportMethod AS [Transport method search code], 
       IntPort AS [Search code city of loading/unloading], IntSystem AS [Search code statistical system], IntTransA AS [Search code transaction A], 
       IntStatNr AS [Statistical number], IntStandardCode AS [Intrastat Standard Code], IntTransShipment AS [Transshipment search code], 
       IntTransB AS [Search code transaction B], IntArea AS [Search code area], IntLandISO AS [ISO country], IntLandDestOrig AS [Country code of destination / origin], 
       IntDeliveryMethod AS [Search code delivery method], IntStatUnit AS [Statistical units], IntWeight AS Weight, IntComplete AS Complete, 
       LinkedLine AS [Line number link], PayrollCosts AS Costs, TaxCode2 AS [Tax code 2], TaxCode3 AS [Tax code 3], TaxCode4 AS [Tax code 4], 
       TaxCode5 AS [Tax code 5], TaxBasis2 AS [Tax basis 2], TaxBasis3 AS [Tax basis 3], TaxBasis4 AS [Tax basis 4], TaxBasis5 AS [Tax basis 5], 
       TaxAmount2 AS [Tax amount 2], TaxAmount3 AS [Tax amount 3], TaxAmount4 AS [Tax amount 4], TaxAmount5 AS [Tax amount 5], 
       StatisticalFactor AS [Statistical factor], IntLandAssembly AS [Country of assembly], backflush, LastReminderLayout AS [Layout reminder layout], Correction, 
       IBTDeliveryNr AS [IBT delivery number], Routing, Step, Reasoncode AS [Reason code], Checked, Reviewed, Shipment, 
       TransactionNumber AS [Transaction number], Type, Status, UniqueSeqNo, RevaluationCurrency, LineType AS [Line type]
FROM  dbo.gbkmut
WHERE bkstnr LIKE '13902727%'
ORDER BY syscreated

--SELECT * FROM
--DELETE FROM 
--dbo.gbkmut
--WHERE ID IN ('2925795','2925796')