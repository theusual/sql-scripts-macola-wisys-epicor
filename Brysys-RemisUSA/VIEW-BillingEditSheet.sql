USE [060]
GO
ALTER VIEW [View_BillingEditSheet]
AS
SELECT        LTRIM(OH.ord_no) AS [Order #], RTRIM(OH.oe_po_no) AS [PO #], OH.frt_pay_cd AS [Frt Terms], LTRIM(OH.cus_no) AS [Cust #], RTRIM(OH.bill_to_name) 
                         AS [Bill To Name], RTRIM(OH.ship_to_name) AS [Ship To Name], OL.line_seq_no AS [Line Seq. #], RTRIM(OL.item_no) AS [Item #], OL.qty_ordered AS [Qty Ordered], 
                         OL.qty_to_ship AS [Qty to Ship], OL.qty_bkord AS [Qty B/O], OL.unit_price AS [Unit Price], CONVERT(varchar, CAST(RTRIM(OL.shipped_dt) AS datetime), 101) 
                         AS [Shipped Date], RTRIM(OH.cmt_1) AS Carrier, RTRIM(OH.cmt_2) AS [N/C Freight Note], RTRIM(OH.cmt_3) AS Tracking, OH.tot_sls_amt AS [TTL Sales Amt], 
                         OH.misc_amt AS [Misc Chg's], OH.frt_amt AS [Freight Chg], OH.sls_tax_amt_1 AS [Sales Tax 1], OH.sls_tax_amt_2 AS [Sales Tax 2], 
                         OH.sls_tax_amt_3 AS [Sales Tax 3], OH.tot_dollars AS [Grand Total], OH.inv_batch_id AS [Batch ID]
FROM            dbo.oeordhdr_sql AS OH INNER JOIN
                         dbo.oeordlin_sql AS OL ON OH.ord_no = OL.ord_no
WHERE        (NOT (OH.inv_batch_id = 'null'))