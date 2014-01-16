SELECT        CAST(LTRIM(SUBSTRING(PL.ord_no, 1, 6)) AS int) AS [ORDER], AP.vend_name AS [VENDOR NAME], PL.line_no, PL.item_no AS [ITEM NAME], 
                         PL.item_desc_1 AS [ITEM DESC 1], PL.item_desc_2 AS [ITEM DESC 2], PL.qty_ordered AS [QTY ORDERED], PL.qty_received AS [QTY RECEIVED], CONVERT(varchar, 
                         PH.ord_dt, 101) AS [ORDER DATE], CONVERT(varchar, PL.request_dt, 101) AS [REQUEST DATE], CONVERT(varchar, PL.promise_dt, 101) AS [PROMISE DATE], 
                         CONVERT(varchar, PL.receipt_dt, 101) AS [RECEIPT DATE], PL.stk_loc, PL.user_def_fld_3, PL.exp_unit_cost AS [ORIG PO COST], 
                         PL.act_unit_cost AS [ACTUAL PO COST], IL.std_cost AS [CURRENT STD COST], IL.last_cost AS [CURRENT LAST COST], PC.flat_amt AS [TOTAL FREIGHT], 
                         PH.ship_to_cd + PS.loc + PS.ship_to_desc AS [DELIVERY LOCATION], HR.fullname AS PURCHASER, PH.cmt_1 AS COMMENT, LTRIM(PL.mn_no) 
                         + '-' + PL.sb_no AS [ACCOUNT #], IM.mat_cost_type AS [MATERIAL COST CODES], EDI.edi_item_num AS WMSAP#, IM.prod_cat 
FROM            dbo.apvenfil_sql AS AP INNER JOIN
                         dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                         dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                         dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                         dbo.imitmidx_sql AS IM ON PL.item_no = IM.item_no LEFT OUTER JOIN
                         dbo.Z_IMINVLOC AS IL ON PL.item_no = IL.item_no LEFT OUTER JOIN
                         dbo.poshpfil_sql AS PS ON PH.ship_to_cd = PS.ship_to_cd LEFT OUTER JOIN
                         dbo.popurcst_sql AS PC ON PC.ord_no = PH.ord_no AND PL.line_no = PC.line_no LEFT OUTER JOIN
                         dbo.edcitmfl_sql AS EDI WITH (NOLOCK) ON EDI.mac_item_num = IL.item_no
WHERE        (PH.ord_dt > DATEADD(month, - 24, GETDATE())) 
				AND (PH.ord_status <> 'X') 
				AND (PL.ord_status <> 'X') 
				AND (PL.qty_ordered > 0) 
				AND (LTRIM(PL.vend_no) IN
								 (SELECT    vend_no
								    FROM    dbo.BG_CH_Vendors))