--ALTER VIEW BG_PO_OPEN AS 

--Created:	1/2/14	 By:	BG
--Last Updated:	--/--/--	 By:	BG
--Purpose:	View for showing open POs

SELECT PH.ord_status, CONVERT(date, PH.ord_dt, 101) AS [Order Dt],  PL.item_no AS Item, PH.ord_no AS [PO #], IM.prod_cat AS Cat, 
               IMC.prod_cat_desc AS CatDesc, PL.qty_ordered AS [QtyOrdered], PL.qty_received AS [QtyRecv], PL.exp_unit_cost AS UnitPrice, 
               (PL.qty_ordered - PL.qty_received) * PL.exp_unit_cost AS TotCost, vend_name
FROM           dbo.poordhdr_sql AS PH INNER JOIN
               dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no LEFT OUTER JOIN
			   dbo.apvenfil_sql AS AP ON AP.vend_no = PH.vend_no LEFT OUTER JOIN
               dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd LEFT OUTER JOIN
               dbo.imitmidx_sql AS IM ON IM.item_no = PL.item_no LEFT OUTER JOIN
               dbo.imcatfil_sql AS IMC ON IMC.prod_cat = IM.prod_cat
WHERE PL.qty_received < PL.qty_ordered
