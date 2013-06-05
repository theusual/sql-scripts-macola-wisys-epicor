----------------------------------------------------------------------------------------------------------------------
--If AP/vendro card issues, identify the bad entry number that exists in GBKMUT but does not exist in BankTransactions  
--If AR/customer card issues, identify the the duplicate/bad ID that exists in GBKMUT and BankTransactions (but does not have a match ID) 
--Once the bad entry number (or ID) and amounts (and preferably the corresponding PO # as well) have been identified for deletion, then purge the entries from GBKMUT and AMUTAS using their ID fields
--Purge from just GBKMUT and BankTransactions if the bad entry is on the AR side (not amutak or amutas)
--NOTE: This can also be done by using the vendor/customer card. Search by voucher/customer then add the ID and Entry Number fields to the payables and card views.  
--      Next, find the entry number that doesn't exist on the payables/receivables view but exists on the card view, then find it's ID and use that ID for deletion.
--NOTE: may exist on both views if on AR side, but you can find the bad ID because it will not have a Match ID and not be Matched

--Find the GBKMUT IDs of the bad entries
SELECT * FROM dbo.BG_gbkmut AS BG WHERE -- LTRIM([Our Ref. (PO = Vchr #, OE = Inv #)]) = '399674' AND
 [Entry number] = '11130015' --NOTE: Pay attention that only the entries in the offbalance GL accounts are deleted

--Backup bad entries prior to deletion, using the ID fields
SELECT * 
INTO [BG_BACKUP].[dbo].[gbkmut_badentries_4_27_2012]
FROM gbkmut 
WHERE ID IN ('844896')

--Delete bad entry from GBKMUT, using the ID fields
DELETE FROM gbkmut WHERE ID IN ('844896')

--Find the AMUTAS ID's using the Entry # and the PO, check to ensure the correct GL account entries are being deleted
SELECT ID,  reknr, val_bdr, faktuurnr, * 
FROM dbo.amutak
WHERE bkstnr = '12905593' --AND LTRIM(faktuurnr) = '384959'

--Backup bad entry from AMUTAS prior to deletion, using the ID
SELECT * 
INTO [BG_BACKUP].[dbo].[amutas_badentries_2_02_2012]
FROM amutas WHERE id IN ('889390', '889389', '889391', '958429', '958432', '341227', '341228', '429345', '429344', '607626', '607627', '826404', '826405', '869393', '869390', '869389', '82326', '82325')  
--Questionable entries:  889388 -4591.6  210, 
--                       958428 -255.62  210,    
--                       958431 -225     416,
--                       958430 225      416,
--                       869391 281.25   442,
--                       869392 -281.25  442,

--Delete bad entry from AMUTAS, using the ID
DELETE FROM amutas WHERE id IN ('889390', '889389', '889391', '958429', '958432', '341227', '341228', '429345', '429344', '607626', '607627', '826404', '826405', '869393', '869390', '869389', '82326', '82325')  

--Fix bad entries in BankTransactions (bad check/payment entries, like what occurred with Brilliant in Feb2012), and duplicate AR customer card entries
--
SELECT * FROM dbo.BankTransactions AS BT WHERE EntryNumber =  '12905593'

--Back up into BankTransactions using EntryNumber
SELECT * 
INTO [BG_BACKUP].[dbo].[banktransactions_badentries_4_27_2012]
FROM BankTransactions
WHERE --EntryNumber =  '11130015'
		ID = '844896'

--Delete from BankTransactions using EntryNumber
DELETE FROM dbo.BankTransactions
WHERE --EntryNumber =  '11130015'
		ID = '844896'


