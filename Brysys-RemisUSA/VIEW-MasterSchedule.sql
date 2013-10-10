USE [060]


select '1' AS LEVEL, OL.item_no AS [ITEM], 
		rtrim(OL.item_no) AS RUN,
		CASE WHEN OL.item_desc_2 is null
			 THEN rtrim(OL.item_desc_1)
			 ELSE rtrim(OL.item_desc_1)+'--'+rtrim(OL.item_desc_2) 
		 END AS [ITEM DESC], 
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

select '2' AS LEVEL, IM.item_no AS [ITEM], 
		rtrim(OL.item_no) AS RUN,
		CASE WHEN IM.item_desc_2 is null
			 THEN rtrim(IM.item_desc_1)
			 ELSE rtrim(IM.item_desc_1)+'--'+rtrim(IM.item_desc_2) 
		 END AS [ITEM DESC], 
		 (OL.qty_to_ship*BM1.qty_per) AS [ITEM QTY],
		 BM1.qty_per AS QPP,	
		 (OL.qty_to_ship*BM1.qty_per) AS QTY,
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
		 END AS [WORK FLOW]
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
		JOIN IMORDBLD_SQL BM1 ON BM1.item_no = OL.item_no 
		JOIN IMITMIDX_SQL IM ON IM.item_no = BM1.item_no
WHERE OH.ord_no = '99999999' AND OH.ord_Type = 'O'
	AND OL.qty_to_ship > 0
	AND BM1.qty_per > 0

UNION ALL

select '3' AS LEVEL, IM.item_no AS [ITEM], 
		rtrim(OL.item_no) AS RUN,
		CASE WHEN IM.item_desc_2 is null
			 THEN rtrim(IM.item_desc_1)
			 ELSE rtrim(IM.item_desc_1)+'--'+rtrim(IM.item_desc_2) 
		 END AS [ITEM DESC], 
		 (OL.qty_to_ship*BM1.qty_per_par*BM2.qty_per_par) AS [ITEM QTY],
		 BM2.qty_per_par AS QPP,	
		 CASE WHEN BM2.mfg_uom = 'EA'
			  THEN (OL.qty_to_ship*BM1.qty_per_par*BM2.qty_per_par)
			  ELSE ((OL.qty_to_ship*BM1.qty_per_par*BM2.qty_per_par) / BM2.qty_per_par) 
		 END AS QTY,
		 CASE WHEN BM2.attach_oper_no >= 1000
			  THEN CAST(FLOOR(BM2.attach_oper_no/1000) AS VARCHAR)
			  WHEN BM2.attach_oper_no >= 100 
			  THEN CAST(FLOOR(BM2.attach_oper_no/100) AS VARCHAR)
			  WHEN BM2.attach_oper_no >= 10
			  THEN CAST(FLOOR(BM2.attach_oper_no/10) AS VARCHAR)
			  WHEN BM2.attach_oper_no >= 1
			  THEN CAST(FLOOR(BM2.attach_oper_no) AS VARCHAR)
			  ELSE '--'
		 END AS [ORIGIN],
		 CASE WHEN BM2.attach_oper_no >= 1000
			  THEN CAST(((BM2.attach_oper_no/100) % 10) AS VARCHAR)
			  WHEN BM2.attach_oper_no >= 100
			  THEN CAST(((BM2.attach_oper_no/10) % 10) AS VARCHAR)
			  WHEN BM2.attach_oper_no >= 10
			  THEN CAST((BM2.attach_oper_no % 10) AS VARCHAR)
			  WHEN BM2.attach_oper_no >= 1
			  THEN '--'
			  ELSE '--'
		 END AS [WORK FLOW]
		 /*
		 CASE WHEN BM2.attach_oper_no >= 1000
			  THEN CAST(((BM2.attach_oper_no/10) % 10) AS VARCHAR)
			  WHEN BM2.attach_oper_no >= 100
			  THEN CAST(((BM2.attach_oper_no) % 10) AS VARCHAR)
			  WHEN BM2.attach_oper_no >= 10
			  THEN '--'
			  WHEN BM2.attach_oper_no >= 1
			  THEN '--'
			  ELSE '--'
		 END AS [WORK FLOW 3],
		 CASE WHEN BM2.attach_oper_no >= 1000
			  THEN CAST(((BM2.attach_oper_no) % 10) AS VARCHAR)
			  WHEN BM2.attach_oper_no >= 100
			  THEN '--'
			  WHEN BM2.attach_oper_no >= 10
			  THEN '--'
			  WHEN BM2.attach_oper_no >= 1
			  THEN '--'
			  ELSE '--'
		 END AS [WORK FLOW 4]
		 */
