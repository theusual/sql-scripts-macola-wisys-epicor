SELECT  *
FROM    Z_IMINVLOC IM JOIN bmprdstr_sql BM ON BM.comp_item_no = IM.item_no
where BM.item_no = 'BAK-707COBV97A'

SELECT  *
FROM    IMINVLOC_SQL IM
WHERE IM.item_no like 'BAK-707COBV97b'

SELECT  *
FROM    poordlin_sql
where item_no like 'BAK-707COBV97A'

SELECT  *
FROM    imitmidx_sql
where item_weight > 0

SELECT  *
FROM    wspikpak
where ltrim(shipment) = '14090'

SELECT  *
FROM    oeordhdr_sql OH JOIN OEORDLIN_SQL OL ON OL.ord_no = OH.ord_no
wHERE ltrim(oh.ord_no) = '365401'