USE [001]
GO

/****** Object:  View [dbo].[WM_PO_BARCODING_WISYS]    Script Date: 08/16/2011 09:30:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*AND (LTRIM(OL.cus_no) IN ('1575', '20938', '25000', '22056', '1100'))*/
ALTER VIEW [dbo].[WM_PO_BARCODING_WISYS]
AS
SELECT OH.ord_no, CASE WHEN ISNUMERIC(OH.cus_alt_adr_cd) = 1 THEN CAST(LEFT(OH.cus_alt_adr_cd, 6) AS int) ELSE '' END AS [Store #], 
               OL.cus_item_no AS [WM ITEM #], OL.item_no AS [MARCO ITEM #], OL.item_desc_1, CAST(OL.qty_ordered AS int) AS [Item Qty], 
               CASE WHEN OH.user_def_fld_4 LIKE '%PH%' THEN 'ELECTRONICS' WHEN OH.user_def_fld_4 LIKE '%EB%' THEN 'ELECTRONICS' WHEN OH.user_def_fld_4 LIKE '%BLUE%'
                THEN 'ELECTRONICS' ELSE 'FO' END AS Code, 
               CASE WHEN OH.user_def_fld_4 LIKE '%PH%' THEN 'ELECTRONICS' WHEN OH.user_def_fld_4 LIKE '%EB%' THEN 'ELECTRONICS' WHEN OH.user_def_fld_4 LIKE '%BLUE%'
                THEN 'ELECTRONICS' ELSE 'FOOD ORANGE' END AS [Dept.], 
               CASE WHEN OH.user_def_fld_4 LIKE '%ON%' THEN 'FIXTURE REQUEST' WHEN OH.user_def_fld_4 LIKE '%FR%' THEN 'FIXTURE REQUEST' END AS [Ord Type], 
               OH.oe_po_no AS [WM PO #], OL.loc, OH.ship_to_name, OH.ship_to_addr_1, OH.ship_to_addr_2, OH.ship_to_addr_3, OH.ship_to_addr_4, OH.ship_to_country
FROM  dbo.oeordhdr_sql AS OH INNER JOIN
               dbo.oeordlin_sql AS OL ON OH.ord_no = OL.ord_no
WHERE (OH.oe_po_no IS NOT NULL) AND (NOT (OL.prod_cat = '036' OR
               OL.prod_cat = '111' OR
               OL.prod_cat = '336' OR
               OL.prod_cat = '037'))

GO


