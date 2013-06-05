SELECT     TOP (100) PERCENT OEORDHDR_SQL.ord_no, OEORDHDR_SQL.cus_no, OEORDHDR_SQL.bill_to_name, OEORDLIN_SQL.qty_ordered, 
                      Z_IMINVLOC.qty_on_hand, OEORDLIN_SQL.item_no, imitmidx_sql.item_desc_1, imitmidx_sql.item_note_1, OEORDHDR_SQL.ord_dt, 
                      OEORDHDR_SQL.shipping_dt
FROM         dbo.oeordhdr_sql AS OEORDHDR_SQL INNER JOIN
                      dbo.oeordlin_sql AS OEORDLIN_SQL ON OEORDHDR_SQL.ord_type = OEORDLIN_SQL.ord_type AND 
                      OEORDHDR_SQL.ord_no = OEORDLIN_SQL.ord_no INNER JOIN
                      dbo.Z_IMINVLOC AS Z_IMINVLOC ON OEORDLIN_SQL.item_no = Z_IMINVLOC.item_no INNER JOIN
                      dbo.imitmidx_sql AS imitmidx_sql ON OEORDLIN_SQL.item_no = imitmidx_sql.item_no
WHERE     (Z_IMINVLOC.qty_allocated > 0)
ORDER BY  OEORDHDR_SQL.shipping_dt, OEORDLIN_SQL.ord_no, OEORDLIN_SQL.item_no