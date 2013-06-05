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
	CAST((SELECT COUNT(distinct OL.item_no) 
	
					FROM         OEORDLIN_SQL OL INNER JOIN
										  OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
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
										  AS datetime), 101) > DATEADD(day, - 2, GETDATE()))) )
 
             as int)
    SET @PlasticMissing = 
    CAST((SELECT COUNT(distinct OL.item_no)
						FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
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
                      AS datetime), 101) > DATEADD(day, - 2, GETDATE()))) )

						as int)
	SET @WoodshopCount = 
	CAST((SELECT COUNT(distinct OL.item_no) 
	
					FROM         OEORDLIN_SQL OL INNER JOIN
										  OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
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
										  AS datetime), 101) > DATEADD(day, - 2, GETDATE()))) )
 
             as int)
    SET @WoodshopMissing = 
    CAST((SELECT COUNT(distinct OL.item_no)
						FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
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
                      AS datetime), 101) > DATEADD(day, - 2, GETDATE()))) )

						as int)			
	SET @BeachCount = 
	CAST((SELECT COUNT(distinct OL.item_no) 
	
					FROM         OEORDLIN_SQL OL INNER JOIN
										  OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
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
										  AS datetime), 101) > DATEADD(day, - 2, GETDATE()))) )
 
             as int)
    SET @BeachMissing = 
    CAST((SELECT COUNT(distinct OL.item_no)
						FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
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
                      AS datetime), 101) > DATEADD(day, - 2, GETDATE()))) )

						as int)
	SET @CentralCount = 
	CAST((SELECT COUNT(distinct OL.item_no) 
	
					FROM         OEORDLIN_SQL OL INNER JOIN
										  OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
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
										  AS datetime), 101) > DATEADD(day, - 2, GETDATE()))) )
 
             as int)
    SET @CentralMissing = 
    CAST((SELECT COUNT(distinct OL.item_no)
						FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
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
                      AS datetime), 101) > DATEADD(day, - 2, GETDATE()))) )

						as int)
	SET @NewEvermanCount = 
	CAST((SELECT COUNT(distinct OL.item_no) 
	
					FROM         OEORDLIN_SQL OL INNER JOIN
										  OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
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
										  AS datetime), 101) > DATEADD(day, - 2, GETDATE()))) )
 
             as int)
    SET @NewEvermanMissing = 
    CAST((SELECT COUNT(distinct OL.item_no)
						FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
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
                      AS datetime), 101) > DATEADD(day, - 2, GETDATE()))) )

						as int)	
						
	SET @PlasticWkCount = 
	CAST((SELECT COUNT(distinct OL.item_no) 
	
					FROM         OEORDLIN_SQL OL INNER JOIN
										  OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
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
										  AS datetime), 101) > DATEADD(day, - 8, GETDATE()))) )
 
             as int)
    SET @PlasticWkMissing = 
    CAST((SELECT COUNT(distinct OL.item_no)
						FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
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
                      AS datetime), 101) > DATEADD(day, - 8, GETDATE()))) )

						as int)
	SET @WoodshopWkCount = 
	CAST((SELECT COUNT(distinct OL.item_no) 
	
					FROM         OEORDLIN_SQL OL INNER JOIN
										  OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
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
										  AS datetime), 101) > DATEADD(day, - 8, GETDATE()))) )
 
             as int)
    SET @WoodshopWkMissing = 
    CAST((SELECT COUNT(distinct OL.item_no)
						FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
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
                      AS datetime), 101) > DATEADD(day, - 8, GETDATE()))) )

						as int)			
	SET @BeachWkCount = 
	CAST((SELECT COUNT(distinct OL.item_no) 
	
					FROM         OEORDLIN_SQL OL INNER JOIN
										  OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
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
										  AS datetime), 101) > DATEADD(day, - 8, GETDATE()))) )
 
             as int)
    SET @BeachWkMissing = 
    CAST((SELECT COUNT(distinct OL.item_no)
						FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
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
                      AS datetime), 101) > DATEADD(day, - 8, GETDATE()))) )

						as int)
	SET @CentralWkCount = 
	CAST((SELECT COUNT(distinct OL.item_no) 
	
					FROM         OEORDLIN_SQL OL INNER JOIN
										  OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
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
										  AS datetime), 101) > DATEADD(day, - 8, GETDATE()))) )
 
             as int)
    SET @CentralWkMissing = 
    CAST((SELECT COUNT(distinct OL.item_no)
						FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
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
                      AS datetime), 101) > DATEADD(day, - 8, GETDATE()))) )

						as int)
	SET @NewEvermanWkCount = 
	CAST((SELECT COUNT(distinct OL.item_no) 
	
					FROM         OEORDLIN_SQL OL INNER JOIN
										  OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
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
										  AS datetime), 101) > DATEADD(day, - 8, GETDATE()))) )
 
             as int)
    SET @NewEvermanWkMissing = 
    CAST((SELECT COUNT(distinct OL.item_no)
						FROM         OEORDLIN_SQL OL INNER JOIN
                      OEORDHDR_SQL OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
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
                      AS datetime), 101) > DATEADD(day, - 8, GETDATE()))) )

						as int)							
             
	SET @tableHTML =
		N'<p style="font-family:arial; font-size:12px;">' +
		N'<b>Shipping Team,</b><br><br>'+
		N'Below are the number of WM items shipped from each dock both yesterday and during the last week that were missing Pallet IDs, along with the total # of WM items shipped from each dock, and the total % of items missing Pallet IDs.  Every dock needs to be at 0% for the week.  For reference, attached to this email is the line item detail of the items shipped in the last 7 days that were missing Pallet IDs .<br><br>'  +
		N' If your dock is having issues achieving 100% or you have questions about the report, please contact Bryan at 817-521-0352.<br><br><br>' + 
			
		N'<table style="background-color:white; font-family:arial; font-size:12px;" border="1" cellpadding="2" cellspacing="0">' +
		N'<tr><th>DOCK</th>' +
		N'<th>SHIPPED YESTERDAY </th>' +
		N'<th>MISSING YESTERDAY </th>' +
		N'<th>YESTERDAY MISSING %</th>' +
		N'<th>SHIPPED THIS WEEK</th>' +
		N'<th>MISSING THIS WEEK</th>' +
		N'<th>WEEKLY MISSING %</th>' +
		
		N'<tr><td><b>PLASTICS</b></TD>' +
		N'<td>'+ CAST(@plasticCount as CHAR) +
		N'</td><td>' + CAST(@PlasticMissing as CHAR) +
		N'</td><td>' + CASE WHEN (@PlasticCount = 0) THEN @NA ELSE CAST((cast((@plasticMissing/@PlasticCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		N'<td>'+ CAST(@plasticWkCount as CHAR) +
		N'</td><td>' + CAST(@PlasticWkMissing as CHAR) +
		N'</td><td>' + CASE WHEN (@PlasticWkCount = 0) THEN @NA ELSE CAST((cast((@PlasticWkMissing/@PlasticWkCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		
		N'<tr><td><b>WOODSHOP</b></TD>' +
		N'<td>'+ CAST(@WoodshopCount as CHAR) +
		N'</td><td>' + CAST(@WoodshopMissing as CHAR) +
		N'</td><td>' + CASE WHEN (@WoodshopCount = 0) THEN @NA ELSE CAST((cast((@WoodshopMissing/@WoodshopCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		N'<td>'+ CAST(@WoodshopWkCount as CHAR) +
		N'</td><td>' + CAST(@WoodshopWkMissing as CHAR) +
		N'</td><td>' + CASE WHEN (@WoodshopWkCount = 0) THEN @NA ELSE CAST((cast((@WoodshopWkMissing/@WoodshopWkCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		
		N'<tr><td><b>BEACH</b></TD>' +
		N'<td>'+ CAST(@BeachCount as CHAR) +
		N'</td><td>' + CAST(@BeachMissing as CHAR) +
		N'</td><td>' + CASE WHEN (@BeachCount = 0) THEN @NA ELSE CAST((cast((@BeachMissing/@BeachCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		N'<td>'+ CAST(@BeachWkCount as CHAR) +
		N'</td><td>' + CAST(@BeachWkMissing as CHAR) +
		N'</td><td>' + CASE WHEN (@BeachWkCount = 0) THEN @NA ELSE CAST((cast((@BeachWkMissing/@BeachWkCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
				
		N'<tr><td><b>CENTRAL</B></TD>' +
		N'<td>'+ CAST(@CentralCount as CHAR) +
		N'</td><td>' + CAST(@CentralMissing as CHAR) +
		N'</td><td>' + CASE WHEN (@CentralCount = 0) THEN @NA ELSE CAST((cast((@CentralMissing/@CentralCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		N'<td>'+ CAST(@CentralWkCount as CHAR) +
		N'</td><td>' + CAST(@CentralWkMissing as CHAR) +
		N'</td><td>' + CASE WHEN (@CentralWkCount = 0) THEN @NA ELSE CAST((cast((@CentralWkMissing/@CentralWkCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
				
		N'<tr><td><b>NEW EVERMAN</b></TD>' +
		N'<td>'+ CAST(@NewEvermanCount as CHAR) +
		N'</td><td>' + CAST(@NewEvermanMissing as CHAR) +
		N'</td><td>' + CASE WHEN (@NewEvermanCount = 0) THEN @NA ELSE CAST((cast((@NewEvermanMissing/@NewEvermanCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		N'<td>'+ CAST(@NewEvermanWkCount as CHAR) +
		N'</td><td>' + CAST(@NewEvermanWkMissing as CHAR) +
		N'</td><td>' + CASE WHEN (@NewEvermanWkCount = 0) THEN @NA ELSE CAST((cast((@NewEvermanWkMissing/@NewEvermanWkCount) AS decimal(7,2)) * 100) AS NVARCHAR(MAX)) END + '%' +
		N'</table>' + 
			
		/*N'<br><br>If you have any questions about the report or are having barcoding/scanning issues, please contact Bryan at 817-521-0352.' +*/
		N'<br><br><b>Thanks,</b><br>'+
		N'The Marco Team</p>';


	/* Send the mail */
	EXEC	msdb.dbo.sp_send_dbmail
	
			@profile_name = 'SQL2008_DBMail_IT_General',
			@recipients = 'bryan.gregory@marcocompany.com',
			@copy_recipients = '',
			@file_attachments = 'C:\bin\CHPOMAIL\WM ITEMS SHIPPED LAST WEEK MISSING PALLET IDS.xls',
			@body_format = 'HTML',
			@body = @tableHTML,
			@subject = 'Daily Missing Pallet IDs Report' ;
			