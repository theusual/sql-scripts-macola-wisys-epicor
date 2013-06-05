SELECT oeordlin_sql.loc AS [SHIP FROM],
       oeordhdr_sql.ord_no,
       oeordhdr_sql.oe_po_no,
       oeordhdr_sql.ship_to_name, oeordlin_sql 
       oeordlin_sql.item_no,
       oeordlin_sql.item_desc_1,
       oeordlin_sql.qty_ordered
FROM   oeordhdr_sql INNER JOIN oeordlin_sql ON oeordhdr_sql.ord_no = oeordlin_sql.ord_no
UNION ALL
SELECT oeordlin_sql.loc AS [SHIP FROM],
       oeordhdr_sql.ord_no,
       oeordhdr_sql.oe_po_no,
       oeordhdr_sql.ship_to_name,
       oeordlin_sql.item_no,
       oeordlin_sql.item_desc_1,
       oeordlin_sql.qty_ordered
FROM   oeordhdr_sql INNER JOIN oeordlin_sql ON oeordhdr_sql.ord_no = oeordlin_sql.ord_no