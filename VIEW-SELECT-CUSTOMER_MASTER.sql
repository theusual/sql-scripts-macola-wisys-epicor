USE [Data_10]

GO

CREATE VIEW BG_CUSTOMER_MASTER AS 

--Created:	10/15/12  By:	BG
--Last Updated:	  	  By:	BG
--Purpose: View for Customer Master
--Last Change: --

SELECT cus_no, cus_name, addr_1, addr_2, city, state, zip, phone_no, slspsn_no, sls_ytd, sls_last_yr, balance, high_balance 
FROM dbo.ARCUSFIL_SQL