SELECT  vend_no, request_dt, ord_no, item_no, item_desc_1, item_desc_2, qty_ordered, act_unit_cost
FROM    poordlin_Sql
where request_dt > '01/01/2011' and item_desc_1 like '%BUMPER%'