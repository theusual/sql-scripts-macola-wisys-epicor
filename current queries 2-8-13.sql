--WMPO Checking--------------------------------------------------------------------------
SELECT * FROM dbo.oeordhdr_SQL WHERE oe_po_no = '31748801'
SELECT * FROM dbo.OEHDRHST_SQL WHERE oe_po_no LIKE '31748801%'
SELECT * FROM dbo.oelinhst_sql WHERE ord_no = '  701811' 
SELECT * FROM dbo.oeordlin_sql WHERE ord_no = '  701266' AND cus_item_no = '100033842'
SELECT * FROM wspikpak WHERE ord_no = '  701266' AND line_no = 7

UPDATE dbo.oehdrhst_sql
SET cus_alt_adr_cd = '5843'             
WHERE   ord_no = '  701517'

SELECT * FROM dbo.BG_WMPO WHERE [Supplier Sales/Work Order Number] = '701517'
-------------------------------------------------------------------------------

SELECT * FROM dbo.poordlin_sql WHERE item_no = 'HARDW-4044'
SELECT * FROM dbo.poordlin_sql WHERE ord_no LIKE '%122669%'
SELECT * FROM dbo.poordhdr_sql WHERE ord_no = ' 1056800'

SELECT quantity, IM.item_no, doc_type, trx_Dt, *
FROM [020].dbo.iminvtrx_sql TRX
	JOIN [001].dbo.IMITMIDX_SQL IM ON IM.item_no = TRX.item_no
WHERE IM.item_note_3 = 'KPB' AND IM.item_note_1 = 'CH' 
	  AND doc_type IN ('R','Q')
	  AND (LTRIM(vend_no) NOT IN ('181','2666') OR vend_no IS NULL)
	 



SELECT * FROM dbo.poordlin_sql
WHERE item_no IN ('HARDW-4044', 'HARDW-4045', 'HARDW-4099') AND qty_received < qty_ordered


SELECT item_no, SUM(qty_received) AS TOTQTY 
FROM dbo.imrechst_sql WHERE item_no IN ('HARDW-4044', 'HARDW-4045', 'HARDW-4099')
GROUP BY item_no

UPDATE oelinhst_Sql 
SET cus_item_no = '100034617'
WHERE ord_no = '  701952'

SELECT * FROM BG_wmpo WHERE [Supplier Sales/Work Order Number] = '701952'