USE [020]

GO

--ALTER VIEW BG_SHIPPING_FORM AS 

--Created:	09/25/12  By:	BG
--Last Updated:	  	  By:	BG
--Purpose: View for Access Shipping Form		
--Last Change: --


SELECT TOP 100 PERCENT OL.user_def_fld_2  AS Shipped, OH.shipping_dt AS ShipDate, LTRIM(OH.ord_no) AS [Order], 
						OH.ship_to_name AS ShipTo, OH.cus_alt_adr_cd AS Store, 
						OH.ship_via_cd AS Carrier, OL.prod_cat AS ProdCat, OL.item_no AS Item, OL.item_desc_1 AS Description1, 
						OL.item_desc_2, OL.qty_ordered, OL.line_no AS Line, OL.user_Def_Fld_3 AS [ShippedDate], OL.user_def_fld_4 AS [Carrier/Tracking],
						CASE WHEN OL.extra_5 IS NULL THEN 'N' ELSE OL.extra_5 END AS ShpFlag, OH.job_no
FROM  dbo.oeordhdr_sql AS OH 
			INNER JOIN dbo.oeordlin_sql AS OL ON OH.ord_type = OL.ord_type AND OH.ord_no = OL.ord_no 
			--LEFT OUTER JOIN dbo.arcusfil_sql AS AR ON AR.cus_no = OH.cus_no
            LEFT OUTER JOIN dbo.jobfile_sql JOB ON JOB.job_no = OH.job_no 
            --LEFT OUTER JOIN dbo.OELINCMT_SQL CMT ON CMT.ord_no = OH.ord_no AND CMT.line_seq_no = OL.line_no
WHERE (OH.ord_type = 'O')
		 --AND (OL.item_no NOT LIKE '%TEST%') 
		 AND (OH.status < 8) 
		 --Take off order marked as shipped
		 --AND (NOT (OL.user_def_fld_2 LIKE '%S%') OR OL.user_def_fld_2 IS NULL)
ORDER BY LTRIM(OH.ord_no)


