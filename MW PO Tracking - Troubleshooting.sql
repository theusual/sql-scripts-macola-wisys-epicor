SELECT prod_cat, * FROM oehdrhst_Sql OH JOIN dbo.oelinhst_sql OL ON OH.inv_no = OL.inv_no WHERE OH.oe_po_no IN ('31951116')
SELECT prod_cat, * FROM oehdrhst_Sql OH JOIN dbo.oelinhst_sql OL ON OH.inv_no = OL.inv_no WHERE OH.ord_no IN ('  705488')
SELECT prod_cat, * FROM oeordhdr_Sql OH JOIN dbo.oeordlin_sql OL ON OH.ord_no = OL.ord_no WHERE OH.ord_no IN ('  705544')
SELECT prod_cat, * FROM oeordhdr_Sql OH JOIN dbo.oeordlin_sql OL ON OH.ord_no = OL.ord_no WHERE OH.oe_po_no IN ('32055458')
SELECT * FROM wspikpak WHERE ord_no = '  704724'

UPDATE oeordlin_Sql
SET cus_item_no = '100526242'
WHERE ord_no = '  708374' --AND item_no = 'MET-SIDEKICKRSV'

