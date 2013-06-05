exec efwGetDDInfo 'gbkmut'

exec efwGetDDInfo 'banktransactions'

SELECT * FROM dbo.amutak AS AM


SELECT dc.columnname, dc.description, dc.type, dc.length, dc.scale, dc.dimensions, dc.termid, dc.flags 
FROM ddcolumns dc 
WHERE dc.tablename = 'gbkmut'
ORDER BY dc.tablename, (type & 1048576), (dc.flags & 1), dc.seqnr, dc.columnname 


SELECT *
FROM dbo.bi50_gbkmut_fsyrpd_trxdt AS BGFT
