--Fix printer corrupted printer settings in Macola by removing the user's records from this table

SELECT * FROM printdft_sql WHERE prt_df_user LIKE 'RWALKER%'

DELETE FROM printdft_sql WHERE prt_df_user LIKE 'RWALKER%'

