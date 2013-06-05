USE [020]

GO

--ALTER VIEW BG_LateOrderReport_Inf AS 

--Created:	10/19/12  By:	BG
--Last Updated:	  	  By:	BG
--Purpose: View for late order report		
--Last Change: --

SELECT DISTINCT 
               OH.shipping_dt AS [Order Shipping Date], LTRIM(OH.ord_no) AS [Order], OH.job_no AS [Job #], RTRIM(JOB.job_desc) AS [Job Desc], LTRIM(OH.cus_no) AS [Cust #], 
               RTRIM(OH.bill_to_name) AS [Bill To], RTRIM(OH.ship_to_name) AS [Ship To], RTRIM(OH.oe_po_no) AS [PO #], RTRIM(OH.cus_alt_adr_cd) AS [Cust Alt Addr], 
               RTRIM(OH.ship_to_addr_2) AS [Ship To Addr2], CASE WHEN OC2.cmt IS NULL THEN '' ELSE OC2.cmt END AS [HDR CMT], RTRIM(OH.ship_instruction_1) 
               AS [Ship n1], RTRIM(OH.ship_instruction_2) AS [Ship n2], OL.line_no, RTRIM(OL.item_no) AS Item, OL.unit_price AS Price, OL.qty_to_ship AS Qty, 
               RTRIM(OL.item_desc_1) AS Desc1, RTRIM(OL.item_desc_2) AS Desc2, OL.prod_cat, OL.unit_price * OL.qty_to_ship AS ExtPrc, CASE WHEN OC.cmt_seq_no IS NULL
                THEN '' ELSE OC.cmt_seq_no END AS [Cmt Seq#], CASE WHEN OC.cmt IS NULL THEN '' ELSE OC.cmt END AS [LN CMT], OH.cmt_2 AS [Invoicing Comment]
FROM  dbo.oeordhdr_sql AS OH INNER JOIN
               dbo.oeordlin_sql AS OL ON OH.ord_no = OL.ord_no LEFT OUTER JOIN
               dbo.jobfile_sql AS JOB ON JOB.job_no = OH.job_no LEFT OUTER JOIN
               dbo.OELINCMT_SQL AS OC ON OC.ord_no = OH.ord_no AND OC.line_seq_no = OL.line_no LEFT OUTER JOIN
               dbo.OELINCMT_SQL AS OC2 ON OC2.ord_no = OH.ord_no AND OC2.line_seq_no = 0
WHERE (OH.ord_type = 'O') AND (OH.status < 8) AND (OL.user_def_fld_3 IS NULL) AND (OH.shipping_dt < DATEADD(DAY, - 3, GETDATE()))