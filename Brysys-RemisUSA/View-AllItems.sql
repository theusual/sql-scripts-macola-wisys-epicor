--Created:	1/9/14		 By:	BG
--Last Updated:	1/9/14	 By:	BG
--Purpose: Show primary fields of all items

--ALTER VIEW [BG_AllItems] AS
SELECT        TOP (100) PERCENT IM.item_no, IM.item_desc_1, IM.item_desc_2, IM.item_note_1, IM.item_note_2, IM.item_note_3, IM.item_note_4, IM.item_note_5, IM.stocked_fg,
                          IM.pur_or_mfg, IM.mfg_method, IM.prod_cat, IL.frz_qty, IL.qty_on_hand, IL.prior_year_usage, IL.avg_cost, IL.last_cost, IL.std_cost,
						  IM.drawing_release_no, IM.drawing_revision_no
FROM            dbo.imitmidx_sql AS IM INNER JOIN
                         dbo.iminvloc_Sql AS IL ON IL.item_no = IM.item_no 
ORDER BY IM.item_no