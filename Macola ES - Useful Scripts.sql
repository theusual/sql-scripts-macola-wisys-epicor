--List all tables with the macola description, in descending rowcount order
select t.NAME as [table_name],i.rows --tb.abbr, tb.description, tb.termid, tb.uid, tb.reportoptions, tb.flags 
FROM sys.tables t INNER JOIN sysindexes i ON (t.object_id = i.id AND i.indid < 2) --JOIN ddtables tb ON tb.tablename = t.NAME
ORDER BY rows desc

--list all Macola info about a table
EXEC efwgetddinfo ddtables  

--list all Macola info about a range of tables
SELECT tb.tablename, tb.abbr, tb.description, tb.termid, tb.uid, tb.reportoptions, tb.flags 
FROM ddtables tb 
WHERE tb.TableName LIKE 'dd%'




