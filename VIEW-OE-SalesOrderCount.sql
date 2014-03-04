--ALTER VIEW [BG_OE_SALESORDER_COUNT_YTD] AS

--Created:	02/26/14	 By:	BG
--Last Updated:	--		 By:	BG
--Purpose: Order count 
--Last Change: 

SELECT item_no, COUNT(oe_po_no) AS [COUNT]
FROM (
			SELECT     ol.item_no , OH.oe_po_no
			FROM          oelinhst_sql ol WITH(NOLOCK) JOIN
									oehdrhst_sql oh WITH(NOLOCK) ON oh.inv_no = ol.inv_no JOIN
									imitmidx_Sql IM WITH(NOLOCK) ON IM.item_no = ol.item_no
			WHERE      YEAR(OH.inv_dt) = YEAR(GETDATE())  
						AND orig_ord_type IN ('O', 'I', 'C', 'Q')					
						--VERY important for obvious reasons:
						AND ol.loc NOT IN ('CAN', 'IN', 'BR') 
						--Exclude KPB items sold to Inf
						AND NOT (ltrim(oh.cus_no) = '22523' AND IM.item_note_3 = 'KPB') 
			UNION ALL
			SELECT     ol.item_no , OH.oe_po_no
			FROM         oeordlin_sql ol WITH(NOLOCK) JOIN
									imitmidx_Sql IM WITH(NOLOCK) ON IM.item_no = ol.item_no JOIN
									oeordhdr_Sql oh WITH(NOLOCK) ON oh.ord_no = ol.ord_no JOIN
									wspikpak pp WITH(NOLOCK) ON pp.ord_no = ol.ord_no AND pp.line_no = ol.line_no
			WHERE       shipped = 'Y' 
						--VERY important for obvious reasons:
						AND ol.loc NOT IN ('CAN', 'IN', 'BR') 
						--Exclude KPB items sold to Inf
						AND NOT (ltrim(oh.cus_no) = '22523' AND IM.item_note_3 = 'KPB')
         ) AS TEMP
GROUP BY item_no
