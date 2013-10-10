CREATE VIEW BG_OE_OpenOrdersWithIM AS

--View for open order reports
--Created: 9/26/2013

SELECT        TOP (100) PERCENT OH.slspsn_no, OH.ord_no, OH.cus_no, OH.bill_to_name, OL.qty_ordered, OL.item_no, OL.item_desc_1, OL.item_desc_2, IM.qty_bkord, 
                         IM.qty_on_ord, IM.qty_on_hand, QALL.qty_allocated, OL.prod_cat, QUSG.usage_ytd, IM.price, OL.unit_price, OH.cus_alt_adr_cd, IM.avg_cost, IM.last_cost, 
                         IM.std_cost, OH.shipping_dt, OL.request_dt, OL.promise_dt, OH.ord_dt, OH.user_def_fld_4, IM2.item_note_1, OH.oe_po_no
FROM            dbo.oeordhdr_sql AS OH INNER JOIN
                         dbo.oeordlin_sql AS OL ON OH.ord_type = OL.ord_type AND OH.ord_no = OL.ord_no INNER JOIN
                         dbo.Z_IMINVLOC AS IM ON OL.item_no = IM.item_no INNER JOIN
                         dbo.imitmidx_sql AS IM2 ON IM2.item_no = IM.item_no INNER JOIN
                         dbo.Z_IMINVLOC_QALL AS QALL ON IM.item_no = QALL.item_no INNER JOIN
                         dbo.Z_IMINVLOC_USAGE AS QUSG ON QUSG.item_no = IM.item_no
ORDER BY OL.item_no, OH.shipping_dt