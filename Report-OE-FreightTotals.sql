SELECT OH.inv_no, OH.ord_no, OH.inv_Dt, frt_amt, oh.frt_pay_cd, oh.ship_via_cd, bl.carrier_cd, bl.ship_via_cd, bl.bol_pre_collect_fg, pp.ParcelType
FROM oehdrhst_sql OH
	LEFT OUTER JOIN wspikpak PP ON PP.ord_no = OH.ord_no 
	LEFT OUTER JOIN dbo.wsShipment SHP ON PP.Shipment = SHP.Shipment 
	LEFT OUTER JOIN dbo.oebolfil_sql BL ON SHP.bol_no = BL.bol_no
WHERE LTRIM(OH.cus_no) = '1100' AND YEAR(oh.inv_dt) = '2011' 
	AND inv_no NOT IN(SELECT inv_no FROM oelinhst_Sql OL WHERE LTRIM(OL.cus_no) = '1100' AND OL.item_no LIKE '%PROTO%' OR frt_pay_cd = 'N')
	AND NOT(frt_pay_cd =  'T' AND pp.ParcelType = 'FEDEX')



--Grouped by month and carrier...

GROUP BY YEAR(oh.inv_dt), MONTH(oh.inv_dt), SUBSTRING(oh.cmt_1, 1, 3), x.code_desc