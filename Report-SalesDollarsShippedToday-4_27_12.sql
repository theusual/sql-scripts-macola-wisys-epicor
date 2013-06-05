SELECT LTRIM(oh.ord_no) AS [Order], oh.orig_ord_type AS [Original Order Type], CONVERT(varchar, oh.ord_dt, 101) AS Date, LTRIM(oh.cus_no) AS Customer, 
               oh.oe_po_no AS PO, oh.bill_to_name AS [Bill To], LTRIM(oh.cus_alt_adr_cd) AS Store, oh.ship_to_name AS [Ship To], LTRIM(oh.slspsn_no) AS Sales, 
               oh.discount_pct AS Discount, CASE WHEN (oh.orig_ord_type = 'C' AND ol.item_no <> 'RESTOCK FEE') THEN - (oh.tot_sls_amt) 
               ELSE oh.tot_sls_amt END AS [Total Sales Amt], CASE WHEN (oh.orig_ord_type = 'C' AND ol.item_no <> 'RESTOCK FEE') THEN - (oh.tot_sls_amt) 
               ELSE (oh.tot_sls_amt * (1 - (.01 * oh.discount_pct))) END AS [Total Sales Amt After Disc.], oh.frt_amt AS [Freight Amount], oh.cmt_1 AS [Cmt 1], oh.cmt_2 AS [Cmt 2], 
               oh.cmt_3 AS [Cmt 3], CONVERT(varchar, oh.inv_dt, 101) AS [Invoice Date], ol.line_seq_no AS [Item Line Seq], ol.item_no AS Item, ol.cus_item_no AS [Customer Item], 
               ol.qty_ordered AS [Qty Ordered], ol.qty_to_ship AS [Qty To Ship], ol.unit_price AS [Unit Price], ol.prod_cat AS [Product Category]
FROM  dbo.oeordhdr_sql AS oh INNER JOIN
               dbo.oeordlin_sql AS ol ON oh.ord_no = ol.ord_no
WHERE (oh.ord_type IN ('O', 'C', 'I')) AND shipped_dt > DATEADD(day, -1, GETDATE())
