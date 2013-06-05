SELECT AllowBackOrders, AllowPartialShipment, debnr, cmp_name FROM dbo.cicmpy WHERE (debcode IS NOT NULL) ORDER BY cmp_name


UPDATE cicmpy 
SET AllowBackOrders = 1, AllowPartialShipment = 1
WHERE (debcode IS NOT NULL)
