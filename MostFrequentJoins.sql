USE tempdb;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
BEGIN TRANSACTION
 
;WITH XMLNAMESPACES (DEFAULT 'http://schemas.microsoft.com/sqlserver/2004/07/showplan')
select 
	cp.usecounts as numberOfJoins,
	seeknodes.query('.') as plansnippet
into #my_joins
from sys.dm_exec_cached_plans cp
cross apply sys.dm_exec_query_plan(cp.plan_handle)
	as qp
cross apply query_plan.nodes('/ShowPlanXML/BatchSequence/Batch/Statements/StmtSimple/QueryPlan//SeekKeys/Prefix[@ScanType="EQ"]') 
	as seeks(seeknodes)
where seeknodes.exist('./RangeColumns/ColumnReference[1]/@Database') = 1
	and seeknodes.exist('./RangeExpressions/ScalarOperator/Identifier/ColumnReference[1]/@Database') = 1;
 
WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' as p1)
select sum(numberOfJoins) as [Number Of Joins],
	myValues.lookupTable + '(' + myValues.lookupColumn + ')' as lookupColumn,
	myValues.expressionTable + '(' + myValues.expressionColumn + ')' as expressionColumn
from #my_joins
cross apply plansnippet.nodes('./p1:Prefix/p1:RangeColumns/p1:ColumnReference[1]')
	as rangeColumns(rangeColumnNodes)
cross apply plansnippet.nodes('./p1:Prefix/p1:RangeExpressions/p1:ScalarOperator/p1:Identifier/p1:ColumnReference[1]')
	as rangeExpressions(rangeExpressionNodes)
cross apply (
	select
		rangeColumnNodes.value('@Database', 'sysname') as lookupDatabase, 
		rangeColumnNodes.value('@Schema', 'sysname') as lookupSchema,
		rangeColumnNodes.value('@Table', 'sysname') as lookupTable,
		rangeColumnNodes.value('@Column', 'sysname') as lookupColumn,
		rangeExpressionNodes.value('@Database', 'sysname') as expressionDatabase, 
		rangeExpressionNodes.value('@Schema', 'sysname') as expressionSchema,
		rangeExpressionNodes.value('@Table', 'sysname') as expressionTable,
		rangeExpressionNodes.value('@Column', 'sysname') as expressionColumn	
	) as myValues
where myValues.expressionTable != myValues.lookupTable
group by myValues.lookupTable, myValues.lookupColumn, myValues.expressionTable, myValues.expressionColumn
order by SUM(numberOfJoins) desc;
 
rollback;