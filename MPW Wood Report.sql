SELECT  PH.ord_dt AS  [Order Dt], PH.ord_no, item_no, item_desc_1, item_desc_2, qty_ordered, qty_received, request_dt AS [Expected Recv Dt], extra_8 AS [Container ETA], receipt_dt AS [Recv DT],  dollars_inv, cmt_1, cmt_2, cmt_3,*
FROM    POORDLIN_SQL PL INNER JOIN poordhdr_sql PH ON PH.ord_no = PL.ord_no
WHERE ltrim(PH.vend_no) = '1556' AND ship_to_cd = 'DS' AND receipt_dt > '01/01/2010' AND NOT(ltrim(PH.ord_no) = '7977700')
ORDER BY PL.qty_received ASC