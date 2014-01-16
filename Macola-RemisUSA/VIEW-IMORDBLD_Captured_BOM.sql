ALTER VIEW [BG_IMORDBLD_CAPTURED_BOM]
AS
select OH.ord_no, OL.line_no, lvl_no, seq_no, par_item_no, OL.item_no, IMBLD.stocked_fg, qty, qty_per, par_fg, mfg_uom 
FROM imordbld_sql IMBLD JOIN OEORDHDR_SQL OH ON OH.ord_no = IMBLD.ord_no 
						JOIN OEORDLIN_SQL OL ON OL.ord_no = IMBLD.ord_no AND OL.line_no = IMBLD.line_no
WHERE qty > 0