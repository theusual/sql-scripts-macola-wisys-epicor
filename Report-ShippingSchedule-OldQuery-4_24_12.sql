--CREATE VIEW Z_OPEN_OPS_SHIP3 AS 
SELECT            OH.ID
                  ,AO.aud_dt AS PRINTED
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
                  ,CASE WHEN OC_LIN.ord_no IS NULL THEN 'N/A' ELSE 'See Comments' END AS COMMENTS
                  
FROM         dbo.oeordlin_sql AS OL INNER JOIN
                      dbo.oeordhdr_sql AS OH ON OH.ord_no = OL.ord_no LEFT OUTER JOIN
                          (SELECT DISTINCT ord_no
                            FROM          dbo.OELINCMT_SQL
                            GROUP BY ord_no) AS OC_LIN ON OL.ord_no = OC_LIN.ord_no LEFT OUTER JOIN
                          (SELECT     AO_1.ord_no, AO_1.aud_dt
                            FROM          dbo.oehdraud_sql AS AO_1 INNER JOIN
                                                       (SELECT     ord_no, MIN(aud_dt + aud_tm) AS aud_dt_tm_2
                                                         FROM          dbo.oehdraud_sql
                                                         WHERE      (NOT (user_def_fld_5 IN ('', 'TEST')))
                                                         GROUP BY ord_no) AS AO_2 ON AO_1.ord_no = AO_2.ord_no AND AO_1.aud_dt + AO_1.aud_tm = AO_2.aud_dt_tm_2) AS AO ON 
                      AO.ord_no = OH.ord_no
WHERE     (OH.ord_type = 'O') AND (LTRIM(OH.cus_no) NOT IN ('23033', '24033', '32300', '32401')) AND (NOT (OL.user_def_fld_2 LIKE '%SHIP%') OR 
                      OL.user_def_fld_2 IS NULL) AND (NOT (OH.user_def_fld_5 IN ('', 'TEST'))) AND (NOT (OH.user_def_fld_5 IS NULL)) 
                      AND (OL.loc NOT IN ('CAN', 'IN', 'BR')) AND ((OH.ord_no + OL.item_no) NOT IN
                          (SELECT     Ord_no + Item_no AS Expr1
                            FROM          dbo.wsPikPak AS pp
                            WHERE      (Shipped = 'Y')))
GROUP BY OH.ID, AO.aud_dt, OH.mfg_loc, OL.loc, OH.shipping_dt, OH.ord_no, OH.ship_to_name, OH.cus_alt_adr_cd, OL.item_no, OL.item_no, OL.line_seq_no, 
                      OL.item_desc_1, OL.prod_cat, OL.qty_to_ship, OH.oe_po_no, OH.ship_via_cd, OH.ship_instruction_1, OH.ship_instruction_2, OC_LIN.ord_no


