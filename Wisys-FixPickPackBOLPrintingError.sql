--Identify the oebolfil and wsShipment table IDs for the offending order that is using the same BOL # as the order we want to print.  
--Set ord_no in where clause to the good order
SELECT BL.id, SHP.id, BL.bol_no, ord_no, shp.shipment, * FROM wspikpak PP JOIN dbo.wsShipment SHP ON SHP.shipment = PP.shipment JOIN dbo.oebolfil_sql BL ON BL.bol_no = SHP.bol_no WHERE BL.bol_no IN (SELECT SHP.bol_no FROM wsShipment SHP JOIN wspikpak PP ON PP.Shipment = SHP.shipment WHERE ord_no = '  708050')

BEGIN TRAN
--Using the 2 IDs identified above, update the offending BOL_NO entries to a new placeholder BOL #
UPDATE wsshipment SET bol_no = '99974115' WHERE ID = 75231
UPDATE dbo.oebolfil_sql SET bol_no = '99974115' WHERE ID = 111383
COMMIT TRAN