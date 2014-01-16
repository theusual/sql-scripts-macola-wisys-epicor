--ALTER VIEW BG_PO_CH_LATE_ORDER_REPORT AS

--Created:	4/27/10			     By:	BG
--Last Updated:	12/4/13			 By:	BG
--Purpose:	View for late China purchase orders
--Last changes: 

SELECT 'NO EST SHIP DT' AS [ERROR], PL.extra_8 AS [EST SHIP DT], PL.user_def_fld_2 AS [MARCO ETA], promise_dt AS [PROMISE DT], 
		LEFT(PH.ord_no,LEN(PH.ord_no)-2) AS ORD_NO, PH.vend_no, AP.vend_name, PL.line_no, PL.item_no, PL.item_desc_1, PL.item_desc_2, PL.qty_ordered, PL.qty_received, PL.exp_unit_cost, PH.user_name
FROM poordhdr_sql PH 
		JOIN poordlin_sql PL ON PL.ord_no = PH.ord_no
		JOIN apvenfil_sql AP ON AP.vend_no = PL.vend_no
WHERE  qty_received < qty_ordered 
		and PL.ord_status != 'X'
		and PH.ord_status != 'X'
		and ltrim(PH.vend_no) IN (select vend_no from BG_CH_Vendors)
       --Item is expected within 14 days but no shipping date is present
		and promise_dt < DATEADD(day, 14, GETDATE()) and PL.extra_8 is null
UNION ALL
SELECT 'PAST MARCO ETA' AS [ERROR], PL.extra_8 AS [EST SHIP DT], PL.user_def_fld_2 AS [MARCO ETA], promise_dt AS [PROMISE DT], 
		LEFT(PH.ord_no,LEN(PH.ord_no)-2) AS ORD_NO, PH.vend_no, AP.vend_name, PL.line_no, PL.item_no, PL.item_desc_1, PL.item_desc_2, PL.qty_ordered, PL.qty_received, PL.exp_unit_cost, PH.user_name
FROM poordhdr_sql PH 
		JOIN poordlin_sql PL ON PL.ord_no = PH.ord_no
		JOIN apvenfil_sql AP ON AP.vend_no = PL.vend_no
WHERE   qty_received < qty_ordered 
		and PL.ord_status != 'X'
		and PH.ord_status != 'X'
		AND LEN(PL.user_def_fld_2) = 10
		and ltrim(PH.vend_no) IN (select vend_no from BG_CH_Vendors)
       --Item is past MARCO ETA and not yet received
		and PL.user_def_fld_2 < DATEADD(day, 0, GETDATE()) 