FROM  oeordlin_sql AS OL 
		JOIN OEORDHDR_SQL AS OH ON OH.ord_no = OL.ord_no AND OH.ord_type = OL.ord_type
		JOIN BMPRDSTR_SQL BM1 ON BM1.item_no = OL.item_no 
		JOIN IMITMIDX_SQL IM ON IM.item_no = BM2.comp_item_no
WHERE OH.ord_no = '99999999' AND OH.ord_Type = 'O' 
	AND OL.qty_to_ship > 0
	AND BM1.qty_per_par > 0
	AND BM2.qty_per_par > 0

UNION ALL

select '4' AS LEVEL, IM.item_no AS [ITEM], 
		rtrim(OL.item_no) AS RUN,
		CASE WHEN IM.item_desc_2 is null
			 THEN rtrim(IM.item_desc_1)
			 ELSE rtrim(IM.item_desc_1)+'--'+rtrim(IM.item_desc_2) 
		 END AS [ITEM DESC], 
		 (OL.qty_to_ship*BM1.qty_per_par*BM2.qty_per_par*BM3.qty_per_par) AS [ITEM QTY],
		 BM3.qty_per_par AS QPP,
		 CASE WHEN BM3.mfg_uom = 'EA'
			  THEN (OL.qty_to_ship*BM1.qty_per_par*BM2.qty_per_par*BM3.qty_per_par)
			  ELSE ((OL.qty_to_ship*BM1.qty_per_par*BM2.qty_per_par*BM3.qty_per_par) / BM3.qty_per_par) 
		 END AS QTY,
		 CASE WHEN BM3.attach_oper_no >= 1000
			  THEN CAST(FLOOR(BM3.attach_oper_no/1000) AS VARCHAR)
			  WHEN BM3.attach_oper_no >= 100 
			  THEN CAST(FLOOR(BM3.attach_oper_no/100) AS VARCHAR)
			  WHEN BM3.attach_oper_no >= 10
			  THEN CAST(FLOOR(BM3.attach_oper_no/10) AS VARCHAR)
			  WHEN BM3.attach_oper_no >= 1
			  THEN CAST(FLOOR(BM3.attach_oper_no) AS VARCHAR)
			  ELSE '--'
		 END AS [ORIGIN],
		 CASE WHEN BM3.attach_oper_no >= 1000
			  THEN CAST(((BM3.attach_oper_no/100) % 10) AS VARCHAR)
			  WHEN BM3.attach_oper_no >= 100
			  THEN CAST(((BM3.attach_oper_no/10) % 10) AS VARCHAR)
			  WHEN BM3.attach_oper_no >= 10
			  THEN CAST((BM3.attach_oper_no % 10) AS VARCHAR)
			  WHEN BM3.attach_oper_no >= 1
			  THEN '--'
			  ELSE '--'
		 END AS [WORK FLOW]
		 /*
		 CASE WHEN BM3.attach_oper_no >= 1000
			  THEN CAST(((BM3.attach_oper_no/10) % 10) AS VARCHAR)
			  WHEN BM3.attach_oper_no >= 100
			  THEN CAST(((BM3.attach_oper_no) % 10) AS VARCHAR)
			  WHEN BM3.attach_oper_no >= 10
			  THEN '--'
			  WHEN BM3.attach_oper_no >= 1
			  THEN '--'
			  ELSE '--'
		 END AS [WORK FLOW 3],
		 CASE WHEN BM3.attach_oper_no >= 1000
			  THEN CAST(((BM3.attach_oper_no) % 10) AS VARCHAR)
			  WHEN BM3.attach_oper_no >= 100
			  THEN '--'
			  WHEN BM3.attach_oper_no >= 10
			  THEN '--'
			  WHEN BM3.attach_oper_no >= 1
			  THEN '--'
			  ELSE '--'
		 END AS [WORK FLOW 4]
		*/
FROM  oeordlin_sql AS OL 
		JOIN OEORDHDR_SQL AS OH ON OH.ord_no = OL.ord_no AND OH.ord_type = OL.ord_type
		JOIN BMPRDSTR_SQL BM1 ON BM1.item_no = OL.item_no 
		JOIN BMPRDSTR_SQL BM2 ON BM2.item_no = BM1.comp_item_no 
		JOIN BMPRDSTR_SQL BM3 ON BM3.item_no = BM2.comp_item_no 
		JOIN IMITMIDX_SQL IM ON IM.item_no = BM3.comp_item_no
