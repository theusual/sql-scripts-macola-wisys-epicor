SELECT CASE WHEN PL.qty_received < PL.qty_ordered THEN 'OPEN'
			ELSE 'RECEIVED'
		END AS [Status], PH.ord_no AS [PH.ord_no], PH.vend_no AS [PH.vend_no], AP.vend_name AS [AP.vend_name], PH.ord_dt AS [PH.ord_dt], PL.vend_no AS [PL.vend_no], 
               PL.item_no AS [PL.item_no], PL.vend_item_no AS [PL.vend_item_no], 
               PL.mn_no AS [PL.mn_no], PL.sb_no AS [PL.sb_no], PL.var_mn_no AS [PL.var_mn_no], PL.var_sb_no AS [PL.var_sb_no], PL.acc_mn_no AS [PL.acc_mn_no], 
               PL.acc_sb_no AS [PL.acc_sb_no], PL.exp_unit_cost AS [PL.exp_unit_cost], PL.act_unit_cost AS [PL.act_unit_cost], PL.std_cost AS [PL.std_cost], 
               PL.qty_ordered AS [PL.qty_ordered], PL.qty_ord_chg_amt AS [PL.qty_ord_chg_amt], PL.qty_released AS [PL.qty_released], PL.qty_received AS [PL.qty_received], 
               PL.qty_remaining AS [PL.qty_remaining], PL.qty_inv AS [PL.qty_inv], 
               PL.dollars_inv AS [PL.dollars_inv], PL.request_dt AS [PL.request_dt], PL.promise_dt AS [PL.promise_dt], PL.receipt_dt AS [PL.receipt_dt], 
               PL.oe_ord_no AS [PL.oe_ord_no], PL.var_qty_mn_no AS [PL.var_qty_mn_no], PL.var_qty_sb_no AS [PL.var_qty_sb_no], FL.chk_no AS [Check #], 
               FL.chk_dt AS [Check Date], FL.inv_no AS [Inv #], SH.flat_amt AS [Landed Cost]
FROM  dbo.poordhdr_sql AS PH INNER JOIN
               dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
               dbo.apvenfil_sql AS AP ON AP.vend_no = PH.vend_no LEFT OUTER JOIN
               dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
               dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd LEFT OUTER JOIN
               apopnfil_sql AS FL ON FL.ap_po_no = PH.ord_no LEFT OUTER JOIN
               popurcst_sql AS SH ON SH.ord_no = PL.ord_no AND SH.line_no = PL.line_no
WHERE ord_dt > '01/01/2011'