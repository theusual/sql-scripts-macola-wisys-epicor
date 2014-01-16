ALTER VIEW [BG_IM_INV_TRANSACTIONS_PAST_30_DAYS] 
AS

select item_no, loc, trx_dt, doc_dt, doc_ord_no, doc_type, quantity, user_name, comment
from iminvtrx_sql
WHERE doc_dt > DATEADD(day,-30,GETDATE())