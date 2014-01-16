SELECT        CAST(LTRIM(Customer) AS int) AS Customer, [Bill To], CAST(LTRIM(Sales) AS int) AS Sales, SUM([Total Sales Amt After Disc.]) AS [Total Sales Amount], 
                         SUM([Total Sales Amt After Disc.]) AS [Sales After Disc.], [YEAR]
FROM            (SELECT        LTRIM(oh.ord_no) AS [Order], oh.orig_ord_type AS [Orig Order Type], oh.entered_dt AS [Order Date], CAST(LTRIM(oh.cus_no) AS INT) AS Customer, 
                         oh.oe_po_no AS PO, oh.bill_to_name AS [Bill To], LTRIM(oh.cus_alt_adr_cd) AS Store, oh.ship_to_name AS [Ship To], LTRIM(oh.slspsn_no) AS Sales, 
                         oh.discount_pct AS Discount, ol.sls_amt AS [Total Sales Amt], (1 - ol.discount_pct / 100) * ol.sls_amt AS [Total Sales Amt After Disc.], oh.frt_amt AS [Freight Amount], 
                         oh.cmt_1 AS [Cmt 1], oh.cmt_2 AS [Cmt 2], oh.cmt_3 AS [Cmt 3], oh.user_def_fld_5 AS [CS Rep], LTRIM(oh.inv_no) AS Invoice#, oh.inv_dt AS [Invoice Date], 
                         ol.line_seq_no AS [Item Line Seq], ol.item_no AS Item, ol.cus_item_no AS [Customer Item], ol.item_desc_1 AS [Item Desc 1], ol.item_desc_2 AS [Item Desc 2], 
                         CASE WHEN drawing_release_no IS NULL AND drawing_revision_no IS NULL THEN '-' WHEN drawing_release_no IS NOT NULL AND drawing_revision_no IS NULL 
                         THEN (RTRIM(drawing_release_no) + ' - ?') WHEN drawing_release_no IS NOT NULL AND drawing_revision_no IS NOT NULL THEN (RTRIM(drawing_release_no) 
                         + ' - ' + RTRIM(drawing_revision_no)) END AS [DWG & REV], ol.qty_ordered AS [Qty Ordered], ol.qty_to_ship AS [Qty To Ship], ol.unit_price AS [Unit Price], 
                         ol.prod_cat AS [Product Category], IM.item_note_1 AS N1, IM.item_note_5 AS N5, ol.loc AS [Ship From Loc], 
                         CASE WHEN ol.loc = 'BR' THEN 'Brazil' WHEN ol.loc = 'CAN' THEN 'Canada' WHEN ol.loc = 'IN' THEN 'India' WHEN ol.loc = 'IT' THEN 'SEE ORDER' ELSE 'US' END AS
                          [Ship From Country], oh.ship_to_city, oh.ship_to_state, oh.ship_to_zip, oh.ship_to_addr_4, oh.ship_to_addr_2 AS StreetName,
						  YEAR(OH.inv_dt) AS [YEAR]
FROM            dbo.oehdrhst_sql AS oh WITH (NOLOCK) INNER JOIN 
                         dbo.oelinhst_sql AS ol WITH (NOLOCK) ON oh.inv_no = ol.inv_no INNER JOIN
                         dbo.imitmidx_sql AS IM WITH (NOLOCK) ON IM.item_no = ol.item_no
WHERE        (oh.inv_dt >= '01/01/2010') AND (oh.inv_dt <= '12/31/2013')) AS TEMP
GROUP BY [Year], Customer, [Bill To], Sales

