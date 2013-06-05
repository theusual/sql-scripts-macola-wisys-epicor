 SELECT OH."slspsn_no", OH."ord_no", OH."cus_no", OH."bill_to_name", OL."qty_ordered", OL."item_no", OL."item_desc_1", OL."item_desc_2", IM."qty_bkord", IM."qty_on_ord", IM."qty_on_hand", QALL."qty_allocated", OL."prod_cat", QUSG."usage_ytd", IM."price", OL."unit_price", OH."cus_alt_adr_cd", IM."avg_cost", IM."last_cost", IM."std_cost", OH."shipping_dt", OL."request_dt", OL."promise_dt", OH."ord_dt", OH."user_def_fld_4", IM2."item_note_1", OH."oe_po_no"
 FROM   (("001"."dbo".oeordhdr_sql OH INNER JOIN "001"."dbo".oeordlin_sql OL ON (OH."ord_type"=OL."ord_type") AND (OH."ord_no"=OL."ord_no")) INNER JOIN "001"."dbo".Z_IMINVLOC IM ON OL."item_no"=IM."item_no") INNER JOIN "001"."dbo".imitmidx_sql IM2 ON IM2."item_no"=IM."item_no" INNER JOIN Z_IMINVLOC_QALL AS QALL ON IM.item_no =  QALL.item_no INNER JOIN Z_IMINVLOC_USAGE AS QUSG ON QUSG.item_no = IM.item_no
 WHERE  IM."prod_cat"='AP'
 ORDER BY OL."item_no", OH."shipping_dt"


