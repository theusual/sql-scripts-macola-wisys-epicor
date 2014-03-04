--ALTER VIEW BG_OE_OPEN_ORDERS AS 

--Created:	2/28/14    By:	BG
--Last Updated:	  	  By:	BG
--Purpose: View for REMIS open sales orders
--Last Change: --

SELECT  ltrim(OH.ord_no) AS [OrderNo],
		OH.oe_po_no AS [PO #],
		OH.entered_dt AS [EnteredDt],
		OL.promise_dt AS [ScopeDt],
		OL.req_ship_dt AS [RequestedShipDt],
		OL.request_dt AS [InstallDt],
		OH.shipping_dt AS [ShippingDt],
		OH.user_def_fld_1 AS [OrderType],
		CUS.cus_name AS [Customer],
		OH.cus_alt_adr_cd AS [StoreNo],
		CASE WHEN OH.ship_to_addr_1 IS NULL THEN
				CASE WHEN OH.ship_to_addr_2 is null THEN rtrim(OH.ship_to_addr_4)
					 WHEN OH.ship_to_addr_3 is null THEN rtrim(OH.ship_to_addr_2) + ' ' + rtrim(OH.ship_to_addr_4)
					 WHEN OH.ship_to_addr_4 is null THEN rtrim(OH.ship_to_addr_2) + ' ' + rtrim(OH.ship_to_addr_3)
					 ELSE rtrim(OH.ship_to_addr_2) + ' ' + rtrim(OH.ship_to_addr_3) + ' ' + rtrim(OH.ship_to_addr_4)
				END 
			 WHEN  OH.ship_to_addr_2 IS NULL THEN
				CASE WHEN OH.ship_to_addr_3 is null THEN rtrim(OH.ship_to_addr_1) + ' ' + rtrim(OH.ship_to_addr_4)
					 WHEN OH.ship_to_addr_4 is null THEN rtrim(OH.ship_to_addr_1) + ' ' + rtrim(OH.ship_to_addr_3)
					 ELSE rtrim(OH.ship_to_addr_1) + ' ' + rtrim(OH.ship_to_addr_3) + ' ' + rtrim(OH.ship_to_addr_4)
				END 
			WHEN  OH.ship_to_addr_3 IS NULL THEN rtrim(OH.ship_to_addr_1)  + ' ' + rtrim(OH.ship_to_addr_2) + ' ' +  ' ' + rtrim(OH.ship_to_addr_4)
			ELSE rtrim(OH.ship_to_addr_1)  + ' ' + rtrim(OH.ship_to_addr_2) + ' ' + rtrim(OH.ship_to_addr_3) + ' ' + rtrim(OH.ship_to_addr_4)
		END AS [Ship To Address],	
		OH.tot_sls_amt AS [TOTAL SALES $],
		OL.user_def_fld_3 AS [ActShippedDt],
		substring(OL.user_def_fld_4, 1, (charindex(',', OL.user_def_fld_4) - 1)) AS [Carrier], 
		substring(OL.user_def_fld_4, (charindex(',', OL.user_def_fld_4)+1), LEN(OL.user_Def_Fld_4)) AS [TrackingNo]
FROM OEORDHDR_SQL OH JOIN (SELECT ord_no, request_dt, req_ship_dt, promise_dt, user_def_fld_3, user_def_fld_4
							FROM OEORDLIN_SQL OL 
							WHERE line_no = 1) AS OL ON OL.ord_no = OH.ord_no
					 LEFT OUTER JOIN arcusfil_sql CUS ON CUS.cus_no = OH.cus_no
WHERE OH.ord_type = 'O'
		--Test
		--AND OH.ord_no = '   25010'		