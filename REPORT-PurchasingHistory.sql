SELECT PL.item_no, PL.item_desc_1, PL.item_desc_2,PL.act_unit_cost, PH.ord_no, PL.qty_ordered, PH.ord_dt, YEAR(ord_dt) AS Year, 
				ltrim(PH.vend_no) AS vend_no, CH.vend_name, IM.prod_cat, OE.price
FROM dbo.poordlin_sql PL JOIN dbo.poordhdr_sql PH ON PH.ord_no = PL.ord_no 
						 JOIN dbo.imitmidx_sql IM ON IM.item_no = PL.item_no 
						 JOIN BG_CH_Vendors CH ON CH.vend_no = ltrim(PH.vend_no)
						 LEFT OUTER JOIN 
						 (SELECT OL.item_no, YEAR(inv_dt) AS YEAR, AVG(OL.unit_price) AS price
							FROM oehdrhst_sql OH JOIN oelinhst_sql OL ON OL.inv_no = OH.inv_no
							WHERE OL.qty_to_ship > 1 
							GROUP BY OL.item_no, YEAR(OH.inv_dt)
							--ORDER BY OL.item_no
							) AS OE ON OE.item_no = PL.item_no AND OE.YEAR = YEAR(ord_dt)
WHERE qty_received > 1 AND act_unit_cost > 0 
				AND PL.item_no IN (select  PL.item_no  
									FROM dbo.poordlin_sql PL JOIN dbo.poordhdr_sql PH ON PH.ord_no = PL.ord_no 
																JOIN dbo.imitmidx_sql IM ON IM.item_no = PL.item_no 
																JOIN BG_CH_Vendors CH ON CH.vend_no = ltrim(PH.vend_no)
									WHERE ord_dt > '01/01/2013')
				AND PL.item_no IN (select  PL.item_no  
									FROM dbo.poordlin_sql PL JOIN dbo.poordhdr_sql PH ON PH.ord_no = PL.ord_no 
																JOIN dbo.imitmidx_sql IM ON IM.item_no = PL.item_no 
																JOIN BG_CH_Vendors CH ON CH.vend_no = ltrim(PH.vend_no)
									WHERE ord_dt < '01/01/2013')



