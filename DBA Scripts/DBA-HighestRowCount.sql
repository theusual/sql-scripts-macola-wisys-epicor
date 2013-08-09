select distinct convert(varchar(30),object_name(a.id)) [Table Name], a.rows
from sysindexes a inner join sysobjects b on a.id = b.id
inner join INFORMATION_SCHEMA.TABLES c on c.[TABLE_NAME]=convert(varchar(30),object_name(a.id))
where c.Table_catalog='SD206N_001'
ORDER BY a.rows DESC

