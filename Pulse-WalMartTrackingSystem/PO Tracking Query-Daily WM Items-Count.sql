SELECT COUNT(OL.item_no)
	
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
                      AS datetime), 101) > DATEADD(day, - 4, GETDATE()))) 
