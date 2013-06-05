USE [001]
UPDATE poordlin_sql
SET qty_received  = 0
WHERE ord_no like '%9693600%' OR ord_no like '%9716100%'