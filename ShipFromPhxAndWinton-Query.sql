USE [001]
SELECT 'WINTON' AS [Warehouse], ord_no AS [Order #], ship_to_name AS [Ship To], CONVERT(varchar, CAST(rtrim(shipping_dt)AS datetime), 101) AS [Shipping Dt], ship_instruction_1, ship_instruction_2
FROM OEORDHDR_SQL
WHERE ship_instruction_1 like '%WINTON%' OR ship_instruction_2 like '%WINTON%' OR ship_via_cd like '%NC%'
UNION ALL
SELECT 'PHX' AS [Warehouse], ord_no AS [Order #], ship_to_name AS [Ship To], CONVERT(varchar, CAST(rtrim(shipping_dt)AS datetime), 101) AS [Shipping Dt], ship_instruction_1, ship_instruction_2
FROM OEORDHDR_SQL
WHERE ship_instruction_1 like '%PHOENIX%' OR ship_instruction_2 like '%PHOENIX%' OR ship_via_cd like '%AZ%' 
