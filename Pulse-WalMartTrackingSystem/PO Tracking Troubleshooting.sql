SELECT * FROM dbo.oehdrhst_sql WHERE oe_po_no IN ('31812282')

UPDATE oeordhdr_sql 
SET cus_alt_adr_cd = '2126'
WHERE oe_po_no IN ('31843771')


SELECT * FROM wspikpak pp JOIN dbo.wsShipment SH ON SH.shipment = pp.shipment
			LEFT OUTER JOIN dbo.oebolfil_sql BL ON BL.bol_no = SH.bol_no  WHERE ord_no = '  702268'
			
SELECT * FROM oehdrhst_Sql WHERE ord_no = '  701266'

SELECT line_no, * FROM oelinhst_Sql WHERE ord_no = '  701266'
SELECT line_no, * FROM oeordlin_Sql WHERE ord_no = '  701267'

SELECT * FROM bg_shipped WHERE ord_no = '701267'
SELECT * FROM bg_WMPO WHERE [Supplier Sales/Work Order Number] = '702166'

SELECT * FROM wspikpak WHERE ord_no = '  701266'

SELECT * FROM dbo.oelinaud_sql WHERE ord_no = '  701267' AND line_no = '20'
