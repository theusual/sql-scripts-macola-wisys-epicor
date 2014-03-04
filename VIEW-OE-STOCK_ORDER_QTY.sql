--ALTER VIEW [BG_OE_STOCK_ORDER_QTY] AS

--Created:	02/26/14	 By:	BG
--Last Updated:	--		 By:	BG
--Purpose: Order count 
--Last Change: 

SELECT	OL.item_no, SUM(qty_to_ship) AS QTY
FROM          oeordlin_sql ol WITH(NOLOCK) JOIN
									oeordhdr_sql oh WITH(NOLOCK) ON oh.ord_no = ol.ord_no JOIN
									imitmidx_Sql IM WITH(NOLOCK) ON IM.item_no = ol.item_no
WHERE      ltrim(oh.cus_no) = '999999'
		--Test
		--AND OL.item_no like 'MZ%'
GROUP BY OL.item_no