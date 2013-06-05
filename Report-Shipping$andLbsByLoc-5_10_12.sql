--ALTER VIEW BG_Shipping_$_And_Lbs_By_Loc AS 

--Created:	05/11/12	 By:	BG
--Last Updated:	5/11/12	 By:	BG
--Purpose: Report for shipping $ and lbs by location
--Last Change: --

SELECT  OH.ord_no, 
		CASE WHEN MAX(PP.LOC) IS NULL THEN MAX(OL.loc)
			 ELSE MAX(PP.loc)
		END AS LOC,
		CASE WHEN (SUM(pp.weight) IS NULL AND SUM(OL.weight) = 0) THEN SUM(OL.qty_to_ship * 50)
			 WHEN (SUM(pp.weight) IS NULL) THEN SUM(OL.weight)		
			 WHEN (SUM(bl.carrier_cd_weight) = 0 OR SUM(bl.carrier_cd_weight) IS NULL) THEN SUM(pp.weight)
			 ELSE SUM(bl.carrier_cd_weight)
		END [Lbs],  
		CASE WHEN SUM(pp.qty) IS NULL THEN	SUM(OL.qty_to_ship)
			 ELSE SUM(pp.qty) 
		END AS UNITS, 
		OH.tot_sls_amt AS [$], 
		CASE WHEN MAX(OH.ord_Dt_Shipped) IS NULL THEN MAX(OH.inv_dt)
			 ELSE MAX(OH.ord_dt_shipped)
		END AS [Shipped_Dt] 
FROM (SELECT SUM(OH.tot_sls_amt) AS [tot_sls_amt], OH.ord_no, MAX(ord_dt_shipped) AS ord_dt_Shipped, MAX(inv_dt) AS inv_Dt
		   FROM oehdrhst_Sql OH WITH (NOLOCK)
		   GROUP BY OH.ord_no) AS OH
	  JOIN 
	   (SELECT SUM(qty_to_ship) AS qty_to_ship, ord_no, SUM(unit_weight*qty_to_ship) AS weight, loc
	   FROM oelinhst_Sql WITH (NOLOCK)
	   WHERE loc IN ('MDC','WS','PS','MS')
	   GROUP BY ord_no, loc) AS OL ON OH.ord_no = OL.ord_no
	 LEFT OUTER JOIN 
	  (SELECT SUM(qty)  AS qty, SUM(weight) AS weight, ord_no, pp.shipment, PP.loc, MAX(ship_dt) AS Ship_dt
	   FROM dbo.wsPikPak PP WITH(NOLOCK)
	   GROUP BY ord_no, pp.shipment, pp.loc) AS PP ON OH.ord_no = PP.ord_no 
	 LEFT OUTER JOIN dbo.wsShipment SHP WITH (NOLOCK) ON PP.Shipment = SHP.Shipment 
	 LEFT OUTER JOIN dbo.oebolfil_sql BL WITH (NOLOCK) ON SHP.bol_no = BL.bol_no
WHERE (OH.ord_dt_shipped > '01/01/2012'  OR (ord_dt_shipped IS NULL AND OH.inv_dt > '01/01/2012'))
	  --AND OH.ord_dt_shipped > '01/01/2012'
	  AND OL.qty_to_ship > 0
	  AND (PP.LOC IN ('MDC', 'WS', 'PS', 'MS') OR (PP.loc IS NULL AND OH.ord_no IN (SELECT ord_no FROM oelinhst_sql WHERE loc IN ('MDC','WS','PS','MS'))))
	  --AND OH.ord_no = ' 3002228'
GROUP BY OH.ord_no, OH.tot_sls_amt, OH.ord_Dt_Shipped
