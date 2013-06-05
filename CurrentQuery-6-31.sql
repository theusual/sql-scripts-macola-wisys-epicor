BEGIN TRAN

SELECT  *
FROM    wsPikPak INNER JOIN oeordhdr_sql ON ltrim(wsPikPak.Ord_no) = ltrim(oeordhdr_sql.ord_no)
WHERE 
ltrim(Pallet_UCC128) = '10000001'  
--ord_no = '88888888'

SELECT  *
FROM    iminvloc_sql
WHERE item_no = 'bom test'

SELECT  *
FROM    oeordhdr_sql INNER JOIN oeordlin_sql ON oeordhdr_sql.ord_no = oeordlin_sql.ord_no
where oeordhdr_sql.ord_no = '  673710'

UPDATE wspikpak
SET loc = 'MDC'
where ord_no = '88888888'

Select LTrim(wspikpak.Ord_no) + '  -  ' +
  Convert(varchar,(Convert(int,wspikpak.Shipment)),10) As 'Ord/Shpmnt'
From wspikpak
Where wspikpak.Shipment <> 0 And wspikpak.Shipped = 'N'
Order By 1 Desc


Select wspikpak.Ord_no As '@txtOrdNo', arcusfil_sql.cus_name As
  '@txtCustomer', oeordhdr_sql.oe_po_no As '@txtPO'
From wspikpak Inner Join
  oeordhdr_sql On wspikpak.Ord_no = oeordhdr_sql.ord_no INNER JOIN arcusfil_sql ON arcusfil_sql.cus_no = oeordhdr_Sql.cus_no
  
  DECLARE @DEFLOc VARCHAR(MAX)
  
  SET @DEFLOC = 'MDC'
  
  Select imlocfil_sql.loc As 'Loc', imlocfil_sql.loc_desc As 'Description'
From imlocfil_sql
Where imlocfil_sql.loc <> @DEFLoc