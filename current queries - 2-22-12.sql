SELECT * 
FROM dbo.poordlin_sql AS PL JOIN dbo.poordhdr_sql AS PH ON PH.ord_no = PL.ord_no --JOIN dbo.BG_CH_Vendors BG ON BG.vend_no = LTRIM(PL.vend_no)
WHERE ord_dt > '08/01/2010' AND item_no = '13124 FLAT BAR' AND PL.ord_status != 'X'


SELECT * FROM dbo.Z_IMINVLOC AS IM WHERE IM.item_no = 'GRO-011 WM BV'

SELECT * FROM dbo.bmprdstr_sql AS BS WHERE item_no = '58685-2 bk'
