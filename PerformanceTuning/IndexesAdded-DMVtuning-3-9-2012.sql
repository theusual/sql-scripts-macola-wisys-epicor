CREATE NONCLUSTERED INDEX BG_gbkmut_DMVindex_1 ON gbkmut 
( [oms25], [freefield3] ) INCLUDE ([ID], [faktuurnr]) 
WITH (SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF) on [Primary];

CREATE NONCLUSTERED INDEX BG_gbkmut_DMVindex_2 ON gbkmut ( [reknr],[bdr_hfl], [docdate] ) INCLUDE ([bkstnr], [debnr], [docnumber], [faktuurnr], [transtype]) 
WITH (SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF) on [Primary];

CREATE NONCLUSTERED INDEX BG_BankTransaction_DMVindex_1 ON BankTransactions ( [Type],[Status] ) INCLUDE ([AmountDC], [MatchID])
WITH (SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF) on [Primary];

CREATE NONCLUSTERED INDEX BG_iminvtrx_DMVindex_1 ON iminvtrx_sql ( [lev_no], [doc_type],[trx_dt] ) INCLUDE ([item_no], [loc], [trx_tm], [doc_ord_no], [quantity], [user_name], [comment])
WITH (SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF) on [Primary];

CREATE NONCLUSTERED INDEX BG_BankTransaction_DMVindex_2 ON BankTransactions ( [InstrumentReference] ) INCLUDE ([ID], [timestamp])
WITH (SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF) on [Primary];

CREATE NONCLUSTERED INDEX BG_oehdraud_DMVindex_1 ON oehdraud_sql ( [ord_no] ) INCLUDE ([user_name]) 
WITH (SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF) on [Primary];

DROP INDEX BG_gbkmut_DMVindex_1 ON gbkmut 


DROP INDEX BG_gbkmut_DMVindex_2 ON gbkmut 

DROP INDEX BG_BankTransaction_DMVindex_1 ON BankTransactions 

drop INDEX BG_iminvtrx_DMVindex_1 ON iminvtrx_sql 

drop INDEX BG_BankTransaction_DMVindex_2 ON BankTransactions 

drop INDEX BG_oehdraud_DMVindex_1 ON oehdraud_sql