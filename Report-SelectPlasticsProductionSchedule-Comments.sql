--USE [Data_10]

ALTER VIEW BG_SELECT_PRODUCTION_SCHEDULE_CMT AS 

--Created:	06/20/12	 By:	BG
--Last Updated:	06/20/12	 By:	BG
--Purpose:	View for Select Plastic production schedule
--Last Change:  

SELECT DISTINCT 
               OC.ord_type, RIGHT(OC.ord_no,5) AS Ord_No, OC.line_seq_no AS [line_no], CASE WHEN OC.line_seq_no = 0 THEN 'Header Cmt' WHEN OC.line_seq_no > 0 THEN 'Line Cmt' END AS			   cmt_type, OC.cmt_seq_no, LTRIM(OC.cmt) AS Comment, CASE WHEN OC.line_seq_no = 0 THEN 'N/A' ELSE OL.item_no END AS item_no
FROM  dbo.OELINCMT_SQL AS OC INNER JOIN
               dbo.oeordlin_sql AS OL ON OL.ord_no = OC.ord_no INNER JOIN
               dbo.oeordhdr_sql AS OH ON OH.ord_no = OC.ord_no AND OC.ord_type = OH.ord_type
WHERE (OH.ord_type = 'O') AND 
               (OC.cmt NOT LIKE 'Shipment:%') AND (OC.cmt NOT LIKE 'Shipment Date:%') AND (OC.cmt NOT LIKE 'Shipment Type:%') 
               AND (OC.cmt NOT LIKE 'Trailer:%') AND (OC.cmt NOT LIKE 'Pallet:%') AND (OC.cmt NOT LIKE '%Tracking No:%') AND (OC.cmt NOT LIKE 'End Shipment:%') 
               AND (OC.cmt NOT LIKE '%Carton:%') AND (OC.cmt NOT LIKE 'Color Length%') AND (OC.cmt NOT LIKE 'Height%') AND (OC.cmt NOT LIKE 'FOOD  ORANGECol%') 
               AND (OC.cmt <> 'Delivery Day Within 10 Days') AND (OC.cmt NOT LIKE 'ColorBLKGLS%') AND (OC.cmt NOT LIKE '%Unit of Dim.IN%') 
               AND (OC.cmt NOT LIKE '%samsclub%') AND (OC.cmt NOT LIKE '%uswalmart%') AND (OC.cmt NOT LIKE '%us.wal%') AND (OC.cmt NOT LIKE '%stores.us%') 
               AND (OC.cmt NOT LIKE '%.000%') 
            