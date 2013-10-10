SELECT OH.ord_no, oe_po_no, OL.item_no, OH.shipping_dt, OH.entered_dt
FROM         dbo.oeordlin_sql AS OL 
			INNER JOIN dbo.oeordhdr_sql AS OH ON OL.ord_no = OH.ord_no 
WHERE     (OH.ord_type = 'O') 
			AND ltrim(OH.cus_no) IN ('1575', '20938') 
			AND (OH.shipping_dt - OH.ord_dt) < 8 
			AND (CONVERT(varchar, CAST(rtrim(OH.entered_dt) AS datetime), 101) > DATEADD(day, -30, GETDATE()))


			select * 
			from oeordlin_sql OL JOIN oeordhdr_sql OH ON OH.ord_no = OL.ord_no 
			WHERE item_no = 'MDWM-0025 SB' AND qty_to_ship = 0

			select * from wspikpak WHERE ord_no = '  713396'
