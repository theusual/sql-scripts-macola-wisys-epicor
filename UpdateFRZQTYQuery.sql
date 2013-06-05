USE[001]
UPDATE iminvloc_sql
SET iminvloc_sql.frz_dt = '2010-11-27 00:00:00.000'
FROM NovInventory_Corrections_NC INNER JOIN iminvloc_sql ON (rtrim(ltrim(NovInventory_Corrections_NC.item_no))=rtrim(ltrim(IMINVLOC_SQL.Item_no))) AND (rtrim(ltrim(NovInventory_Corrections_NC.loc))=rtrim(ltrim(IMINVLOC_SQL.loc)))
