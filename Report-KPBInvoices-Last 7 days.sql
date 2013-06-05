ALTER VIEW BG_KPB_INVOICES_LAST_7_DAYS AS 

--Created:	08/30/12	 By:	BG
--Last Updated:	08/30/12	 By:	BG
--Purpose:	View for KPB orders
--Last Change:  

SELECT TOP 10000000 OH.Ord_No,	OH.inv_no,	oe_po_no,  inv_dt,	ord_dt_billed,	OH.Cus_no,	Bill_To_Name,	Ship_To_Name,	cus_alt_adr_cd,	ship_to_addr_4,	OL.Item_No,	OL.Item_Desc_1,	qty_to_ship,	Unit_Price,	unit_price * qty_to_ship AS Total, 
	CASE WHEN OL.item_no IN ('KR1315290', 'KR1315252', 'KR1315290', 'KB1318610', 'KB1318553','KR1318801','KB1318800','KB1318609','KB1318609','KB1319964','KB1319968','KB1319965','KR1315292','KR1315291') THEN 'DEC' 
		 WHEN (OL.item_Desc_1 LIKE '%ENDCAP%' OR OL.item_desc_1 LIKE '%END CAP%') THEN 'MW' ELSE 'DEC' 
	END AS [MW/DEC]
FROM oehdrhst_sql OH JOIN dbo.oelinhst_sql OL ON OH.inv_no = OL.inv_no JOIN dbo.imitmidx_sql IM ON IM.item_no = OL.item_no 
WHERE IM.item_note_3 = 'KPB' AND ord_dt_Billed > DATEADD(DAY,-7,GETDATE()) ORDER BY ord_Dt_billed DESC