SELECT *
FROM ARSHTTBL
WHERE zone is null and ship_dt > '20110520'

SELECT *
FROM BG_SHIPPED
WHERE Ord_no like '%675532%'

SELECT *
FROM oeordlin_sql
WHERE Ord_no = '  376914'

UPDATE oeordhdr_sql
SET status = 4
WHERE ord_no = '  675409'

SELECT *
FROM oebolfil_sql inner join wsShipment 
WHERE Ord_no = '  669358'

SELECT *
FROM wsPikPak inner join ARSHTFIL_SQL on wsPikPak.Ord_no = ARSHTFIL_SQL.ord_no
WHERE wspikpak.ord_no = '  675815'

SELECT *
FROM oehdrhst_sql
WHERE Ord_no = '  675532'

SELECT *
FROM wsShipment SH INNER JOIN wsPikPak PP on PP.Shipment = sh.Shipment LEFT OUTER JOIN oebolfil_sql BL ON BL.bol_no = SH.bol_no
WHERE Ord_no = '  675532'

SELECT *
FROM         [001].dbo.wsPikPak pp INNER JOIN
					  oelinhst_sql OL ON ol.item_no = pp.Item_no AND ol.ord_no = pp.ord_no AND line_seq_no = pp.line_no INNER JOIN 
					  oehdrhst_sql OH on OH.inv_no = ol.inv_no INNER JOIN
                      [001].dbo.wsShipment ws ON ws.shipment = pp.shipment LEFT OUTER JOIN
                      [001].dbo.oebolfil_sql BL ON BL.bol_no = ws.bol_no
WHERE     pp.ord_no <> '' AND (CONVERT(varchar, CAST(rtrim(pp.ship_dt) AS datetime), 101) > DATEADD(day, - 40, GETDATE())) AND 
                      pp.Shipped = 'Y' and pp.ord_no like '%675532%'


UPDATE oeordhdr_sql
SET status = 4
WHERE ord_no = '  676839'

UPDATE oeordlin_sql
SET user_def_fld_2 = null
WHERE ord_no = '  668685'

SELECT *
FROM wspikpak
WHERE ord_no = '  678519'

SELECT *
FROM wspikpak
WHERE Pallet_UCC128 like '%10007455%'
--WHERE ord_no like '%675192%'

DELETE FROM wsPikPak
WHERE ord_no = '  676827'

SELECT *
FROM iminvloc_Sql
WHERE item_no = 'wbh-004 wmbv'

SELECT SUM(qty_ordered)
FROM OEORDLIN_SQL OL INNER JOIN oeordhdr_sql OH ON OH.ord_no = OL.ord_no
WHERE ltrim(oh.oe_po_no) like '%30689769%'

SELECT *
FROM poitmvnd_sql
where item_no = 'test item'

SELECT * FROM wsPikPak WHERE Ord_no = '  677076'

DELETE FROM wspikpak
WHERE Ord_no = '  716269'

SELECT *
FROM oeordhdr_sql
WHERE ship_via_cd IN ('u2a','UXP')

SELECT * FROM sycdefil_sql where cd_type = 'v'

SELECT * FROM oelinhst_sql OL INNER JOIN oehdrhst_sql OH ON OL.ord_no = OH.ord_no WHERE OL.ord_no like '%676138%'

DELETE FROM wspikpak  WHERE Pallet_UCC128 like '%10007455%'

SELECT * FROM Z_OPEN_OPS WHERE [ORDER]= '5012306'

SELECT * FROM oelinhst_Sql WHERE item_no like 'BBPOB-BAN EC BK'

SELECT * FROM BG_WMPO WHERE [Supplier Sales/Work Order Number] = '675113'

SELECT * FROM iminvloc_Sql WHERE item_no = 'PCT-004 PC SS' 

UPDATE imitmidx_sql
SET stocked_fg = 'N'
WHERE item_no = '12NLDEBS'

SELECT * FROM POORDLIN_SQL WHERE ord_no = '11281900'

SELECT * FROM imrechst_sql WHERE ord_no = '11281900'

SELECT  DISTINCT(loc)
FROM    iminvloc_sql
WHERE item_no = 'TMK812B'

UPDATE OEORDHDR_SQL
SET status = 4
WHERE ord_no = '  675501'

SELECT * 
FROM BG_WMPO
WHERE [Supplier Sales/Work Order Number] = '679988'

SELECT *
FROM araltadr_sql
WHERE cus_alt_adr_cd = 'lakeland'

SELECT * 
FROM oeordlin_sql
WHERE ord_no = ' 5012455'

SELECT * 
FROM iminvtrx_sql
WHERE item_no = 'test item' AND doc_type = 'R'

SELECT * FROM POORDLIN_SQL

SELECT * FROM WSPIKPAK WHERE ord_no = '  676233'
ORDER BY Item_no

SELECT * FROM oeordlin_sql WHERE ord_no = '  676233'
ORDER BY item_no

SELECT  *
FROM    imitmidx_sql
where item_no like 'sw10061%'


