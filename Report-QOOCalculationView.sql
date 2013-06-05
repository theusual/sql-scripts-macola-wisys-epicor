--ALTER VIEW Z_IMINVLOC_QOO AS

--Created:	9/6/12	 By:	BG
--Last Updated:	9/6/12	 By:	BG
--Purpose:	View for calculating quantity on order.  Used in nightly update job
--Last changes: 

SELECT item_no, stk_loc, SUM(qty_ordered - qty_received) AS qty_on_ord
FROM dbo.poordhdr_sql PH JOIN dbo.poordlin_sql PL ON PL.ord_no = PH.ord_no 
WHERE PH.ord_status != 'X' AND PL.ord_status != 'X' AND qty_received < qty_ordered --AND item_no = 'KR4204 OAK TB'
GROUP BY item_no, stk_loc
