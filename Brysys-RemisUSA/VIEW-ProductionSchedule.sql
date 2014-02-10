--ALTER VIEW BG_PRODUCTION_SCHEDULE AS 

--Created:	2/4/14    By:	BG
--Last Updated:	  	  By:	BG
--Purpose: View for REMIS Production Schedule
--Last Change: --

SELECT  OH.ord_no AS [OrderNo],
		OL.line_no AS [Line],
		OH.cus_alt_adr_cd AS StoreNo,
		OH.bill_to_name AS [CusName],
		OH.shipping_dt AS [ShipDt],
		OL.item_no AS [Run Code], 
		rtrim(OL.item_desc_1) AS [Run Descr],
		IM.item_note_1 AS Color,
		BM.Item AS Component,
		rtrim(IM.item_desc_1) AS [ComponentDescr],
		rtrim(IM.item_desc_2) AS [Specs], 
		CASE WHEN BM.[DWG#] is null THEN IM.drawing_release_no
			 ELSE BM.[DWG#]
		END AS [DrawingNo],
		--BM.[CUT L] AS DIMS,
		 CASE WHEN BM.DETAIL like '%X%' THEN BM.DETAIL
			  WHEN BM.[CUT L] IS NULL THEN ''
		      ELSE BM.[CUT L]
		 END AS DIMS,	
		 BM.Qty AS QTY,
		 CASE WHEN BM.ORIG=1 THEN 'OUT'
		      WHEN BM.ORIG=2 THEN 'WAR'
			  WHEN BM.ORIG=3 THEN 'SAW'
			  WHEN BM.ORIG=4 THEN 'TIN'
			  WHEN BM.ORIG=5 THEN 'FRAME'
			  WHEN BM.ORIG=6 THEN 'DOOR'
			  WHEN BM.ORIG=7 THEN 'INSTALL'
			  WHEN BM.ORIG=8 THEN 'ECOSAFE'
		 END AS [ORIGIN],
		 CASE WHEN BM.DEST=1 THEN 'OUT'
		      WHEN BM.DEST=2 THEN 'WAR'
			  WHEN BM.DEST=3 THEN 'SAW'
			  WHEN BM.DEST=4 THEN 'TIN'
			  WHEN BM.DEST=5 THEN 'FRAME'
			  WHEN BM.DEST=6 THEN 'DOOR'
			  WHEN BM.DEST=7 THEN 'INSTALL'
			  WHEN BM.DEST=8 THEN 'ECOSAFE'
		 END AS [DESTINATION],
		 BM.SUOM AS UOM
FROM OEORDHDR_SQL OH JOIN OEORDLIN_SQL OL ON OL.ord_no = OH.ord_no
					 LEFT OUTER JOIN [BG_BOM_TEMPLATE] BM ON ltrim(BM.[Order]) = ltrim(OH.ord_no) AND ltrim(BM.[Order Line]) = ltrim(OL.line_seq_no)
					 LEFT OUTER JOIN IMITMIDX_SQL IM ON IM.item_no = BM.Item				 