--Make into nightly job if invoicing works:
UPDATE dbo.oeordhdr_sql
SET tax_fg = 'N'
WHERE tax_cd = 'NON' AND LTRIM(cus_no) = '1575'
