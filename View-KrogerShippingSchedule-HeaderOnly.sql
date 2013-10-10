--CREATE VIEW BG_KROGER_SHIP_SCHEDULE_HEADERONLY AS 

--Created:	9/19/13	 By:	BG
--Last Updated:	9/19/13	 By:	BG
--Purpose:	View for Kroger team showing all open Kroger orders
--Last Change: --
SELECT TOP (100) PERCENT--OH.ID, 
			OH.entered_dt AS ENTERED_DT, 
			  OH.mfg_loc AS [ORDER LOC], 
			  OH.loc AS [SHIP LOC], 
              OH.shipping_dt AS [SHIP DATE], 
              LTRIM(OH.ord_no) AS [ORDER], 
              OH.ship_to_name AS [SHIP TO],
              LTRIM(OH.cus_alt_adr_cd) AS STORE, 
              OH.oe_po_no AS PO, 
              OH.ship_via_cd AS [SHIP VIA], 
              OH.ship_instruction_1 AS [INSTRUCTIONS 1], 
              OH.ship_instruction_2 AS [INSTRUCTIONS 2]
FROM	dbo.oeordlin_sql AS OL WITH (NOLOCK) JOIN
               dbo.oeordhdr_sql AS OH WITH (NOLOCK) ON OH.ord_no = OL.ord_no
               /*LEFT OUTER JOIN
               dbo.OELINCMT_SQL AS CMT WITH (NOLOCK) ON CMT.ord_no = OH.ord_no AND CMT.line_seq_no = OL.line_seq_no LEFT OUTER JOIN
                   (SELECT ord_no, MIN(aud_dt) AS aud_dt
                    FROM   dbo.oehdraud_sql WITH (NOLOCK)
                    WHERE (NOT (user_def_fld_5 IN ('', 'TEST'))) 
                    GROUP BY ord_no) AS AO ON AO.ord_no = OH.ord_no */
                 LEFT OUTER JOIN
               dbo.wsPikPak AS PP WITH (NOLOCK) ON PP.Ord_no = OH.ord_no AND PP.Line_no = OL.line_no LEFT OUTER JOIN
                   (SELECT Ord_no, Line_no, SUM(Qty) AS SumQty
                    FROM   dbo.wsPikPak AS pp
                    WHERE (ship_dt > '10/01/12')
                    GROUP BY Ord_no, Line_no) AS SumShp ON SumShp.Ord_no = PP.Ord_no AND SumShp.Line_no = PP.Line_no
WHERE (OH.ord_type = 'O') 
		AND (LTRIM(OH.cus_no) IN ('306','391','398','399','389','339','501','323','503','9312','22585','22578','22580','988','1130','22597','22561','354','6730','875','806','809','879','8357','885','867','880','883','400','23123','22655','4201','845','8124','1350','11059','32549','32374','32524','115111','32686','32739','32744','27638','32354'))
        AND (NOT (OH.user_def_fld_5 IN ('', 'TEST'))) 
        AND (NOT (OH.user_def_fld_5 IS NULL)) 
GROUP BY OH.ID,OH.mfg_loc, OH.shipping_dt, OH.ord_no, OH.ship_to_name, OH.cus_alt_adr_cd,  OH.oe_po_no, OH.ship_via_cd, OH.ship_instruction_1, OH.ship_instruction_2,  OH.entered_dt,   PP.Pallet
ORDER BY Store, shipping_dt, OH.ord_no
       