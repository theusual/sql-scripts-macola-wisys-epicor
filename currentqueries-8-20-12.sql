SELECT * FROM wspikpak WHERE ship_dt > '08/01/2012'

SELECT sls_amt FROM oelinhst_Sql WHERE shipped_Dt > '08/01/2012'

SELECT ol.line_no, pp.line_no , ol.item_no, pp.item_no, * FROM wspikpak pp JOIN oeordlin_sql OL ON OL.ord_no = pp.ord_no AND ol.item_no = pp.item_no WHERE pp.ord_no = ' 7700355'

SELECT line_no, * FROM dbo.oeordlin_sql WHERE ord_no = ' 7700355'
SELECT * FROM dbo.oelinaud_sql WHERE ord_no = ' 7700355' AND item_no = 'BAK-619 L WM WF'

UPDATE oeordlin_Sql 
SET line_no = 11
WHERE ord_no = ' 7700355' AND item_no = 'BAK-619 L WM WF'