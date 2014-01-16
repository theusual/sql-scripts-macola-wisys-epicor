select * 
from oehdrhst_sql OH JOIN oelinhst_sql OL ON OL.inv_no = OH.inv_no
WHERE OH.ord_no = '  721419'

select * 
from oecusitm_sql 
WHERE item_no = 'SH-GP SM 10 BV'

select month(shipping_dt) AS [MONTH], SUM(OL.qty_to_ship), OL.item_no
from oeordhdr_Sql OH JOIN oeordlin_sql OL ON OH.ord_no = OL.ord_no
WHERE ltrim(OH.cus_no) = '23033'
GROUP BY month(shipping_dt), item_no

select * 
from BG_WM_Current_Projections

select *
from bg_shipped
WHERE Ord_No = '721419'

BEGIN TRAN
UPDATE oehdrhst_sql
SET cus_alt_adr_cd = '2187'
WHERE item_no = 'SH-GP SM 10 BV' and ord_no = '  720865'
COMMIT TRAN

BEGIN TRAN
UPDATE oeordhdr_sql
SET ship_to_addr_4 = 'RIALTO, CA 92376'
WHERE cus_alt_adr_cd = '3131'
COMMIT TRAN

select * from z_iminvloc WHERE ord_no like '  721419'

select * FROM BG_WM_Current_Projections WHERE item_no = 'DELI-77 BK'

select * from oeordhdr_sql WHERE cus_alt_adr_cd = '3131'

select * from oeordhdr_sql WHERE ord_no = ' 1007411'

select * from arcusfil_sql WHERE ltrim(cus_no) = '22408'

UPDATE oeordhdr_Sql
SET ship_to_addr_1 = 'SOUTHEAST POs 327'
WHERE  ltrim(ord_no) IN ('901890','901884') 


select * from oeordlin_Sql WHERE ord_no = '  379561'       
select * from wspikpak WHERE ord_no = '  379561'        

BEGIN TRAN
DELETE FROM wspikpak WHERE ord_no = '  379561'
COMMIT TRAN


SELECT dbo.[fn_BG_WMProjection]('58685-2 BK')

select * from WM_Forecast_2013

select PL.extra_8, *
from poordlin_sql PL JOIN poordhdr_sql PH ON PH.ord_no = PL.ord_no
WHERE ord_dt = '09/06/2013'

UPDATE poordlin_sql
SET extra_8 = '10/24/2013'
WHERE ord_no = '12650700'

select PL.item_no, CASE WHEN (MIN(PL.user_def_fld_2) IS NOT NULL AND LEN(MIN(PL.user_def_fld_2)) = 10)  
			 THEN MIN(PL.user_def_fld_2)
			 WHEN (MIN(PL.user_def_fld_2) IS NULL OR LEN(MIN(PL.user_def_fld_2)) != 10) AND (MIN(PL.extra_8) IS NOT NULL AND LEN(MIN(PL.extra_8)) = 10 )
			 THEN MIN(DATEADD(day, 28, PL.extra_8))
			 WHEN (MIN(PL.user_def_fld_2) IS NULL OR LEN(MIN(PL.user_def_fld_2)) != 10) AND (MIN(PL.extra_8) IS NULL OR LEN(MIN(PL.extra_8)) != 10) 
					AND LTRIM(PL.vend_no) IN  (SELECT vend_no
												FROM   BG_CH_Vendors) 
			 THEN MIN(CONVERT(varchar(10), DATEADD(DAY, 90, PH.ord_dt), 101))
			 WHEN MIN(PL.promise_dt) IS NULL 
			 THEN MIN(CONVERT(varchar(10), DATEADD(DAY, 14, PH.ord_dt), 101))
			 ELSE MIN(CONVERT(varchar(10), PL.promise_dt, 101))
		END AS [SHP/RECV DT] from poordlin_sql PL JOIN poordhdr_Sql PH ON PH.ord_no = PL.ord_no WHERE ord_dt = '09/06/2013' GROUP BY PL.item_no, PH.ord_no, PL.vend_no