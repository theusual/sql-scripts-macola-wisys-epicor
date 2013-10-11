--ALTER VIEW BG_MASTER_SCHEDULE AS 

--Created:	02/01/11	 By:	BG
--Last Updated:	10/11/13	 By:	BG
--Purpose:	View for refeshable master schedule
--Last Change:  Added order #
--TODO: fix level 4 and 5 calculations for non-eaches

SELECT TOP 100 PERCENT *
FROM (
/*
select '1' AS LEVEL, OH.ord_no AS [ORDER#],OL.item_no AS [ITEM], 
		rtrim(OL.item_no) AS RUN,
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
*/
select '2' AS LEVEL, OH.ord_no AS [ORDER#], IM.item_no AS [ITEM], 
		rtrim(OL.item_no) AS RUN,
		IM.item_note_1 AS COLOR,
		rtrim(IM.item_desc_1) AS [ITEM DESC],
		rtrim(IM.item_desc_2) AS [SPECS],
		IM.drawing_release_no + '-'+IM.drawing_revision_no AS [DWG#],
		 (OL.qty_to_ship*BM1.qty_per) AS [ITEM QTY],
		 BM1.qty_per AS QPP,	
		 BM1.qty AS QTY,
		 CASE WHEN BM1.attach_oper_no >= 1000
			  THEN CAST(FLOOR(BM1.attach_oper_no/1000) AS VARCHAR)
			  WHEN BM1.attach_oper_no >= 100 
			  THEN CAST(FLOOR(BM1.attach_oper_no/100) AS VARCHAR)
			  WHEN BM1.attach_oper_no >= 10
			  THEN CAST(FLOOR(BM1.attach_oper_no/10) AS VARCHAR)
			  WHEN BM1.attach_oper_no >= 1
			  THEN CAST(FLOOR(BM1.attach_oper_no) AS VARCHAR)
			  ELSE '--'
		 END AS [ORIGIN],
		 CASE WHEN BM1.attach_oper_no >= 1000
			  THEN CAST(((BM1.attach_oper_no/100) % 10) AS VARCHAR)
			  WHEN BM1.attach_oper_no >= 100
			  THEN CAST(((BM1.attach_oper_no/10) % 10) AS VARCHAR)
			  WHEN BM1.attach_oper_no >= 10
			  THEN CAST((BM1.attach_oper_no % 10) AS VARCHAR)
			  WHEN BM1.attach_oper_no >= 1
			  THEN '--'
			  ELSE '--'
		 END AS [WORK FLOW],
		 BM1.SEQ_NO
		 /*
		 CASE WHEN BM1.attach_oper_no >= 1000
			  THEN CAST(((BM1.attach_oper_no/10) % 10) AS VARCHAR)
			  WHEN BM1.attach_oper_no >= 100
			  THEN CAST(((BM1.attach_oper_no) % 10) AS VARCHAR)
			  WHEN BM1.attach_oper_no >= 10
			  THEN '--'
			  WHEN BM1.attach_oper_no >= 1
			  THEN '--'
			  ELSE '--'
		 END AS [WORK FLOW 3],
		 CASE WHEN BM1.attach_oper_no >= 1000
			  THEN CAST(((BM1.attach_oper_no) % 10) AS VARCHAR)
			  WHEN BM1.attach_oper_no >= 100
			  THEN '--'
			  WHEN BM1.attach_oper_no >= 10
			  THEN '--'
			  WHEN BM1.attach_oper_no >= 1
			  THEN '--'
			  ELSE '--'
		 END AS [WORK FLOW 4]
		 */
FROM  oeordlin_sql AS OL 
		JOIN OEORDHDR_SQL AS OH ON OH.ord_no = OL.ord_no AND OH.ord_type = OL.ord_type
		JOIN IMORDBLD_SQL BM1 ON BM1.line_no = OL.line_no AND BM1.ord_no = OH.ord_no  AND BM1.ord_type = OH.ord_type
		JOIN IMITMIDX_SQL IM ON IM.item_no = BM1.item_no
WHERE OH.ord_no = '99999999' AND OH.ord_Type = 'O'
	AND OL.qty_to_ship > 0
	AND BM1.qty_per > 0
	AND lvl_no = 1

UNION ALL

select '3' AS LEVEL, OH.ord_no AS [ORDER#], IM.item_no AS [ITEM], 
		rtrim(OL.item_no) AS RUN,
		IM.item_note_1 AS COLOR,
		rtrim(IM.item_desc_1) AS [ITEM DESC],
		rtrim(IM.item_desc_2) AS [SPECS], 
		IM.drawing_release_no + '-'+IM.drawing_revision_no AS [DWG#],
		 (OL.qty_to_ship*BM1.qty_per) AS [ITEM QTY],
		 BM1.qty_per AS QPP,	
		 CASE WHEN BM1.mfg_uom = 'EA'
			  THEN BM1.qty
			  ELSE (BM1.qty) / (BM1.qty_per / BM2.qty_per)
		 END AS QTY,
		 CASE WHEN BM1.attach_oper_no >= 1000
			  THEN CAST(FLOOR(BM1.attach_oper_no/1000) AS VARCHAR)
			  WHEN BM1.attach_oper_no >= 100 
			  THEN CAST(FLOOR(BM1.attach_oper_no/100) AS VARCHAR)
			  WHEN BM1.attach_oper_no >= 10
			  THEN CAST(FLOOR(BM1.attach_oper_no/10) AS VARCHAR)
			  WHEN BM1.attach_oper_no >= 1
			  THEN CAST(FLOOR(BM1.attach_oper_no) AS VARCHAR)
			  ELSE '--'
		 END AS [ORIGIN],
		 CASE WHEN BM1.attach_oper_no >= 1000
			  THEN CAST(((BM1.attach_oper_no/100) % 10) AS VARCHAR)
			  WHEN BM1.attach_oper_no >= 100
			  THEN CAST(((BM1.attach_oper_no/10) % 10) AS VARCHAR)
			  WHEN BM1.attach_oper_no >= 10
			  THEN CAST((BM1.attach_oper_no % 10) AS VARCHAR)
			  WHEN BM1.attach_oper_no >= 1
			  THEN '--'
			  ELSE '--'
		 END AS [WORK FLOW],
		 BM1.SEQ_NO
		 /*
		 CASE WHEN BM1.attach_oper_no >= 1000
			  THEN CAST(((BM1.attach_oper_no/10) % 10) AS VARCHAR)
			  WHEN BM1.attach_oper_no >= 100
			  THEN CAST(((BM1.attach_oper_no) % 10) AS VARCHAR)
			  WHEN BM1.attach_oper_no >= 10
			  THEN '--'
			  WHEN BM1.attach_oper_no >= 1
			  THEN '--'
			  ELSE '--'
		 END AS [WORK FLOW 3],
		 CASE WHEN BM1.attach_oper_no >= 1000
			  THEN CAST(((BM1.attach_oper_no) % 10) AS VARCHAR)
			  WHEN BM1.attach_oper_no >= 100
			  THEN '--'
			  WHEN BM1.attach_oper_no >= 10
			  THEN '--'
			  WHEN BM1.attach_oper_no >= 1
			  THEN '--'
			  ELSE '--'
		 END AS [WORK FLOW 4]
		 */
FROM  oeordlin_sql AS OL 
		JOIN OEORDHDR_SQL AS OH ON OH.ord_no = OL.ord_no AND OH.ord_type = OL.ord_type
		JOIN IMORDBLD_SQL BM1 ON BM1.line_no = OL.line_no AND BM1.ord_no = OH.ord_no  AND BM1.ord_type = OH.ord_type
		JOIN IMORDBLD_SQL BM2 ON BM2.item_no = BM1.par_item_no AND BM2.ord_no = BM1.ord_no  AND BM2.ord_type = BM1.ord_type AND BM2.lvl_no = 1 AND BM2.line_no = BM1.line_no
		JOIN IMITMIDX_SQL IM ON IM.item_no = BM1.item_no
WHERE OH.ord_no = '99999999' AND OH.ord_Type = 'O' 
	AND OL.qty_to_ship > 0
	AND BM1.qty_per > 0
	AND BM1.lvl_no = 2


UNION ALL

select '4' AS LEVEL, OH.ord_no AS [ORDER#], IM.item_no AS [ITEM], 
		rtrim(OL.item_no) AS RUN,
		IM.item_note_1 AS COLOR,
		rtrim(IM.item_desc_1) AS [ITEM DESC],
		rtrim(IM.item_desc_2) AS [SPECS],
		IM.drawing_release_no + '-'+IM.drawing_revision_no AS [DWG#],
		 BM1.qty AS [ITEM QTY],
		 BM1.qty_per AS QPP,
		 CASE WHEN BM1.mfg_uom = 'EA'
			  THEN BM1.qty
			  ELSE (BM1.qty) / (BM1.qty_per)
		 END AS QTY,
		 CASE WHEN BM1.attach_oper_no >= 1000
			  THEN CAST(FLOOR(BM1.attach_oper_no/1000) AS VARCHAR)
			  WHEN BM1.attach_oper_no >= 100 
			  THEN CAST(FLOOR(BM1.attach_oper_no/100) AS VARCHAR)
			  WHEN BM1.attach_oper_no >= 10
			  THEN CAST(FLOOR(BM1.attach_oper_no/10) AS VARCHAR)
			  WHEN BM1.attach_oper_no >= 1
			  THEN CAST(FLOOR(BM1.attach_oper_no) AS VARCHAR)
			  ELSE '--'
		 END AS [ORIGIN],
		 CASE WHEN BM1.attach_oper_no >= 1000
			  THEN CAST(((BM1.attach_oper_no/100) % 10) AS VARCHAR)
			  WHEN BM1.attach_oper_no >= 100
			  THEN CAST(((BM1.attach_oper_no/10) % 10) AS VARCHAR)
			  WHEN BM1.attach_oper_no >= 10
			  THEN CAST((BM1.attach_oper_no % 10) AS VARCHAR)
			  WHEN BM1.attach_oper_no >= 1
			  THEN '--'
			  ELSE '--'
		 END AS [WORK FLOW],
		 BM1.SEQ_NO
		 /*
		 CASE WHEN BM1.attach_oper_no >= 1000
			  THEN CAST(((BM1.attach_oper_no/10) % 10) AS VARCHAR)
			  WHEN BM1.attach_oper_no >= 100
			  THEN CAST(((BM1.attach_oper_no) % 10) AS VARCHAR)
			  WHEN BM1.attach_oper_no >= 10
			  THEN '--'
			  WHEN BM1.attach_oper_no >= 1
			  THEN '--'
			  ELSE '--'
		 END AS [WORK FLOW 3],
		 CASE WHEN BM1.attach_oper_no >= 1000
			  THEN CAST(((BM1.attach_oper_no) % 10) AS VARCHAR)
			  WHEN BM1.attach_oper_no >= 100
			  THEN '--'
			  WHEN BM1.attach_oper_no >= 10
			  THEN '--'
			  WHEN BM1.attach_oper_no >= 1
			  THEN '--'
			  ELSE '--'
		 END AS [WORK FLOW 4]
		*/
FROM  oeordlin_sql AS OL 
		JOIN OEORDHDR_SQL AS OH ON OH.ord_no = OL.ord_no AND OH.ord_type = OL.ord_type
		JOIN IMORDBLD_SQL BM1 ON BM1.line_no = OL.line_no AND BM1.ord_no = OH.ord_no  AND BM1.ord_type = OH.ord_type
		--JOIN IMORDBLD_SQL BM2 ON BM2.item_no = BM1.par_item_no AND BM2.ord_no = BM1.ord_no  AND BM2.ord_type = BM1.ord_type AND BM2.lvl_no = 1 AND BM2.line_no = BM1.line_no
		--JOIN IMORDBLD_SQL BM3 ON BM3.item_no = BM2.par_item_no AND BM3.ord_no = BM2.ord_no  AND BM3.ord_type = BM2.ord_type AND BM3.lvl_no = 2 AND BM3.line_no = BM2.line_no
		JOIN IMITMIDX_SQL IM ON IM.item_no = BM1.item_no
WHERE OH.ord_no = '99999999' AND OH.ord_Type = 'O' 
	AND OL.qty_to_ship > 0
	AND BM1.qty_per > 0
	AND BM1.lvl_no = 3

UNION ALL

select '5' AS LEVEL, OH.ord_no AS [ORDER#], IM.item_no AS [ITEM], 
		rtrim(OL.item_no) AS RUN,
		IM.item_note_1 AS COLOR,
		rtrim(IM.item_desc_1) AS [ITEM DESC],
		rtrim(IM.item_desc_2) AS [SPECS],
		IM.drawing_release_no + '-'+IM.drawing_revision_no AS [DWG#],
		 (OL.qty_to_ship*BM1.qty_per) AS [ITEM QTY],
		 BM1.qty_per AS QPP,
		 CASE WHEN BM1.mfg_uom = 'EA'
			  THEN BM1.qty
			  ELSE BM1.qty_per
		 END AS QTY,
		 CASE WHEN BM1.attach_oper_no >= 1000
			  THEN CAST(FLOOR(BM1.attach_oper_no/1000) AS VARCHAR)
			  WHEN BM1.attach_oper_no >= 100 
			  THEN CAST(FLOOR(BM1.attach_oper_no/100) AS VARCHAR)
			  WHEN BM1.attach_oper_no >= 10
			  THEN CAST(FLOOR(BM1.attach_oper_no/10) AS VARCHAR)
			  WHEN BM1.attach_oper_no >= 1
			  THEN CAST(FLOOR(BM1.attach_oper_no) AS VARCHAR)
			  ELSE '--'
		 END AS [ORIGIN],
		 CASE WHEN BM1.attach_oper_no >= 1000
			  THEN CAST(((BM1.attach_oper_no/100) % 10) AS VARCHAR)
			  WHEN BM1.attach_oper_no >= 100
			  THEN CAST(((BM1.attach_oper_no/10) % 10) AS VARCHAR)
			  WHEN BM1.attach_oper_no >= 10
			  THEN CAST((BM1.attach_oper_no % 10) AS VARCHAR)
			  WHEN BM1.attach_oper_no >= 1
			  THEN '--'
			  ELSE '--'
		 END AS [WORK FLOW],
		 BM1.SEQ_NO
		 /*
		 CASE WHEN BM1.attach_oper_no >= 1000
			  THEN CAST(((BM1.attach_oper_no/10) % 10) AS VARCHAR)
			  WHEN BM1.attach_oper_no >= 100
			  THEN CAST(((BM1.attach_oper_no) % 10) AS VARCHAR)
			  WHEN BM1.attach_oper_no >= 10
			  THEN '--'
			  WHEN BM1.attach_oper_no >= 1
			  THEN '--'
			  ELSE '--'
		 END AS [WORK FLOW 3],
		 CASE WHEN BM1.attach_oper_no >= 1000
			  THEN CAST(((BM1.attach_oper_no) % 10) AS VARCHAR)
			  WHEN BM1.attach_oper_no >= 100
			  THEN '--'
			  WHEN BM1.attach_oper_no >= 10
			  THEN '--'
			  WHEN BM1.attach_oper_no >= 1
			  THEN '--'
			  ELSE '--'
		 END AS [WORK FLOW 4]	
		 */
FROM  oeordlin_sql AS OL 
		JOIN OEORDHDR_SQL AS OH ON OH.ord_no = OL.ord_no AND OH.ord_type = OL.ord_type
		JOIN IMORDBLD_SQL BM1 ON BM1.line_no = OL.line_no AND BM1.ord_no = OH.ord_no  AND BM1.ord_type = OH.ord_type
		JOIN IMITMIDX_SQL IM ON IM.item_no = BM1.item_no
WHERE OH.ord_no = '99999999' AND OH.ord_Type = 'O' 
	AND OL.qty_to_ship > 0
	AND BM1.qty_per > 0
	AND lvl_no = 4
	) AS TEMP
ORDER BY LEVEL, SEQ_NO