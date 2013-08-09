USE [001]
GO

	DECLARE @tableHTML  NVARCHAR(MAX)
	DECLARE @PlasticCount DECIMAL(5,0)
	DECLARE @PlasticMissing DECIMAL(5,0) 
	DECLARE @WoodshopCount DECIMAL(5,0)
	DECLARE @WoodshopMissing DECIMAL(5,0)
	DECLARE @BeachCount DECIMAL(5,0)
	DECLARE @BeachMissing DECIMAL(5,0)
	DECLARE @CentralCount DECIMAL(5,0)
	DECLARE @CentralMissing DECIMAL(5,0)
	DECLARE @NewEvermanCount DECIMAL(5,0)
	DECLARE @NewEvermanMissing DECIMAL(5,0)
	
	DECLARE @PlasticWkCount DECIMAL(5,0)
	DECLARE @PlasticWkMissing DECIMAL(5,0) 
	DECLARE @WoodshopWkCount DECIMAL(5,0)
	DECLARE @WoodshopWkMissing DECIMAL(5,0)
	DECLARE @BeachWkCount DECIMAL(5,0)
	DECLARE @BeachWkMissing DECIMAL(5,0)
	DECLARE @CentralWkCount DECIMAL(5,0)
	DECLARE @CentralWkMissing DECIMAL(5,0)
	DECLARE @NewEvermanWkCount DECIMAL(5,0)
	DECLARE @NewEvermanWkMissing DECIMAL(5,0)
	
	DECLARE @NA NVARCHAR(MAX)
	;
	SET @NA=' N/A'
	SET @PlasticCount = 
	CAST((SELECT COUNT(OL.item_no) 
	
					FROM         Z_ALLORDLIN OL INNER JOIN
										  Z_ALLORDHDR OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
										  ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
										  WMPALID PL ON OH.oe_po_no = PL.purchaseorder AND OL.item_no = PL.marco_item_no LEFT OUTER JOIN
										  OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
										  EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via
					WHERE     /* INITIAL WHERE CLAUSE */ ltrim(OH.cus_no) IN ('1575', '20938') AND OH.oe_po_no > '0' AND OH.ord_type = 'O' AND 
										  NOT OH.user_def_fld_4 LIKE '%ON%' AND NOT OH.user_def_fld_4 LIKE '%FX%' AND NOT OH.user_def_fld_4 LIKE '%RP%' AND OH.slspsn_no IN ('011',
										   '047') AND OH.oe_po_no IS NOT NULL AND SH.void_fg IS NULL AND NOT OL.item_no IN ('ADD ON', 'BACKORDER', 'CAP EX', 'FIXTURE REQUEST', 
										  'INITIAL DIV 01', 'INITIAL RM', 'INITIAL SC', 'INITIAL WNM', 'PROTOTYPE METAL', 'PROTOTYPE PLASTIC', 'PROTOTYPE WOOD', 'REVIEW ITEM', 
										  'SAMPLE','DVD SHELF SET','WM-PETITEMOMZONE','WM-MOVIEDUMPBIN') AND isnumeric(OH.oe_po_no) = 1 
										  /*FOR ONLY 1 SHOP*/
										  AND (SH.mode = 1) 
												/*For Only Yesterday*/
												AND ((SH.void_fg IS NULL) AND (CONVERT(varchar, CAST(RTRIM(SH.ship_dt) 
										  AS datetime), 101)) = (CONVERT(VARCHAR, (DATEADD(day, - 1, GETDATE()) ), 101))) )
 
             as int)
    SET @PlasticMissing = 
    CAST((SELECT COUNT(OL.item_no)
						FROM         Z_ALLORDLIN OL INNER JOIN
                      Z_ALLORDHDR OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      WMPALID PL ON OH.oe_po_no = PL.purchaseorder AND OL.item_no = PL.marco_item_no LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via
						WHERE     /* INITIAL WHERE CLAUSE */ ltrim(OH.cus_no) IN ('1575', '20938') AND OH.oe_po_no > '0' AND OH.ord_type = 'O' AND 
                      NOT OH.user_def_fld_4 LIKE '%ON%' AND NOT OH.user_def_fld_4 LIKE '%FX%' AND NOT OH.user_def_fld_4 LIKE '%RP%' AND OH.slspsn_no IN ('011',
                       '047') AND OH.oe_po_no IS NOT NULL AND SH.void_fg IS NULL AND NOT OL.item_no IN ('ADD ON', 'BACKORDER', 'CAP EX', 'FIXTURE REQUEST', 
                      'INITIAL DIV 01', 'INITIAL RM', 'INITIAL SC', 'INITIAL WNM', 'PROTOTYPE METAL', 'PROTOTYPE PLASTIC', 'PROTOTYPE WOOD', 'REVIEW ITEM', 
                      'SAMPLE','DVD SHELF SET','WM-PETITEMOMZONE','WM-MOVIEDUMPBIN') AND isnumeric(OH.oe_po_no) = 1 /* ONLY PALLET_MISSING_SHIPPED RECORDS */ AND (OH.ord_no IN
                          (SELECT DISTINCT cast(ord_no AS int)
                            FROM          arshttbl) AND PL.palletid IS NULL AND NOT SH.hand_chg IS NULL)
                            /*FOR ONLY 1 SHOP*/
							AND (SH.mode = 1)   
                            /*For Only Yesterday*/
                            AND ((SH.void_fg IS NULL) AND (CONVERT(varchar, CAST(RTRIM(SH.ship_dt) 
                      AS datetime), 101)) = (CONVERT(VARCHAR, (DATEADD(day, - 2, GETDATE()) ), 101))) )

						as int)
	SET @WoodshopCount = 
	CAST((SELECT COUNT(OL.item_no) 
	
					FROM         Z_ALLORDLIN OL INNER JOIN
										  Z_ALLORDHDR OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
										  ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
										  WMPALID PL ON OH.oe_po_no = PL.purchaseorder AND OL.item_no = PL.marco_item_no LEFT OUTER JOIN
										  OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
										  EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via
					WHERE     /* INITIAL WHERE CLAUSE */ ltrim(OH.cus_no) IN ('1575', '20938') AND OH.oe_po_no > '0' AND OH.ord_type = 'O' AND 
										  NOT OH.user_def_fld_4 LIKE '%ON%' AND NOT OH.user_def_fld_4 LIKE '%FX%' AND NOT OH.user_def_fld_4 LIKE '%RP%' AND OH.slspsn_no IN ('011',
										   '047') AND OH.oe_po_no IS NOT NULL AND SH.void_fg IS NULL AND NOT OL.item_no IN ('ADD ON', 'BACKORDER', 'CAP EX', 'FIXTURE REQUEST', 
										  'INITIAL DIV 01', 'INITIAL RM', 'INITIAL SC', 'INITIAL WNM', 'PROTOTYPE METAL', 'PROTOTYPE PLASTIC', 'PROTOTYPE WOOD', 'REVIEW ITEM', 
										  'SAMPLE','DVD SHELF SET','WM-PETITEMOMZONE','WM-MOVIEDUMPBIN') AND isnumeric(OH.oe_po_no) = 1 
										  /*FOR ONLY 1 SHOP*/
										  AND (SH.mode = 2) 
												/*For Only Yesterday*/
												AND ((SH.void_fg IS NULL) AND (CONVERT(varchar, CAST(RTRIM(SH.ship_dt) 
										  AS datetime), 101)) = (CONVERT(VARCHAR, (DATEADD(day, - 1, GETDATE()) ), 101))) )
 
             as int)
    SET @WoodshopMissing = 
    CAST((SELECT COUNT(OL.item_no)
						FROM         Z_ALLORDLIN OL INNER JOIN
                      Z_ALLORDHDR OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      WMPALID PL ON OH.oe_po_no = PL.purchaseorder AND OL.item_no = PL.marco_item_no LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via
						WHERE     /* INITIAL WHERE CLAUSE */ ltrim(OH.cus_no) IN ('1575', '20938') AND OH.oe_po_no > '0' AND OH.ord_type = 'O' AND 
                      NOT OH.user_def_fld_4 LIKE '%ON%' AND NOT OH.user_def_fld_4 LIKE '%FX%' AND NOT OH.user_def_fld_4 LIKE '%RP%' AND OH.slspsn_no IN ('011',
                       '047') AND OH.oe_po_no IS NOT NULL AND SH.void_fg IS NULL AND NOT OL.item_no IN ('ADD ON', 'BACKORDER', 'CAP EX', 'FIXTURE REQUEST', 
                      'INITIAL DIV 01', 'INITIAL RM', 'INITIAL SC', 'INITIAL WNM', 'PROTOTYPE METAL', 'PROTOTYPE PLASTIC', 'PROTOTYPE WOOD', 'REVIEW ITEM', 
                      'SAMPLE','DVD SHELF SET','WM-PETITEMOMZONE','WM-MOVIEDUMPBIN') AND isnumeric(OH.oe_po_no) = 1 /* ONLY PALLET_MISSING_SHIPPED RECORDS */ AND (OH.ord_no IN
                          (SELECT DISTINCT cast(ord_no AS int)
                            FROM          arshttbl) AND PL.palletid IS NULL AND NOT SH.hand_chg IS NULL)
                            /*FOR ONLY 1 SHOP*/
							AND (SH.mode = 2)   
                            /*For Only Yesterday*/
                            AND ((SH.void_fg IS NULL) AND (CONVERT(varchar, CAST(RTRIM(SH.ship_dt) 
                      AS datetime), 101)) = (CONVERT(VARCHAR, (DATEADD(day, - 1, GETDATE()) ), 101))) )

						as int)			
	SET @BeachCount = 
	CAST((SELECT COUNT(OL.item_no) 
	
					FROM         Z_ALLORDLIN OL INNER JOIN
										  Z_ALLORDHDR OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
										  ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
										  WMPALID PL ON OH.oe_po_no = PL.purchaseorder AND OL.item_no = PL.marco_item_no LEFT OUTER JOIN
										  OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
										  EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via
					WHERE     /* INITIAL WHERE CLAUSE */ ltrim(OH.cus_no) IN ('1575', '20938') AND OH.oe_po_no > '0' AND OH.ord_type = 'O' AND 
										  NOT OH.user_def_fld_4 LIKE '%ON%' AND NOT OH.user_def_fld_4 LIKE '%FX%' AND NOT OH.user_def_fld_4 LIKE '%RP%' AND OH.slspsn_no IN ('011',
										   '047') AND OH.oe_po_no IS NOT NULL AND SH.void_fg IS NULL AND NOT OL.item_no IN ('ADD ON', 'BACKORDER', 'CAP EX', 'FIXTURE REQUEST', 
										  'INITIAL DIV 01', 'INITIAL RM', 'INITIAL SC', 'INITIAL WNM', 'PROTOTYPE METAL', 'PROTOTYPE PLASTIC', 'PROTOTYPE WOOD', 'REVIEW ITEM', 
										  'SAMPLE','DVD SHELF SET','WM-PETITEMOMZONE','WM-MOVIEDUMPBIN') AND isnumeric(OH.oe_po_no) = 1 
										  /*FOR ONLY 1 SHOP*/
										  AND (SH.mode = 3) 
												/*For Only Yesterday*/
												AND ((SH.void_fg IS NULL) AND (CONVERT(varchar, CAST(RTRIM(SH.ship_dt) 
										  AS datetime), 101)) = (CONVERT(VARCHAR, (DATEADD(day, - 1, GETDATE()) ), 101))) )
 
             as int)
    SET @BeachMissing = 
    CAST((SELECT COUNT(OL.item_no)
						FROM         Z_ALLORDLIN OL INNER JOIN
                      Z_ALLORDHDR OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      WMPALID PL ON OH.oe_po_no = PL.purchaseorder AND OL.item_no = PL.marco_item_no LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via
						WHERE     /* INITIAL WHERE CLAUSE */ ltrim(OH.cus_no) IN ('1575', '20938') AND OH.oe_po_no > '0' AND OH.ord_type = 'O' AND 
                      NOT OH.user_def_fld_4 LIKE '%ON%' AND NOT OH.user_def_fld_4 LIKE '%FX%' AND NOT OH.user_def_fld_4 LIKE '%RP%' AND OH.slspsn_no IN ('011',
                       '047') AND OH.oe_po_no IS NOT NULL AND SH.void_fg IS NULL AND NOT OL.item_no IN ('ADD ON', 'BACKORDER', 'CAP EX', 'FIXTURE REQUEST', 
                      'INITIAL DIV 01', 'INITIAL RM', 'INITIAL SC', 'INITIAL WNM', 'PROTOTYPE METAL', 'PROTOTYPE PLASTIC', 'PROTOTYPE WOOD', 'REVIEW ITEM', 
                      'SAMPLE','DVD SHELF SET','WM-PETITEMOMZONE','WM-MOVIEDUMPBIN') AND isnumeric(OH.oe_po_no) = 1 /* ONLY PALLET_MISSING_SHIPPED RECORDS */ AND (OH.ord_no IN
                          (SELECT DISTINCT cast(ord_no AS int)
                            FROM          arshttbl) AND PL.palletid IS NULL AND NOT SH.hand_chg IS NULL)
                            /*FOR ONLY 1 SHOP*/
							AND (SH.mode = 3)   
                            /*For Only Yesterday*/
                            AND ((SH.void_fg IS NULL) AND (CONVERT(varchar, CAST(RTRIM(SH.ship_dt) 
                      AS datetime), 101)) = (CONVERT(VARCHAR, (DATEADD(day, - 1, GETDATE()) ), 101))) )

						as int)
	SET @CentralCount = 
	CAST((SELECT COUNT(OL.item_no) 
	
					FROM         Z_ALLORDLIN OL INNER JOIN
										  Z_ALLORDHDR OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
										  ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
										  WMPALID PL ON OH.oe_po_no = PL.purchaseorder AND OL.item_no = PL.marco_item_no LEFT OUTER JOIN
										  OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
										  EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via
					WHERE     /* INITIAL WHERE CLAUSE */ ltrim(OH.cus_no) IN ('1575', '20938') AND OH.oe_po_no > '0' AND OH.ord_type = 'O' AND 
										  NOT OH.user_def_fld_4 LIKE '%ON%' AND NOT OH.user_def_fld_4 LIKE '%FX%' AND NOT OH.user_def_fld_4 LIKE '%RP%' AND OH.slspsn_no IN ('011',
										   '047') AND OH.oe_po_no IS NOT NULL AND SH.void_fg IS NULL AND NOT OL.item_no IN ('ADD ON', 'BACKORDER', 'CAP EX', 'FIXTURE REQUEST', 
										  'INITIAL DIV 01', 'INITIAL RM', 'INITIAL SC', 'INITIAL WNM', 'PROTOTYPE METAL', 'PROTOTYPE PLASTIC', 'PROTOTYPE WOOD', 'REVIEW ITEM', 
										  'SAMPLE','DVD SHELF SET','WM-PETITEMOMZONE','WM-MOVIEDUMPBIN') AND isnumeric(OH.oe_po_no) = 1 
										  /*FOR ONLY 1 SHOP*/
										  AND (SH.mode = 4) 
												/*For Only Yesterday*/
												AND ((SH.void_fg IS NULL) AND (CONVERT(varchar, CAST(RTRIM(SH.ship_dt) 
										  AS datetime), 101)) = (CONVERT(VARCHAR, (DATEADD(day, - 1, GETDATE()) ), 101))) )
 
             as int)
    SET @CentralMissing = 
    CAST((SELECT COUNT(OL.item_no)
						FROM         Z_ALLORDLIN OL INNER JOIN
                      Z_ALLORDHDR OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      WMPALID PL ON OH.oe_po_no = PL.purchaseorder AND OL.item_no = PL.marco_item_no LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via
						WHERE     /* INITIAL WHERE CLAUSE */ ltrim(OH.cus_no) IN ('1575', '20938') AND OH.oe_po_no > '0' AND OH.ord_type = 'O' AND 
                      NOT OH.user_def_fld_4 LIKE '%ON%' AND NOT OH.user_def_fld_4 LIKE '%FX%' AND NOT OH.user_def_fld_4 LIKE '%RP%' AND OH.slspsn_no IN ('011',
                       '047') AND OH.oe_po_no IS NOT NULL AND SH.void_fg IS NULL AND NOT OL.item_no IN ('ADD ON', 'BACKORDER', 'CAP EX', 'FIXTURE REQUEST', 
                      'INITIAL DIV 01', 'INITIAL RM', 'INITIAL SC', 'INITIAL WNM', 'PROTOTYPE METAL', 'PROTOTYPE PLASTIC', 'PROTOTYPE WOOD', 'REVIEW ITEM', 
                      'SAMPLE','DVD SHELF SET','WM-PETITEMOMZONE','WM-MOVIEDUMPBIN') AND isnumeric(OH.oe_po_no) = 1 /* ONLY PALLET_MISSING_SHIPPED RECORDS */ AND (OH.ord_no IN
                          (SELECT DISTINCT cast(ord_no AS int)
                            FROM          arshttbl) AND PL.palletid IS NULL AND NOT SH.hand_chg IS NULL)
                            /*FOR ONLY 1 SHOP*/
							AND (SH.mode = 4)   
                            /*For Only Yesterday*/
                            AND ((SH.void_fg IS NULL) AND (CONVERT(varchar, CAST(RTRIM(SH.ship_dt) 
                      AS datetime), 101)) = (CONVERT(VARCHAR, (DATEADD(day, - 1, GETDATE()) ), 101))) )

						as int)
	SET @NewEvermanCount = 
	CAST((SELECT COUNT(OL.item_no) 
	
					FROM         Z_ALLORDLIN OL INNER JOIN
										  Z_ALLORDHDR OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
										  ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
										  WMPALID PL ON OH.oe_po_no = PL.purchaseorder AND OL.item_no = PL.marco_item_no LEFT OUTER JOIN
										  OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
										  EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via
					WHERE     /* INITIAL WHERE CLAUSE */ ltrim(OH.cus_no) IN ('1575', '20938') AND OH.oe_po_no > '0' AND OH.ord_type = 'O' AND 
										  NOT OH.user_def_fld_4 LIKE '%ON%' AND NOT OH.user_def_fld_4 LIKE '%FX%' AND NOT OH.user_def_fld_4 LIKE '%RP%' AND OH.slspsn_no IN ('011',
										   '047') AND OH.oe_po_no IS NOT NULL AND SH.void_fg IS NULL AND NOT OL.item_no IN ('ADD ON', 'BACKORDER', 'CAP EX', 'FIXTURE REQUEST', 
										  'INITIAL DIV 01', 'INITIAL RM', 'INITIAL SC', 'INITIAL WNM', 'PROTOTYPE METAL', 'PROTOTYPE PLASTIC', 'PROTOTYPE WOOD', 'REVIEW ITEM', 
										  'SAMPLE','DVD SHELF SET','WM-PETITEMOMZONE','WM-MOVIEDUMPBIN') AND isnumeric(OH.oe_po_no) = 1 
										  /*FOR ONLY 1 SHOP*/
										  AND (SH.mode = 5) 
												/*For Only Yesterday*/
												AND ((SH.void_fg IS NULL) AND (CONVERT(varchar, CAST(RTRIM(SH.ship_dt) 
										  AS datetime), 101)) = (CONVERT(VARCHAR, (DATEADD(day, - 1, GETDATE()) ), 101))) )
 
             as int)
    SET @NewEvermanMissing = 
    CAST((SELECT COUNT(OL.item_no)
						FROM         Z_ALLORDLIN OL INNER JOIN
                      Z_ALLORDHDR OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      WMPALID PL ON OH.oe_po_no = PL.purchaseorder AND OL.item_no = PL.marco_item_no LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via
						WHERE     /* INITIAL WHERE CLAUSE */ ltrim(OH.cus_no) IN ('1575', '20938') AND OH.oe_po_no > '0' AND OH.ord_type = 'O' AND 
                      NOT OH.user_def_fld_4 LIKE '%ON%' AND NOT OH.user_def_fld_4 LIKE '%FX%' AND NOT OH.user_def_fld_4 LIKE '%RP%' AND OH.slspsn_no IN ('011',
                       '047') AND OH.oe_po_no IS NOT NULL AND SH.void_fg IS NULL AND NOT OL.item_no IN ('ADD ON', 'BACKORDER', 'CAP EX', 'FIXTURE REQUEST', 
                      'INITIAL DIV 01', 'INITIAL RM', 'INITIAL SC', 'INITIAL WNM', 'PROTOTYPE METAL', 'PROTOTYPE PLASTIC', 'PROTOTYPE WOOD', 'REVIEW ITEM', 
                      'SAMPLE','DVD SHELF SET','WM-PETITEMOMZONE','WM-MOVIEDUMPBIN') AND isnumeric(OH.oe_po_no) = 1 /* ONLY PALLET_MISSING_SHIPPED RECORDS */ AND (OH.ord_no IN
                          (SELECT DISTINCT cast(ord_no AS int)
                            FROM          arshttbl) AND PL.palletid IS NULL AND NOT SH.hand_chg IS NULL)
                            /*FOR ONLY 1 SHOP*/
							AND (SH.mode = 5)   
                            /*For Only Yesterday*/
                            AND ((SH.void_fg IS NULL) AND (CONVERT(varchar, CAST(RTRIM(SH.ship_dt) 
                      AS datetime), 101)) = (CONVERT(VARCHAR, (DATEADD(day, - 1, GETDATE()) ), 101))) )

						as int)	
						
	SET @PlasticWkCount = 
	CAST((SELECT COUNT( OL.item_no) 
	
					FROM         Z_ALLORDLIN OL INNER JOIN
										  Z_ALLORDHDR OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
										  ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
										  WMPALID PL ON OH.oe_po_no = PL.purchaseorder AND OL.item_no = PL.marco_item_no LEFT OUTER JOIN
										  OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
										  EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via
					WHERE     /* INITIAL WHERE CLAUSE */ ltrim(OH.cus_no) IN ('1575', '20938') AND OH.oe_po_no > '0' AND OH.ord_type = 'O' AND 
										  NOT OH.user_def_fld_4 LIKE '%ON%' AND NOT OH.user_def_fld_4 LIKE '%FX%' AND NOT OH.user_def_fld_4 LIKE '%RP%' AND OH.slspsn_no IN ('011',
										   '047') AND OH.oe_po_no IS NOT NULL AND SH.void_fg IS NULL AND NOT OL.item_no IN ('ADD ON', 'BACKORDER', 'CAP EX', 'FIXTURE REQUEST', 
										  'INITIAL DIV 01', 'INITIAL RM', 'INITIAL SC', 'INITIAL WNM', 'PROTOTYPE METAL', 'PROTOTYPE PLASTIC', 'PROTOTYPE WOOD', 'REVIEW ITEM', 
										  'SAMPLE','DVD SHELF SET','WM-PETITEMOMZONE','WM-MOVIEDUMPBIN') AND isnumeric(OH.oe_po_no) = 1 
										  /*FOR ONLY 1 SHOP*/
										  AND (SH.mode = 1) 
												/*For Only last week not including today*/
												AND ((SH.void_fg IS NULL) AND (CONVERT(varchar, CAST(RTRIM(SH.ship_dt) 
										  AS datetime), 101) > DATEADD(day, - 8, GETDATE())) AND  NOT (CONVERT(varchar, CAST(RTRIM(SH.ship_dt) 
										  AS datetime), 101)) = (CONVERT(VARCHAR, GETDATE(), 101))) )
 
             as int)
    SET @PlasticWkMissing = 
    CAST((SELECT COUNT( OL.item_no)
						FROM         Z_ALLORDLIN OL INNER JOIN
                      Z_ALLORDHDR OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      WMPALID PL ON OH.oe_po_no = PL.purchaseorder AND OL.item_no = PL.marco_item_no LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via
						WHERE     /* INITIAL WHERE CLAUSE */ ltrim(OH.cus_no) IN ('1575', '20938') AND OH.oe_po_no > '0' AND OH.ord_type = 'O' AND 
                      NOT OH.user_def_fld_4 LIKE '%ON%' AND NOT OH.user_def_fld_4 LIKE '%FX%' AND NOT OH.user_def_fld_4 LIKE '%RP%' AND OH.slspsn_no IN ('011',
                       '047') AND OH.oe_po_no IS NOT NULL AND SH.void_fg IS NULL AND NOT OL.item_no IN ('ADD ON', 'BACKORDER', 'CAP EX', 'FIXTURE REQUEST', 
                      'INITIAL DIV 01', 'INITIAL RM', 'INITIAL SC', 'INITIAL WNM', 'PROTOTYPE METAL', 'PROTOTYPE PLASTIC', 'PROTOTYPE WOOD', 'REVIEW ITEM', 
                      'SAMPLE','DVD SHELF SET','WM-PETITEMOMZONE','WM-MOVIEDUMPBIN') AND isnumeric(OH.oe_po_no) = 1 /* ONLY PALLET_MISSING_SHIPPED RECORDS */ AND (OH.ord_no IN
                          (SELECT DISTINCT cast(ord_no AS int)
                            FROM          arshttbl) AND PL.palletid IS NULL AND NOT SH.hand_chg IS NULL)
                            /*FOR ONLY 1 SHOP*/
							AND (SH.mode = 1)   
                           /*For Only last week not including today*/
												AND ((SH.void_fg IS NULL) AND (CONVERT(varchar, CAST(RTRIM(SH.ship_dt) 
										  AS datetime), 101) > DATEADD(day, - 8, GETDATE())) AND  NOT (CONVERT(varchar, CAST(RTRIM(SH.ship_dt) 
										  AS datetime), 101)) = (CONVERT(VARCHAR, GETDATE(), 101))) )

						as int)
	SET @WoodshopWkCount = 
	CAST((SELECT COUNT( OL.item_no) 
	
					FROM         Z_ALLORDLIN OL INNER JOIN
										  Z_ALLORDHDR OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
										  ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
										  WMPALID PL ON OH.oe_po_no = PL.purchaseorder AND OL.item_no = PL.marco_item_no LEFT OUTER JOIN
										  OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
										  EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via
					WHERE     /* INITIAL WHERE CLAUSE */ ltrim(OH.cus_no) IN ('1575', '20938') AND OH.oe_po_no > '0' AND OH.ord_type = 'O' AND 
										  NOT OH.user_def_fld_4 LIKE '%ON%' AND NOT OH.user_def_fld_4 LIKE '%FX%' AND NOT OH.user_def_fld_4 LIKE '%RP%' AND OH.slspsn_no IN ('011',
										   '047') AND OH.oe_po_no IS NOT NULL AND SH.void_fg IS NULL AND NOT OL.item_no IN ('ADD ON', 'BACKORDER', 'CAP EX', 'FIXTURE REQUEST', 
										  'INITIAL DIV 01', 'INITIAL RM', 'INITIAL SC', 'INITIAL WNM', 'PROTOTYPE METAL', 'PROTOTYPE PLASTIC', 'PROTOTYPE WOOD', 'REVIEW ITEM', 
										  'SAMPLE','DVD SHELF SET','WM-PETITEMOMZONE','WM-MOVIEDUMPBIN') AND isnumeric(OH.oe_po_no) = 1 
										  /*FOR ONLY 1 SHOP*/
										  AND (SH.mode = 2) 
												/*For Only last week not including today*/
												AND ((SH.void_fg IS NULL) AND (CONVERT(varchar, CAST(RTRIM(SH.ship_dt) 
										  AS datetime), 101) > DATEADD(day, - 8, GETDATE())) AND  NOT (CONVERT(varchar, CAST(RTRIM(SH.ship_dt) 
										  AS datetime), 101)) = (CONVERT(VARCHAR, GETDATE(), 101))) )
 
             as int)
    SET @WoodshopWkMissing = 
    CAST((SELECT COUNT( OL.item_no)
						FROM         Z_ALLORDLIN OL INNER JOIN
                      Z_ALLORDHDR OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      WMPALID PL ON OH.oe_po_no = PL.purchaseorder AND OL.item_no = PL.marco_item_no LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via
						WHERE     /* INITIAL WHERE CLAUSE */ ltrim(OH.cus_no) IN ('1575', '20938') AND OH.oe_po_no > '0' AND OH.ord_type = 'O' AND 
                      NOT OH.user_def_fld_4 LIKE '%ON%' AND NOT OH.user_def_fld_4 LIKE '%FX%' AND NOT OH.user_def_fld_4 LIKE '%RP%' AND OH.slspsn_no IN ('011',
                       '047') AND OH.oe_po_no IS NOT NULL AND SH.void_fg IS NULL AND NOT OL.item_no IN ('ADD ON', 'BACKORDER', 'CAP EX', 'FIXTURE REQUEST', 
                      'INITIAL DIV 01', 'INITIAL RM', 'INITIAL SC', 'INITIAL WNM', 'PROTOTYPE METAL', 'PROTOTYPE PLASTIC', 'PROTOTYPE WOOD', 'REVIEW ITEM', 
                      'SAMPLE','DVD SHELF SET','WM-PETITEMOMZONE','WM-MOVIEDUMPBIN') AND isnumeric(OH.oe_po_no) = 1 /* ONLY PALLET_MISSING_SHIPPED RECORDS */ AND (OH.ord_no IN
                          (SELECT DISTINCT cast(ord_no AS int)
                            FROM          arshttbl) AND PL.palletid IS NULL AND NOT SH.hand_chg IS NULL)
                            /*FOR ONLY 1 SHOP*/
							AND (SH.mode = 2)   
                            /*For Only last week not including today*/
												AND ((SH.void_fg IS NULL) AND (CONVERT(varchar, CAST(RTRIM(SH.ship_dt) 
										  AS datetime), 101) > DATEADD(day, - 8, GETDATE())) AND  NOT (CONVERT(varchar, CAST(RTRIM(SH.ship_dt) 
										  AS datetime), 101)) = (CONVERT(VARCHAR, GETDATE(), 101))) )

						as int)			
	SET @BeachWkCount = 
	CAST((SELECT COUNT( OL.item_no) 
	
					FROM         Z_ALLORDLIN OL INNER JOIN
										  Z_ALLORDHDR OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
										  ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
										  WMPALID PL ON OH.oe_po_no = PL.purchaseorder AND OL.item_no = PL.marco_item_no LEFT OUTER JOIN
										  OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
										  EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via
					WHERE     /* INITIAL WHERE CLAUSE */ ltrim(OH.cus_no) IN ('1575', '20938') AND OH.oe_po_no > '0' AND OH.ord_type = 'O' AND 
										  NOT OH.user_def_fld_4 LIKE '%ON%' AND NOT OH.user_def_fld_4 LIKE '%FX%' AND NOT OH.user_def_fld_4 LIKE '%RP%' AND OH.slspsn_no IN ('011',
										   '047') AND OH.oe_po_no IS NOT NULL AND SH.void_fg IS NULL AND NOT OL.item_no IN ('ADD ON', 'BACKORDER', 'CAP EX', 'FIXTURE REQUEST', 
										  'INITIAL DIV 01', 'INITIAL RM', 'INITIAL SC', 'INITIAL WNM', 'PROTOTYPE METAL', 'PROTOTYPE PLASTIC', 'PROTOTYPE WOOD', 'REVIEW ITEM', 
										  'SAMPLE','DVD SHELF SET','WM-PETITEMOMZONE','WM-MOVIEDUMPBIN') AND isnumeric(OH.oe_po_no) = 1 
										  /*FOR ONLY 1 SHOP*/
										  AND (SH.mode = 3) 
												/*For Only last week not including today*/
												AND ((SH.void_fg IS NULL) AND (CONVERT(varchar, CAST(RTRIM(SH.ship_dt) 
										  AS datetime), 101) > DATEADD(day, - 8, GETDATE())) AND  NOT (CONVERT(varchar, CAST(RTRIM(SH.ship_dt) 
										  AS datetime), 101)) = (CONVERT(VARCHAR, GETDATE(), 101))) )
 
             as int)
    SET @BeachWkMissing = 
    CAST((SELECT COUNT( OL.item_no)
						FROM         Z_ALLORDLIN OL INNER JOIN
                      Z_ALLORDHDR OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      WMPALID PL ON OH.oe_po_no = PL.purchaseorder AND OL.item_no = PL.marco_item_no LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via
						WHERE     /* INITIAL WHERE CLAUSE */ ltrim(OH.cus_no) IN ('1575', '20938') AND OH.oe_po_no > '0' AND OH.ord_type = 'O' AND 
                      NOT OH.user_def_fld_4 LIKE '%ON%' AND NOT OH.user_def_fld_4 LIKE '%FX%' AND NOT OH.user_def_fld_4 LIKE '%RP%' AND OH.slspsn_no IN ('011',
                       '047') AND OH.oe_po_no IS NOT NULL AND SH.void_fg IS NULL AND NOT OL.item_no IN ('ADD ON', 'BACKORDER', 'CAP EX', 'FIXTURE REQUEST', 
                      'INITIAL DIV 01', 'INITIAL RM', 'INITIAL SC', 'INITIAL WNM', 'PROTOTYPE METAL', 'PROTOTYPE PLASTIC', 'PROTOTYPE WOOD', 'REVIEW ITEM', 
                      'SAMPLE','DVD SHELF SET','WM-PETITEMOMZONE','WM-MOVIEDUMPBIN') AND isnumeric(OH.oe_po_no) = 1 /* ONLY PALLET_MISSING_SHIPPED RECORDS */ AND (OH.ord_no IN
                          (SELECT DISTINCT cast(ord_no AS int)
                            FROM          arshttbl) AND PL.palletid IS NULL AND NOT SH.hand_chg IS NULL)
                            /*FOR ONLY 1 SHOP*/
							AND (SH.mode = 3)   
                            /*For Only last week not including today*/
												AND ((SH.void_fg IS NULL) AND (CONVERT(varchar, CAST(RTRIM(SH.ship_dt) 
										  AS datetime), 101) > DATEADD(day, - 8, GETDATE())) AND  NOT (CONVERT(varchar, CAST(RTRIM(SH.ship_dt) 
										  AS datetime), 101)) = (CONVERT(VARCHAR, GETDATE(), 101))) )

						as int)
	SET @CentralWkCount = 
	CAST((SELECT COUNT( OL.item_no) 
	
					FROM         Z_ALLORDLIN OL INNER JOIN
										  Z_ALLORDHDR OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
										  ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
										  WMPALID PL ON OH.oe_po_no = PL.purchaseorder AND OL.item_no = PL.marco_item_no LEFT OUTER JOIN
										  OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
										  EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via
					WHERE     /* INITIAL WHERE CLAUSE */ ltrim(OH.cus_no) IN ('1575', '20938') AND OH.oe_po_no > '0' AND OH.ord_type = 'O' AND 
										  NOT OH.user_def_fld_4 LIKE '%ON%' AND NOT OH.user_def_fld_4 LIKE '%FX%' AND NOT OH.user_def_fld_4 LIKE '%RP%' AND OH.slspsn_no IN ('011',
										   '047') AND OH.oe_po_no IS NOT NULL AND SH.void_fg IS NULL AND NOT OL.item_no IN ('ADD ON', 'BACKORDER', 'CAP EX', 'FIXTURE REQUEST', 
										  'INITIAL DIV 01', 'INITIAL RM', 'INITIAL SC', 'INITIAL WNM', 'PROTOTYPE METAL', 'PROTOTYPE PLASTIC', 'PROTOTYPE WOOD', 'REVIEW ITEM', 
										  'SAMPLE','DVD SHELF SET','WM-PETITEMOMZONE','WM-MOVIEDUMPBIN') AND isnumeric(OH.oe_po_no) = 1 
										  /*FOR ONLY 1 SHOP*/
										  AND (SH.mode = 4) 
												/*For Only last week not including today*/
												AND ((SH.void_fg IS NULL) AND (CONVERT(varchar, CAST(RTRIM(SH.ship_dt) 
										  AS datetime), 101) > DATEADD(day, - 8, GETDATE())) AND  NOT (CONVERT(varchar, CAST(RTRIM(SH.ship_dt) 
										  AS datetime), 101)) = (CONVERT(VARCHAR, GETDATE(), 101))) )
 
             as int)
    SET @CentralWkMissing = 
    CAST((SELECT COUNT( OL.item_no)
						FROM         Z_ALLORDLIN OL INNER JOIN
                      Z_ALLORDHDR OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      WMPALID PL ON OH.oe_po_no = PL.purchaseorder AND OL.item_no = PL.marco_item_no LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via
						WHERE     /* INITIAL WHERE CLAUSE */ ltrim(OH.cus_no) IN ('1575', '20938') AND OH.oe_po_no > '0' AND OH.ord_type = 'O' AND 
                      NOT OH.user_def_fld_4 LIKE '%ON%' AND NOT OH.user_def_fld_4 LIKE '%FX%' AND NOT OH.user_def_fld_4 LIKE '%RP%' AND OH.slspsn_no IN ('011',
                       '047') AND OH.oe_po_no IS NOT NULL AND SH.void_fg IS NULL AND NOT OL.item_no IN ('ADD ON', 'BACKORDER', 'CAP EX', 'FIXTURE REQUEST', 
                      'INITIAL DIV 01', 'INITIAL RM', 'INITIAL SC', 'INITIAL WNM', 'PROTOTYPE METAL', 'PROTOTYPE PLASTIC', 'PROTOTYPE WOOD', 'REVIEW ITEM', 
                      'SAMPLE','DVD SHELF SET','WM-PETITEMOMZONE','WM-MOVIEDUMPBIN') AND isnumeric(OH.oe_po_no) = 1 /* ONLY PALLET_MISSING_SHIPPED RECORDS */ AND (OH.ord_no IN
                          (SELECT DISTINCT cast(ord_no AS int)
                            FROM          arshttbl) AND PL.palletid IS NULL AND NOT SH.hand_chg IS NULL)
                            /*FOR ONLY 1 SHOP*/
							AND (SH.mode = 4)   
                            /*For Only last week not including today*/
												AND ((SH.void_fg IS NULL) AND (CONVERT(varchar, CAST(RTRIM(SH.ship_dt) 
										  AS datetime), 101) > DATEADD(day, - 8, GETDATE())) AND  NOT (CONVERT(varchar, CAST(RTRIM(SH.ship_dt) 
										  AS datetime), 101)) = (CONVERT(VARCHAR, GETDATE(), 101))) )

						as int)
	SET @NewEvermanWkCount = 
	CAST((SELECT COUNT( OL.item_no) 
	
					FROM         Z_ALLORDLIN OL INNER JOIN
										  Z_ALLORDHDR OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
										  ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
										  WMPALID PL ON OH.oe_po_no = PL.purchaseorder AND OL.item_no = PL.marco_item_no LEFT OUTER JOIN
										  OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
										  EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via
					WHERE     /* INITIAL WHERE CLAUSE */ ltrim(OH.cus_no) IN ('1575', '20938') AND OH.oe_po_no > '0' AND OH.ord_type = 'O' AND 
										  NOT OH.user_def_fld_4 LIKE '%ON%' AND NOT OH.user_def_fld_4 LIKE '%FX%' AND NOT OH.user_def_fld_4 LIKE '%RP%' AND OH.slspsn_no IN ('011',
										   '047') AND OH.oe_po_no IS NOT NULL AND SH.void_fg IS NULL AND NOT OL.item_no IN ('ADD ON', 'BACKORDER', 'CAP EX', 'FIXTURE REQUEST', 
										  'INITIAL DIV 01', 'INITIAL RM', 'INITIAL SC', 'INITIAL WNM', 'PROTOTYPE METAL', 'PROTOTYPE PLASTIC', 'PROTOTYPE WOOD', 'REVIEW ITEM', 
										  'SAMPLE','DVD SHELF SET','WM-PETITEMOMZONE','WM-MOVIEDUMPBIN') AND isnumeric(OH.oe_po_no) = 1 
										  /*FOR ONLY 1 SHOP*/
										  AND (SH.mode = 5) 
												/*For Only last week not including today*/
												AND ((SH.void_fg IS NULL) AND (CONVERT(varchar, CAST(RTRIM(SH.ship_dt) 
										  AS datetime), 101) > DATEADD(day, - 8, GETDATE())) AND  NOT (CONVERT(varchar, CAST(RTRIM(SH.ship_dt) 
										  AS datetime), 101)) = (CONVERT(VARCHAR, GETDATE(), 101))) )
 
             as int)
    SET @NewEvermanWkMissing = 
    CAST((SELECT COUNT( OL.item_no)
						FROM         Z_ALLORDLIN OL INNER JOIN
                      Z_ALLORDHDR OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      ARSHTTBL SH ON ltrim(OL.ord_no) = cast(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      WMPALID PL ON OH.oe_po_no = PL.purchaseorder AND OL.item_no = PL.marco_item_no LEFT OUTER JOIN
                      OECUSITM_SQL CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      EDCSHVFL_SQL XX ON SH.carrier_cd = XX.mac_ship_via
						WHERE     /* INITIAL WHERE CLAUSE */ ltrim(OH.cus_no) IN ('1575', '20938') AND OH.oe_po_no > '0' AND OH.ord_type = 'O' AND 
                      NOT OH.user_def_fld_4 LIKE '%ON%' AND NOT OH.user_def_fld_4 LIKE '%FX%' AND NOT OH.user_def_fld_4 LIKE '%RP%' AND OH.slspsn_no IN ('011',
                       '047') AND OH.oe_po_no IS NOT NULL AND SH.void_fg IS NULL AND NOT OL.item_no IN ('ADD ON', 'BACKORDER', 'CAP EX', 'FIXTURE REQUEST', 
                      'INITIAL DIV 01', 'INITIAL RM', 'INITIAL SC', 'INITIAL WNM', 'PROTOTYPE METAL', 'PROTOTYPE PLASTIC', 'PROTOTYPE WOOD', 'REVIEW ITEM', 
                      'SAMPLE','DVD SHELF SET','WM-PETITEMOMZONE','WM-MOVIEDUMPBIN') AND isnumeric(OH.oe_po_no) = 1 /* ONLY PALLET_MISSING_SHIPPED RECORDS */ AND (OH.ord_no IN
                          (SELECT DISTINCT cast(ord_no AS int)
                            FROM          arshttbl) AND PL.palletid IS NULL AND NOT SH.hand_chg IS NULL)
                            /*FOR ONLY 1 SHOP*/
							AND (SH.mode = 5)   
                            /*For Only last week not including today*/
												AND ((SH.void_fg IS NULL) AND (CONVERT(varchar, CAST(RTRIM(SH.ship_dt) 
										  AS datetime), 101) > DATEADD(day, - 8, GETDATE())) AND  NOT (CONVERT(varchar, CAST(RTRIM(SH.ship_dt) 
										  AS datetime), 101)) = (CONVERT(VARCHAR, GETDATE(), 101))) )

						as int)							
             
	SET @tableHTML =
		N'<p style="font-family:arial; font-size:12px;">' +
		N'<b>Shipping Team,</b><br><br>'+
		N'Below is a report of WM PO Scanning % from each dock for both yesterday and for the past 7 days.  For reference, attached to this email is the line item detail of the items shipped in the last 7 days that were missing Pallet IDs.<br><br>'  +
		N'If you have questions or concerns with the report, please contact Bryan at 817-521-0352.<br><br><br>' + 
			
		N'<table style="background-color:white; font-family:arial; font-size:12px;" border="1" cellpadding="2" cellspacing="0">' +
		N'<tr><th>DOCK</th>' +
		N'<th>ITEMS SHIPPED YESTERDAY </th>' +
		N'<th>ITEMS SCANNED YESTERDAY </th>' +
		N'<th>YESTERDAY SCAN %</th>' +
		N'<th>SHIPPED THIS WEEK</th>' +
		N'<th>SCANNED THIS WEEK</th>' +
		N'<th>WEEKLY SCAN %</th>' +
		
		N'<tr><td><b>PLASTICS</b></TD>' +
		N'<td>'+ CAST(@plasticCount as CHAR) +
		N'</td><td>' + CAST(@plasticCount - @PlasticMissing as CHAR) +
		N'</td><td><b>' + CASE WHEN (@PlasticCount = 0) THEN @NA ELSE CAST((cast(((@plasticCount - @plasticMissing)/@PlasticCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		N'<td>'+ CAST(@plasticWkCount as CHAR) +
		N'</td><td>' + CAST(@plasticWkCount - @PlasticWkMissing as CHAR) +
		N'</td><td><b>' + CASE WHEN (@PlasticWkCount = 0) THEN @NA ELSE CAST((cast(((@plasticWkCount - @PlasticWkMissing)/@PlasticWkCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		
		N'<tr><td><b>WOODSHOP</b></TD>' +
		N'<td>'+ CAST(@WoodshopCount as CHAR) +
		N'</td><td>' + CAST(@WoodshopCount - @WoodshopMissing as CHAR) +
		N'</td><td><b>' + CASE WHEN (@WoodshopCount = 0) THEN @NA ELSE CAST((cast(((@WoodshopCount - @WoodshopMissing)/@WoodshopCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		N'<td>'+ CAST(@WoodshopWkCount as CHAR) +
		N'</td><td>' + CAST(@WoodshopWkCount - @WoodshopWkMissing as CHAR) +
		N'</td><td><b>' + CASE WHEN (@WoodshopWkCount = 0) THEN @NA ELSE CAST((cast(((@WoodshopWkCount - @WoodshopWkMissing)/@WoodshopWkCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		
		N'<tr><td><b>BEACH</b></TD>' +
		N'<td>'+ CAST(@BeachCount as CHAR) +
		N'</td><td>' + CAST(@BeachCount - @BeachMissing as CHAR) +
		N'</td><td><b>' + CASE WHEN (@BeachCount = 0) THEN @NA ELSE CAST((cast(((@BeachCount - @BeachMissing)/@BeachCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		N'<td>'+ CAST(@BeachWkCount as CHAR) +
		N'</td><td>' + CAST(@BeachWkCount - @BeachWkMissing as CHAR) +
		N'</td><td><b>' + CASE WHEN (@BeachWkCount = 0) THEN @NA ELSE CAST((cast(((@BeachWkCount - @BeachWkMissing)/@BeachWkCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
				
		N'<tr><td><b>CENTRAL</B></TD>' +
		N'<td>'+ CAST(@CentralCount as CHAR) +
		N'</td><td>' + CAST(@CentralCount - @CentralMissing as CHAR) +
		N'</td><td><b>' + CASE WHEN (@CentralCount = 0) THEN @NA ELSE CAST((cast(((@CentralCount - @CentralMissing)/@CentralCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		N'<td>'+ CAST(@CentralWkCount as CHAR) +
		N'</td><td>' + CAST(@CentralWkCount - @CentralWkMissing as CHAR) +
		N'</td><td><b>' + CASE WHEN (@CentralWkCount = 0) THEN @NA ELSE CAST((cast(((@CentralWkCount - @CentralWkMissing)/@CentralWkCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
				
		N'<tr><td><b>NEW EVERMAN</b></TD>' +
		N'<td>'+ CAST(@NewEvermanCount as CHAR) +
		N'</td><td>' + CAST(@NewEvermanCount - @NewEvermanMissing as CHAR) +
		N'</td><td><b>' + CASE WHEN (@NewEvermanCount = 0) THEN @NA ELSE CAST((cast(((@NewEvermanCount - @NewEvermanMissing)/@NewEvermanCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		N'<td>'+ CAST(@NewEvermanWkCount as CHAR) +
		N'</td><td>' + CAST(@NewEvermanWkCount - @NewEvermanWkMissing as CHAR) +
		N'</td><td><b>' + CASE WHEN (@NewEvermanWkCount = 0) THEN @NA ELSE CAST((cast(((@NewEvermanWkCount - @NewEvermanWkMissing)/@NewEvermanWkCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		N'</table>' + 
			
		/*N'<br><br>If you have any questions about the report or are having barcoding/scanning issues, please contact Bryan at 817-521-0352.' +*/
		N'<br><br><b>Thanks,</b><br>'+
		N'The Marco Team</p>';


	/* Send the mail */
	EXEC	msdb.dbo.sp_send_dbmail
	
			@profile_name = 'SQL2008_DBMail_IT_General',
			@recipients = 'craig.nickell@marcocompany.com; ray.lewis@marcocompany.com; steve.jarboe@marcocompany.com; mike.sharp@marcocompany.com; victor.gandara@marcocompany.com; darrell.cooper@marcocompany.com; katrina.little@marcocompany.com; gary.dews@marcocompany.com; jon.stewart@marcocompany.com;  autumn.armstrong@marcocompany.com; alan.whited@marcocompany.com; brad.rogers@marcocompany.com; allen.patterson@marcocompany.com; tommy.magill@marcocompany.com; cheryl.little@marcocompany.com; melissa.calhoon@marcocompany.com; joshua.grider@marcocompany.com; rita.walker@marcocompany.com; rebekah.stephens@marcocompany.com; pat.buie@marcocompany.com',
			@copy_recipients = 'bryan.gregory@marcocompany.com',
			@file_attachments = 'C:\bin\CHPOMAIL\WM ITEMS SHIPPED LAST WEEK MISSING PALLET IDS.xls',
			@body_format = 'HTML',
			@body = @tableHTML,
			@subject = 'Daily WM PO Tracking Scanning Report' ;
			