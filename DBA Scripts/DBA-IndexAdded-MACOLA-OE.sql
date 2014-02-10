/*
Missing Index Details from Report-CH Ordering.sql - HQSQL.001 (MARCO\bgregory (600))
The Query Processor estimates that implementing the following index could improve the query cost by 29.005%.
*/

USE [001]
GO
CREATE NONCLUSTERED INDEX [<Name of Missing Index, sysname,>]
ON [dbo].[oelinhst_sql] ([loc])
INCLUDE ([item_no],[qty_to_ship],[qty_return_to_stk],[inv_no])
GO
