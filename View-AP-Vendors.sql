--Created:	1/14/14		 By:	BG
--Last Updated:	1/14/14	 By:	BG
--Purpose:  All POs

USE [001]
GO

SET QUOTED_IDENTIFIER ON
GO

--ALTER VIEW [dbo].[BG_AP_1099] AS

SELECT vend_no, vend_name, cat_1099, user_amount
FROM apvenfil_sql
