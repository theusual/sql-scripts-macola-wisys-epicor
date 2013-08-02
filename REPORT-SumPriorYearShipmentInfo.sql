SELECT pp.loc, COUNT(pp.ord_no)
FROM dbo.oehdrhst_sql OH 
		JOIN oelinhst_sql OL ON OL.inv_no = OH.inv_no 
		JOIN wspikpak PP ON PP.ord_no = OH.ord_no
WHERE OH.oe_po_no 
GROUP BY pp.Loc


SELECT DISTINCT OH.oe_po_no, SHP.id_scac_code, OH.cmt_3, PP.ship_dt, RTRIM(OH.ship_to_addr_2) + ' ' + LTRIM(OH.ship_to_addr_4)
FROM wspikpak pp JOIN dbo.oehdrhst_sql OH ON OH.ord_no = pp.ord_no
				JOIN dbo.edcshvfl_sql SHP ON SHP.mac_ship_via = LEFT(OH.cmt_1,3)
WHERE LTRIM(OH.cus_no) = '1575' 
		AND OH.oe_po_no IN ('31504408',
						'31239566',
						'31239567',
						'31262958',
						'31262959',
						'31480958',
						'31585017',
						'31593266',
						'31633107',
						'31639314',
						'31650671',
						'31755287',
						'31761936',
						'31778209',
						'31787676',
						'31788673',
						'31790824',
						'31801200',
						'31803562',
						'31804898',
						'31806399',
						'31816502',
						'31846357',
						'31853152',
						'31854960',
						'31859540',
						'31876464')

SELECT * FROM wspikpak WHERE 