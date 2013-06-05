SELECT (CASE WHEN b.MatchID IS NOT NULL THEN CAST(b.MatchID AS char) ELSE '' END) AS MatchedWithCashID, InvoiceDate AS Date, InvoiceNumber, SupplierInvoiceNumber, CONVERT(varchar(50), b.Description) AS Description, TCCode, (CASE WHEN AmountTC <> 0 THEN AmountTC ELSE Null END) AS AmountTC, (CASE WHEN MatchID IS NOT NULL AND b.Type = 'W' THEN 1 ELSE
	 (CASE WHEN Type = 'S' AND EXISTS (SELECT btw.ID FROM banktransactions btw WHERE Type = 'W' AND Status <> 'V' AND DebtorNumber = b.DebtorNumber AND btw.MatchID = b.ID) THEN 1  ELSE 0 END) END) AS MatchID, 
	 (CASE WHEN documentID IS NULL THEN 0 ELSE 1 END) AS Note, 
	 (CASE TransactionType WHEN 'A' THEN 'Receipt' WHEN 'B' THEN 'Fulfillment' WHEN 'C' THEN 'Sales credit note' WHEN 'D' THEN 'Debit memo' WHEN 'E' THEN 'Revaluation' WHEN 'F' THEN 'Discount/Surcharge' WHEN 'G' THEN 'Counts' WHEN 'H' THEN 'Return fulfillment' WHEN 'I' THEN 'Disposal' WHEN 'J' THEN 'Return receipt' WHEN 'K' THEN 'Sales invoice' WHEN 'L' THEN 'Labor hours' WHEN 'M' THEN 'Machine hours' WHEN 'N' THEN 'Other' WHEN 'O' THEN 'POS sales invoice' WHEN 'P' THEN 'Interbank' WHEN 'Q' THEN 'Purchase credit note' WHEN 'R' THEN 'Refund' WHEN 'S' THEN 'Reversal credit note' WHEN 'T' THEN 'Purchase invoice' WHEN 'V' THEN 'Depreciation' WHEN 'W' THEN 'Payroll' WHEN 'X' THEN 'Settled' WHEN 'Y' THEN 'Payment' WHEN 'Z' THEN 'Cash receipt' ELSE '??' END) AS TransactionTypeDescription, 
	 DueDate, 
	 EntryNumber, 
	 b.ID AS ID, 
	 ((CASE WHEN AmountDC > 0 THEN AmountDC ELSE NULL END)) AS Debit, 
	 ((CASE WHEN AmountDC < 0 THEN -AmountDC ELSE NULL END)) AS Credit, 
	 (CASE WHEN Type = 'W' AND EntryNumber IS NULL THEN
	 'To be invoiced'
	 ELSE (CASE PaymentType 
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
	 ELSE '?? ' + PaymentType END) END) AS PaymentType, 
	 (CASE Type  WHEN 'S' THEN 'Cashflow' WHEN 'W' THEN 'Terms' END) AS Type, 
	 OrderNumber, 
	 LedgerAccount, 
	 DebtorNumber, 
	 CreditorNumber, 
	 InvoiceAmount, 
	 TransactionNumber, 
	 BatchNumber, 
	 OwnBankAccount, 
	 OffsetBankAccount, 
	 OffsetLedgerAccountNumber, 
	 OffsetReference, 
	 Blocked, 
	 ProcessingDate, 
	 Pending 
	 
 FROM 
	(
		(
			(SELECT
				S.ValueDate AS InvoiceDate,
				s.InvoiceNumber AS InvoiceNumber,
				S.SupplierInvoiceNumber AS SupplierInvoiceNumber,
				(-S.AmountTC) AS AmountTC,
				-S.AMountDC as AmountDC,
				S.Description,
				S.TCCode,
				S.MatchID,
				S.PaymentType,
				S.DocumentID,
				S.Approved,
				S.Approved2,
				S.OrderNumber,
				S.EntryNumber,
				S.LedgerAccount,
				S.DebtorNumber,
				S.CreditorNUmber,
				(-InvoiceAmount) AS InvoiceAmount,
				S.DueDate,
				S.ProcessingDate AS ProcessingDate,
				S.TransactionNumber,
				(CASE WHEN S.BatchNumber = 0 THEN NULL ELSE S.BatchNumber END) AS BatchNumber,    
				S.OwnBankAccount,    
				S.OffsetBankAccount,    
				S.OffsetLedgerAccountNumber,    
				S.OffsetReference AS OffsetReference,    
				S.ID,    
				S.Type,
				(CASE WHEN Status NOT IN ('V', 'C', 'A') AND S.MatchID IS NULL AND S.BatchNumber > 0 THEN 1 ELSE 0 END ) AS Pending, 
				S.Transactiontype,
				S.Blocked
			FROM BankTransactions S LEFT OUTER JOIN 
				(SELECT    btx.MatchID,    ROUND(Sum(ROUND(IsNull(btx.AmountDC, 0), 2)), 2) As AmountDC 
				 FROM banktransactions btx 
				 WHERE btx.type = 'W' AND btx.Status <> 'V' 
				 GROUP BY btx.MatchID Having btx.MatchID Is Not NULL) as bts ON bts.MatchID = S.ID LEFT OUTER JOIN
			     
				(SELECT ISNULL(DebtorNumber,'') AS DebtorNumber, ISNULL(CreditorNumber,'') AS CreditorNumber,
						InvoiceNumber As InvoiceNumber, SUM(AmountTC) As InvoiceAmount
				 FROM BankTransactions
				 WHERE Type = 'S' AND Status <> 'V' AND DebtorNumber = ' 32409'
				 GROUP BY ISNULL(DebtorNumber,''), ISNULL(CreditorNumber,''), InvoiceNumber) AS W2 ON ISNULL(W2.CreditorNumber,'') = ISNULL(S.CreditorNumber,'') AND W2.InvoiceNumber = S.InvoiceNumber
			 WHERE S.Type = 'S'  AND S.Status <> 'V' AND S.offsetledgeraccountnumber IN 
									(SELECT reknr FROM grtbk WHERE omzrek = 'D') AND Round(S.AmountDC,2) <> 0 AND  S.DebtorNumber=' 32409'
			) 
			Union All 
			( 
			 SELECT
				InvoiceDate,
				W.InvoiceNumber AS InvoiceNumber,
				SupplierInvoiceNumber AS SupplierInvoiceNumber,
				(+AmountTC) AS AmountTC,    
				(+AmountDC) AS AmountDC,    
				Description,
				TCCode,
				MatchID,
				PaymentType,
				DocumentID,
				Approved,
				Approved2,
				OrderNumber,
				EntryNumber,
				LedgerAccount,
				W.DebtorNumber,
				W.CreditorNUmber,
				(+InvoiceAmount) AS InvoiceAmount,
				DueDate,
				ProcessingDate,    
				TransactionNumber,
			   (CASE WHEN BatchNumber = 0 THEN NULL ELSE BatchNumber END) AS BatchNumber,
				OwnBankAccount,
				OffsetBankAccount,
				OffsetLedgerAccountNumber,
				OffsetReference AS OffsetReference,
				ID,
				Type,
				(CASE WHEN Status NOT IN ('V', 'C', 'A') AND MatchID IS NULL AND BatchNumber > 0 THEN 1 ELSE 0 END ) AS Pending,     
				Transactiontype,
				Blocked 
			FROM BankTransactions W LEFT OUTER JOIN
				(SELECT ISNULL(DebtorNumber,'') AS DebtorNumber, 
					ISNULL(CreditorNumber,'') AS CreditorNumber,
					InvoiceNumber As InvoiceNumber, 
					SUM(AmountTC) As InvoiceAmount
				FROM BankTransactions
				WHERE Type = 'W' AND Status <> 'V' AND DebtorNumber = ' 32409'
				GROUP BY ISNULL(DebtorNumber,''), ISNULL(CreditorNumber,''), InvoiceNumber) AS W2 ON ISNULL(W2.CreditorNumber,'') = ISNULL(W.CreditorNumber,'') AND W2.InvoiceNumber = W.InvoiceNumber
			WHERE W.Type = 'W'  AND W.EntryNumber IS NOT NULL  AND W.Status <> 'V'  AND ROUND(W.AmountDC,2) <> 0 AND W.DebtorNumber=' 32409'
			)
		)
	) b
 WHERE DebtorNumber = ' 32409' AND b.InvoiceDate >= {d '2012-02-01'}  AND b.InvoiceDate <= {d '2012-05-01'} 
 ORDER BY MatchedWithCashID, Type