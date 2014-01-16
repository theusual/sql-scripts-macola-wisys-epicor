--ALTER VIEW BG_MASTER_SCHEDULE AS 

--Created:	02/01/11	     By:	BG
--Last Updated:	10/24/13	 By:	BG
--Purpose:	View for refeshable master schedule
--Last Change:  Added order #
--TODO: fix level 4 and 5 calculations for non-eaches
SELECT TOP 100 PERCENT *
FROM (
/*
select '1' AS LEVEL, OH.ord_no AS [ORDER#],OL.item_no AS [ITEM], 
		rtrim(OL.item_desc_1) AS RUN,
		IM.item_note_1 AS COLOR,
		rtrim(IM.item_desc_1) AS [ITEM DESC],
		rtrim(IM.item_desc_2) AS [SPECS],
		IM.drawing
		 OL.qty_to_ship AS [ITEM QTY],	
		  '00' AS QPP,
		  00 AS QTY,
		 '--' AS [ORIGIN],
		 '--' AS [WORK FLOW]
		 /*
		 '--' AS [WORK FLOW 3],
		 '--' AS [WORK FLOW 4]	
		 */	 
FROM  oeordlin_sql AS OL
	  JOIN OEORDHDR_SQL AS OH ON OH.ord_no = OL.ord_no AND OH.ord_type = OL.ord_type
WHERE OH.ord_no = '99999999' AND OH.ord_Type = 'O'
	AND OL.qty_to_ship > 0

UNION ALL

select '2' AS LEVEL, OH.ord_no AS [ORDER#], IM.item_no AS [ITEM], 
		rtrim(OL.item_no) AS RUN,
		IM.item_note_1 AS COLOR,
		rtrim(IM.item_desc_1) AS [ITEM DESC],
		rtrim(IM.item_desc_2) AS [SPECS],
		IM.drawing_release_no + '-'+IM.drawing_revision_no AS [DWG#],
		 (OL.qty_to_ship*BM.qty_per) AS [ITEM QTY],
		 BM.qty_per AS QPP,	
		 BM.qty AS QTY,
		 CASE WHEN BM.attach_oper_no >= 1000
			  THEN CAST(FLOOR(BM.attach_oper_no/1000) AS VARCHAR)
			  WHEN BM.attach_oper_no >= 100 
			  THEN CAST(FLOOR(BM.attach_oper_no/100) AS VARCHAR)
			  WHEN BM.attach_oper_no >= 10
			  THEN CAST(FLOOR(BM.attach_oper_no/10) AS VARCHAR)
			  WHEN BM.attach_oper_no >= 1
			  THEN CAST(FLOOR(BM.attach_oper_no) AS VARCHAR)
			  ELSE '--'
		 END AS [ORIGIN],
		 CASE WHEN BM.attach_oper_no >= 1000
			  THEN CAST(((BM.attach_oper_no/100) % 10) AS VARCHAR)
			  WHEN BM.attach_oper_no >= 100
			  THEN CAST(((BM.attach_oper_no/10) % 10) AS VARCHAR)
			  WHEN BM.attach_oper_no >= 10
			  THEN CAST((BM.attach_oper_no % 10) AS VARCHAR)
			  WHEN BM.attach_oper_no >= 1
			  THEN '--'
			  ELSE '--'
		 END AS [WORK FLOW],
		 BM.SEQ_NO
		 /*
		 CASE WHEN BM.attach_oper_no >= 1000
			  THEN CAST(((BM.attach_oper_no/10) % 10) AS VARCHAR)
			  WHEN BM.attach_oper_no >= 100
			  THEN CAST(((BM.attach_oper_no) % 10) AS VARCHAR)
			  WHEN BM.attach_oper_no >= 10
			  THEN '--'
			  WHEN BM.attach_oper_no >= 1
			  THEN '--'
			  ELSE '--'
		 END AS [WORK FLOW 3],
		 CASE WHEN BM.attach_oper_no >= 1000
			  THEN CAST(((BM.attach_oper_no) % 10) AS VARCHAR)
			  WHEN BM.attach_oper_no >= 100
			  THEN '--'
			  WHEN BM.attach_oper_no >= 10
			  THEN '--'
			  WHEN BM.attach_oper_no >= 1
			  THEN '--'
			  ELSE '--'
		 END AS [WORK FLOW 4]
		 */
FROM  oeordlin_sql AS OL 
		JOIN OEORDHDR_SQL AS OH ON OH.ord_no = OL.ord_no AND OH.ord_type = OL.ord_type
		JOIN IMORDBLD_SQL BM ON BM.line_no = OL.line_no AND BM.ord_no = OH.ord_no  AND BM.ord_type = OH.ord_type
		JOIN IMITMIDX_SQL IM ON IM.item_no = BM.item_no
WHERE OH.ord_no = '99999999' AND OH.ord_Type = 'O'
	AND OL.qty_to_ship > 0
	AND BM.qty_per > 0
	AND lvl_no = 1

UNION ALL
*/

select '2' AS LEVEL,
		OH.ord_no AS [ORDER#], 
		OH.cus_alt_adr_cd AS STORE#,
		OH.bill_to_name AS [CUS NAME],
		OH.shipping_dt AS [SHIP_DT],
		IM.item_no AS [ITEM], 
		rtrim(OL.item_desc_1) AS RUN,
		IM.item_note_1 AS COLOR,
		rtrim(IM.item_desc_1) AS [ITEM DESC],
		rtrim(IM.item_desc_2) AS [SPECS], 
		CASE WHEN IM.drawing_revision_no is null THEN IM.drawing_release_no
			 ELSE IM.drawing_release_no + '-'+IM.drawing_revision_no 
		END AS [DWG#],
		 BM.qty_per AS [TOT QTY],
		 CASE WHEN BM.mfg_uom = 'EA' 
			  THEN 'EA'
			  ELSE CAST(CAST(BM.qty_per/BM1.qty_per AS INT) AS VARCHAR)
		 END AS DIMS,	
		 CASE WHEN BM.mfg_uom = 'EA'
			  THEN BM.qty
			  ELSE BM1.qty_per
		 END AS QTY,
		 CASE WHEN BM.attach_oper_no >= 1000
			  THEN CAST(FLOOR(BM.attach_oper_no/1000) AS VARCHAR)
			  WHEN BM.attach_oper_no >= 100 
			  THEN CAST(FLOOR(BM.attach_oper_no/100) AS VARCHAR)
			  WHEN BM.attach_oper_no >= 10
			  THEN CAST(FLOOR(BM.attach_oper_no/10) AS VARCHAR)
			  WHEN BM.attach_oper_no >= 1
			  THEN CAST(FLOOR(BM.attach_oper_no) AS VARCHAR)
			  ELSE 0
		 END AS [ORIGIN ID],
		 CASE WHEN BM.attach_oper_no >= 1000
			  THEN CAST(((BM.attach_oper_no/100) % 10) AS VARCHAR)
			  WHEN BM.attach_oper_no >= 100
			  THEN CAST(((BM.attach_oper_no/10) % 10) AS VARCHAR)
			  WHEN BM.attach_oper_no >= 10
			  THEN CAST((BM.attach_oper_no % 10) AS VARCHAR)
			  WHEN BM.attach_oper_no >= 1
			  THEN 0
			  ELSE 0
		 END AS [WORK FLOW ID],
		 BM.SEQ_NO,
		 BM.mfg_uom AS UOM
		 /*
		 CASE WHEN BM.attach_oper_no >= 1000
			  THEN CAST(((BM.attach_oper_no/10) % 10) AS VARCHAR)
			  WHEN BM.attach_oper_no >= 100
			  THEN CAST(((BM.attach_oper_no) % 10) AS VARCHAR)
			  WHEN BM.attach_oper_no >= 10
			  THEN '--'
			  WHEN BM.attach_oper_no >= 1
			  THEN '--'
			  ELSE '--'
		 END AS [WORK FLOW 3],
		 CASE WHEN BM.attach_oper_no >= 1000
			  THEN CAST(((BM.attach_oper_no) % 10) AS VARCHAR)
			  WHEN BM.attach_oper_no >= 100
			  THEN '--'
			  WHEN BM.attach_oper_no >= 10
			  THEN '--'
			  WHEN BM.attach_oper_no >= 1
			  THEN '--'
			  ELSE '--'
		 END AS [WORK FLOW 4]
		 */
FROM  oeordlin_sql AS OL 
		JOIN OEORDHDR_SQL AS OH ON OH.ord_no = OL.ord_no AND OH.ord_type = OL.ord_type
		JOIN IMORDBLD_SQL BM ON BM.line_no = OL.line_no AND BM.ord_no = OH.ord_no  AND BM.ord_type = OH.ord_type
		JOIN IMORDBLD_SQL BM1 ON BM1.item_no = BM.par_item_no AND BM1.ord_no = BM.ord_no  AND BM1.ord_type = BM.ord_type AND BM1.lvl_no = 1 AND BM1.line_no = BM.line_no
		JOIN IMITMIDX_SQL IM ON IM.item_no = BM.item_no
WHERE --OH.ord_no = '99999999' AND 
		OH.ord_Type = 'O' 
	AND OL.qty_to_ship > 0
	AND BM.qty_per > 0
	AND IM.stocked_fg = 'Y'
	AND BM.lvl_no = 2
	AND BM1.qty > 0

UNION ALL

select '3' AS LEVEL, 
		OH.ord_no AS [ORDER#], 
		OH.cus_alt_adr_cd AS STORE#,
		OH.bill_to_name AS [CUS NAME],
		OH.shipping_dt AS [SHIP_DT],
		IM.item_no AS [ITEM], 
		rtrim(OL.item_desc_1) AS RUN,
		IM.item_note_1 AS COLOR,
		rtrim(IM.item_desc_1) AS [ITEM DESC],
		rtrim(IM.item_desc_2) AS [SPECS], 
		CASE WHEN IM.drawing_revision_no is null THEN IM.drawing_release_no
			 ELSE IM.drawing_release_no + '-'+IM.drawing_revision_no 
		END AS [DWG#],
		 BM.qty_per AS [TOT QTY],
		 CASE WHEN BM.mfg_uom = 'EA' 
			  THEN 'EA'
			  ELSE CAST(CAST(BM.qty_per/BM1.qty_per/BM2.qty_per AS INT) AS VARCHAR)
		 END AS DIMS,	
		 CASE WHEN BM.mfg_uom = 'EA'
			  THEN BM.qty
			  ELSE ROUND(BM.qty_per/BM1.qty_per,1)
		 END AS QTY,
		 CASE WHEN BM.attach_oper_no >= 1000
			  THEN CAST(FLOOR(BM.attach_oper_no/1000) AS VARCHAR)
			  WHEN BM.attach_oper_no >= 100 
			  THEN CAST(FLOOR(BM.attach_oper_no/100) AS VARCHAR)
			  WHEN BM.attach_oper_no >= 10
			  THEN CAST(FLOOR(BM.attach_oper_no/10) AS VARCHAR)
			  WHEN BM.attach_oper_no >= 1
			  THEN CAST(FLOOR(BM.attach_oper_no) AS VARCHAR)
			  ELSE 0
		 END AS [ORIGIN ID],
		 CASE WHEN BM.attach_oper_no >= 1000
			  THEN CAST(((BM.attach_oper_no/100) % 10) AS VARCHAR)
			  WHEN BM.attach_oper_no >= 100
			  THEN CAST(((BM.attach_oper_no/10) % 10) AS VARCHAR)
			  WHEN BM.attach_oper_no >= 10
			  THEN CAST((BM.attach_oper_no % 10) AS VARCHAR)
			  WHEN BM.attach_oper_no >= 1
			  THEN 0
			  ELSE 0
		 END AS [WORK FLOW ID],
		 BM.SEQ_NO,
		 BM.mfg_uom AS UOM
		 /*
		 CASE WHEN BM.attach_oper_no >= 1000
			  THEN CAST(((BM.attach_oper_no/10) % 10) AS VARCHAR)
			  WHEN BM.attach_oper_no >= 100
			  THEN CAST(((BM.attach_oper_no) % 10) AS VARCHAR)
			  WHEN BM.attach_oper_no >= 10
			  THEN '--'
			  WHEN BM.attach_oper_no >= 1
			  THEN '--'
			  ELSE '--'
		 END AS [WORK FLOW 3],
		 CASE WHEN BM.attach_oper_no >= 1000
			  THEN CAST(((BM.attach_oper_no) % 10) AS VARCHAR)
			  WHEN BM.attach_oper_no >= 100
			  THEN '--'
			  WHEN BM.attach_oper_no >= 10
			  THEN '--'
			  WHEN BM.attach_oper_no >= 1
			  THEN '--'
			  ELSE '--'
		 END AS [WORK FLOW 4]
		*/
FROM  oeordlin_sql AS OL 
		JOIN OEORDHDR_SQL AS OH ON OH.ord_no = OL.ord_no AND OH.ord_type = OL.ord_type
		JOIN IMORDBLD_SQL BM ON BM.line_no = OL.line_no AND BM.ord_no = OH.ord_no  AND BM.ord_type = OH.ord_type
		JOIN IMORDBLD_SQL BM2 ON BM2.item_no = BM.par_item_no AND BM2.ord_no = BM.ord_no  AND BM2.ord_type = BM.ord_type AND BM2.lvl_no = 2 AND BM2.line_no = BM.line_no
		JOIN IMORDBLD_SQL BM1 ON BM1.item_no = BM2.par_item_no AND BM1.ord_no = BM.ord_no  AND BM1.ord_type = BM.ord_type AND BM1.lvl_no = 1 AND BM1.line_no = BM.line_no
		JOIN IMITMIDX_SQL IM ON IM.item_no = BM.item_no
WHERE OH.ord_no = '99999999' AND OH.ord_Type = 'O' 
	AND OL.qty_to_ship > 0
	AND BM.qty_per > 0
	AND IM.stocked_fg = 'Y'
	AND BM.lvl_no = 3
	AND BM2.qty > 0

UNION ALL

select '4' AS LEVEL, 
		OH.ord_no AS [ORDER#], 
		OH.cus_alt_adr_cd AS STORE#,
		OH.bill_to_name AS [CUS NAME],
		OH.shipping_dt AS [SHIP_DT],
		IM.item_no AS [ITEM], 
		rtrim(OL.item_desc_1) AS RUN,
		IM.item_note_1 AS COLOR,		
		rtrim(IM.item_desc_1) AS [ITEM DESC],
		rtrim(IM.item_desc_2) AS [SPECS], 
		CASE WHEN IM.drawing_revision_no is null THEN IM.drawing_release_no
			 ELSE IM.drawing_release_no + '-'+IM.drawing_revision_no 
		END AS [DWG#],
		 BM.qty_per AS [TOT QTY],
		 CASE WHEN BM.mfg_uom = 'EA' 
			  THEN 'EA'
			  ELSE CAST(CAST(BM.qty_per/BM1.qty_per/BM2.qty_per/BM3.qty_per AS INT) AS VARCHAR)
		 END AS DIMS,	
		 CASE WHEN BM.mfg_uom = 'EA'
			  THEN BM.qty
			  ELSE ROUND(BM.qty_per/(BM.qty_per/BM1.qty_per/BM2.qty_per/BM3.qty_per),1)
		 END AS QTY,
		 CASE WHEN BM.attach_oper_no >= 1000
			  THEN CAST(FLOOR(BM.attach_oper_no/1000) AS VARCHAR)
			  WHEN BM.attach_oper_no >= 100 
			  THEN CAST(FLOOR(BM.attach_oper_no/100) AS VARCHAR)
			  WHEN BM.attach_oper_no >= 10
			  THEN CAST(FLOOR(BM.attach_oper_no/10) AS VARCHAR)
			  WHEN BM.attach_oper_no >= 1
			  THEN CAST(FLOOR(BM.attach_oper_no) AS VARCHAR)
			  ELSE 0
		 END AS [ORIGIN ID],
		 CASE WHEN BM.attach_oper_no >= 1000
			  THEN CAST(((BM.attach_oper_no/100) % 10) AS VARCHAR)
			  WHEN BM.attach_oper_no >= 100
			  THEN CAST(((BM.attach_oper_no/10) % 10) AS VARCHAR)
			  WHEN BM.attach_oper_no >= 10
			  THEN CAST((BM.attach_oper_no % 10) AS VARCHAR)
			  WHEN BM.attach_oper_no >= 1
			  THEN 0
			  ELSE 0
		 END AS [WORK FLOW ID],

		 BM.SEQ_NO,
		 BM.mfg_uom AS UOM
		 /*
		 CASE WHEN BM.attach_oper_no >= 1000
			  THEN CAST(((BM.attach_oper_no/10) % 10) AS VARCHAR)
			  WHEN BM.attach_oper_no >= 100
			  THEN CAST(((BM.attach_oper_no) % 10) AS VARCHAR)
			  WHEN BM.attach_oper_no >= 10
			  THEN '--'
			  WHEN BM.attach_oper_no >= 1
			  THEN '--'
			  ELSE '--'
		 END AS [WORK FLOW 3],
		 CASE WHEN BM.attach_oper_no >= 1000
			  THEN CAST(((BM.attach_oper_no) % 10) AS VARCHAR)
			  WHEN BM.attach_oper_no >= 100
			  THEN '--'
			  WHEN BM.attach_oper_no >= 10
			  THEN '--'
			  WHEN BM.attach_oper_no >= 1
			  THEN '--'
			  ELSE '--'
		 END AS [WORK FLOW 4]
		*/
FROM  oeordlin_sql AS OL 
		JOIN OEORDHDR_SQL AS OH ON OH.ord_no = OL.ord_no AND OH.ord_type = OL.ord_type
		JOIN IMORDBLD_SQL BM ON BM.line_no = OL.line_no AND BM.ord_no = OH.ord_no  AND BM.ord_type = OH.ord_type
		JOIN IMORDBLD_SQL BM3 ON BM3.item_no = BM.par_item_no AND BM3.ord_no = BM.ord_no  AND BM3.ord_type = BM.ord_type AND BM3.lvl_no = 3 AND BM3.line_no = BM.line_no
		JOIN IMORDBLD_SQL BM2 ON BM2.item_no = BM3.par_item_no AND BM2.ord_no = BM.ord_no  AND BM2.ord_type = BM.ord_type AND BM2.lvl_no = 2 AND BM2.line_no = BM.line_no
		JOIN IMORDBLD_SQL BM1 ON BM1.item_no = BM2.par_item_no AND BM1.ord_no = BM.ord_no  AND BM1.ord_type = BM.ord_type AND BM1.lvl_no = 1 AND BM1.line_no = BM.line_no
		JOIN IMITMIDX_SQL IM ON IM.item_no = BM.item_no
WHERE --OH.ord_no = '99999999' AND 
	OH.ord_Type = 'O' 
	AND OL.qty_to_ship > 0
	AND BM.qty_per > 0
	AND IM.stocked_fg = 'Y'
	AND BM.lvl_no = 4
	AND BM3.qty > 0
	) AS TEMP
	LEFT OUTER JOIN (SELECT 'OUT' AS [Origin],1 AS [OriginID]
		  UNION ALL
		  SELECT 'WH' AS [Origin],2 AS [OriginID]
		  UNION ALL
		  SELECT 'SAW' AS [Origin],3 AS [OriginID]
		  UNION ALL
		  SELECT 'N/A' AS [Origin],0 AS [OriginID]) AS TEMP2 ON TEMP.[ORIGIN ID] = TEMP2.OriginID
	LEFT OUTER JOIN (SELECT 'TIN' AS [WorkCenter],4 AS [WorkCenterID]
		  UNION ALL
		  SELECT 'FRA' AS [WorkCenter],5 AS [WorkCenterID]
		  UNION ALL
		  SELECT 'DR' AS [WorkCenter],6 AS [WorkCenterID]
		  UNION ALL
		  SELECT 'IN' AS [WorkCenter],7 AS [WorkCenterID]
		  UNION ALL
		  SELECT 'ECO' AS [WorkCenter],8 AS [WorkCenterID]
		  UNION ALL
		  SELECT 'N/A' AS [WorkCenter],0 AS [WorkCenterID]) AS TEMP3 ON TEMP.[WORK FLOW ID] = TEMP3.WorkCenterID
ORDER BY LEVEL, SEQ_NO
