--Returns summary information about missing index groups, for example, the performance improvements that could be gained by implementing a specific group of missing indexes.
select *
from sys.dm_db_missing_index_group_stats 

--Returns detailed information about a missing index; for example, it returns the name and identifier of the table where the index is missing, and the columns and column types that should make up the missing index.
select *
from sys.dm_db_missing_index_details

--Returns information about the database table columns that are missing an index.
select *
from sys.dm_db_missing_index_columns(316)