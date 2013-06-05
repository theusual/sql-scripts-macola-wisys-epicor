USE [001]
GO

	DECLARE @tableHTML  NVARCHAR(MAX)
	
	DECLARE @PlasticCount DECIMAL(5,0)
	DECLARE @PlasticMissing DECIMAL(5,0) 
	DECLARE @PlasticOT DECIMAL(5,0)
	DECLARE @PlasticWMCount DECIMAL(5,0)
	DECLARE @PlasticWMMissing DECIMAL(5,0)
	DECLARE @PlasticWMOT DECIMAL(5,0)
	DECLARE @PlasticCountItem DECIMAL(5,0)
	DECLARE @PlasticMissingItem DECIMAL(5,0) 
	DECLARE @PlasticOTItem DECIMAL(5,0)
	DECLARE @PlasticWMCountItem DECIMAL(5,0)
	DECLARE @PlasticWMMissingItem DECIMAL(5,0)
	DECLARE @PlasticWMOTItem DECIMAL(5,0)
	
	DECLARE @WoodshopCount DECIMAL(5,0)
	DECLARE @WoodshopMissing DECIMAL(5,0) 
	DECLARE @WoodshopOT DECIMAL(5,0)
	DECLARE @WoodshopWMCount DECIMAL(5,0)
	DECLARE @WoodshopWMMissing DECIMAL(5,0)
	DECLARE @WoodshopWMOT DECIMAL(5,0)
	DECLARE @WoodshopCountItem DECIMAL(5,0)
	DECLARE @WoodshopMissingItem DECIMAL(5,0) 
	DECLARE @WoodshopOTItem DECIMAL(5,0)
	DECLARE @WoodshopWMCountItem DECIMAL(5,0)
	DECLARE @WoodshopWMMissingItem DECIMAL(5,0)
	DECLARE @WoodshopWMOTItem DECIMAL(5,0)
	
	DECLARE @BeachCount DECIMAL(5,0)
	DECLARE @BeachMissing DECIMAL(5,0) 
	DECLARE @BeachOT DECIMAL(5,0)
	DECLARE @BeachWMCount DECIMAL(5,0)
	DECLARE @BeachWMMissing DECIMAL(5,0)
	DECLARE @BeachWMOT DECIMAL(5,0)
	DECLARE @BeachCountItem DECIMAL(5,0)
	DECLARE @BeachMissingItem DECIMAL(5,0) 
	DECLARE @BeachOTItem DECIMAL(5,0)
	DECLARE @BeachWMCountItem DECIMAL(5,0)
	DECLARE @BeachWMMissingItem DECIMAL(5,0)
	DECLARE @BeachWMOTItem DECIMAL(5,0)
	
	DECLARE @BeachSWCount DECIMAL(5,0)
	DECLARE @BeachSWMissing DECIMAL(5,0) 
	DECLARE @BeachSWOT DECIMAL(5,0)
	DECLARE @BeachSWWMCount DECIMAL(5,0)
	DECLARE @BeachSWWMMissing DECIMAL(5,0)
	DECLARE @BeachSWWMOT DECIMAL(5,0)
	DECLARE @BeachSWCountItem DECIMAL(5,0)
	DECLARE @BeachSWMissingItem DECIMAL(5,0) 
	DECLARE @BeachSWOTItem DECIMAL(5,0)
	DECLARE @BeachSWWMCountItem DECIMAL(5,0)
	DECLARE @BeachSWWMMissingItem DECIMAL(5,0)
	DECLARE @BeachSWWMOTItem DECIMAL(5,0)
	
	DECLARE @CentralCount DECIMAL(5,0)
	DECLARE @CentralMissing DECIMAL(5,0) 
	DECLARE @CentralOT DECIMAL(5,0)
	DECLARE @CentralWMCount DECIMAL(5,0)
	DECLARE @CentralWMMissing DECIMAL(5,0)
	DECLARE @CentralWMOT DECIMAL(5,0)
	DECLARE @CentralCountItem DECIMAL(5,0)
	DECLARE @CentralMissingItem DECIMAL(5,0) 
	DECLARE @CentralOTItem DECIMAL(5,0)
	DECLARE @CentralWMCountItem DECIMAL(5,0)
	DECLARE @CentralWMMissingItem DECIMAL(5,0)
	DECLARE @CentralWMOTItem DECIMAL(5,0)
	
	DECLARE @NewEvermanCount DECIMAL(5,0)
	DECLARE @NewEvermanMissing DECIMAL(5,0) 
	DECLARE @NewEvermanOT DECIMAL(5,0)
	DECLARE @NewEvermanWMCount DECIMAL(5,0)
	DECLARE @NewEvermanWMMissing DECIMAL(5,0)
	DECLARE @NewEvermanWMOT DECIMAL(5,0)
	DECLARE @NewEvermanCountItem DECIMAL(5,0)
	DECLARE @NewEvermanMissingItem DECIMAL(5,0) 
	DECLARE @NewEvermanOTItem DECIMAL(5,0)
	DECLARE @NewEvermanWMCountItem DECIMAL(5,0)
	DECLARE @NewEvermanWMMissingItem DECIMAL(5,0)
	DECLARE @NewEvermanWMOTItem DECIMAL(5,0)
	
	DECLARE @TotalCount DECIMAL(5,0)
	DECLARE @TotalMissing DECIMAL(5,0) 
	DECLARE @TotalOT DECIMAL(5,0)
	DECLARE @TotalWMCount DECIMAL(5,0)
	DECLARE @TotalWMMissing DECIMAL(5,0)
	DECLARE @TotalWMOT DECIMAL(5,0)
	DECLARE @TotalCountItem DECIMAL(5,0)
	DECLARE @TotalMissingItem DECIMAL(5,0) 
	DECLARE @TotalOTItem DECIMAL(5,0)
	DECLARE @TotalWMCountItem DECIMAL(5,0)
	DECLARE @TotalWMMissingItem DECIMAL(5,0)
	DECLARE @TotalWMOTItem DECIMAL(5,0)
	
	DECLARE @MthPlasticCount DECIMAL(5,0)
	DECLARE @MthPlasticMissing DECIMAL(5,0) 
	DECLARE @MthPlasticOT DECIMAL(5,0)
	DECLARE @MthPlasticWMCount DECIMAL(5,0)
	DECLARE @MthPlasticWMMissing DECIMAL(5,0)
	DECLARE @MthPlasticWMOT DECIMAL(5,0)
	DECLARE @MthPlasticCountItem DECIMAL(5,0)
	DECLARE @MthPlasticMissingItem DECIMAL(5,0) 
	DECLARE @MthPlasticOTItem DECIMAL(5,0)
	DECLARE @MthPlasticWMCountItem DECIMAL(5,0)
	DECLARE @MthPlasticWMMissingItem DECIMAL(5,0)
	DECLARE @MthPlasticWMOTItem DECIMAL(5,0)
	
	DECLARE @MthWoodshopCount DECIMAL(5,0)
	DECLARE @MthWoodshopMissing DECIMAL(5,0) 
	DECLARE @MthWoodshopOT DECIMAL(5,0)
	DECLARE @MthWoodshopWMCount DECIMAL(5,0)
	DECLARE @MthWoodshopWMMissing DECIMAL(5,0)
	DECLARE @MthWoodshopWMOT DECIMAL(5,0)
	DECLARE @MthWoodshopCountItem DECIMAL(5,0)
	DECLARE @MthWoodshopMissingItem DECIMAL(5,0) 
	DECLARE @MthWoodshopOTItem DECIMAL(5,0)
	DECLARE @MthWoodshopWMCountItem DECIMAL(5,0)
	DECLARE @MthWoodshopWMMissingItem DECIMAL(5,0)
	DECLARE @MthWoodshopWMOTItem DECIMAL(5,0)
	
	DECLARE @MthBeachCount DECIMAL(5,0)
	DECLARE @MthBeachMissing DECIMAL(5,0) 
	DECLARE @MthBeachOT DECIMAL(5,0)
	DECLARE @MthBeachWMCount DECIMAL(5,0)
	DECLARE @MthBeachWMMissing DECIMAL(5,0)
	DECLARE @MthBeachWMOT DECIMAL(5,0)
	DECLARE @MthBeachCountItem DECIMAL(5,0)
	DECLARE @MthBeachMissingItem DECIMAL(5,0) 
	DECLARE @MthBeachOTItem DECIMAL(5,0)
	DECLARE @MthBeachWMCountItem DECIMAL(5,0)
	DECLARE @MthBeachWMMissingItem DECIMAL(5,0)
	DECLARE @MthBeachWMOTItem DECIMAL(5,0)
	
	DECLARE @MthBeachSWCount DECIMAL(5,0)
	DECLARE @MthBeachSWMissing DECIMAL(5,0) 
	DECLARE @MthBeachSWOT DECIMAL(5,0)
	DECLARE @MthBeachSWWMCount DECIMAL(5,0)
	DECLARE @MthBeachSWWMMissing DECIMAL(5,0)
	DECLARE @MthBeachSWWMOT DECIMAL(5,0)
	DECLARE @MthBeachSWCountItem DECIMAL(5,0)
	DECLARE @MthBeachSWMissingItem DECIMAL(5,0) 
	DECLARE @MthBeachSWOTItem DECIMAL(5,0)
	DECLARE @MthBeachSWWMCountItem DECIMAL(5,0)
	DECLARE @MthBeachSWWMMissingItem DECIMAL(5,0)
	DECLARE @MthBeachSWWMOTItem DECIMAL(5,0)
	
	DECLARE @MthCentralCount DECIMAL(5,0)
	DECLARE @MthCentralMissing DECIMAL(5,0) 
	DECLARE @MthCentralOT DECIMAL(5,0)
	DECLARE @MthCentralWMCount DECIMAL(5,0)
	DECLARE @MthCentralWMMissing DECIMAL(5,0)
	DECLARE @MthCentralWMOT DECIMAL(5,0)
	DECLARE @MthCentralCountItem DECIMAL(5,0)
	DECLARE @MthCentralMissingItem DECIMAL(5,0) 
	DECLARE @MthCentralOTItem DECIMAL(5,0)
	DECLARE @MthCentralWMCountItem DECIMAL(5,0)
	DECLARE @MthCentralWMMissingItem DECIMAL(5,0)
	DECLARE @MthCentralWMOTItem DECIMAL(5,0)
	
	DECLARE @MthNewEvermanCount DECIMAL(5,0)
	DECLARE @MthNewEvermanMissing DECIMAL(5,0) 
	DECLARE @MthNewEvermanOT DECIMAL(5,0)
	DECLARE @MthNewEvermanWMCount DECIMAL(5,0)
	DECLARE @MthNewEvermanWMMissing DECIMAL(5,0)
	DECLARE @MthNewEvermanWMOT DECIMAL(5,0)
	DECLARE @MthNewEvermanCountItem DECIMAL(5,0)
	DECLARE @MthNewEvermanMissingItem DECIMAL(5,0) 
	DECLARE @MthNewEvermanOTItem DECIMAL(5,0)
	DECLARE @MthNewEvermanWMCountItem DECIMAL(5,0)
	DECLARE @MthNewEvermanWMMissingItem DECIMAL(5,0)
	DECLARE @MthNewEvermanWMOTItem DECIMAL(5,0)
	
	DECLARE @MthTotalCount DECIMAL(5,0)
	DECLARE @MthTotalMissing DECIMAL(5,0) 
	DECLARE @MthTotalOT DECIMAL(5,0)
	DECLARE @MthTotalWMCount DECIMAL(5,0)
	DECLARE @MthTotalWMMissing DECIMAL(5,0)
	DECLARE @MthTotalWMOT DECIMAL(5,0)
	DECLARE @MthTotalCountItem DECIMAL(5,0)
	DECLARE @MthTotalMissingItem DECIMAL(5,0) 
	DECLARE @MthTotalOTItem DECIMAL(5,0)
	DECLARE @MthTotalWMCountItem DECIMAL(5,0)
	DECLARE @MthTotalWMMissingItem DECIMAL(5,0)
	DECLARE @MthTotalWMOTItem DECIMAL(5,0)
	
	
	DECLARE @NA NVARCHAR(MAX)
	;
	SET @NA=' N/A'
	
	SET @PlasticCount = 
	CAST((
	SELECT COUNT(distinct OH.ord_no)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			    /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*FOR ONLY 1 SHOP*/
				AND (SH.mode = 1) 
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
 
             as int)
    SET @PlasticMissing = 
    CAST((
    SELECT  COUNT(distinct OH.ord_no)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 1) 
			   /*ONLY ORDERS SHIPPING LATE*/
			     AND (OH.shipping_dt <  (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
    SET @PlasticOT = 
    CAST((
    SELECT COUNT(distinct OH.ord_no)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 1) 
			   /*ONLY ORDERS SHIPPING ON TIME OR EARLY*/
			     AND (OH.shipping_dt >= (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)	
	SET @PlasticWMCount = 
	CAST((
	SELECT COUNT(distinct OH.ord_no)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			    /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*FOR ONLY 1 SHOP*/
				AND (SH.mode = 1) 
				/*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')			
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
 
             as int)
    SET @PlasticWMMissing = 
    CAST((
    SELECT COUNT(distinct OH.ord_no)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*ONLY ORDERS SHIPPING LATE*/
			     AND (OH.shipping_dt <  (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			     /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 1) 
			     /*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
    SET @PlasticWMOT = 
    CAST((
    SELECT COUNT(distinct OH.ord_no)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*ONLY ORDERS SHIPPING ON TIME OR EARLY*/
			     AND (OH.shipping_dt >= (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			     /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 1) 
			     /*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
	SET @PlasticCountItem = 
	CAST((
	SELECT    SUM(OL.qty_ordered)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			    /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*FOR ONLY 1 SHOP*/
				AND (SH.mode = 1) 
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
 
             as int)
    SET @PlasticMissingItem = 
    CAST((
    SELECT		 SUM(OL.qty_ordered)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 1) 
			   /*ONLY ORDERS SHIPPING LATE*/
			     AND (OH.shipping_dt <  (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
    SET @PlasticOTItem = 
    CAST((
    SELECT		SUM(SH.hand_chg)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 1) 
			   /*ONLY ORDERS SHIPPING ON TIME OR EARLY*/
			     AND (OH.shipping_dt >= (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
	SET @PlasticWMCountItem = 
	CAST((
	SELECT    SUM(OL.qty_ordered)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			 /*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
			    /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*FOR ONLY 1 SHOP*/
				AND (SH.mode = 1) 
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
 
             as int)
    SET @PlasticWMMissingItem = 
    CAST((
    SELECT		 SUM(OL.qty_ordered)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   			     /*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 1) 
			   /*ONLY ORDERS SHIPPING LATE*/
			     AND (OH.shipping_dt <  (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
    SET @PlasticWMOTItem = 
    CAST((
    SELECT		SUM(SH.hand_chg)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   			     /*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 1) 
			   /*ONLY ORDERS SHIPPING ON TIME OR EARLY*/
			     AND (OH.shipping_dt >= (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)							
		
	SET @WoodshopCount = 
	CAST((
	SELECT COUNT(distinct OH.ord_no)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			    /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*FOR ONLY 1 SHOP*/
				AND (SH.mode = 2) 
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
 
             as int)
    SET @WoodshopMissing = 
    CAST((
    SELECT  COUNT(distinct OH.ord_no)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 2) 
			   /*ONLY ORDERS SHIPPING LATE*/
			     AND (OH.shipping_dt <  (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
    SET @WoodshopOT = 
    CAST((
    SELECT COUNT(distinct OH.ord_no)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 2) 
			   /*ONLY ORDERS SHIPPING ON TIME OR EARLY*/
			     AND (OH.shipping_dt >= (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)	
	SET @WoodshopWMCount = 
	CAST((
	SELECT COUNT(distinct OH.ord_no)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			    /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*FOR ONLY 1 SHOP*/
				AND (SH.mode = 2) 
				/*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')			
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
 
             as int)
    SET @WoodshopWMMissing = 
    CAST((
    SELECT COUNT(distinct OH.ord_no)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*ONLY ORDERS SHIPPING LATE*/
			     AND (OH.shipping_dt <  (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			     /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 2) 
			     /*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
    SET @WoodshopWMOT = 
    CAST((
    SELECT COUNT(distinct OH.ord_no)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*ONLY ORDERS SHIPPING ON TIME OR EARLY*/
			     AND (OH.shipping_dt >= (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			     /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 2) 
			     /*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
	SET @WoodshopCountItem = 
	CAST((
	SELECT    SUM(OL.qty_ordered)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			    /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*FOR ONLY 1 SHOP*/
				AND (SH.mode = 2) 
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
 
             as int)
    SET @WoodshopMissingItem = 
    CAST((
    SELECT		 SUM(OL.qty_ordered)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 2) 
			   /*ONLY ORDERS SHIPPING LATE*/
			     AND (OH.shipping_dt <  (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
    SET @WoodshopOTItem = 
    CAST((
    SELECT		SUM(SH.hand_chg)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 2) 
			   /*ONLY ORDERS SHIPPING ON TIME OR EARLY*/
			     AND (OH.shipping_dt >= (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
	SET @WoodshopWMCountItem = 
	CAST((
	SELECT    SUM(OL.qty_ordered)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			 /*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
			    /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*FOR ONLY 1 SHOP*/
				AND (SH.mode = 2) 
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
 
             as int)
    SET @WoodshopWMMissingItem = 
    CAST((
    SELECT		 SUM(OL.qty_ordered)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   			     /*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 2) 
			   /*ONLY ORDERS SHIPPING LATE*/
			     AND (OH.shipping_dt <  (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
    SET @WoodshopWMOTItem = 
    CAST((
    SELECT		SUM(SH.hand_chg)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   			     /*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 2) 
			   /*ONLY ORDERS SHIPPING ON TIME OR EARLY*/
			     AND (OH.shipping_dt >= (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)	
						
	SET @BeachCount = 
	CAST((
	SELECT COUNT(distinct OH.ord_no)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			    /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*FOR ONLY 1 SHOP*/
				AND (SH.mode = 3) AND OL.prod_cat in ('336', 'AP', 'INS','111','036','037','326')
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
 
             as int)
    SET @BeachMissing = 
    CAST((
    SELECT  COUNT(distinct OH.ord_no)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 3) AND OL.prod_cat in ('336', 'AP', 'INS','111','036','037','326')
			   /*ONLY ORDERS SHIPPING LATE*/
			     AND (OH.shipping_dt <  (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
    SET @BeachOT = 
    CAST((
    SELECT COUNT(distinct OH.ord_no)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 3) AND OL.prod_cat in ('336', 'AP', 'INS','111','036','037','326')
			   /*ONLY ORDERS SHIPPING ON TIME OR EARLY*/
			     AND (OH.shipping_dt >= (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)	
	SET @BeachWMCount = 
	CAST((
	SELECT COUNT(distinct OH.ord_no)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 3) AND OL.prod_cat in ('336', 'AP', 'INS','111','036','037','326')
			    /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')			
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
 
             as int)
    SET @BeachWMMissing = 
    CAST((
    SELECT COUNT(distinct OH.ord_no)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*ONLY ORDERS SHIPPING LATE*/
			     AND (OH.shipping_dt <  (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			     /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 3) AND OL.prod_cat in ('336', 'AP', 'INS','111','036','037','326')
			     /*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
    SET @BeachWMOT = 
    CAST((
    SELECT COUNT(distinct OH.ord_no)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*ONLY ORDERS SHIPPING ON TIME OR EARLY*/
			     AND (OH.shipping_dt >= (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			     /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 3) AND OL.prod_cat in ('336', 'AP', 'INS','111','036','037','326')
			     /*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
	SET @BeachCountItem = 
	CAST((
	SELECT    SUM(OL.qty_ordered)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			    /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*FOR ONLY 1 SHOP*/
				AND (SH.mode = 3) AND OL.prod_cat in ('336', 'AP', 'INS','111','036','037','326')
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
 
             as int)
    SET @BeachMissingItem = 
    CAST((
    SELECT		 SUM(OL.qty_ordered)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 3) AND OL.prod_cat in ('336', 'AP', 'INS','111','036','037','326')
			   /*ONLY ORDERS SHIPPING LATE*/
			     AND (OH.shipping_dt <  (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
    SET @BeachOTItem = 
    CAST((
    SELECT		SUM(SH.hand_chg)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 3) AND OL.prod_cat in ('336', 'AP', 'INS','111','036','037','326')
			   /*ONLY ORDERS SHIPPING ON TIME OR EARLY*/
			     AND (OH.shipping_dt >= (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
	SET @BeachWMCountItem = 
	CAST((
	SELECT    SUM(OL.qty_ordered)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			 /*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
			    /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*FOR ONLY 1 SHOP*/
				AND (SH.mode = 3) AND OL.prod_cat in ('336', 'AP', 'INS','111','036','037','326')
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
 
             as int)
    SET @BeachWMMissingItem = 
    CAST((
    SELECT		 SUM(OL.qty_ordered)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   			     /*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 3) AND OL.prod_cat in ('336', 'AP', 'INS','111','036','037','326')
			   /*ONLY ORDERS SHIPPING LATE*/
			     AND (OH.shipping_dt <  (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
    SET @BeachWMOTItem = 
    CAST((
    SELECT		SUM(SH.hand_chg)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   			     /*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 3) AND OL.prod_cat in ('336', 'AP', 'INS','111','036','037','326')
			   /*ONLY ORDERS SHIPPING ON TIME OR EARLY*/
			     AND (OH.shipping_dt >= (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)	
		
	SET @BeachSWCount = 
	CAST((
	SELECT COUNT(distinct OH.ord_no)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			    /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*FOR ONLY 1 SHOP*/
				AND (SH.mode = 3) AND not OL.prod_cat in ('336', 'AP', 'INS','111','036')
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
 
             as int)
    SET @BeachSWMissing = 
    CAST((
    SELECT  COUNT(distinct OH.ord_no)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 3) AND not OL.prod_cat in ('336', 'AP', 'INS','111','036','037','326')
			   /*ONLY ORDERS SHIPPING LATE*/
			     AND (OH.shipping_dt <  (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
    SET @BeachSWOT = 
    CAST((
    SELECT COUNT(distinct OH.ord_no)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 3) AND not OL.prod_cat in ('336', 'AP', 'INS','111','036','037','326')
			   /*ONLY ORDERS SHIPPING ON TIME OR EARLY*/
			     AND (OH.shipping_dt >= (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)	
	SET @BeachSWWMCount = 
	CAST((
	SELECT COUNT(distinct OH.ord_no)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 3) AND not OL.prod_cat in ('336', 'AP', 'INS','111','036','037','326')
			    /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')			
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
 
             as int)
    SET @BeachSWWMMissing = 
    CAST((
    SELECT COUNT(distinct OH.ord_no)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*ONLY ORDERS SHIPPING LATE*/
			     AND (OH.shipping_dt <  (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			     /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 3) AND not OL.prod_cat in ('336', 'AP', 'INS','111','036','037','326')
			     /*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
    SET @BeachSWWMOT = 
    CAST((
    SELECT COUNT(distinct OH.ord_no)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*ONLY ORDERS SHIPPING ON TIME OR EARLY*/
			     AND (OH.shipping_dt >= (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			     /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 3) AND not OL.prod_cat in ('336', 'AP', 'INS','111','036','037','326')
			     /*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
	SET @BeachSWCountItem = 
	CAST((
	SELECT    SUM(OL.qty_ordered)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			    /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*FOR ONLY 1 SHOP*/
				AND (SH.mode = 3) AND not OL.prod_cat in ('336', 'AP', 'INS','111','036','037','326')
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
 
             as int)
    SET @BeachSWMissingItem = 
    CAST((
    SELECT		 SUM(OL.qty_ordered)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 3) AND not OL.prod_cat in ('336', 'AP', 'INS','111','036','037','326')
			   /*ONLY ORDERS SHIPPING LATE*/
			     AND (OH.shipping_dt <  (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
    SET @BeachSWOTItem = 
    CAST((
    SELECT		SUM(SH.hand_chg)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 3) AND not OL.prod_cat in ('336', 'AP', 'INS','111','036','037','326')
			   /*ONLY ORDERS SHIPPING ON TIME OR EARLY*/
			     AND (OH.shipping_dt >= (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
	SET @BeachSWWMCountItem = 
	CAST((
	SELECT    SUM(OL.qty_ordered)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			 /*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
			    /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*FOR ONLY 1 SHOP*/
				AND (SH.mode = 3) AND not OL.prod_cat in ('336', 'AP', 'INS','111','036','037','326')
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
 
             as int)
    SET @BeachSWWMMissingItem = 
    CAST((
    SELECT		 SUM(OL.qty_ordered)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   			     /*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 3) AND not OL.prod_cat in ('336', 'AP', 'INS','111','036','037','326')
			   /*ONLY ORDERS SHIPPING LATE*/
			     AND (OH.shipping_dt <  (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
    SET @BeachSWWMOTItem = 
    CAST((
    SELECT		SUM(SH.hand_chg)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   			     /*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 3) AND not OL.prod_cat in ('336', 'AP', 'INS','111','036','037','326')
			   /*ONLY ORDERS SHIPPING ON TIME OR EARLY*/
			     AND (OH.shipping_dt >= (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)										
						
	SET @CentralCount = 
	CAST((
	SELECT COUNT(distinct OH.ord_no)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			    /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*FOR ONLY 1 SHOP*/
				AND (SH.mode = 4) 
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
 
             as int)
    SET @CentralMissing = 
    CAST((
    SELECT  COUNT(distinct OH.ord_no)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 4) 
			   /*ONLY ORDERS SHIPPING LATE*/
			     AND (OH.shipping_dt <  (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
    SET @CentralOT = 
    CAST((
    SELECT COUNT(distinct OH.ord_no)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 4) 
			   /*ONLY ORDERS SHIPPING ON TIME OR EARLY*/
			     AND (OH.shipping_dt >= (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)	
	SET @CentralWMCount = 
	CAST((
	SELECT COUNT(distinct OH.ord_no)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 4) 
			    /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')			
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
 
             as int)
    SET @CentralWMMissing = 
    CAST((
    SELECT COUNT(distinct OH.ord_no)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*ONLY ORDERS SHIPPING LATE*/
			     AND (OH.shipping_dt <  (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			     /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 4) 
			     /*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
    SET @CentralWMOT = 
    CAST((
    SELECT COUNT(distinct OH.ord_no)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*ONLY ORDERS SHIPPING ON TIME OR EARLY*/
			     AND (OH.shipping_dt >= (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			     /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 4) 
			     /*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
	SET @CentralCountItem = 
	CAST((
	SELECT    SUM(OL.qty_ordered)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			    /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*FOR ONLY 1 SHOP*/
				AND (SH.mode = 4) 
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
 
             as int)
    SET @CentralMissingItem = 
    CAST((
    SELECT		 SUM(OL.qty_ordered)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 4) 
			   /*ONLY ORDERS SHIPPING LATE*/
			     AND (OH.shipping_dt <  (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
    SET @CentralOTItem = 
    CAST((
    SELECT		SUM(SH.hand_chg)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 4) 
			   /*ONLY ORDERS SHIPPING ON TIME OR EARLY*/
			     AND (OH.shipping_dt >= (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
	SET @CentralWMCountItem = 
	CAST((
	SELECT    SUM(OL.qty_ordered)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			 /*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
			    /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*FOR ONLY 1 SHOP*/
				AND (SH.mode = 4) 
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
 
             as int)
    SET @CentralWMMissingItem = 
    CAST((
    SELECT		 SUM(OL.qty_ordered)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   			     /*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 4) 
			   /*ONLY ORDERS SHIPPING LATE*/
			     AND (OH.shipping_dt <  (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
    SET @CentralWMOTItem = 
    CAST((
    SELECT		SUM(SH.hand_chg)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   			     /*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 4) 
			   /*ONLY ORDERS SHIPPING ON TIME OR EARLY*/
			     AND (OH.shipping_dt >= (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)		
		
	SET @NewEvermanCount = 
	CAST((
	SELECT COUNT(distinct OH.ord_no)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			    /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*FOR ONLY 1 SHOP*/
				AND (SH.mode = 5) 
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
 
             as int)
    SET @NewEvermanMissing = 
    CAST((
    SELECT  COUNT(distinct OH.ord_no)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 5) 
			   /*ONLY ORDERS SHIPPING LATE*/
			     AND (OH.shipping_dt <  (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
    SET @NewEvermanOT = 
    CAST((
    SELECT COUNT(distinct OH.ord_no)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 5) 
			   /*ONLY ORDERS SHIPPING ON TIME OR EARLY*/
			     AND (OH.shipping_dt >= (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)	
	SET @NewEvermanWMCount = 
	CAST((
	SELECT COUNT(distinct OH.ord_no)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 5) 
			    /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')			
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
 
             as int)
    SET @NewEvermanWMMissing = 
    CAST((
    SELECT COUNT(distinct OH.ord_no)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*ONLY ORDERS SHIPPING LATE*/
			     AND (OH.shipping_dt <  (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			     /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 5) 
			     /*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
    SET @NewEvermanWMOT = 
    CAST((
    SELECT COUNT(distinct OH.ord_no)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*ONLY ORDERS SHIPPING ON TIME OR EARLY*/
			     AND (OH.shipping_dt >= (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			     /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 5) 
			     /*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
	SET @NewEvermanCountItem = 
	CAST((
	SELECT    SUM(OL.qty_ordered)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			    /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*FOR ONLY 1 SHOP*/
				AND (SH.mode = 5) 
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
 
             as int)
    SET @NewEvermanMissingItem = 
    CAST((
    SELECT		 SUM(OL.qty_ordered)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 5) 
			   /*ONLY ORDERS SHIPPING LATE*/
			     AND (OH.shipping_dt <  (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
    SET @NewEvermanOTItem = 
    CAST((
    SELECT		SUM(SH.hand_chg)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 5) 
			   /*ONLY ORDERS SHIPPING ON TIME OR EARLY*/
			     AND (OH.shipping_dt >= (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
	SET @NewEvermanWMCountItem = 
	CAST((
	SELECT    SUM(OL.qty_ordered)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			 /*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
			    /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*FOR ONLY 1 SHOP*/
				AND (SH.mode = 5) 
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
 
             as int)
    SET @NewEvermanWMMissingItem = 
    CAST((
    SELECT		 SUM(OL.qty_ordered)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   			     /*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 5) 
			   /*ONLY ORDERS SHIPPING LATE*/
			     AND (OH.shipping_dt <  (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
    SET @NewEvermanWMOTItem = 
    CAST((
    SELECT		SUM(SH.hand_chg)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   			     /*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 5) 
			   /*ONLY ORDERS SHIPPING ON TIME OR EARLY*/
			     AND (OH.shipping_dt >= (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)	
		
	SET @TotalCount = 
	CAST((
	SELECT COUNT(distinct OH.ord_no)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			    /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))								 
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
 
             as int)
    SET @TotalMissing = 
    CAST((
    SELECT  COUNT(distinct OH.ord_no)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   
				 
			   /*ONLY ORDERS SHIPPING LATE*/
			     AND (OH.shipping_dt <  (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
    SET @TotalOT = 
    CAST((
    SELECT COUNT(distinct OH.ord_no)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   
				 
			   /*ONLY ORDERS SHIPPING ON TIME OR EARLY*/
			     AND (OH.shipping_dt >= (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)	
	SET @TotalWMCount = 
	CAST((
	SELECT COUNT(distinct OH.ord_no)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   
				 
			    /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')			
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
 
             as int)
    SET @TotalWMMissing = 
    CAST((
    SELECT COUNT(distinct OH.ord_no)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*ONLY ORDERS SHIPPING LATE*/
			     AND (OH.shipping_dt <  (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			     
				 
			     /*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
    SET @TotalWMOT = 
    CAST((
    SELECT COUNT(distinct OH.ord_no)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*ONLY ORDERS SHIPPING ON TIME OR EARLY*/
			     AND (OH.shipping_dt >= (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			     
				 
			     /*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
	SET @TotalCountItem = 
	CAST((
	SELECT    SUM(OL.qty_ordered)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			    /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				
				 
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
 
             as int)
    SET @TotalMissingItem = 
    CAST((
    SELECT		 SUM(OL.qty_ordered)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   
				 
			   /*ONLY ORDERS SHIPPING LATE*/
			     AND (OH.shipping_dt <  (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
    SET @TotalOTItem = 
    CAST((
    SELECT		SUM(SH.hand_chg)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   
				 
			   /*ONLY ORDERS SHIPPING ON TIME OR EARLY*/
			     AND (OH.shipping_dt >= (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
	SET @TotalWMCountItem = 
	CAST((
	SELECT    SUM(OL.qty_ordered)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			 /*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
			    /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				
				 
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
 
             as int)
    SET @TotalWMMissingItem = 
    CAST((
    SELECT		 SUM(OL.qty_ordered)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   			     /*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
			   
				 
			   /*ONLY ORDERS SHIPPING LATE*/
			     AND (OH.shipping_dt <  (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
    SET @TotalWMOTItem = 
    CAST((
    SELECT		SUM(SH.hand_chg)
	FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   			     /*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
			   
				 
			   /*ONLY ORDERS SHIPPING ON TIME OR EARLY*/
			     AND (OH.shipping_dt >= (CONVERT(varchar, (DATEADD(day,-1, GETDATE())), 101)))
			   /*ONLY ORDERS SHIPPED YESTERDAY*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -1, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)		
		
		
	SET @MthPlasticCount = 
	CAST((
	SELECT COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 1) 
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
 
             as int)
    SET @MthPlasticMissing = 
    CAST((
    SELECT  COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 1) 
			   /*ONLY ORDERS SHIPPING LATE*/
			     AND (OH.shipping_dt < (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101)))
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
    SET @MthPlasticOT = 
    CAST((
    SELECT COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 1) 
			   /*ONLY ORDERS SHIPPING ON TIME OR EARLY*/
			     AND (OH.shipping_dt >= (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101)))
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)	
	SET @MthPlasticWMCount = 
	CAST((
	SELECT COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 1) 
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
 
             as int)
    SET @MthPlasticWMMissing = 
    CAST((
     SELECT  COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 1) 
			   /*ONLY ORDERS SHIPPING LATE*/
			     AND (OH.shipping_dt < (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101)))
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
    SET @MthPlasticWMOT = 
    CAST((
   SELECT COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 1) 
			   /*ONLY ORDERS SHIPPING ON TIME OR EARLY*/
			     AND (OH.shipping_dt >= (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101)))
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
						
	--SET @MthPlasticCountItem = 
	--CAST((
	--SELECT    SUM(OL.qty_ordered)
	--FROM         OEORDLIN_SQL OL INNER JOIN
 --                     OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
 --                     ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
 --                     OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
 --                     EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
 --                     imitmidx_sql IM ON OL.item_no=IM.item_no 
	--WHERE     /* INITIAL WHERE CLAUSE */ 
	--            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
	--		   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
	--		     /*ONLY ORDERS SHIPPED THIS MONTH*/
	--		    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE()))
	--		    /*FOR ONLY 1 SHOP*/
	--			AND (SH.mode = 1) 
	--			/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
	--			AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
 
 --            as int)
 --   SET @MthPlasticMissingItem = 
 --   CAST((
 --   SELECT		 SUM(OL.qty_ordered)
	--FROM         OEORDLIN_SQL OL INNER JOIN
 --                     OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
 --                     ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
 --                     OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
 --                     EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
 --                     imitmidx_sql IM ON OL.item_no=IM.item_no 
	--WHERE     /* INITIAL WHERE CLAUSE */ 
	--            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
	--		   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
	--		   /*FOR ONLY 1 SHOP*/
	--			AND (SH.mode = 1) 
	--		   /*ONLY ORDERS SHIPPED LATE*/
	--		     AND (OH.shipping_dt < (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101)))
	--		   /*ONLY ORDERS SHIPPED THIS MONTH*/
	--		    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE()))
	--		    /*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
	--			AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
	--					as int)
 --   SET @MthPlasticOTItem = 
 --   CAST((
 --   SELECT		SUM(SH.hand_chg)
	--FROM         OEORDLIN_SQL OL INNER JOIN
 --                     OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
 --                     ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
 --                     OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
 --                     EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
 --                     imitmidx_sql IM ON OL.item_no=IM.item_no 
	--WHERE     /* INITIAL WHERE CLAUSE */ 
	--            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
	--		   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
	--		   /*FOR ONLY 1 SHOP*/
	--			AND (SH.mode = 1) 
	--		   /*ONLY ORDERS SHIPPING ON TIME OR EARLY*/
	--		     AND (OH.shipping_dt >= (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101)))
	--		   /*ONLY ORDERS SHIPPED THIS MONTH*/
	--		    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE()))/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
	--			AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

	--					as int)
	--SET @MthPlasticWMCountItem = 
	--CAST((
	--SELECT    SUM(OL.qty_ordered)
	--FROM         OEORDLIN_SQL OL INNER JOIN
 --                     OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
 --                     ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
 --                     OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
 --                     EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
 --                     imitmidx_sql IM ON OL.item_no=IM.item_no 
	--WHERE     /* INITIAL WHERE CLAUSE */ 
	--            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
	--		   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
	--		 /*FOR ONLY WM*/
	--			AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
	--		    /*ONLY ORDERS SHIPPED YESTERDAY*/
	--		    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -8, GETDATE())), 101)))
	--			/*FOR ONLY 1 SHOP*/
	--			AND (SH.mode = 1) 
	--			/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
	--			AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
 
 --            as int)
 --   SET @MthPlasticWMMissingItem = 
 --   CAST((
 --   SELECT		 SUM(OL.qty_ordered)
	--FROM         OEORDLIN_SQL OL INNER JOIN
 --                     OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
 --                     ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
 --                     OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
 --                     EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
 --                     imitmidx_sql IM ON OL.item_no=IM.item_no 
	--WHERE     /* INITIAL WHERE CLAUSE */ 
	--            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
	--		   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
	--		   			     /*FOR ONLY WM*/
	--			AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
	--		   /*FOR ONLY 1 SHOP*/
	--			AND (SH.mode = 1) 
	--		   /*ONLY ORDERS SHIPPING LATE*/
	--		     AND (OH.shipping_dt <= (CONVERT(varchar, (DATEADD(day, -8, GETDATE())), 101)))
	--		   /*ONLY ORDERS SHIPPED YESTERDAY*/
	--		    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -8, GETDATE())), 101)))
	--			/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
	--			AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

	--					as int)
 --   SET @MthPlasticWMOTItem = 
 --   CAST((
 --   SELECT		SUM(SH.hand_chg)
	--FROM         OEORDLIN_SQL OL INNER JOIN
 --                     OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
 --                     ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
 --                     OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
 --                     EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
 --                     imitmidx_sql IM ON OL.item_no=IM.item_no 
	--WHERE     /* INITIAL WHERE CLAUSE */ 
	--            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
	--		   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
	--		   			     /*FOR ONLY WM*/
	--			AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
	--		   /*FOR ONLY 1 SHOP*/
	--			AND (SH.mode = 1) 
	--		   /*ONLY ORDERS SHIPPING ON TIME OR EARLY*/
	--		     AND (OH.shipping_dt > (CONVERT(varchar, (DATEADD(day, -8, GETDATE())), 101)))
	--		   /*ONLY ORDERS SHIPPED YESTERDAY*/
	--		    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) = (CONVERT(varchar, (DATEADD(day, -8, GETDATE())), 101)))
	--			/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
	--			AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

	--					as int)							
		
	SET @MthPlasticCount = 
	CAST((
	SELECT COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 1) 
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
 
             as int)
    SET @MthPlasticMissing = 
    CAST((
    SELECT  COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 1) 
			   /*ONLY ORDERS SHIPPING LATE*/
			     AND (OH.shipping_dt < (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101)))
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
    SET @MthPlasticOT = 
    CAST((
    SELECT COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 1) 
			   /*ONLY ORDERS SHIPPING ON TIME OR EARLY*/
			     AND (OH.shipping_dt >= (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101)))
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)	
	SET @MthPlasticWMCount = 
	CAST((
	SELECT COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 1) 
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
 
             as int)
    SET @MthPlasticWMMissing = 
    CAST((
     SELECT  COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 1) 
			   /*ONLY ORDERS SHIPPING LATE*/
			     AND (OH.shipping_dt < (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101)))
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
    SET @MthPlasticWMOT = 
    CAST((
   SELECT COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 1) 
			   /*ONLY ORDERS SHIPPING ON TIME OR EARLY*/
			     AND (OH.shipping_dt >= (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101)))
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
						
	SET @MthWoodshopCount = 
	CAST((
	SELECT COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 2) 
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
 
             as int)
    SET @MthWoodshopMissing = 
    CAST((
    SELECT  COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 2) 
			   /*ONLY ORDERS SHIPPING LATE*/
			     AND (OH.shipping_dt < (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101)))
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
    SET @MthWoodshopOT = 
    CAST((
    SELECT COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 2) 
			   /*ONLY ORDERS SHIPPING ON TIME OR EARLY*/
			     AND (OH.shipping_dt >= (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101)))
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)	
	SET @MthWoodshopWMCount = 
	CAST((
	SELECT COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 2) 
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
 
             as int)
    SET @MthWoodshopWMMissing = 
    CAST((
     SELECT  COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 2) 
			   /*ONLY ORDERS SHIPPING LATE*/
			     AND (OH.shipping_dt < (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101)))
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
    SET @MthWoodshopWMOT = 
    CAST((
   SELECT COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 2) 
			   /*ONLY ORDERS SHIPPING ON TIME OR EARLY*/
			     AND (OH.shipping_dt >= (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101)))
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
						
	SET @MthBeachCount = 
	CAST((
	SELECT COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 3) AND OL.prod_cat in ('336', 'AP', 'INS','111','036','037','326')
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
 
             as int)
    SET @MthBeachMissing = 
    CAST((
    SELECT  COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 3) AND OL.prod_cat in ('336', 'AP', 'INS','111','036','037','326')
			   /*ONLY ORDERS SHIPPING LATE*/
			     AND (OH.shipping_dt < (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101)))
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
    SET @MthBeachOT = 
    CAST((
    SELECT COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 3) AND OL.prod_cat in ('336', 'AP', 'INS','111','036','037','326')
			   /*ONLY ORDERS SHIPPING ON TIME OR EARLY*/
			     AND (OH.shipping_dt >= (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101)))
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)	
	SET @MthBeachWMCount = 
	CAST((
	SELECT COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 3) AND OL.prod_cat in ('336', 'AP', 'INS','111','036','037','326')
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
 
             as int)
    SET @MthBeachWMMissing = 
    CAST((
     SELECT  COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 3) AND OL.prod_cat in ('336', 'AP', 'INS','111','036','037','326')
			   /*ONLY ORDERS SHIPPING LATE*/
			     AND (OH.shipping_dt < (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101)))
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
    SET @MthBeachWMOT = 
    CAST((
   SELECT COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 3) AND OL.prod_cat in ('336', 'AP', 'INS','111','036','037','326')
			   /*ONLY ORDERS SHIPPING ON TIME OR EARLY*/
			     AND (OH.shipping_dt >= (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101)))
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
						
	SET @MthBeachSWCount = 
	CAST((
	SELECT COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 3) AND not OL.prod_cat in ('336', 'AP', 'INS','111','036','037','326')
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
 
             as int)
    SET @MthBeachSWMissing = 
    CAST((
    SELECT  COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 3) AND not OL.prod_cat in ('336', 'AP', 'INS','111','036','037','326')
			   /*ONLY ORDERS SHIPPING LATE*/
			     AND (OH.shipping_dt < (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101)))
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
    SET @MthBeachSWOT = 
    CAST((
    SELECT COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 3) AND not OL.prod_cat in ('336', 'AP', 'INS','111','036','037','326')
			   /*ONLY ORDERS SHIPPING ON TIME OR EARLY*/
			     AND (OH.shipping_dt >= (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101)))
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)	
	SET @MthBeachSWWMCount = 
	CAST((
	SELECT COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 3) AND not OL.prod_cat in ('336', 'AP', 'INS','111','036','037','326')
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
 
             as int)
    SET @MthBeachSWWMMissing = 
    CAST((
     SELECT  COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 3) AND not OL.prod_cat in ('336', 'AP', 'INS','111','036','037','326')
			   /*ONLY ORDERS SHIPPING LATE*/
			     AND (OH.shipping_dt < (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101)))
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
    SET @MthBeachSWWMOT = 
    CAST((
   SELECT COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 3) AND not OL.prod_cat in ('336', 'AP', 'INS','111','036','037','326') 
			   /*ONLY ORDERS SHIPPING ON TIME OR EARLY*/
			     AND (OH.shipping_dt >= (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101)))
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
						
	SET @MthCentralCount = 
	CAST((
	SELECT COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 4) 
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
 
             as int)
    SET @MthCentralMissing = 
    CAST((
    SELECT  COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 4) 
			   /*ONLY ORDERS SHIPPING LATE*/
			     AND (OH.shipping_dt < (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101)))
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
    SET @MthCentralOT = 
    CAST((
    SELECT COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 4) 
			   /*ONLY ORDERS SHIPPING ON TIME OR EARLY*/
			     AND (OH.shipping_dt >= (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101)))
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)	
	SET @MthCentralWMCount = 
	CAST((
	SELECT COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 4) 
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
 
             as int)
    SET @MthCentralWMMissing = 
    CAST((
     SELECT  COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 4) 
			   /*ONLY ORDERS SHIPPING LATE*/
			     AND (OH.shipping_dt < (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101)))
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
    SET @MthCentralWMOT = 
    CAST((
   SELECT COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 4) 
			   /*ONLY ORDERS SHIPPING ON TIME OR EARLY*/
			     AND (OH.shipping_dt >= (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101)))
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)					
						
	SET @MthNewEvermanCount = 
	CAST((
	SELECT COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 5) 
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
 
             as int)
    SET @MthNewEvermanMissing = 
    CAST((
    SELECT  COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 5) 
			   /*ONLY ORDERS SHIPPING LATE*/
			     AND (OH.shipping_dt < (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101)))
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
    SET @MthNewEvermanOT = 
    CAST((
    SELECT COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 5) 
			   /*ONLY ORDERS SHIPPING ON TIME OR EARLY*/
			     AND (OH.shipping_dt >= (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101)))
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)	
	SET @MthNewEvermanWMCount = 
	CAST((
	SELECT COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 5) 
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
 
             as int)
    SET @MthNewEvermanWMMissing = 
    CAST((
     SELECT  COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 5) 
			   /*ONLY ORDERS SHIPPING LATE*/
			     AND (OH.shipping_dt < (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101)))
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
    SET @MthNewEvermanWMOT = 
    CAST((
   SELECT COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   /*FOR ONLY 1 SHOP*/
				AND (SH.mode = 5) 
			   /*ONLY ORDERS SHIPPING ON TIME OR EARLY*/
			     AND (OH.shipping_dt >= (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101)))
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)						
						
	SET @MthTotalCount = 
	CAST((
	SELECT COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   
				 
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
 
             as int)
    SET @MthTotalMissing = 
    CAST((
    SELECT  COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   
				 
			   /*ONLY ORDERS SHIPPING LATE*/
			     AND (OH.shipping_dt < (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101)))
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
    SET @MthTotalOT = 
    CAST((
    SELECT COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   
				 
			   /*ONLY ORDERS SHIPPING ON TIME OR EARLY*/
			     AND (OH.shipping_dt >= (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101)))
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)	
	SET @MthTotalWMCount = 
	CAST((
	SELECT COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   
				 
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))
 
             as int)
    SET @MthTotalWMMissing = 
    CAST((
     SELECT  COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   
				 
			   /*ONLY ORDERS SHIPPING LATE*/
			     AND (OH.shipping_dt < (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101)))
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)
    SET @MthTotalWMOT = 
    CAST((
   SELECT COUNT(distinct OH.ord_no)
	FROM         OELINHST_SQL OL INNER JOIN
                      OEHDRHST_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via INNER JOIN
                      imitmidx_sql IM ON OL.item_no=IM.item_no 
	WHERE     /* INITIAL WHERE CLAUSE */ 
	            OH.ord_type = 'O' AND SH.void_fg IS NULL AND NOT SH.hand_chg IS NULL AND  
			   (OH.ord_no IN (SELECT DISTINCT cast(OH.ord_no AS int) FROM arshttbl))
			   
				 
			   /*ONLY ORDERS SHIPPING ON TIME OR EARLY*/
			     AND (OH.shipping_dt >= (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101)))
			   /*ONLY ORDERS SHIPPED THIS MONTH*/
			    AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > (CONVERT(varchar, (DATEADD(day, -32, GETDATE())), 101)))
				/*FOR ONLY WM*/
				AND ltrim(OH.cus_no) IN ('1575', '20938') AND NOT IM.prod_cat IN ('102', '036', '336', '111')
				/*EXCLUDE FAKE ITEMS AND MANUAL ENTRIES TO ARSHTTBL*/
				AND NOT IM.mat_cost_type in ('6','N') AND NOT OL.item_no in ('TREATED PALLET') AND NOT (SH.mode = 9))

						as int)									
																																																	           
	SET @tableHTML =
		N'<p style="font-family:arial; font-size:12px;">' +
		N''+
		N'' + 
			
		N'<table style="background-color:white; font-family:arial; font-size:12px;" border="1" cellpadding="2" cellspacing="0">' +
		N'<tr><TH> </TH><TH colspan="8">YESTERDAY BY ORDER</TH></TR>'/*<TH colspan="8">BY ITEM</TH>*/ +
		N'<tr><th>DOCK</th>' +
		N'<th>TOTAL SHIPPED </th>' +
		N'<th>SHIPPED ON TIME </th>' +
		N'<th>SHIPPED LATE </th>' +
		N'<th>ON TIME % </th>' +
		N'<th>WM TOTAL SHIPPED</th>' +
		N'<th>WM SHIPPED ON TIME </th>' +
		N'<th>WM SHIPPED LATE </th>' +
		N'<th>WM ON TIME % </th>' +
		
		--N'<th>TOTAL SHIPPED </th>' +
		--N'<th>SHIPPED ON TIME </th>' +
		--N'<th>SHIPPED LATE </th>' +
		--N'<th>ON TIME % </th>' +
		--N'<th>WM TOTAL SHIPPED</th>' +
		--N'<th>WM SHIPPED ON TIME </th>' +
		--N'<th>WM SHIPPED LATE </th>' +
		--N'<th>WM ON TIME % </th>' +
		
		N'<tr><td><b>PLASTICS</b></TD>' +
		N'<td>'+ CAST(@plasticCount as CHAR) +
		N'</td><td>' + CAST(@PlasticOT as CHAR) +
		N'</td><td>' + CAST(@PlasticMissing as CHAR) +
		N'</td><td>' + CASE WHEN (@PlasticCount = 0) THEN @NA ELSE CAST((cast((@plasticOT/@PlasticCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		N'<td>'+ CAST(@plasticWMCount as CHAR) +
		N'</td><td>' + CAST(@PlasticWMOT as CHAR) +
		N'</td><td>' + CAST(@PlasticWMMissing as CHAR) +
		N'</td><td>' + CASE WHEN (@PlasticWMCount = 0) THEN @NA ELSE CAST((cast((@PlasticWMOT/@PlasticWMCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		--N'<td>'+ CAST(@plasticCountItem as CHAR) +
		--N'</td><td>' + CAST(@PlasticOTItem as CHAR) +
		--N'</td><td>' + CAST(@PlasticMissingItem as CHAR) +
		--N'</td><td>' + CASE WHEN (@PlasticCountItem = 0) THEN @NA ELSE CAST((cast((@plasticOTItem/@PlasticCountItem) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		--N'<td>'+ CAST(@plasticWMCount as CHAR) +
		--N'</td><td>' + CAST(@PlasticWMOTItem as CHAR) +
		--N'</td><td>' + CAST(@PlasticWMMissingItem as CHAR) +
		--N'</td><td>' + CASE WHEN (@PlasticWMCountItem = 0) THEN @NA ELSE CAST((cast((@PlasticWMOTItem/@PlasticWMCountItem) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		
		N'<tr><td><b>WOODSHOP</b></TD>' +
		N'<td>'+ CAST(@WOODSHOPCount as CHAR) +
		N'</td><td>' + CAST(@WOODSHOPOT as CHAR) +
		N'</td><td>' + CAST(@WOODSHOPMissing as CHAR) +
		N'</td><td>' + CASE WHEN (@WOODSHOPCount = 0) OR (@WOODSHOPOT is null) THEN @NA ELSE CAST((cast((@WOODSHOPOT/@WOODSHOPCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		N'<td>'+ CAST(@WOODSHOPWMCount as CHAR) +
		N'</td><td>' + CAST(@WOODSHOPWMOT as CHAR) +
		N'</td><td>' + CAST(@WOODSHOPWMMissing as CHAR) +
		N'</td><td>' + CASE WHEN (@WOODSHOPWMCount = 0) OR (@WOODSHOPOT is null) THEN @NA ELSE CAST((cast((@WOODSHOPWMOT/@WOODSHOPWMCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		--N'</td><td>'+ CAST(@WOODSHOPCountItem as CHAR) +
		--N'</td><td>' + CAST(@WOODSHOPOTItem as CHAR) +
		--N'</td><td>' + CAST(@WOODSHOPMissingItem as CHAR) +
		--N'</td><td>' + CASE WHEN (@WOODSHOPCountItem = 0) THEN @NA ELSE CAST((cast((@WOODSHOPOTItem/@WOODSHOPCountItem) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		--N'</td><td>'+ CAST(@WOODSHOPWMCount as CHAR) +
		--N'</td><td>' + CASE WHEN (@WOODSHOPWMOTItem is null) THEN '0' ELSE CAST(@WOODSHOPWMOTItem as CHAR) END +
		--N'</td><td>' + CAST(@WOODSHOPWMMissingItem as CHAR) +
		--N'</td><td>' + CASE WHEN (@WOODSHOPWMCountItem = 0) OR (@WOODSHOPWMOTItem is null) THEN @NA ELSE CAST((cast((@WOODSHOPWMOTItem/@WOODSHOPWMCountItem) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		--N'</td></tr>' +
		
		N'<tr><td><b>BEACH AP&CR</b></TD>' +
		N'<td>'+ CAST(@BeachCount as CHAR) +
		N'</td><td>' + CAST(@BeachOT as CHAR) +
		N'</td><td>' + CAST(@BeachMissing as CHAR) +
		N'</td><td>' + CASE WHEN (@BeachCount = 0) THEN @NA ELSE CAST((cast((@BeachOT/@BeachCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		N'<td>'+ CAST(@BeachWMCount as CHAR) +
		N'</td><td>' + CAST(@BeachWMOT as CHAR) +
		N'</td><td>' + CAST(@BeachWMMissing as CHAR) +
		N'</td><td>' + CASE WHEN (@BeachWMCount = 0) THEN @NA ELSE CAST((cast((@BeachWMOT/@BeachWMCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		--N'<td>'+ CAST(@BeachCountItem as CHAR) +
		--N'</td><td>' + CAST(@BeachOTItem as CHAR) +
		--N'</td><td>' + CAST(@BeachMissingItem as CHAR) +
		--N'</td><td>' + CASE WHEN (@BeachCountItem = 0) THEN @NA ELSE CAST((cast((@BeachOTItem/@BeachCountItem) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		--N'<td>'+ CAST(@BeachWMCount as CHAR) +
		--N'</td><td>' + CAST(@BeachWMOTItem as CHAR) +
		--N'</td><td>' + CAST(@BeachWMMissingItem as CHAR) +
		--N'</td><td>' + CASE WHEN (@BeachWMCountItem = 0) THEN @NA ELSE CAST((cast((@BeachWMOTItem/@BeachWMCountItem) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		N'<tr><td><b>BEACH SW</b></TD>' +
		N'<td>'+ CAST(@BeachSWCount as CHAR) +
		N'</td><td>' + CAST(@BeachSWOT as CHAR) +
		N'</td><td>' + CAST(@BeachSWMissing as CHAR) +
		N'</td><td>' + CASE WHEN (@BeachSWCount = 0) THEN @NA ELSE CAST((cast((@BeachSWOT/@BeachSWCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		N'<td>'+ CAST(@BeachSWWMCount as CHAR) +
		N'</td><td>' + CAST(@BeachSWWMOT as CHAR) +
		N'</td><td>' + CAST(@BeachSWWMMissing as CHAR) +
		N'</td><td>' + CASE WHEN (@BeachSWWMCount = 0) THEN @NA ELSE CAST((cast((@BeachSWWMOT/@BeachSWWMCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		
		
		N'<tr><td><b>CENTRAL</B></TD>' +
		N'<td>'+ CAST(@CentralCount as CHAR) +
		N'</td><td>' + CAST(@CentralOT as CHAR) +
		N'</td><td>' + CAST(@CentralMissing as CHAR) +
		N'</td><td>' + CASE WHEN (@CentralCount = 0) THEN @NA ELSE CAST((cast((@CentralOT/@CentralCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		N'<td>'+ CAST(@CentralWMCount as CHAR) +
		N'</td><td>' + CAST(@CentralWMOT as CHAR) +
		N'</td><td>' + CAST(@CentralWMMissing as CHAR) +
		N'</td><td>' + CASE WHEN (@CentralWMCount = 0) THEN @NA ELSE CAST((cast((@CentralWMOT/@CentralWMCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		--N'<td>'+ CAST(@CentralCountItem as CHAR) +
		--N'</td><td>' + CAST(@CentralOTItem as CHAR) +
		--N'</td><td>' + CAST(@CentralMissingItem as CHAR) +
		--N'</td><td>' + CASE WHEN (@CentralCountItem = 0) THEN @NA ELSE CAST((cast((@CentralOTItem/@CentralCountItem) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		--N'<td>'+ CAST(@CentralWMCount as CHAR) +
		--N'</td><td>' + CAST(@CentralWMOTItem as CHAR) +
		--N'</td><td>' + CAST(@CentralWMMissingItem as CHAR) +
		--N'</td><td>' + CASE WHEN (@CentralWMCountItem = 0) THEN @NA ELSE CAST((cast((@CentralWMOTItem/@CentralWMCountItem) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		
		
		N'<tr><td><b>NEW EVERMAN</b></TD>' +
		N'<td>'+ CAST(@NewEvermanCount as CHAR) +
		N'</td><td>' + CAST(@NewEvermanOT as CHAR) +
		N'</td><td>' + CAST(@NewEvermanMissing as CHAR) +
		N'</td><td>' + CASE WHEN (@NewEvermanCount = 0) THEN @NA ELSE CAST((cast((@NewEvermanOT/@NewEvermanCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		N'<td>'+ CAST(@NewEvermanWMCount as CHAR) +
		N'</td><td>' + CAST(@NewEvermanWMOT as CHAR) +
		N'</td><td>' + CAST(@NewEvermanWMMissing as CHAR) +
		N'</td><td>' + CASE WHEN (@NewEvermanWMCount = 0) THEN @NA ELSE CAST((cast((@NewEvermanWMOT/@NewEvermanWMCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		--N'<td>'+ CAST(@NewEvermanCountItem as CHAR) +
		--N'</td><td>' + CAST(@NewEvermanOTItem as CHAR) +
		--N'</td><td>' + CAST(@NewEvermanMissingItem as CHAR) +
		--N'</td><td>' + CASE WHEN (@NewEvermanCountItem = 0) THEN @NA ELSE CAST((cast((@NewEvermanOTItem/@NewEvermanCountItem) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		--N'<td>'+ CAST(@NewEvermanWMCount as CHAR) +
		--N'</td><td>' + CAST(@NewEvermanWMOTItem as CHAR) +
		--N'</td><td>' + CAST(@NewEvermanWMMissingItem as CHAR) +
		--N'</td><td>' + CASE WHEN (@NewEvermanWMCountItem = 0) THEN @NA ELSE CAST((cast((@NewEvermanWMOTItem/@NewEvermanWMCountItem) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		
		
		N'<tr><td><b><I>TOTAL</I></b></TD>' +
		N'<td><b>'+ CAST(@TotalCount as CHAR) +
		N'</td><td><b>' + CAST(@TotalOT as CHAR) +
		N'</td><td><b>' + CAST(@TotalMissing as CHAR) +
		N'</td><td><b>' + CASE WHEN (@TotalCount = 0) THEN @NA ELSE CAST((cast((@TotalOT/@TotalCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		N'<td><b>'+ CAST(@TotalWMCount as CHAR) +
		N'</td><td><b>' + CAST(@TotalWMOT as CHAR) +
		N'</td><td><b>' + CAST(@TotalWMMissing as CHAR) +
		N'</td><td><b>' + CASE WHEN (@TotalWMCount = 0) THEN @NA ELSE CAST((cast((@TotalWMOT/@TotalWMCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		--N'<td>'+ CAST(@TotalCountItem as CHAR) +
		--N'</td><td>' + CAST(@TotalOTItem as CHAR) +
		--N'</td><td>' + CAST(@TotalMissingItem as CHAR) +
		--N'</td><td>' + CASE WHEN (@TotalCountItem = 0) THEN @NA ELSE CAST((cast((@TotalOTItem/@TotalCountItem) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		--N'<td>'+ CAST(@TotalWMCount as CHAR) +
		--N'</td><td>' + CAST(@TotalWMOTItem as CHAR) +
		--N'</td><td>' + CAST(@TotalWMMissingItem as CHAR) +
		--N'</td><td>' + CASE WHEN (@TotalWMCountItem = 0) THEN @NA ELSE CAST((cast((@TotalWMOTItem/@TotalWMCountItem) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		
		N'</b></table><br><br><br>' + 
		
		N'<table style="background-color:white; font-family:arial; font-size:12px;" border="1" cellpadding="2" cellspacing="0">' +
		N'<tr><TH> </TH><TH colspan="8">MONTHLY BY ORDER</TH></TR>'/*<TH colspan="8">BY ITEM</TH>*/ +
		N'<tr><th>DOCK</th>' +
		N'<th>TOTAL SHIPPED </th>' +
		N'<th>SHIPPED ON TIME </th>' +
		N'<th>SHIPPED LATE </th>' +
		N'<th>ON TIME % </th>' +
		N'<th>WM TOTAL SHIPPED</th>' +
		N'<th>WM SHIPPED ON TIME </th>' +
		N'<th>WM SHIPPED LATE </th>' +
		N'<th>WM ON TIME % </th>' +
		
		--N'<th>TOTAL SHIPPED </th>' +
		--N'<th>SHIPPED ON TIME </th>' +
		--N'<th>SHIPPED LATE </th>' +
		--N'<th>ON TIME % </th>' +
		--N'<th>WM TOTAL SHIPPED</th>' +
		--N'<th>WM SHIPPED ON TIME </th>' +
		--N'<th>WM SHIPPED LATE </th>' +
		--N'<th>WM ON TIME % </th>' +
		
		N'<tr><td><b>PLASTICS</b></TD>' +
		N'<td>'+ CAST(@MthplasticCount as CHAR) +
		N'</td><td>' + CAST(@MthPlasticOT as CHAR) +
		N'</td><td>' + CAST(@MthPlasticMissing as CHAR) +
		N'</td><td>' + CASE WHEN (@MthPlasticCount = 0) THEN @NA ELSE CAST((cast((@MthplasticOT/@MthPlasticCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		N'<td>'+ CAST(@MthplasticWMCount as CHAR) +
		N'</td><td>' + CAST(@MthPlasticWMOT as CHAR) +
		N'</td><td>' + CAST(@MthPlasticWMMissing as CHAR) +
		N'</td><td>' + CASE WHEN (@MthPlasticWMCount = 0) THEN @NA ELSE CAST((cast((@MthPlasticWMOT/@MthPlasticWMCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		--N'<td>'+ CAST(@MthplasticCountItem as CHAR) +
		--N'</td><td>' + CAST(@MthPlasticOTItem as CHAR) +
		--N'</td><td>' + CAST(@MthPlasticMissingItem as CHAR) +
		--N'</td><td>' + CASE WHEN (@MthPlasticCountItem = 0) THEN @NA ELSE CAST((cast((@MthplasticOTItem/@MthPlasticCountItem) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		--N'<td>'+ CAST(@MthplasticWMCount as CHAR) +
		--N'</td><td>' + CAST(@MthPlasticWMOTItem as CHAR) +
		--N'</td><td>' + CAST(@MthPlasticWMMissingItem as CHAR) +
		--N'</td><td>' + CASE WHEN (@MthPlasticWMCountItem = 0) THEN @NA ELSE CAST((cast((@MthPlasticWMOTItem/@MthPlasticWMCountItem) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		
		N'<tr><td><b>WOODSHOP</b></TD>' +
		N'<td>'+ CAST(@MthWOODSHOPCount as CHAR) +
		N'</td><td>' + CAST(@MthWOODSHOPOT as CHAR) +
		N'</td><td>' + CAST(@MthWOODSHOPMissing as CHAR) +
		N'</td><td>' + CASE WHEN (@MthWOODSHOPCount = 0) OR (@MthWOODSHOPOT is null) THEN @NA ELSE CAST((cast((@MthWOODSHOPOT/@MthWOODSHOPCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		N'<td>'+ CAST(@MthWOODSHOPWMCount as CHAR) +
		N'</td><td>' + CAST(@MthWOODSHOPWMOT as CHAR) +
		N'</td><td>' + CAST(@MthWOODSHOPWMMissing as CHAR) +
		N'</td><td>' + CASE WHEN (@MthWOODSHOPWMCount = 0) OR (@MthWOODSHOPOT is null) THEN @NA ELSE CAST((cast((@MthWOODSHOPWMOT/@MthWOODSHOPWMCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		--N'</td><td>'+ CAST(@MthWOODSHOPCountItem as CHAR) +
		--N'</td><td>' + CAST(@MthWOODSHOPOTItem as CHAR) +
		--N'</td><td>' + CAST(@MthWOODSHOPMissingItem as CHAR) +
		--N'</td><td>' + CASE WHEN (@MthWOODSHOPCountItem = 0) THEN @NA ELSE CAST((cast((@MthWOODSHOPOTItem/@MthWOODSHOPCountItem) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		--N'</td><td>'+ CAST(@MthWOODSHOPWMCount as CHAR) +
		--N'</td><td>' + CASE WHEN (@MthWOODSHOPWMOTItem is null) THEN '0' ELSE CAST(@MthWOODSHOPWMOTItem as CHAR) END +
		--N'</td><td>' + CAST(@MthWOODSHOPWMMissingItem as CHAR) +
		--N'</td><td>' + CASE WHEN (@MthWOODSHOPWMCountItem = 0) OR (@MthWOODSHOPWMOTItem is null) THEN @NA ELSE CAST((cast((@MthWOODSHOPWMOTItem/@MthWOODSHOPWMCountItem) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		--N'</td></tr>' +
		
		N'<tr><td><b>BEACH AP&CR</b></TD>' +
		N'<td>'+ CAST(@MthBeachCount as CHAR) +
		N'</td><td>' + CAST(@MthBeachOT as CHAR) +
		N'</td><td>' + CAST(@MthBeachMissing as CHAR) +
		N'</td><td>' + CASE WHEN (@MthBeachCount = 0) THEN @NA ELSE CAST((cast((@MthBeachOT/@MthBeachCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		N'<td>'+ CAST(@MthBeachWMCount as CHAR) +
		N'</td><td>' + CAST(@MthBeachWMOT as CHAR) +
		N'</td><td>' + CAST(@MthBeachWMMissing as CHAR) +
		N'</td><td>' + CASE WHEN (@MthBeachWMCount = 0) THEN @NA ELSE CAST((cast((@MthBeachWMOT/@MthBeachWMCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		--N'<td>'+ CAST(@MthBeachCountItem as CHAR) +
		--N'</td><td>' + CAST(@MthBeachOTItem as CHAR) +
		--N'</td><td>' + CAST(@MthBeachMissingItem as CHAR) +
		--N'</td><td>' + CASE WHEN (@MthBeachCountItem = 0) THEN @NA ELSE CAST((cast((@MthBeachOTItem/@MthBeachCountItem) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		--N'<td>'+ CAST(@MthBeachWMCount as CHAR) +
		--N'</td><td>' + CAST(@MthBeachWMOTItem as CHAR) +
		--N'</td><td>' + CAST(@MthBeachWMMissingItem as CHAR) +
		--N'</td><td>' + CASE WHEN (@MthBeachWMCountItem = 0) THEN @NA ELSE CAST((cast((@MthBeachWMOTItem/@MthBeachWMCountItem) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		
		N'<tr><td><b>BEACH SW</b></TD>' +
		N'<td>'+ CAST(@MthBeachSWCount as CHAR) +
		N'</td><td>' + CAST(@MthBeachSWOT as CHAR) +
		N'</td><td>' + CAST(@MthBeachSWMissing as CHAR) +
		N'</td><td>' + CASE WHEN (@MthBeachSWCount = 0) THEN @NA ELSE CAST((cast((@MthBeachSWOT/@MthBeachSWCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		N'<td>'+ CAST(@MthBeachSWWMCount as CHAR) +
		N'</td><td>' + CAST(@MthBeachSWWMOT as CHAR) +
		N'</td><td>' + CAST(@MthBeachSWWMMissing as CHAR) +
		N'</td><td>' + CASE WHEN (@MthBeachSWWMCount = 0) THEN @NA ELSE CAST((cast((@MthBeachSWWMOT/@MthBeachSWWMCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		--N'<td>'+ CAST(@MthBeachCountItem as CHAR) +
		--N'</td><td>' + CAST(@MthBeachOTItem as CHAR) +
		--N'</td><td>' + CAST(@MthBeachMissingItem as CHAR) +
		--N'</td><td>' + CASE WHEN (@MthBeachCountItem = 0) THEN @NA ELSE CAST((cast((@MthBeachOTItem/@MthBeachCountItem) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		--N'<td>'+ CAST(@MthBeachWMCount as CHAR) +
		--N'</td><td>' + CAST(@MthBeachWMOTItem as CHAR) +
		--N'</td><td>' + CAST(@MthBeachWMMissingItem as CHAR) +
		--N'</td><td>' + CASE WHEN (@MthBeachWMCountItem = 0) THEN @NA ELSE CAST((cast((@MthBeachWMOTItem/@MthBeachWMCountItem) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +		

		N'<tr><td><b>CENTRAL</B></TD>' +
		N'<td>'+ CAST(@MthCentralCount as CHAR) +
		N'</td><td>' + CAST(@MthCentralOT as CHAR) +
		N'</td><td>' + CAST(@MthCentralMissing as CHAR) +
		N'</td><td>' + CASE WHEN (@MthCentralCount = 0) THEN @NA ELSE CAST((cast((@MthCentralOT/@MthCentralCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		N'<td>'+ CAST(@MthCentralWMCount as CHAR) +
		N'</td><td>' + CAST(@MthCentralWMOT as CHAR) +
		N'</td><td>' + CAST(@MthCentralWMMissing as CHAR) +
		N'</td><td>' + CASE WHEN (@MthCentralWMCount = 0) THEN @NA ELSE CAST((cast((@MthCentralWMOT/@MthCentralWMCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		--N'<td>'+ CAST(@MthCentralCountItem as CHAR) +
		--N'</td><td>' + CAST(@MthCentralOTItem as CHAR) +
		--N'</td><td>' + CAST(@MthCentralMissingItem as CHAR) +
		--N'</td><td>' + CASE WHEN (@MthCentralCountItem = 0) THEN @NA ELSE CAST((cast((@MthCentralOTItem/@MthCentralCountItem) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		--N'<td>'+ CAST(@MthCentralWMCount as CHAR) +
		--N'</td><td>' + CAST(@MthCentralWMOTItem as CHAR) +
		--N'</td><td>' + CAST(@MthCentralWMMissingItem as CHAR) +
		--N'</td><td>' + CASE WHEN (@MthCentralWMCountItem = 0) THEN @NA ELSE CAST((cast((@MthCentralWMOTItem/@MthCentralWMCountItem) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		
		
		N'<tr><td><b>NEW EVERMAN</b></TD>' +
		N'<td>'+ CAST(@MthNewEvermanCount as CHAR) +
		N'</td><td>' + CAST(@MthNewEvermanOT as CHAR) +
		N'</td><td>' + CAST(@MthNewEvermanMissing as CHAR) +
		N'</td><td>' + CASE WHEN (@MthNewEvermanCount = 0) THEN @NA ELSE CAST((cast((@MthNewEvermanOT/@MthNewEvermanCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		N'<td>'+ CAST(@MthNewEvermanWMCount as CHAR) +
		N'</td><td>' + CAST(@MthNewEvermanWMOT as CHAR) +
		N'</td><td>' + CAST(@MthNewEvermanWMMissing as CHAR) +
		N'</td><td>' + CASE WHEN (@MthNewEvermanWMCount = 0) THEN @NA ELSE CAST((cast((@MthNewEvermanWMOT/@MthNewEvermanWMCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		--N'<td>'+ CAST(@MthNewEvermanCountItem as CHAR) +
		--N'</td><td>' + CAST(@MthNewEvermanOTItem as CHAR) +
		--N'</td><td>' + CAST(@MthNewEvermanMissingItem as CHAR) +
		--N'</td><td>' + CASE WHEN (@MthNewEvermanCountItem = 0) THEN @NA ELSE CAST((cast((@MthNewEvermanOTItem/@MthNewEvermanCountItem) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		--N'<td>'+ CAST(@MthNewEvermanWMCount as CHAR) +
		--N'</td><td>' + CAST(@MthNewEvermanWMOTItem as CHAR) +
		--N'</td><td>' + CAST(@MthNewEvermanWMMissingItem as CHAR) +
		--N'</td><td>' + CASE WHEN (@MthNewEvermanWMCountItem = 0) THEN @NA ELSE CAST((cast((@MthNewEvermanWMOTItem/@MthNewEvermanWMCountItem) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		
		
		N'<tr><td><b><I>TOTAL</I></b></TD>' +
		N'<td><b>'+ CAST(@MthTotalCount as CHAR) +
		N'</td><td><b>' + CAST(@MthTotalOT as CHAR) +
		N'</td><td><b>' + CAST(@MthTotalMissing as CHAR) +
		N'</td><td><b>' + CASE WHEN (@MthTotalCount = 0) THEN @NA ELSE CAST((cast((@MthTotalOT/@MthTotalCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		N'<td><b>'+ CAST(@MthTotalWMCount as CHAR) +
		N'</td><td><b>' + CAST(@MthTotalWMOT as CHAR) +
		N'</td><td><b>' + CAST(@MthTotalWMMissing as CHAR) +
		N'</td><td><b>' + CASE WHEN (@MthTotalWMCount = 0) THEN @NA ELSE CAST((cast((@MthTotalWMOT/@MthTotalWMCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		--N'<td>'+ CAST(@MthTotalCountItem as CHAR) +
		--N'</td><td>' + CAST(@MthTotalOTItem as CHAR) +
		--N'</td><td>' + CAST(@MthTotalMissingItem as CHAR) +
		--N'</td><td>' + CASE WHEN (@MthTotalCountItem = 0) THEN @NA ELSE CAST((cast((@MthTotalOTItem/@MthTotalCountItem) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		--N'<td>'+ CAST(@MthTotalWMCount as CHAR) +
		--N'</td><td>' + CAST(@MthTotalWMOTItem as CHAR) +
		--N'</td><td>' + CAST(@MthTotalWMMissingItem as CHAR) +
		--N'</td><td>' + CASE WHEN (@MthTotalWMCountItem = 0) THEN @NA ELSE CAST((cast((@MthTotalWMOTItem/@MthTotalWMCountItem) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		
		N'</b></table>' + 
		N'<br><HR><br>If you have any questions about this report, please contact Bryan at 817-521-0352.' +
		N'</p>';


	/* Send the mail */
	EXEC	msdb.dbo.sp_send_dbmail
	
			@profile_name = 'SQL2008_DBMail_IT_General',
			@recipients = 'dan.cooper@marcocompany.com; craig.nickell@marcocompany.com; victor.gandara@marcocompany.com; john.quiroz@marcocompany.com; darrell.cooper@marcocompany.com; gary.dews@marcocompany.com; katrina.little@marcocompany.com; ray.lewis@marcocompany.com; igor.savic@marcocompany.com; allen.patterson@marcocompany.com; johnnie.bynum@marcocompany.com; jon.stewart@marcocompany.com; carl.cunningham@marcocompany.com; cheryl.little@marcocompany.com; jud.griffis@marcocompany.com; roosevelt.dilworth@marcocompany.com; laura.romero@marcocompany.com; steve.jarboe@marcocompany.com; deborah.brennan@marcocompany.com; daryl.kidd@marcocompany.com; scott.smith@marcocompany.com; jeff.bradfield@marcocompany.com; del.pentecost@marcocompany.com',
			@copy_recipients = 'bryan.gregory@marcocompany.com',
			@file_attachments = '',
			@body_format = 'HTML',
			@body = @tableHTML,
			@subject = 'Daily On Time Shipping Report for Yesterday' ;
