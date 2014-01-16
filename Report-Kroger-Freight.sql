--ALTER VIEW dbo.BG_KROGER_FREIGHT AS 

--Created:	02/12/13     By:	BG
--Last Updated:	02/12/13 By:	BG
--Purpose: View for freight charges per month by carrier (Pre-Paid Only)
--Last Change: --

SELECT MAX(pp.ship_dt) AS [SHIPMENT DATE], 
	   OH.oe_po_no AS [KROGER PO #],
	   OH.inv_no AS [INVOICE #],
	   LEFT(cmt_1,3) AS [CARRIER],
	   CASE WHEN PP.loc = 'GD' THEN 'GODLEY'
		    ELSE 'FORT WORTH'
	   END AS [ORIGIN CITY],
	   'TX' AS [ORIGIN STATE],
	   OH.ship_to_name AS [KROGER FACILITY NAME],
	   OH.ship_to_city AS [DESTINATION CITY],
	   OH.ship_to_state AS [DESTINATION STATE],
	   '' AS [MODE OF TRANSPORTATION],
	   '' AS [EQUIPMENT TYPE],
	   MAX(frt_amt) AS [FREIGHT$],
	   MAX(OH.tot_sls_amt) AS [GOODS SHIPPED $],
	   MAX(OH.tot_dollars) AS [Total $ Invoiced],
	   '' AS [# OF PALLETS],
	   MAX(OH.tot_weight) AS [WEIGHT],
	   '' AS [L],
	   '' AS [W],
	   '' AS [H],
	   '100' AS [FREIGHT CLASS]
FROM dbo.oehdrhst_sql OH JOIN OELINHST_SQL OL ON OL.inv_no = OH.inv_no 
						 LEFT OUTER JOIN wspikpak PP ON PP.ord_no = OH.ord_no
WHERE  cmt_1 IS NOT NULL 
		AND ship_Dt > '01/01/2013' 
		AND LEFT(cmt_1,3) NOT IN ('CPU',' 56','3rd','10%','A)','WTL')
		AND LEFT(cmt_1,3) IN (SELECT sy_code FROM dbo.sycdefil_sql WHERE cd_Type = 'V') 
		AND frT_amt > 0
		AND ltrim(OH.cus_no) IN (SELECT cus_no FROM BG_Xref_Cus WHERE cus_name = 'KROGER')
GROUP BY OH.oe_po_no, OH.inv_no, LEFT(cmt_1,3), PP.loc, OH.ship_to_name, OH.ship_to_city, OH.ship_to_state
--ORDER BY LEFT(cmt_1,3)


