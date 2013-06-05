USE [001]

GO

DECLARE @ITEM NVARCHAR(MAX)
DECLARE @DATERANGE NVARCHAR(MAX)

DECLARE @Sold NVARCHAR(MAX)
DECLARE @Received NVARCHAR(MAX)
DECLARE @FRZQTY NVARCHAR(MAX)
DECLARE @PQOH NVARCHAR(MAX)

DECLARE @tableHTML  NVARCHAR(MAX)

SET @ITEM =
('MET-TBL 001 BV')
SET @DATERANGE =
('07/04/2010')
SET @FRZQTY =
('145')  /*SET @QOH =
	CAST((CAST((SELECT iminvloc_sql.qty_on_hand
	      FROM iminvloc_sql
	      WHERE iminvloc_sql.item_no = @ITEM
	      ) AS DECIMAL)) as NVARCHAR(MAX))*/
	      
    SELECT     OELINHST_SQL.item_no, SUM((OELINHST_sql.qty_ordered))
	FROM         dbo.OEHDRHST_sql AS OEHDRHST_SQL INNER JOIN
                      dbo.OELINHST_sql AS OELINHST_SQL ON OEHDRHST_SQL.ord_type = OELINHST_SQL.ord_type AND 
                      OEHDRHST_SQL.ord_no = OELINHST_SQL.ord_no LEFT OUTER JOIN
                      dbo.ARSHTTBL ON LTRIM(OELINHST_SQL.ord_no) = CAST(dbo.ARSHTTBL.ord_no AS int) AND 
                      OELINHST_SQL.item_no = dbo.ARSHTTBL.filler_0001 AND dbo.ARSHTTBL.void_fg IS NULL
	WHERE           
                    
                    (OEHDRHST_SQL.shipping_dt > '07/04/2010') and
                    OELINHST_SQL.unit_price > 0
    GROUP BY oelinhst_sql.item_no


SELECT     PL.item_no, SUM((PL.qty_received))
FROM         dbo.apvenfil_sql AS AP INNER JOIN
                      dbo.poordhdr_sql AS PH ON AP.vend_no = PH.vend_no INNER JOIN
                      dbo.poordlin_sql AS PL ON PL.ord_no = PH.ord_no AND PL.vend_no = PH.vend_no INNER JOIN
                      dbo.humres AS HR ON PL.byr_plnr = HR.res_id LEFT OUTER JOIN
                      dbo.poshpfil_sql AS PS ON PS.ship_to_cd = PH.ship_to_cd
WHERE           
                    
                    (PL.receipt_dt > '07/04/2010') 
GROUP BY PL.item_no                    

USE[001]
SELECT iminvloc_sql.item_no, iminvloc_sql.frz_qty
	      FROM iminvloc_sql INNER JOIN imitmidx_sql ON iminvloc_sql.item_no = imitmidx_sql.item_no
	      WHERE iminvloc_sql.loc = 'FW'  AND
	             iminvloc_sql.usage_ytd > 0 OR
	             iminvloc_sql.prior_year_usage > 0 OR
	             frz_qty > 0
