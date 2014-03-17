--ALTER VIEW [BG_SCAC] AS
--Created:	4/27/10			     By:	BG
--Last Updated:	3/17/14			 By:	BG
--Purpose:	View for EDI SCAC codes

select code, cust_num, mac_ship_via, carrier, id_scac_code
from edcshvfl_sql