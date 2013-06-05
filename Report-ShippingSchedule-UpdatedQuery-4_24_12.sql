--ALTER VIEW Z_OPEN_OPS_SHIP3 AS 

--Created:	02/01/11	 By:	AW/SW
--Last Updated:	3/20/13	 By:	BG
--Purpose:	View for Shipping Schedule Report used by docks
--Last Change:  Added "released by" flag

SELECT            OH.ID
				  --,OL.ID
                  ,CASE WHEN AO.aud_dt IS NULL THEN OH.entered_dt 
                        ELSE AO.aud_dt 
                   END AS PRINTED
                  ,OH.mfg_loc AS [ORDER LOC]
                  ,OL.loc AS [ITEM LOC]
                  ,OH.shipping_dt AS [SHIP DATE]
                  ,LTRIM(OH.ord_no) AS [ORDER]
                  ,OH.ship_to_name AS [SHIP TO]
                  ,LTRIM(OH.cus_alt_adr_cd) AS STORE
                  ,OL.item_no AS ITEM
                  ,OL.line_seq_no AS [LINE SEQ]
                  ,OL.item_desc_1 AS DESC1
                  ,OL.prod_cat AS CAT
                  ,OL.qty_to_ship AS QTY
                  ,OH.oe_po_no AS PO
                  ,OH.ship_via_cd AS [SHIP VIA]
                  ,OH.ship_instruction_1 AS [INSTRUCTIONS 1]
                  ,OH.ship_instruction_2 AS [INSTRUCTIONS 2]
                  ,CASE WHEN CMT.line_Seq_no IS NOT null THEN 'See Comments' ELSE 'N/A' END AS COMMENTS
                  ,LTRIM(PP.Pallet) AS [PALLET ID #]
                  ,OL.extra_8 AS [RELEASED BY]
                  
FROM         dbo.oeordlin_sql AS OL  WITH(NOLOCK)
         INNER JOIN   dbo.oeordhdr_sql AS OH  WITH(NOLOCK) ON OH.ord_no = OL.ord_no 
         LEFT OUTER JOIN  OELINCMT_SQL CMT WITH(NOLOCK) ON CMT.ord_no = OH.ord_no AND CMT.line_seq_no = OL.line_seq_no
         LEFT OUTER JOIN  (SELECT     ord_no, MIN(aud_dt) AS aud_dt
                           FROM          dbo.oehdraud_sql WITH(NOLOCK)
                           WHERE    NOT (user_def_fld_5 IN ('', 'TEST')) 
									--AND aud_action IN ('A','C') 
                           GROUP BY ord_no) AS AO ON AO.ord_no = OH.ord_no
         LEFT OUTER JOIN wspikpak AS PP WITH(NOLOCK) ON PP.ord_no = OH.ord_no AND PP.line_no = OL.line_no
         LEFT OUTER JOIN (SELECT ord_no, line_no, SUM(qty) AS SumQty
						  FROM dbo.wsPikPak pp
						  WHERE pp.ship_dt > '10/01/12'
						  GROUP BY ord_no, line_no) AS SumShp ON SumShp.ord_no = pp.ord_no AND SumShp.line_no = pp.line_no
                      
WHERE     (OH.ord_type = 'O') AND (LTRIM(OH.cus_no) NOT IN ('23033', '24033', '32300', '32401')) 
					  --AND (NOT (OL.user_def_fld_2 LIKE '%SHIP%') OR OL.user_def_fld_2 IS NULL) 
                      AND (NOT (OH.user_def_fld_5 IN ('', 'TEST'))) 
                      AND (NOT (OH.user_def_fld_5 IS NULL)) 
                      AND (OL.loc NOT IN ('CAN', 'IN', 'BR')) 
			--If shipped=Y take it off the report UNLESS the sum of qty shipped is less than the qty to ship on the line
			--This prevents backordered line items from dropping off the report
					 AND ((pp.shipped != 'Y' OR pp.shipped IS NULL) OR 
								(--CONVERT(DATE,PP.ship_dt) < DATEADD(day, -7, CONVERT(DATE,GETDATE())) AND 
								OL.qty_to_ship > SumShp.SumQty))
                     --AND OL.shipped_dt IS null
                     --AND pp.shipment IS NULL
                     --Test
                     --AND OH.ord_no = '  701989'
                      
GROUP BY OH.ID, AO.aud_dt, 
	OH.mfg_loc, OL.loc, OH.shipping_dt, OH.ord_no, OH.ship_to_name, OH.cus_alt_adr_cd, OL.item_no, OL.item_no, OL.line_seq_no, 
    OL.item_desc_1, OL.prod_cat, OL.qty_to_ship, OH.oe_po_no, OH.ship_via_cd, OH.ship_instruction_1, 
	OH.ship_instruction_2, OL.ord_no, OH.entered_dt, OL.id, CMT.line_seq_no, pp.Pallet, OL.extra_8


