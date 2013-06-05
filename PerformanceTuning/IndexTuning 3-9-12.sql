-----------------------------------------------------------------------------------------
--Show basic missing indexes
-----------------------------------------------------------------------------------------

SELECT   
 DISTINCT  
 sys.objects.name, sys.partitions.rows, migs.user_seeks,migs.avg_total_user_cost,migs.avg_user_impact,
 'CREATE NONCLUSTERED INDEX <NewNameHere> ON ' + sys.objects.name + ' ( ' + mid.equality_columns + 
 CASE WHEN mid.inequality_columns IS NULL
 THEN '' ELSE CASE WHEN mid.equality_columns IS NULL
 THEN '' ELSE ',' END + mid.inequality_columns END + ' ) ' + CASE WHEN mid.included_columns IS NULL
 THEN '' ELSE 'INCLUDE (' + mid.included_columns + ')' END + ' with (online =ON, maxdop = 2, sort_in_tempdb = ON ) on IndexFileGroup ;' 
 AS CreateIndexStatement , mid.equality_columns, mid.inequality_columns,
 mid.included_columns
FROM     
 sys.dm_db_missing_index_group_stats AS migs INNER JOIN
 sys.dm_db_missing_index_groups AS mig ON migs.group_handle = mig.index_group_handle INNER JOIN
 sys.dm_db_missing_index_details AS mid ON mig.index_handle = mid.index_handle INNER JOIN
 sys.objects WITH (nolock) ON mid.object_id = sys.objects.object_id  INNER JOIN
 sys.partitions on sys.objects.object_id = sys.partitions.object_id 
 --and sys.partitions.index_id = 1
WHERE     
 migs.group_handle IN
  (SELECT     TOP (10) group_handle
    FROM          sys.dm_db_missing_index_group_stats WITH (nolock)
    ORDER BY user_seeks DESC )
order by 
 --migs.user_seeks desc
 --migs.avg_total_user_cost desc
 migs.avg_user_impact DESC
 
-----------------------------------------------------------------------------------------
--List index recommendations and sort by a calculated "index_advantage".  Recommendations with Index_advantage > 10000 should be created
-----------------------------------------------------------------------------------------
 SELECT  TableName=o.name, migs_Adv.index_advantage
, s.avg_user_impact
, s.avg_total_user_cost
, s.last_user_seek
,s.unique_compiles,
d.index_handle
,d.equality_columns, d.inequality_columns, d.included_columns,  
'CREATE NONCLUSTERED INDEX <NewNameHere> ON ' + sys.objects.name + ' ( ' + mid.equality_columns + 
 CASE WHEN mid.inequality_columns IS NULL
 THEN '' ELSE CASE WHEN mid.equality_columns IS NULL
 THEN '' ELSE ',' END + mid.inequality_columns END + ' ) ' + CASE WHEN mid.included_columns IS NULL
 THEN '' ELSE 'INCLUDE (' + mid.included_columns + ')' END + ' with (online =ON, maxdop = 2, sort_in_tempdb = ON ) on IndexFileGroup ;' 
 AS CreateIndexStatement ,
from sys.dm_db_missing_index_group_stats s
inner join sys.dm_db_missing_index_groups g on g.index_group_handle=s.group_handle
inner join sys.dm_db_missing_index_details d on d.index_handle=g.index_handle
inner join sys.objects o on o.object_id=d.object_id
inner join (select user_seeks * avg_total_user_cost * (avg_user_impact * 0.01) as index_advantage,
              migs.* from sys.dm_db_missing_index_group_stats migs) as migs_adv on migs_adv.group_handle=g.index_group_handle
order by migs_adv.index_advantage desc, s.avg_user_impact DESC


-----------------------------------------------------------------------------------------
--Determine improper clustered indexes and recommend the nonclustered index to replace it
-----------------------------------------------------------------------------------------
 DECLARE @NonClusteredSeekPct float
DECLARE @ClusteredLookupFromNCPct float
 
-- Define percentage of usage the non clustered should
-- receive over the clustered index
SET @NonClusteredSeekPct = 1.50 -- 150%
 
-- Define the percentage of all lookups on the clustered index
-- should be executed by this non clustered index
SET @ClusteredLookupFromNCPct = .75 -- 75%
 
SELECT
    TableName                   = object_name(idx.object_id)
    ,NonUsefulClusteredIndex    = idx.NAME
    ,ShouldBeClustered          = nc.NonClusteredName
    ,Clustered_User_Seeks       = c.user_seeks
    ,NonClustered_User_Seeks    = nc.user_seeks
    ,Clustered_User_Lookups     = c.user_lookups
    ,DatabaseName               = db_name(c.database_id)
FROM sys.indexes idx
LEFT JOIN sys.dm_db_index_usage_stats c
ON idx.object_id = c.object_id
AND idx.index_id = c.index_id
--AND c.database_id = @DBID
JOIN (
    SELECT
        idx.object_id
        ,nonclusteredname = idx.NAME
        ,ius.user_seeks
    FROM sys.indexes idx
    JOIN sys.dm_db_index_usage_stats ius
    ON idx.object_id = ius.object_id
        AND idx.index_id = ius.index_id
    WHERE idx.type_desc = 'nonclustered'
    AND ius.user_seeks =
    (
        SELECT MAX(user_seeks)
        FROM sys.dm_db_index_usage_stats
        WHERE object_id = ius.object_id
        AND type_desc = 'nonclustered'
    )
    GROUP BY
        idx.object_id
        ,idx.NAME
        ,ius.user_seeks
) nc
ON nc.object_id = idx.object_id
WHERE
    idx.type_desc IN ('clustered','heap')
-- non clustered user seeks outweigh clustered by 150%
AND nc.user_seeks > (c.user_seeks * @NonClusteredSeekPct)
-- nc index usage is primary cause of clustered lookups 80%
AND nc.user_seeks >= (c.user_lookups * @ClusteredLookupFromNCPct)
ORDER BY nc.user_seeks DESC
