    SELECT COUNT(distinct OL.item_no)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*ONLY ORDERS SHIPPING LATE*/
			     AND (OH.shipping_dt >= (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			   /*ONLY ORDERS SHIPPED TODAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET')

