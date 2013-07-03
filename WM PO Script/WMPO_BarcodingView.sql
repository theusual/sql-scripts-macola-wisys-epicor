USE [001]
SELECT    CONVERT(varchar, OH.shipping_dt, 101) AS [Shipping Dt], OH.ord_no, CASE WHEN ISNUMERIC(OH.cus_alt_adr_cd) = 1 THEN CAST(OH.cus_alt_adr_cd as int) END AS [Store #], OL.cus_item_no AS [WM ITEM #], OL.item_no AS [MARCO ITEM #], OL.item_desc_1,  CAST(OL.qty_ordered as int) AS [Item Qty], '1' AS [Label  Qty],
                       CASE WHEN OH.user_def_fld_4  LIKE  '%PH%' THEN 'ELECTRONICS' ELSE 'FO' END AS [Code],  CASE WHEN OH.user_def_fld_4  LIKE  '%PH%' THEN 'ELECTRONICS' ELSE 'FOOD ORANGE' END AS [Dept.], CASE WHEN OH.user_def_fld_4 LIKE '%ON%' THEN 'FIXTURE REQUEST' WHEN OH.user_def_fld_4 LIKE '%FR%' THEN 'FIXTURE REQUEST' END AS [Ord Type], OH.oe_po_no AS [WM PO #]
FROM         dbo.OEORDHDR_SQL AS OH INNER JOIN
                      dbo.OEORDLIN_SQL AS OL ON OH.ord_no = OL.ord_no
WHERE     (OH.ord_type = 'O') AND (OH.oe_po_no IS NOT NULL) AND (NOT (OL.prod_cat = '036' OR
                      OL.prod_cat = '111' OR
                      OL.prod_cat = '336' OR OL.prod_cat = '037')) AND (LTRIM(OL.cus_no) IN ('1575','20938','25000')) /*'122523'*/