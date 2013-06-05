ALTER VIEW AA_OpenOrders_ProtoAll AS 

--Created:	06/01/12	 By:	AA
--Last Updated:	10/12/12	 By:	BG
--Purpose:	View for prototype orders
--Last Change:  Added comments


SELECT OH.ord_no, OH.ord_dt, OH.oe_po_no, OH.bill_to_name, OH.ship_to_name, OH.shipping_dt, OH.ship_via_cd, OH.ship_instruction_1, OH.ship_instruction_2, 
               HUM.fullname AS Slspsn, OH.mfg_loc AS Ship_Loc, OL.item_no, OL.item_desc_1, OL.item_desc_2, OL.loc AS Mfg_Loc, OL.qty_to_ship, OL.shipped_dt, cmt.cmt
FROM  dbo.oeordhdr_sql AS OH INNER JOIN
               dbo.oeordlin_sql AS OL ON OH.ord_no = OL.ord_no INNER JOIN
               dbo.humres AS HUM ON HUM.res_id = OH.slspsn_no
               LEFT OUTER JOIN dbo.OELINCMT_SQL CMT ON CMT.ord_no = OH.ord_no
WHERE (OL.item_no LIKE 'PROTO%' OR CMT.cmt LIKE '%PROTO%')  AND (OH.ord_type = 'O')

               
              
   