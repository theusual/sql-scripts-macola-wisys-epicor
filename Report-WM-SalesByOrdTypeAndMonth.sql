SELECT MONTH(billed_dt), qty_ordered, sls_amt, * FROM dbo.oelinhst_sql OL JOIN oehdrhst_Sql OH ON OH.inv_no = OL.inv_no WHERE item_no IN ('MET-BSKT 01 RSV',
'MET-BSKT 02 RSV',
'MET-HNG ARM RSV',
'MET-HNG KIT1RSV',
'MET-HNG KIT2RSV',
'MET-HNG KIT3RSV',
'MET-RACK 01 RSV',
'MET-RACK 02 RSV',
'MET-SIDEKICKRSV',
'MET-WR DVDR2RSV',
'MET-WR RACK RSV',
'MET-WR RACK2RSV',
'MET-HANG RL RSV') AND billed_dt > '01/01/2012'

SELECT MONTH(billed_dt), qty_ordered, * FROM dbo.oeordlin_sql OL JOIN oeordhdr_Sql OH ON OH.ord_no = OL.ord_no WHERE item_no IN ('MET-BSKT 01 RSV',
'MET-BSKT 02 RSV',
'MET-HNG ARM RSV',
'MET-HNG KIT1RSV',
'MET-HNG KIT2RSV',
'MET-HNG KIT3RSV',
'MET-RACK 01 RSV',
'MET-RACK 02 RSV',
'MET-SIDEKICKRSV',
'MET-WR DVDR2RSV',
'MET-WR RACK RSV',
'MET-WR RACK2RSV',
'MET-HANG RL RSV')

SELECT * FROM oeordlin_sql WHERE item_no = 'MET-HNG KIT3RSV'
SELECT * FROM oelinhst_sql WHERE item_no = 'MET-HNG KIT3RSV'
