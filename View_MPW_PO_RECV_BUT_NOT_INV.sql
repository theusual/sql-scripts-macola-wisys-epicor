USE [DATA_41]
GO
CREATE VIEW [MPW_MFG_PO_RECV_BUT_NOT_INV] 

AS 
(
--Updated: 7/13/11 By BG
--Purpose: Show PO lines received but not yet invoiced

SELECT  ord_no AS [PO], ap.vend_no, vend_name, item_no, act_unit_cost AS [Unit Cost], qty_ordered, qty_received, receipt_dt
FROM    poordlin_Sql JOIN APVENFIL_SQL AP ON AP.vend_no = poordlin_sql.vend_no
where qty_received >= qty_ordered AND qty_inv = 0 AND dollars_inv = 0 AND qty_ordered > 0
)