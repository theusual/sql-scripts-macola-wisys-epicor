SELECT COUNT (DISTINCT OH.ord_no)
FROM         dbo.oeordlin_sql AS OL INNER JOIN
                      dbo.oeordhdr_sql AS OH ON OL.ord_no = OH.ord_no LEFT OUTER JOIN
                      dbo.ARSHTTBL AS SH ON LTRIM(OL.ord_no) = CAST(SH.ord_no AS int) AND OL.item_no = SH.filler_0001 LEFT OUTER JOIN
                      dbo.oecusitm_sql AS CI ON OL.item_no = CI.item_no AND OH.cus_no = CI.cus_no LEFT OUTER JOIN
                      dbo.edcshvfl_sql AS XX ON SH.carrier_cd = XX.mac_ship_via
WHERE     (OH.ord_type = 'O') AND ltrim(OH.cus_no) IN ('1575', '20938') AND (OH.shipping_dt - OH.ord_dt) < 6 AND (SH.void_fg IS NULL) AND (CONVERT(varchar, CAST(rtrim(SH.ship_dt) AS datetime), 101) > DATEADD(day, -7, GETDATE()))
