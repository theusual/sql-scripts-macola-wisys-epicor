SELECT ord_no AS [Order], qty_ordered AS Miles, '$' + convert(varchar(10), convert(money, exp_unit_cost)) AS [$PerMile], CONVERT(varchar, request_dt,101)  AS [DELIVERY DT], 
CASE WHEN (user_def_fld_4 IS NULL) THEN substring(user_def_fld_3, -3, (len(user_def_fld_3))) ELSE user_def_Fld_3 END AS [CITY],
CASE WHEN (user_def_fld_4 IS NULL) THEN substring(user_def_fld_3, (charindex(',', user_def_fld_3) + 2), 2) ELSE user_def_Fld_4 END AS [ST], user_def_fld_5 AS [Zip]

FROM POORDLIN_SQL
WHERE ord_no IN (
     SELECT ord_no FROM POORDLIN_SQL GROUP BY ord_no HAVING COUNT(line_no) = 1) AND NOT(ord_no IN (100, 200))
     AND
     qty_ordered > 10 
     AND exp_unit_cost < 7 AND exp_unit_cost > 0