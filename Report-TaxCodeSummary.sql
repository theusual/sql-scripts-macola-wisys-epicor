SELECT tax_cd, TAX_CD_DESCRIPTION, tax_cd_percent, TAX_CD_MAIN_ACCT_NO, TAX_CD_SUB_ACCT_NO, TAX_CD_DP_ACCT_NO, frt_fg, misc_chg_fg, lower_cds_fg, TAX_CD_TAX_AMOUNT, TAX_CD_MAX_TAX_AMOUNT, tax_cd_sales_ptd, TAX_CD_SALES_YTD, tax_cd_taxes_ptd, tax_cd_taxes_ytd
FROM TAXDETL_SQL  
ORDER BY TAXDETL_SQL.tax_cd