USE [001]
SELECT DISTINCT PHINF.ord_dt [INF Ord Dt], PHINF.ord_no AS [INF ord #], PHINF.vend_no AS [INF Vend #], APINF.vend_name AS [INF Vendor Name],  PLINF.item_no AS [INF Item #], 
		PLINF.item_desc_1 [INF Item Desc 1], PLINF.item_desc_2 [INF Item Desc 2], PLINF.act_unit_cost [INF Purch Price], PLINF.qty_ordered [INF Qty Ord.],
		--Begin Marco Fields
		PHMAR.ord_dt [MARCO Ord Dt], PHMAR.ord_no AS [MARCO ord #], PHMAR.vend_no AS [MARCO Vend #], APINF.vend_name AS [MARCO Vendor Name],  PLMAR.item_no AS [MARCO Item #], 
		PLMAR.item_desc_1 [MARCO Item Desc 1], PLMAR.item_desc_2 [MARCO Item Desc 2], PLMAR.act_unit_cost [MARCO Purch Price], PLMAR.qty_ordered [MARCO Qty Ord.]
FROM dbo.poordlin_sql PLMAR 
		JOIN dbo.imitmidx_sql IMMAR ON IMMAR.item_no = PLMAR.item_no
		JOIN dbo.poordhdr_sql PHMAR ON PHMAR.ord_no = PLMAR.ord_no	
		JOIN [020].dbo.poordlin_Sql PLINF  ON PLINF.item_no = PLMAR.item_no
		JOIN [020].dbo.poordhdr_sql PHINF ON PHINF.ord_no = PLINF.ord_no
		JOIN [020].dbo.imitmidx_sql IMINF ON IMINF.item_no = PLINF.item_no
		JOIN [020].dbo.apvenfil_sql APINF ON APINF.vend_no = PHINF.vend_no
WHERE NOT(PLINF.item_no LIKE 'RAIL%' OR PLINF.item_no LIKE 'BOLLARD%' OR PLINF.item_no LIKE 'PROTOTYPE%') AND IMINF.prod_cat != 'AP'