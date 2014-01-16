USE [001]
GO

/****** Object:  View [dbo].[Z_IMINVLOC]    Script Date: 1/14/2014 2:32:45 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[Z_IMINVLOC]
AS
SELECT dbo.iminvloc_sql.item_no, MAX(dbo.iminvloc_sql.status) AS status, MAX(dbo.iminvloc_sql.mult_bin_fg) AS mult_bin_fg, SUM(dbo.iminvloc_sql.qty_on_hand) 
               AS qty_on_hand, SUM(dbo.iminvloc_sql.qty_allocated) AS qty_allocated, SUM(dbo.iminvloc_sql.qty_bkord) AS qty_bkord, SUM(dbo.iminvloc_sql.qty_on_ord) 
               AS qty_on_ord, MAX(dbo.iminvloc_sql.reorder_lvl) AS reorder_lvl, MAX(dbo.iminvloc_sql.ord_up_to_lvl) AS ord_up_to_lvl, MAX(dbo.iminvloc_sql.price) AS price, 
               MAX(dbo.iminvloc_sql.avg_cost) AS avg_cost, MAX(dbo.iminvloc_sql.last_cost) AS last_cost, MAX(dbo.iminvloc_sql.std_cost) AS std_cost, 
               MAX(dbo.iminvloc_sql.starting_sls_dt) AS starting_Sls_dt, MAX(dbo.iminvloc_sql.ending_sls_dt) AS ending_sls_dt, MAX(dbo.iminvloc_sql.last_sold_dt) 
               AS last_sold_dt, MAX(dbo.iminvloc_sql.sls_price) AS sls_price, SUM(dbo.iminvloc_sql.qty_last_sold) AS qty_last_sold, MAX(dbo.iminvloc_sql.cycle_count_cd) 
               AS Expr1, MAX(dbo.iminvloc_sql.last_count_dt) AS last_count_dt, MAX(dbo.iminvloc_sql.frz_cost) AS frz_cost, SUM(dbo.iminvloc_sql.frz_qty) AS frz_qty, 
               MAX(dbo.iminvloc_sql.frz_dt) AS frz_dt, SUM(dbo.iminvloc_sql.usage_ptd) AS usage_ptd, SUM(dbo.iminvloc_sql.qty_sld_ptd) AS qty_sld_ptd, 
               SUM(dbo.iminvloc_sql.qty_scrp_ptd) AS qty_scrp_ptd, SUM(dbo.iminvloc_sql.sls_ptd) AS sls_ptd, MAX(dbo.iminvloc_sql.cost_ptd) AS cost_ptd, 
               SUM(dbo.iminvloc_sql.usage_ytd) AS usage_ytd, SUM(dbo.iminvloc_sql.qty_sold_ytd) AS qty_sold_ytd, SUM(dbo.iminvloc_sql.sls_ytd) AS sls_ytd, 
               MAX(dbo.iminvloc_sql.cost_ytd) AS cost_ytd, SUM(dbo.iminvloc_sql.prior_year_usage) AS prior_year_usage, SUM(dbo.iminvloc_sql.qty_sold_last_yr) 
               AS qty_sold_last_yr, SUM(dbo.iminvloc_sql.prior_year_sls) AS prior_year_sls, MAX(dbo.iminvloc_sql.cost_last_yr) AS cost_last_yr, 
               SUM(dbo.iminvloc_sql.avg_usage) AS avg_usage, MAX(dbo.iminvloc_sql.vend_no) AS vend_no, MAX(dbo.iminvloc_sql.tax_sched) AS tax_sched, 
               MAX(dbo.iminvloc_sql.prod_cat) AS prod_cat, MAX(dbo.iminvloc_sql.cube_width_uom) AS cube_width_uom, MAX(dbo.iminvloc_sql.cube_length_uom) 
               AS cube_length_uom, MAX(dbo.iminvloc_sql.cube_height_uom) AS cube_height_uom, MAX(dbo.iminvloc_sql.cube_width) AS cube_width, 
               MAX(dbo.iminvloc_sql.cube_length) AS cube_length, MAX(dbo.iminvloc_sql.cube_height) AS cube_height, MAX(dbo.iminvloc_sql.cube_qty_per) AS cube_qty_per, 
               MAX(dbo.iminvloc_sql.user_def_fld_1) AS user_def_fld_1, MAX(dbo.iminvloc_sql.user_def_fld_2) AS user_def_fld_2, MAX(dbo.iminvloc_sql.user_def_fld_3) 
               AS user_def_fld_3, MAX(dbo.iminvloc_sql.user_def_fld_4) AS user_def_fld_4, MAX(dbo.iminvloc_sql.user_def_fld_5) AS user_def_fld_5, 
               MAX(dbo.iminvloc_sql.po_min) AS po_min, MAX(dbo.iminvloc_sql.po_max) AS po_max, MAX(dbo.iminvloc_sql.safety_stk) AS safety_stk, IM.pur_or_mfg, 
               IM.item_desc_1, IM.item_desc_2
FROM  dbo.iminvloc_sql WITH(NOLOCK) INNER JOIN
               dbo.imitmidx_sql AS IM WITH(NOLOCK) ON IM.item_no = dbo.iminvloc_sql.item_no
WHERE (NOT (dbo.iminvloc_sql.loc IN ('CAN', 'IN', 'BR')))
GROUP BY dbo.iminvloc_sql.item_no, IM.pur_or_mfg, IM.item_desc_1, IM.item_desc_2

GO


