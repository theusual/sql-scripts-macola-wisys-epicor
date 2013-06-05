SELECT DISTINCT
						 CASE WHEN (IMPAR.prod_cat like '6_%' AND IMPAR.prod_cat != '6') THEN IMPAR.item_no ELSE IMCOM.item_no END AS 'Infiniti Item', 
						CASE WHEN (IMPAR.prod_cat like '6_%' AND IMPAR.prod_cat != '6') THEN '' ELSE IMPAR.item_no END AS 'Marco Parent Item', 
				        OH.ord_no,
				       CAST((OL.qty_to_ship) AS INT) AS QTY, 
				        CONVERT(VARCHAR(10),OH.entered_dt,110) AS 'Entered Dt', 
				       CONVERT(VARCHAR(10),OH.shipping_dt,110) AS 'Shipping Dt', 
				       LTRIM(OH.cus_no) AS [Cus #], 
				        OH.ship_to_name, 
			           CASE WHEN OH.user_def_fld_5 is null THEN '?' ELSE OH.user_def_fld_5 END AS [CS Rep]
			            
		FROM				oeordhdr_sql      OH
		INNER JOIN			oeordlin_sql      OL
					ON		OH.ord_no = OL.ord_no
		LEFT OUTER JOIN			imitmidx_sql      IMPAR
				    ON		OL.item_no = IMPAR.item_no
		LEFT OUTER JOIN		bmprdstr_sql      BOM
					ON		OL.item_no = BOM.item_no
		LEFT OUTER JOIN			imitmidx_sql      IMCOM
					ON		BOM.comp_item_no = IMCOM.item_no
					
		WHERE		--OH.entered_dt > DATEADD(day, -7, GETDATE()) AND
					OH.ord_type = 'O'
					AND	(IMPAR.prod_cat LIKE '6_%' OR IMCOM.prod_cat LIKE '6_%')
					AND	(NOT (IMPAR.prod_cat = '6' OR IMCOM.prod_cat = '6') OR IMCOM.prod_Cat IS NULL)
					AND (BOM.comp_item_no not like 'SBB%' OR BOM.comp_item_no is null)
					AND NOT(OL.item_no like 'BROCHURE%')
					AND NOT(OL.prod_cat = '551')