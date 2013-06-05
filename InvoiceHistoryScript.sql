SELECT InvoiceDate AS Date, MatchID AS MatchID, InvoiceNumber AS InvoiceNumber, SupplierInvoiceNumber AS SupplierInvoiceNumber, banktransactions.Description AS Description, DueDate AS DueDate, (InvoiceAmount ) AS InvoiceAmount, ( (CASE WHEN (ISNULL(InvoiceAmount,0) = 0 AND ISNULL(Other,0) = 0) 
       THEN ReceiptPaid  
       ELSE CASE WHEN InvoiceAmount > 0                 THEN Case WHEN(Round(ISNULL(ReceiptPaid, 0), 2) > (Round(ISNULL(InVoiceAmount, 0) + ISNULL(Other, 0), 2)) And 
                                Round(ReceiptPaid, 2) <> 0) 
                           THEN (ISNULL(InvoiceAmount,0) + ISNULL(Other,0)) 
                           ELSE Receiptpaid END 
                 ELSE Case WHEN(Round(ISNULL(ABS(ReceiptPaid), 0), 2) > (Round(ISNULL(ABS(InVoiceAmount), 0) + ISNULL(Other, 0), 2)) And 
                                Round(ABS(ReceiptPaid), 2) <> 0) 
                           THEN (ISNULL(ABS(InvoiceAmount),0) + ISNULL(Other,0)) 
                           ELSE Receiptpaid END 
                 END 
       END) ) AS ReceiptPaid, (Other ) AS Other, (((CASE WHEN (ROUND(ISNULL(OtherInvoice,0),2) = 0.0) 
        THEN ReceiptPaid * -1 
        ELSE CASE WHEN InvoiceAmount > 0 
                  THEN (ISNULL(OtherInvoice,0)) - (CASE WHEN ( ROUND(ISNULL((ReceiptPaid),0),2) > (ROUND(ISNULL(OtherInvoice,0),2)) AND 
                                                               ROUND(ReceiptPaid,2) <> 0.00) 
                                                        THEN (ISNULL(OtherInvoice,0)) 
                                                        ELSE ISNULL((Receiptpaid),0) 
                                                        END) 
                  ELSE (ISNULL(OtherInvoice,0)) - (CASE WHEN ( ROUND(ISNULL(ABS(ReceiptPaid),0),2) > (ROUND(ISNULL(ABS(OtherInvoice),0),2)) AND 
                                                               ROUND(ABS(ReceiptPaid),2) <> 0.00) 
                                                        THEN (ISNULL(OtherInvoice,0)) 
                                                        ELSE ISNULL((Receiptpaid),0) 
                                                        END) 
                  END 
    END))) AS Saldo, (CASE PaymentType 
 WHEN 'B' THEN 'On credit'
 WHEN 'C' THEN 'Check'
 WHEN 'E' THEN 'EFT'
 WHEN 'F' THEN 'Factoring'
 WHEN 'H' THEN 'Chipknip'
 WHEN 'I' THEN 'Collection'
 WHEN 'K' THEN 'Cash'
 WHEN 'O' THEN 'Debt collection'
 WHEN 'P' THEN 'Payment on delivery'
 WHEN 'R' THEN 'Credit card'
 WHEN 'S' THEN 'Settle'
 WHEN 'V' THEN 'ESR payments'
 WHEN 'W' THEN 'Letter of credit'
 WHEN 'X' THEN 'Payments in CHF and FC'
 WHEN 'Y' THEN 'ES payments'
 END ) AS PaymentType, (CASE WHEN (CASE WHEN (ROUND(ISNULL(OtherInvoice,0),2) = 0.0)  THEN ReceiptPaid * -1 ELSE (ISNULL(OtherInvoice,0)) -  (CASE WHEN ( ROUND(ISNULL(ABS(ReceiptPaid),0),2) > (ROUND(ISNULL(OtherInvoice,0),2))  AND ROUND(ReceiptPaid,2) <> 0.00) THEN (ISNULL(OtherInvoice,0))  ELSE ISNULL(ABS(Receiptpaid),0) END) END) = 0 THEN  datediff(dd, InvoiceDate, ISNULL(ActiveDate,MAXInvoiceDate)) ELSE datediff(dd, InvoiceDate, ActiveDate) END) AS ActiveDays, 
 (CASE WHEN ISNULL(ReceiptPaid,0) <> 0 AND  
	(CASE WHEN (ROUND(ISNULL(OtherInvoice,0),2) = 0.0)  
		  THEN ReceiptPaid * -1 
		  ELSE (ISNULL(OtherInvoice,0)) -  
			(CASE WHEN ( ROUND(ISNULL(ABS(ReceiptPaid),0),2) > (ROUND(ISNULL(OtherInvoice,0),2)) AND  ROUND(ReceiptPaid,2) <> 0.00) 
				THEN (ISNULL(OtherInvoice,0)) 
				ELSE ISNULL(ABS(Receiptpaid),0) 
			 END) 
	 END) = 0  
		THEN 1 
	    ELSE 0 
 END) AS Paid, ActiveDate, (CASE TransactionType WHEN 'A' THEN 'Receipt' WHEN 'B' THEN 'Fulfillment' WHEN 'C' THEN 'Sales credit note' WHEN 'D' THEN 'Debit memo' WHEN 'E' THEN 'Revaluation' WHEN 'F' THEN 'Discount/Surcharge' WHEN 'G' THEN 'Counts' WHEN 'H' THEN 'Return fulfillment' WHEN 'I' THEN 'Disposal' WHEN 'J' THEN 'Return receipt' WHEN 'K' THEN 'Sales invoice' WHEN 'L' THEN 'Labor hours' WHEN 'M' THEN 'Machine hours' WHEN 'N' THEN 'Other' WHEN 'O' THEN 'POS sales invoice' WHEN 'P' THEN 'Interbank' WHEN 'Q' THEN 'Purchase credit note' WHEN 'R' THEN 'Refund' WHEN 'S' THEN 'Reversal credit note' WHEN 'T' THEN 'Purchase invoice' WHEN 'V' THEN 'Depreciation' WHEN 'W' THEN 'Payroll' WHEN 'X' THEN 'Settled' WHEN 'Y' THEN 'Payment' WHEN 'Z' THEN 'Cash receipt' ELSE '??' END) AS TransactionTypeDescription, OrderNumber, OffsetReference, EntryNumber, OffsetLedgerAccountNumber, banktransactions.ID AS ID FROM ((
 (
 SELECT MIN(InvoiceDate) AS InvoiceDate,
 MAX(ActiveDate) as ActiveDate,
 MAX(InvoiceDate) AS MaxInvoiceDate,
 MAX(MatchID) As MatchID,
 InvoiceNumber,
 MAX(OffsetLedgerAccountNumber) AS OffsetLedgerAccountNumber, MAX(EntryNumber) AS EntryNumber, MAX(OffsetReference) AS OffsetReference, MAX(ID) AS ID, MAX(OrderNumber) AS OrderNumber,
 MAX(SupplierInvoiceNumber) AS SupplierInvoiceNumber,
 MAX(a.Description) AS Description,
 MAX(DueDate) AS DueDate,
 SUM(InvoiceAmount) AS InvoiceAmount,
 SUM(ReceiptPaid) AS ReceiptPaid,
 SUM(Other) AS Other,
 SUM(ISNULL(InvoiceAmount,0) + ISNULL(Other,0)) AS OtherInvoice, MAX(Paymenttype) AS Paymenttype,
 MAX(TransactionType) As TransactionType,
 MIN(Blocked) As Blocked
 FROM
 (
 (
    (
     SELECT s.ValueDate AS InvoiceDate,
     Null as ActiveDate,
     S.ID AS MatchID,     ISNULL(S.InvoiceNumber,s.InvoiceNumber) AS InvoiceNumber,
     '' AS SupplierInvoiceNumber,
    (CONVERT(VARCHAR(40),S.Description)) AS Description,
     S.DueDate AS DueDate,
     Null AS InvoiceAmount,
     S.AmountDC   AS ReceiptPaid,
     Null AS Other,
     S.PaymentType AS PaymentType,
     S.transactiontype AS Transactiontype,
     S.OffsetLedgerAccountNumber,
     S.EntryNumber, S.OffsetReference, S.ID, S.Ordernumber, S.Blocked AS Blocked
     FROM BankTransactions S
    LEFT JOIN
            (
            SELECT btx.MatchID, ROUND(SUM(ROUND(btx.AmountDC,2)), 2) AS AmountDC
            FROM BankTransactions btx
            WHERE btx.Type = 'W' AND btx.Status <> 'V' AND btx.EntryNumber IS NOT NULL
            GROUP BY btx.MatchID
            HAVING btx.MatchID Is Not Null
            ) AS bts ON bts.MatchID = S.ID
    WHERE
           S.Type = 'S'
           AND S.Status <> 'V'
           AND S.DebtorNumber = '  1100'
           AND ABS(ROUND(ISNULL(S.AmountDC,0),2)) <> ABS(ROUND(ISNULL(bts.AmountDC,0),2))           AND S.offsetledgeraccountnumber IN (SELECT reknr FROM grtbk WHERE omzrek = 'D')   )
    Union All
    (
     SELECT
         InvoiceDate ,
         ISNULL((SELECT TOP 1 valuedate         FROM banktransactions c         WHERE c.id = W.MatchId  ORDER BY valuedate DESC),{d '2011-05-12'}) As ActiveDate,         W.MatchID AS MatchID,         InvoiceNumber AS InvoiceNumber,
        SupplierInvoiceNumber AS SupplierInvoiceNumber,
        (CONVERT(varchar(40),W.Description)) AS Description,
         W.DueDate AS DueDate,
         (CASE WHEN (W.Transactiontype IN ('K','T','Q','C','D','F', 'W') OR (W.Transactiontype = 'F' and StatementType is NULL)) THEN W.AmountDC ELSE Null END) AS InvoiceAmount,
         (CASE WHEN MATCHID IS NOT NULL then W.AMOUNTDC ELSE Null END) AS ReceiptPaid,
         (CASE WHEN (W.Transactiontype NOT IN ('K','T','Q','C','D','F', 'W','Y','Z') AND NOT (W.Transactiontype = 'F' AND W.Statementtype IS NULL)) OR  
         (W.TransactionType IN ('Y', 'Z') AND W.MatchID IS NULL) THEN W.AmountDC ELSE Null END) AS Other,
         W.PaymentType AS PaymentType,
         W.Transactiontype AS Transactiontype,
         W.OffsetLedgerAccountNumber,
         W.EntryNumber, W.OffsetReference, W.ID, W.Ordernumber, W.Blocked
    FROM BankTransactions W
   WHERE W.Type = 'W'   AND W.Status <> 'V'   AND W.EntryNumber is not null   AND W.DebtorNumber = '  1100'    )
 )
 ) a
 GROUP BY EntryNumber, InvoiceNumber 
 )
 Union All
 (
 SELECT   MIN(s.ValueDate) AS InvoiceDate,
 MAX(S.ValueDate) AS ActiveDate,
 MAX(S.InvoiceDate) AS MAXInvoiceDate, MAX(S.ID) AS MatchID, S.InvoiceNumber AS InvoiceNumber,
 '' AS SupplierInvoiceNumber,
 MAX(OffsetLedgerAccountNumber) AS OffsetLedgerAccountNumber, MAX(OffsetReference) AS OffsetReference, MAX(ID) AS ID, MAX(S.OrderNumber) AS OrderNumber, MAX(S.EntryNumber) AS EntryNumber, MAX((CONVERT(VARCHAR(40),S.Description))) AS Description,
 MAX(S.DueDate) AS DueDate,
 Null AS InvoiceAmount,
 SUM(S.AmountDC - bts.AmountDC) AS ReceiptPaid,
 Null AS Other,
 Null AS OtherInvoice, MAX(S.PaymentType) AS PaymentType,
 MAX(s.TransactionType) As TransactionType,
 MIN(s.Blocked) As Blocked
 FROM BankTransactions S
 INNER JOIN
( 
       SELECT btx.MatchID, ROUND(SUM(ROUND(btx.AmountDC,3)), 3) AS AmountDC
       FROM BankTransactions btx
       WHERE btx.Type = 'W' AND btx.Status <> 'V' AND btx.EntryNumber IS NOT NULL
       GROUP BY btx.MatchID
       HAVING btx.MatchID Is Not Null
   ) AS bts ON bts.MatchID = S.ID
 WHERE   S.Type = 'S' AND S.Status <> 'V' AND S.EntryNumber is not null AND S.DebtorNumber = '  1100'
 GROUP BY S.EntryNumber, S.InvoiceNumber
 HAVING (ROUND(SUM(ISNULL(S.AmountDc,0) - ISNULL(bts.AmountDC,0)),2) <> 0)
))) banktransactions
 WHERE banktransactions.InvoiceDate >= {d '2009-01-01'}  AND banktransactions.InvoiceDate <= {d '2009-12-31'} ORDER BY InvoiceDate, Invoicenumber