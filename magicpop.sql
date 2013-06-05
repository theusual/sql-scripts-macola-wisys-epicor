select distinct CASE WHEN (IMPAR.prod_cat like '6_%' AND IMPAR.prod_cat != '6') THEN IMPAR.item_no ELSE IMCOM.item_no END,
						IMPAR.item_no, 
				        OH.ord_no, 
				         CAST((OL.qty_to_ship) AS INT), 
				         CONVERT(VARCHAR(10),OH.entered_dt,110), 
				        CONVERT(VARCHAR(10),OH.shipping_dt,110), 
				       OH.cus_no, 
				        OH.ship_to_name, 
			             CASE WHEN OH.user_def_fld_5 is null THEN '?' ELSE OH.user_def_fld_5 END
			            
			     FROM			oeordhdr_sql      OH
				INNER JOIN      oeordlin_sql      OL
							ON	OH.ord_no = OL.ord_no
				INNER JOIN      imitmidx_sql      IMPAR
							ON	OL.item_no = IMPAR.item_no
				LEFT OUTER JOIN	bmprdstr_sql      BOM
							ON	OL.item_no = BOM.item_no
				INNER JOIN      imitmidx_sql      IMCOM
							ON	BOM.comp_item_no = IMCOM.item_no
                
WHERE			OH.entered_dt > DATEADD(day, -8, GETDATE())
			AND	OH.ord_type = 'O'
			AND	(IMPAR.prod_cat LIKE '6_%' OR IMCOM.prod_cat LIKE '6_%')
			AND	NOT (IMPAR.prod_cat = '6' OR IMCOM.prod_cat = '6')
			AND BOM.comp_item_no not like 'SBB%'


ORDER BY		OH.shipping_dt, OH.ord_no


SELECT  *
FROM    oeordlin_sql ol join oeordhdr_sql oh on oh.ord_no = ol.ord_no
where item_no like 'magic%'

SELECT  *
FROM    bmprdstr_sql
where item_no = 'MICRO-STAND KM'