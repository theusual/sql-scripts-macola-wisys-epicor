CREATE VIEW BG_InfinitiOrdersLast7Days

AS

--Created:	8/26/2011	By:	AA
--Last Updated: 7/23/2012	By: BG
--Purpose:	Notification that pulls Infiniti items ordered in last 7 days.
--Last Update:  Added Comments, Fixed joining error -- only items containing BOMs were pulling

SELECT DISTINCT
						CASE WHEN (IMPAR.prod_cat like '6_%' AND IMPAR.prod_cat != '6') THEN IMPAR.item_no ELSE IMCOM.item_no END AS Item, 
						CASE WHEN (IMPAR.prod_cat like '6_%' AND IMPAR.prod_cat != '6') THEN '' ELSE IMPAR.item_no END AS ComponentItem,
				        OH.ord_no,
				        CAST((OL.qty_to_ship) AS INT) Qty, 
				        CONVERT(VARCHAR(10),OH.entered_dt,110) AS EnteredDt, 
				        CONVERT(VARCHAR(10),OH.shipping_dt,110) AS ShippingDt, 
				        OH.cus_no, 
				        OH.ship_to_name,
			            CASE WHEN OH.user_def_fld_5 is null THEN '?' ELSE OH.user_def_fld_5 END AS INITIALS,
			            CASE WHEN CMT.cmt IS NULL THEN 'NONE' ELSE CMT.cmt END AS COMMENTS
			            	            
		FROM				oeordhdr_sql      OH
		INNER JOIN			oeordlin_sql      OL
					ON		OH.ord_no = OL.ord_no
		LEFT OUTER JOIN			imitmidx_sql      IMPAR
				    ON		OL.item_no = IMPAR.item_no
		LEFT OUTER JOIN		bmprdstr_sql      BOM
					ON		OL.item_no = BOM.item_no
		LEFT OUTER JOIN			imitmidx_sql      IMCOM
					ON		BOM.comp_item_no = IMCOM.item_no
		LEFT OUTER JOIN     dbo.OELINCMT_SQL CMT
					ON		CMT.ord_no = OH.ord_no
					
		WHERE		OH.entered_dt > DATEADD(day, -7, GETDATE())
					AND	OH.ord_type = 'O'
					AND	(IMPAR.prod_cat LIKE '6_%' OR IMCOM.prod_cat LIKE '6_%')
					AND	(NOT (IMPAR.prod_cat = '6' OR IMCOM.prod_cat = '6') OR IMCOM.prod_Cat IS NULL)
					AND (BOM.comp_item_no not like 'SBB%' OR BOM.comp_item_no is null)
					AND NOT(OL.item_no like 'BROCHURE%')
					AND NOT(OL.prod_cat = '551')


