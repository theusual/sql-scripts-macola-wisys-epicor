SELECT PH.ord_dt, LEFT(PH.ord_no,6) AS [PO#], PL.line_no, LTRIM(PH.vend_no) AS Vend#, rtrim(AP.vend_name) AS [Vend Name], 
	RTRIM(PL.item_no) as Item, RTRIM(PL.item_desc_1) as Desc1, RTRIM(PL.item_desc_2) as Desc2, PL.uom, PL.act_unit_cost, 
	PL.stk_loc, PL.qty_ordered, PL.qty_received, PL.receipt_dt, AM.faktuurnr
FROM poordlin_sql PL JOIN poordhdr_sql PH ON PL.ord_no = PH.ord_no 
	JOIN apvenfil_sql AP ON AP.vend_no = PH.vend_no 
	JOIN amutas AM ON AM.bkstnr_vrz = PH.ord_no AND AM.artcode = PL.item_no
	LEFT OUTER JOIN dbo.imrechst_sql REC ON REC.ord_no = PL.ord_no AND REC.line_no = PL.line_no
WHERE --PL.item_no IN (LIST ITEMS HERE) AND
		PL.ord_status <> 'X' AND PL.qty_received > 0 
		AND faktuurnr = '  438122'
		--AND PL.receipt_dt < '1/1/2012'
		--AND AM.regel IN (1, 3)
		
		SELECT * FROM dbo.amutas WHERE faktuurnr = '  438122'
		SELECT * FROM dbo.gbkmut WHERE faktuurnr = '  438122'
		SELECT * FROM dbo.amutak WHERE faktuurnr = '  438122'

