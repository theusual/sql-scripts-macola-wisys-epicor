--ALTER VIEW [BG_ShipVia] AS
select sy_code AS MacShipVia, code_desc AS Carrier
from sycdefil_sql
WHERE cd_type = 'V'