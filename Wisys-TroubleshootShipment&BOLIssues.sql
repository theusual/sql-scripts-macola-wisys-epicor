SELECT * FROM wspikpak PP JOIN dbo.wsShipment SHP ON SHP.shipment = PP.shipment WHERE ord_no =  '12222225'  

SELECT * FROM wsshipment SHP JOIN wspikpak PP ON PP.shipment = SHP.shipment WHERE LEN(bol_no) < 6

SELECT * FROM wspikpak WHERE shipment ='' ORDER BY pallet DESC 

SELECT * FROM wspikpak WHERE shipment like '%82665'

SELECT * FROM wsshipment WHERE shipment like '%82647'

SELECT * FROM wspikpak PP JOIN dbo.wsShipment SHP ON SHP.shipment = PP.shipment 
						--JOIN dbo.oebolfil_sql BOL ON BOL.bol_no = SHP.bol_no 
WHERE PP.shipment like '%82757'

DELETE FROM wspikpak WHERE ord_no = '  377157'
DELETE FROM wsshipment WHERE shipment like '%82709'

SELECT * FROM dbo.oectlfil_sql 

SELECT * FROM [BG_Backup].dbo.DevTesting

SELECT LongValue,* 
FROM   wssettings_sql
WHERE  wssettings_sql.SettingGroup = 'PikPak'
       AND wssettings_sql.SettingName = 'NextTruck' 

SELECT oectlfil_sql.next_bol_no  AS NextBOLNo
FROM   oectlfil_sql 


BEGIN TRAN

SELECT RIGHT(Replicate(' ', 30) + CONVERT(VARCHAR, CONVERT(INT, wssettings_sql.LongValue+4, 0)), 30) AS Shipment
FROM   wssettings_sql
WHERE  wssettings_sql.SettingGroup = 'PikPak'
       AND wssettings_sql.SettingName = 'NextTruck' 
       


UPDATE wssettings_sql
SET  LongValue = wssettings_sql.LongValue + 7
WHERE  wssettings_sql.SettingGroup = 'PikPak'
       AND wssettings_sql.SettingName = 'NextTruck' 
       
COMMIT TRAN

SELECT * FROM dbo.oectlfil_sql

UPDATE dbo.oectlfil_sql
SET next_bol_no = '   74505'
'   74509'

SELECT * FROM dbo.oebolfil_sql WHERE bol_no = '   74509' ORDER BY bol_no

SELECT * FROM dbo.wsShipment WHERE bol_no = '   74509' ORDER BY bol_no