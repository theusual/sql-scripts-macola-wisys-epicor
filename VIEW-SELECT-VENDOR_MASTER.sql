USE [Data_10]

GO

--ALTER VIEW BG_VENDOR_MASTER AS 

--Created:	10/15/12  By:	BG
--Last Updated:	  	  By:	BG
--Purpose: View for Vendor Master
--Last Change: --

SELECT vend_no, vend_name, addr_1, addr_2, city, state, zip, phone_no, fed_id_no, purch_ytd, purch_last_yr, last_chk_amt, payee_name 
FROM dbo.APVENFIL_SQL