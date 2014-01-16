--ALTER VIEW [BG_ALL] AS
select OH.entered_dt, OH.shipping_dt, OH.ord_type, OH.cus_no, OH.ord_no, OL.item_no, OL.item_desc_1, OL.item_desc_2, qty_ordered, unit_price, 
		OL.loc, OH.user_def_fld_5 AS [CS_INITIALS], OH.slspsn_no, OH.bill_to_name
from oeordlin_sql OL JOIN OEORDHDR_SQL OH ON OH.ord_no = OL.ord_no
WHERE OH.ord_no not in (SELECT ord_no FROM BG_LATE_ORDERS_NONWM) 
		AND item_no NOT like '%TEST%'
		AND OH.shipping_dt < GETDATE()
		AND OH.ord_type != 'I'

