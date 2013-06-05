    SELECT /*COUNT(distinct OH.ord_no)*/OH.ord_no, OH.shipping_dt,OH.cus_no, OL.item_no
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O'  
			   /*ONLY ORDERS SHIPPING YESTERDAY*/
			     AND (OH.shipping_dt = (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') 