WHERE OH.ord_no = '99999999' AND OH.ord_Type = 'O' 
	AND OL.qty_to_ship > 0
	AND BM1.qty_per_par > 0
	AND BM2.qty_per_par > 0
	AND BM3.qty_per_par > 0

UNION ALL

select '5' AS LEVEL, IM.item_no AS [ITEM], 
		rtrim(OL.item_no) AS RUN,
		CASE WHEN IM.item_desc_2 is null
			 THEN rtrim(IM.item_desc_1)
			 ELSE rtrim(IM.item_desc_1)+'--'+rtrim(IM.item_desc_2) 
		 END AS [ITEM DESC], 
		 (OL.qty_to_ship*BM1.qty_per_par*BM2.qty_per_par*BM3.qty_per_par*BM4.qty_per_par) AS [ITEM QTY],
		 BM4.qty_per_par AS QPP,
		 ((OL.qty_to_ship*BM1.qty_per_par*BM2.qty_per_par*BM3.qty_per_par*BM4.qty_per_par) / BM4.qty_per_par) AS QTY,
		 CASE WHEN BM4.attach_oper_no >= 1000
			  THEN CAST(FLOOR(BM4.attach_oper_no/1000) AS VARCHAR)
			  WHEN BM4.attach_oper_no >= 100 
			  THEN CAST(FLOOR(BM4.attach_oper_no/100) AS VARCHAR)
			  WHEN BM4.attach_oper_no >= 10
			  THEN CAST(FLOOR(BM4.attach_oper_no/10) AS VARCHAR)
			  WHEN BM4.attach_oper_no >= 1
			  THEN CAST(FLOOR(BM4.attach_oper_no) AS VARCHAR)
			  ELSE '--'
		 END AS [ORIGIN],
		 CASE WHEN BM4.attach_oper_no >= 1000
			  THEN CAST(((BM4.attach_oper_no/100) % 10) AS VARCHAR)
			  WHEN BM4.attach_oper_no >= 100
			  THEN CAST(((BM4.attach_oper_no/10) % 10) AS VARCHAR)
			  WHEN BM4.attach_oper_no >= 10
			  THEN CAST((BM4.attach_oper_no % 10) AS VARCHAR)
			  WHEN BM4.attach_oper_no >= 1
			  THEN '--'
			  ELSE '--'
		 END AS [WORK FLOW]
		 /*
		 CASE WHEN BM4.attach_oper_no >= 1000
			  THEN CAST(((BM4.attach_oper_no/10) % 10) AS VARCHAR)
			  WHEN BM4.attach_oper_no >= 100
			  THEN CAST(((BM4.attach_oper_no) % 10) AS VARCHAR)
			  WHEN BM4.attach_oper_no >= 10
			  THEN '--'
			  WHEN BM4.attach_oper_no >= 1
			  THEN '--'
			  ELSE '--'
		 END AS [WORK FLOW 3],
		 CASE WHEN BM4.attach_oper_no >= 1000
			  THEN CAST(((BM4.attach_oper_no) % 10) AS VARCHAR)
			  WHEN BM4.attach_oper_no >= 100
			  THEN '--'
			  WHEN BM4.attach_oper_no >= 10
			  THEN '--'
			  WHEN BM4.attach_oper_no >= 1
			  THEN '--'
			  ELSE '--'
		 END AS [WORK FLOW 4]	
		 */
FROM  oeordlin_sql AS OL 
		JOIN OEORDHDR_SQL AS OH ON OH.ord_no = OL.ord_no AND OH.ord_type = OL.ord_type
		JOIN BMPRDSTR_SQL BM1 ON BM1.item_no = OL.item_no 
		JOIN BMPRDSTR_SQL BM2 ON BM2.item_no = BM1.comp_item_no 
		JOIN BMPRDSTR_SQL BM3 ON BM3.item_no = BM2.comp_item_no 
		JOIN BMPRDSTR_SQL BM4 ON BM3.item_no = BM3.comp_item_no 
		JOIN IMITMIDX_SQL IM ON IM.item_no = BM4.comp_item_no
WHERE OH.ord_no = '99999999' AND OH.ord_Type = 'O' 
	AND OL.qty_to_ship > 0
	AND BM1.qty_per_par > 0
	AND BM2.qty_per_par > 0
	AND BM3.qty_per_par > 0
	AND BM4.qty_per_par > 0