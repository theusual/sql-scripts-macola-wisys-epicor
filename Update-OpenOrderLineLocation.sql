--Last Updated:	5/14/12	 By:	BG
--Purpose:	Copy items over to other lcoations.  This avoids having to manually create items at each location.  Use if trigger failed or was not active

USE [001]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DECLARE @loc varchar(3)

SET @loc = 'GD'

BEGIN

INSERT INTO IMINVLOC_SQL (item_no, loc, status, mult_bin_fg, qty_on_hand, qty_allocated, qty_bkord, qty_on_ord, reorder_lvl, ord_up_to_lvl, price, avg_cost, last_cost, std_cost, prices_apply_flag,  discs_apply_fg, sls_price, qty_last_sold, tms_cntd_ytd, pct_err_last_cnt, frz_cost, frz_qty, frz_dt, frz_tm, usage_ptd, qty_sld_ptd, qty_scrp_ptd, sls_ptd, cost_ptd, usage_ytd, qty_sold_ytd, qty_scrp_ytd, qty_returned_ytd, sls_ytd, cost_ytd, prior_year_usage, qty_sold_last_yr, qty_scrp_last_yr, prior_year_sls, cost_last_yr, recom_min_ord, economic_ord_qty, avg_usage, po_lead_tm, byr_plnr, doc_to_stk_ld_tm, target_margin, inv_class, po_min, po_max, safety_stk, avg_frcst_error, sum_of_errors, usg_wght_fctr, safety_fctr, usage_filter, active_ords, prod_cat, picking_seq, cube_width, cube_length, cube_height, cube_qty_per, user_def_fld_1, user_def_fld_2, user_def_fld_3, user_def_fld_4, user_def_fld_5, user_fld_8, user_fld_9, user_fld_10, user_fld_11, user_fld_12, user_fld_13, user_14_date, user_15_date, user_16_date, user_fld_17, user_fld_18,user_fld_19, user_fld_20, landed_cost_cd, landed_cost_cd_2, landed_cost_cd_3, landed_cost_cd_4, landed_cost_cd_5, landed_cost_cd_6, landed_cost_cd_7, landed_cost_cd_8, landed_cost_cd_9, landed_cost_cd_10, loc_qty_fld, tag_qty, tag_cost, tag_frz_dt, qty_reject_ptd, qty_reject_ytd, qty_reject_last_yr, include_par_cost, doc_field_1, doc_field_2, doc_field_3, extra_1, extra_2, extra_3, extra_4, extra_5, extra_6, extra_7, extra_8, extra_9, extra_10, extra_11, extra_12, extra_13, extra_14, extra_15, qty_rtn_ptd, qty_rtn_lyr, inv_loc_return_sales_ptd, inv_loc_return_cost_ptd, inv_loc_return_sales_ytd, inv_loc_return_cost_ytd, inv_loc_return_sales_lyr, inv_loc_return_cost_lyr)

SELECT item_no, 'GD', status, mult_bin_fg,'0','0','0','0', reorder_lvl, ord_up_to_lvl, price, avg_cost, last_cost, std_cost, prices_apply_flag,  discs_apply_fg, sls_price, qty_last_sold, tms_cntd_ytd, pct_err_last_cnt, frz_cost, frz_qty, frz_dt, frz_tm, usage_ptd, qty_sld_ptd, qty_scrp_ptd, sls_ptd, cost_ptd, usage_ytd, qty_sold_ytd, qty_scrp_ytd, qty_returned_ytd, sls_ytd, cost_ytd, prior_year_usage, qty_sold_last_yr, qty_scrp_last_yr, prior_year_sls, cost_last_yr, recom_min_ord, economic_ord_qty, avg_usage, po_lead_tm, byr_plnr, doc_to_stk_ld_tm, target_margin, inv_class, po_min, po_max, safety_stk, avg_frcst_error, sum_of_errors, usg_wght_fctr, safety_fctr, usage_filter, active_ords, prod_cat, picking_seq, cube_width, cube_length, cube_height, cube_qty_per, user_def_fld_1, user_def_fld_2, user_def_fld_3, user_def_fld_4, user_def_fld_5, user_fld_8, user_fld_9, user_fld_10, user_fld_11, user_fld_12, user_fld_13, user_14_date, user_15_date, user_16_date, user_fld_17, user_fld_18,user_fld_19, user_fld_20, landed_cost_cd, landed_cost_cd_2, landed_cost_cd_3, landed_cost_cd_4, landed_cost_cd_5, landed_cost_cd_6, landed_cost_cd_7, landed_cost_cd_8, landed_cost_cd_9, landed_cost_cd_10, loc_qty_fld, tag_qty, tag_cost, tag_frz_dt, qty_reject_ptd, qty_reject_ytd, qty_reject_last_yr, include_par_cost, doc_field_1, doc_field_2, doc_field_3, extra_1, extra_2, extra_3, extra_4, extra_5, extra_6, extra_7, extra_8, extra_9, extra_10, extra_11, extra_12, extra_13, extra_14, extra_15, qty_rtn_ptd, qty_rtn_lyr, inv_loc_return_sales_ptd, inv_loc_return_cost_ptd, inv_loc_return_sales_ytd, inv_loc_return_cost_ytd, inv_loc_return_sales_lyr, inv_loc_return_cost_lyr
FROM dbo.iminvloc_sql
WHERE loc = 'FW' AND item_no LIKE 'KR131716%' --AND item_no NOT IN (SELECT item_no FROM iminvloc_sql WHERE loc = 'GD')

END
