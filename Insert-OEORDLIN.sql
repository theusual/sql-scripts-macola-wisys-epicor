select * 
from MasterTrace
WHERE LoginName like '%MARCO\Administrator%' AND [ApplicationName] = 'MacMSS'

select * from oeordlin_sql 

INSERT INTO oeordlin_sql 
    (ord_type, ord_no, line_seq_no, item_no, loc, pick_seq, cus_item_no, item_desc_1, item_desc_2, qty_ordered, qty_to_ship, unit_price, discount_pct, request_dt,
	qty_bkord, qty_return_to_stk, bkord_fg, uom, uom_ratio, unit_cost, unit_weight, comm_calc_type, comm_pct_or_amt, promise_dt, tax_fg, stocked_fg, controlled_fg, select_cd,
	tot_qty_ordered, tot_qty_shipped, tax_fg_1, tax_fg_2, tax_fg_3, orig_price, copy_to_bm_fg, explode_kit, mfg_ord_no, allocate_dt, last_post_dt, post_to_inv_qty,
	posted_to_inv, tot_qty_posted, qty_allocated, components_alloc, bin_fg, cost_meth, ser_lot_cd, mult_ftr_fg, line_type, prod_cat, end_item_cd, reason_cd, feature_return,
	rec_inspection, ship_from_stk, mult_release, req_ship_dt, qty_from_stk, user_def_fld_1, user_def_fld_2, user_def_fld_3, user_def_fld_4, user_def_fld_5,
	picked_dt, shipped_dt, billed_dt, update_fg, prc_cd_orig_price, tax_sched, cus_no, tax_amt, qty_bkord_fg, line_no, mfg_method, forced_demand, conf_pick_dt,
	item_release_no, bin_ser_lot_comp, offset_used_fg, ecs_space, sfc_order_status, total_cost, po_ord_no, rma_seq, vendor_no, posted_unit_cost, extra_1,
	extra_2, extra_3, extra_4, extra_5, extra_6, extra_7, extra_8, extra_9, extra_10, extra_11, extra_12, extra_13, extra_14, extra_15, warranty_date, revision_no, 
	cm_post_fg, recalc_sw, filler_0004)
select ord_type, ord_no, (line_seq_no+1), '101005-6096                   ', loc, pick_seq, cus_item_no, item_desc_1, item_desc_2, qty_ordered, qty_to_ship, unit_price, discount_pct, request_dt,
	qty_bkord, qty_return_to_stk, bkord_fg, uom, uom_ratio, unit_cost, unit_weight, comm_calc_type, comm_pct_or_amt, promise_dt, tax_fg, stocked_fg, controlled_fg, select_cd,
	tot_qty_ordered, tot_qty_shipped, tax_fg_1, tax_fg_2, tax_fg_3, orig_price, copy_to_bm_fg, explode_kit, mfg_ord_no, allocate_dt, last_post_dt, post_to_inv_qty,
	posted_to_inv, tot_qty_posted, qty_allocated, components_alloc, bin_fg, cost_meth, ser_lot_cd, mult_ftr_fg, line_type, prod_cat, end_item_cd, reason_cd, feature_return,
	rec_inspection, ship_from_stk, mult_release, req_ship_dt, qty_from_stk, user_def_fld_1, user_def_fld_2, user_def_fld_3, user_def_fld_4, user_def_fld_5,
	picked_dt, shipped_dt, billed_dt, update_fg, prc_cd_orig_price, tax_sched, cus_no, tax_amt, qty_bkord_fg, (line_no+1), mfg_method, forced_demand, conf_pick_dt,
	item_release_no, bin_ser_lot_comp, offset_used_fg, ecs_space, sfc_order_status, total_cost, po_ord_no, rma_seq, vendor_no, posted_unit_cost, extra_1,
	extra_2, extra_3, extra_4, extra_5, extra_6, extra_7, extra_8, extra_9, extra_10, extra_11, extra_12, extra_13, extra_14, extra_15, warranty_date, revision_no, 
	cm_post_fg, recalc_sw, filler_0004
FROM oeordlin_sql
WHERE ord_no = '    1234' AND line_no = 2