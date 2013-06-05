--ALTER VIEW Z_OPEN_OPS_CMT AS
--Created:	8/23/12	 By:	BG
--Last Updated:	9/23/12	 By:	BG
--Purpose:	Comment View for Schedule 
--Last changes: --

SELECT DISTINCT 
               OC.ord_type, LTRIM(OH.ord_no) AS Ord_No, OC.line_seq_no AS line_no, 
               CASE WHEN OC.line_seq_no = 0 THEN 'Header Cmt' WHEN OC.line_seq_no > 0 THEN 'Line Cmt' END AS cmt_type, OC.cmt_seq_no, LTRIM(OC.cmt) AS Comment, 
               CASE WHEN OC.line_seq_no = 0 THEN 'N/A' ELSE OL.item_no END AS item_no
FROM  dbo.OELINCMT_SQL AS OC WITH (NOLOCK) INNER JOIN
               dbo.oeordlin_sql AS OL WITH (NOLOCK) ON OL.ord_no = OC.ord_no AND OL.line_no = OC.line_seq_no INNER JOIN
               dbo.oeordhdr_sql AS OH WITH (NOLOCK) ON OH.ord_no = OC.ord_no AND OC.ord_type = OH.ord_type
WHERE (OH.ord_type = 'O') AND (OC.cmt NOT LIKE 'Shipment:%') AND (OC.cmt NOT LIKE 'Shipment Date:%') AND (OC.cmt NOT LIKE 'Shipment Type:%') AND 
               (OC.cmt NOT LIKE 'Trailer:%') AND (OC.cmt NOT LIKE 'Pallet:%') AND (OC.cmt NOT LIKE '%Tracking No:%') AND (OC.cmt NOT LIKE 'End Shipment:%') AND 
               (OC.cmt NOT LIKE '%Carton:%') AND (OC.cmt NOT LIKE 'Color Length%') AND (OC.cmt NOT LIKE 'Height%') AND (OC.cmt NOT LIKE 'FOOD  ORANGECol%') AND 
               (OC.cmt <> 'Delivery Day Within 10 Days') AND (OC.cmt NOT LIKE 'ColorBLKGLS%') AND (OC.cmt NOT LIKE '%Unit of Dim.IN%') AND 
               (OC.cmt NOT LIKE '%samsclub%') AND (OC.cmt NOT LIKE '%uswalmart%') AND (OC.cmt NOT LIKE '%us.wal%') AND (OC.cmt NOT LIKE '%stores.us%') AND 
               (OC.cmt NOT LIKE '%.000%')
               --Test Order
               --AND OH.ord_no = '  372411'