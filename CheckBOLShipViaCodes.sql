SELECT OH.inv_no, OH.ord_no, OH.inv_Dt, frt_amt, oh.frt_pay_cd, oh.ship_via_cd, bl.carrier_cd, bl.ship_via_cd, bl.bol_pre_collect_fg, pp.ParcelType
FROM oeordhdr_sql OH
	LEFT OUTER JOIN wspikpak PP ON PP.ord_no = OH.ord_no 
	LEFT OUTER JOIN dbo.wsShipment SHP ON PP.Shipment = SHP.Shipment 
	LEFT OUTER JOIN dbo.oebolfil_sql BL ON SHP.bol_no = BL.bol_no
WHERE LTRIM(OH.ord_no) = '7700102' 

SELECT * FROM dbo.wsBOLView WHERE oeordhdr_sql_ord_no = ' 7700102'