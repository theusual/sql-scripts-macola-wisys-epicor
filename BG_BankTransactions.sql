SELECT  ID ,
         CASE Type 
			WHEN 'S' THEN 'S-Cashflow'
			WHEN 'W' THEN 'W-Term'
			WHEN 'C' THEN 'C-Template'
			WHEN 'P' THEN 'P-Bank statement header'
			WHEN 'N' THEN 'N-Non-financial transaction'
			WHEN 'V' THEN 'V-VerwInfo'
		    ELSE Type
		  END AS [Type], 
        OwnBankAccount ,
        BatchNumber ,
         CASE TransactionType 
            WHEN 'N' THEN	'N-Other'
			WHEN 'K' THEN	'K-Sales invoice'
			WHEN 'C' THEN	'C-Sales credit note'
			WHEN 'T' THEN	'T-Purchase invoice'
			WHEN 'Q' THEN	'Q-Purchase credit note'
			WHEN 'Z' THEN	'Z-Cash receipt'
			WHEN 'Y' THEN	'Y-Payment'
			WHEN 'R' THEN	'R-Refund'
			WHEN 'P' THEN	'P-Prepayment'
			WHEN 'S' THEN	'S-Reversal credit note'
			WHEN 'D' THEN	'D-Debit memo/Financial charge'
			WHEN 'F' THEN	'F-Discount/Surcharge'
			WHEN 'M' THEN	'M-Machine hours'
			WHEN 'L' THEN	'L-Labor hours'
			WHEN 'E' THEN	'E-Revaluation'
			WHEN 'A' THEN	'A-Receipt'
			WHEN 'B' THEN	'B-Fulfillment'
			WHEN 'G' THEN	'G-Counts'
			WHEN 'H' THEN	'H-Return fulfillment'
			WHEN 'J' THEN	'J-Return receipt'
			WHEN 'W' THEN	'W-Payroll'
			WHEN 'O' THEN	'O-POS Sales Invoice'
			WHEN 'X' THEN   'X-Year/Period Closing'
			WHEN 'U' THEN	'U-Credit surcharge'
			ELSE TransactionNumber 
		  END AS [TransactionNumber],
         CASE Status WHEN 'A' THEN 'A-Authorized'
					WHEN 'P' THEN	'P-Processed'
					WHEN 'R' THEN	'R-Matched'
					WHEN 'U' THEN	'U-Unallocated'
					WHEN 'J' THEN	'J-Journalized'
					WHEN 'D' THEN	'D-Deposited'
					WHEN 'V' THEN	'V-Void'
		            ELSE Status
		 END AS [Status],
        PaymentMethod ,
        CreditorNumber ,
        DebtorNumber ,
        ExchangeRate ,
        TCCode ,
        AmountDC ,
        AmountTC ,
        OffsetBankCountry ,
        OffsetName ,
        OffsetAddressLine1 ,
        OffsetAddressLine2 ,
        OffsetAddressLine3 ,
        OffsetBankAccount ,
        OffsetPostalCode ,
        OffsetCity ,
        OffsetReference ,
        OffsetCountryCode ,
        OffsetBankName ,
        OffsetBankSWIFTCode ,
        OwnReference ,
        Description ,
        Blocked ,
        ProcessingDate ,
        InvoiceNumber ,
        StatementType ,
        StatementDate ,
        StatementNumber ,
        StatementLineNumber ,
        ValueDate ,
        FileName ,
        LedgerAccount ,
        OffsetLedgerAccountNumber ,
        EntryNumber ,
        SupplierInvoiceNumber ,
        DueDate ,
        HumanResourceID ,
        MatchID ,
        OffsetIdentificationNumberBank ,
        PaymentType ,
        bedrnr ,
        InvoiceDate ,
        Prepayment ,
        PaymentCondition ,
        OrderNumber ,
        InvoiceCode ,
        SequenceNumber ,
        DocAttachmentID ,
        Approver ,
        Approved ,
        VATCode ,
        Processor ,
        Processed ,
        Approver2 ,
        Approved2 ,
        Journalizer ,
        Journalized ,
        TermPercentage ,
        DepositDate ,
        DepositNumber ,
        PaymentDays ,
        DocumentID ,
        Warehouse ,
        ExtraCurrencyCode ,
        ExtraCurrencyAmount ,
         CASE InstrumentStatus 
				WHEN 'P' THEN	'Printed'
				WHEN 'R' THEN	'Received'
				WHEN 'D' THEN	'Deposited'
				WHEN 'S' THEN	'Settled Bill'
				WHEN 'B' THEN	'Bounced Bill'
				WHEN 'I' THEN 	'Discounted Bill'
				WHEN 'F' THEN	'Financed Bill'
				WHEN 'C' THEN	'Bill Discount Cost'
		        ELSE InstrumentStatus
		  END AS [InstrumentStatus],
        InstrumentReference ,
        InstrumentBank ,
        MaturityDays ,
        OwnBankAccountRef ,
        AdvanceInvoiceNumber ,
        cnt_id ,
        TaxInvoiceDate ,
        TaxInvoiceNumber ,
        CreditCardTransID ,
        CreditCardResult ,
        CreditCardAuthCode ,
        LinkID ,
        Division ,
        ImportAutoMatch ,
        ReportingDate ,
        timestamp ,
        syscreated ,
        syscreator ,
        sysmodified ,
        sysmodifier ,
        sysguid 
FROM dbo.BankTransactions
WHERE EntryNumber = '11013902' 