--ALTER VIEW Z_OPEN_OPS_NO_INIT AS 

--Created:	02/01/11	 By:	AW/SW
--Last Updated:	4/26/12	 By:	BG/AA
--Purpose:	View for showing orders with no initials
--Last Change:  Added Nolock hint to prevent query from applying locks, trying to reduce blocking from the schedule refreshes

SELECT DISTINCT 
               oh.ord_no AS [ORDER], oh.oe_po_no AS PO, LTRIM(oh.cus_no) AS CUST, oh.ship_to_name AS [SHIP TO], oh.shipping_dt AS [SHIP DATE], 
               AO.user_name AS USERNAME
FROM  dbo.oeordhdr_sql AS oh WITH(NOLOCK) JOIN
	  dbo.oeordlin_sql AS OL WITH(NOLOCK) ON OL.ord_no = oh.ord_no JOIN 
							   (SELECT AO.ord_no, AO.user_name
								FROM          dbo.oehdraud_sql AO WITH(NOLOCK)
							    WHERE     (user_def_fld_5 IS NULL OR user_def_fld_5 = '') 
										  AND aud_action IN ('A','C')) AS AO ON AO.ord_no = OH.ord_no
               
WHERE (oh.ord_type = 'O') AND (oh.user_def_fld_5 = '' OR
               oh.user_def_fld_5 IS NULL) AND (NOT (OL.item_no LIKE '%test%')) AND (NOT (oh.oe_po_no LIKE '%TEST%')) AND (NOT (oh.ord_no LIKE '777777%')) AND 
               (NOT (oh.ord_no LIKE '888888%')) AND (NOT (oh.ord_no LIKE '9999999%')) AND (NOT (oh.ord_no LIKE '3333333%'))