ALTER VIEW BG_IMINVLOC_ACCUMULATORS_ONLY AS
--Created By: Bryan Gregory
--Last Updated By:  ---
--Last Updated: 10/9/2013
--Purpose:  Accumulator fields only from iminvloc_sql.

SELECT        IM.item_no, IL.prod_cat, IL.loc, IL.qty_on_hand, IL.avg_cost, IL.last_cost, IL.std_cost, IL.prior_year_usage, QA.qty_allocated AS [QALL_All Loc], 
                         QU.usage_ytd AS [USG YTD_All Loc], IM.extra_1 AS [Par/Sub/Comp Flag], IM.item_desc_1, IM.item_desc_2, IL.qty_on_ord, IL.frz_qty
FROM            dbo.iminvloc_sql AS IL INNER JOIN
                         dbo.imitmidx_sql AS IM ON IM.item_no = IL.item_no LEFT OUTER JOIN
                         dbo.Z_IMINVLOC_QALL AS QA ON QA.item_no = IL.item_no LEFT OUTER JOIN
                         dbo.Z_IMINVLOC_USAGE AS QU ON QU.item_no = QA.item_no
WHERE        (IL.qty_on_hand <> 0) OR
                         (QA.qty_allocated <> 0) OR
                         (IL.qty_on_ord <> 0) OR
                         (IL.usage_ytd <> 0) OR
                         (IL.prior_year_usage <> 0)