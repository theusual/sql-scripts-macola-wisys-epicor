ALTER VIEW [MODEL_PO_HISTORY]
AS 
SELECT PH.ord_no, PH.byr_plnr, PH.ord_dt, PH.vend_no, PH.ship_to_cd, PH.ord_status, PH.po_type, PL.act_unit_cost, PL.exp_unit_cost, 
PL.item_no, PL.item_desc_1, PL.item_desc_2, PL.line_no, PL.qty_ordered, PL.qty_received, PL.uom, 
VEN.vend_name, IM.item_note_1, IM.item_note_2, IM.item_note_3, IM.item_note_4, IM.item_note_5, PL.receipt_dt
FROM poordhdr_sql PH JOIN poordlin_sql PL ON PL.ord_no = PH.ord_no
					 JOIN apvenfil_sql VEN ON VEN.vend_no = PH.vend_no
					 JOIN imitmidx_sql IM ON IM.item_no = PL.item_no
WHERE PL.qty_remaining = 0 and PL.qty_received > 0
