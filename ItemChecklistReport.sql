SELECT  [MARCO item #] AS [Parent Item], BM.comp_item_no AS [CH Components], [WM SAP PART #], [DESCRIPTION 1], [DESCRIPTION 2], [PART COMMENTS], 
        IL.qty_on_hand AS [Par QOH], ILCOMP.qty_on_hand AS [Comp QOH], IL.qty_on_ord AS [Par QOO], ILCOMP.qty_on_ord AS [Comp QOO], IL.qty_allocated AS [Par QALL], QALLCOMP.qty_allocated AS [Comp QALL], [Percentage Award by Category], [DWG #] AS [DWG], cast(qty_per_par as int) AS [Qty Per Parent]
FROM    [BG_WMItemChecklist_8-19-11] IC join z_iminvloc IL on IL.item_no = IC.[Marco item #] left outer join bmprdstr_sql BM on BM.item_no = IC.[marco item #] left outer join Z_IMINVLOC_QALL QALLCOMP on QALLCOMP.item_no = BM.comp_item_no
        LEFT OUTER JOIN Z_IMINVLOC ILCOMP ON ILCOMP.item_no = BM.comp_item_no LEFT OUTER JOIN imitmidx_sql IM2 ON IM2.item_no = BM.comp_item_no
WHERE IM2.item_note_1 = 'CH' or IM2.item_no is null       
ORDER BY IL.item_no, comp_item_no