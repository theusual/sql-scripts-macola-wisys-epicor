--ALTER VIEW Z_OPEN_OPS_SHIP3 AS 

--Created:	02/01/11	 By:	AW/SW
--Last Updated:	7/1/13	 By:	BG
--Purpose:	View for Shipping Schedule Report used by docks
--Last Change:  Excluded lines with qty_to_ship > qty_ordered
SELECT OH.ID, CASE WHEN AO.aud_dt IS NULL THEN OH.entered_dt ELSE AO.aud_dt END AS PRINTED, 
			  OH.mfg_loc AS [ORDER LOC], 
			  OL.loc AS [ITEM LOC], 
              OH.shipping_dt AS [SHIP DATE], 
              LTRIM(OH.ord_no) AS [ORDER], 
              OH.ship_to_name AS [SHIP TO],
              LTRIM(OH.cus_alt_adr_cd) AS STORE, 
              OL.item_no AS ITEM, 
              OL.line_seq_no AS [LINE SEQ], 
              OL.item_desc_1 AS DESC1, 
              OL.prod_cat AS CAT, 
              OL.qty_to_ship AS QTY, 
              OH.oe_po_no AS PO, 
              OH.ship_via_cd AS [SHIP VIA], 
              OH.ship_instruction_1 AS [INSTRUCTIONS 1], 
              OH.ship_instruction_2 AS [INSTRUCTIONS 2], 
              CASE WHEN CMT.line_Seq_no IS NOT NULL  THEN 'See Comments' ELSE 'N/A' END AS COMMENTS, 
              LTRIM(PP.Pallet) AS [PALLET ID #], 
              OL.extra_8 AS [RELEASED BY]
FROM  dbo.oeordlin_sql AS OL WITH (NOLOCK) INNER JOIN
               dbo.oeordhdr_sql AS OH WITH (NOLOCK) ON OH.ord_no = OL.ord_no LEFT OUTER JOIN
               dbo.OELINCMT_SQL AS CMT WITH (NOLOCK) ON CMT.ord_no = OH.ord_no AND CMT.line_seq_no = OL.line_seq_no LEFT OUTER JOIN
                   (SELECT ord_no, MIN(aud_dt) AS aud_dt
                    FROM   dbo.oehdraud_sql WITH (NOLOCK)
                    WHERE (NOT (user_def_fld_5 IN ('', 'TEST')))
                    GROUP BY ord_no) AS AO ON AO.ord_no = OH.ord_no LEFT OUTER JOIN
               dbo.wsPikPak AS PP WITH (NOLOCK) ON PP.Ord_no = OH.ord_no AND PP.Line_no = OL.line_no LEFT OUTER JOIN
                   (SELECT Ord_no, Line_no, SUM(Qty) AS SumQty
                    FROM   dbo.wsPikPak AS pp
                    WHERE (ship_dt > '10/01/12')
                    GROUP BY Ord_no, Line_no) AS SumShp ON SumShp.Ord_no = PP.Ord_no AND SumShp.Line_no = PP.Line_no
WHERE (OH.ord_type = 'O') AND (LTRIM(OH.cus_no) NOT IN ('23033', '24033', '32300', '32401')) 
		AND (NOT (OH.user_def_fld_5 IN ('', 'TEST'))) 
		AND (NOT (OH.user_def_fld_5 IS NULL)) 
		AND (OL.loc NOT IN ('CAN', 'IN', 'BR')) 
		AND (PP.Shipped <> 'Y' OR
               PP.Shipped IS NULL) OR
               (OH.ord_type = 'O') 
        AND (LTRIM(OH.cus_no) NOT IN ('23033', '24033', '32300', '32401')) 
        AND (NOT (OH.user_def_fld_5 IN ('', 'TEST'))) 
        AND (NOT (OH.user_def_fld_5 IS NULL)) 
        AND (OL.loc NOT IN ('CAN', 'IN', 'BR')) 
        AND (OL.qty_ordered > SumShp.SumQty)
        AND (OL.qty_to_ship < qty_ordered)
        AND OL.item_no NOT LIKE 'TEST%'
GROUP BY OH.ID, AO.aud_dt, OH.mfg_loc, OL.loc, OH.shipping_dt, OH.ord_no, OH.ship_to_name, OH.cus_alt_adr_cd, OL.item_no, OL.item_no, OL.line_seq_no, OL.item_desc_1, OL.prod_cat, OL.qty_to_ship, OH.oe_po_no, OH.ship_via_cd, OH.ship_instruction_1, OH.ship_instruction_2, OL.ord_no, OH.entered_dt, OL.ID, CMT.line_seq_no, PP.Pallet, OL.extra_8
       