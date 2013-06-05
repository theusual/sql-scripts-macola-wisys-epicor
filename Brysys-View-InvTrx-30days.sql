CREATE VIEW [dbo].[Brysys_InvTrx_View_30]  AS

--Created:	5/15/13	 By:	BG
--Last Updated:	5/15/13	 By:	BG
--Purpose:	For use with Brysys.  Show all inventory transactions written to the IMINVTRX table by a Brysys object for the last 30 days
--Last changes: --

SELECT ord_no AS trx_ord_no, doc_Type, item_no, par_item_no, loc, trx_dt, trx_tm, doc_dt, quantity, old_quantity, [user_name], comment, comment_2, extra_7, extra_9  
FROM dbo.iminvtrx_sql 
WHERE trx_dt > DATEADD(day,-30,GETDATE()) AND extra_7 = 'BRYSYS'