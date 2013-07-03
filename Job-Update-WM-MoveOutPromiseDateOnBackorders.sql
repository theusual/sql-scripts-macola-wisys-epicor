--Created:	7/3/13	 By:	BG
--Last Updated:	-/-/-	 By:	BG
--Purpose:	Job to update promise date on backordered items
--Last Change:  

BEGIN TRAN

SELECT DATEADD(day,7,TEMP.promise_dt)
--UPDATE dbo.oeordlin_sql
-- promise_dt = DATEADD(day,7,TEMP.promise_dt)
FROM dbo.oeordlin_sql, (SELECT promise_dt, OH.ord_no, OL.line_no
						FROM dbo.oeordlin_sql OL JOIN dbo.oeordhdr_sql OH ON OH.ord_no = OL.ord_no
						WHERE selection_cd = 'S' AND LTRIM(OH.cus_no) IN ('1575','20938') AND SHIPPED_DT IS NULL) AS TEMP
WHERE dbo.oeordlin_sql.ord_no = TEMP.ord_no 
		AND dbo.oeordlin_sql.line_no = TEMP.line_no 
		AND promise_dt > DATEADD(day,7,TEMP.promise_dt)

COMMIT TRAN 

/*
SELECT *
FROM dbo.oehdrhst_sql 
WHERE oe_po_no IN ('32023228','32046192','32045778','32051909','32051910','32038475','32038800','32038477','32038795','32038798')

SELECT promise_dt, * 
FROM dbo.oeordlin_sql OL JOIN dbo.oeordhdr_sql OH ON OH.ord_no = OL.ord_no
WHERE selection_cd = 'S' AND LTRIM(OH.cus_no) IN ('1575','20938') AND SHIPPED_DT IS NULL
*/

