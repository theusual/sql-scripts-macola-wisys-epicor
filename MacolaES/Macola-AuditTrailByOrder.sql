SELECT * 
FROM dbo.oelinaud_sql 
WHERE ord_no IN ('  833274', '  833275') AND aud_action IN ('C','A','D') 
ORDER BY ord_no, item_no, aud_Dt, aud_tm
