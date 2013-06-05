--ALTER VIEW BG_PO_CH_ALLOPENPOs AS 

--Created:	6/19/12	 By:	BG
--Last Updated:	6/19/12	 By:	BG
--Purpose:	View for showing open POs, used in the open order totals by vendor report

SELECT CONVERT(date, PH.ord_dt, 101) AS [Order Dt],  PL.item_no AS Item, PH.ord_no AS [PO #], IM.prod_cat AS Cat, 
               IMC.prod_cat_desc AS CatDesc, PL.qty_ordered AS [QtyOrdered], PL.qty_received AS [QtyRecv], PL.exp_unit_cost AS UnitPrice, 
               (PL.qty_ordered - PL.qty_received) * PL.exp_unit_cost AS TotCost, 
               CASE WHEN LTRIM(PL.vend_no) IN ('9535', '9533') THEN 'MPW MANUFACTURING CO.' ELSE AP.vend_name END AS vend_name, YEAR(PH.ord_dt) AS Year
FROM  dbo.apvenfil_sql AS AP INNER JOIN
               dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
               dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no LEFT OUTER JOIN
               dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd LEFT OUTER JOIN
               dbo.imitmidx_sql AS IM ON IM.item_no = PL.item_no LEFT OUTER JOIN
               dbo.imcatfil_sql AS IMC ON IMC.prod_cat = IM.prod_cat
WHERE (LTRIM(PL.vend_no) IN ('9533', '9523', '8859', '8830', '9535')) AND PL.qty_received < PL.qty_ordered