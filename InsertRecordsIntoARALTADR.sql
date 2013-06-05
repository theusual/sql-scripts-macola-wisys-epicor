SELECT ((select max(idcol) from addresses) + 1), [Type], Account, ContactPerson, AddressLine1, AddressLine2, AddressLine3, PostCode, City, StateCode, 
      County, Country, Phone, Fax, Notes, KeepSameAsVisit, textfield1, Main, AddressCode, SalesPersonNumber, 
      ShipVia, UPSZone, IsTaxable, TaxCode, TaxCode2, warehouse, FOBCode, Division, syscreated, 
      syscreator, sysmodified, sysmodifier, ID, idcol
FROM Addresses
WHERE account = 'F5E81712-F40D-4D45-B2DB-568BA215FF38' --'757B0329-DAE0-4BD5-B0BE-18BE95E66FD0'


INSERT INTO Addresses
      ([Type], Account, ContactPerson, AddressLine1, AddressLine2, AddressLine3, PostCode, City, StateCode, 
      County, Country, Phone, Fax, Notes, KeepSameAsVisit, textfield1, Main, AddressCode, SalesPersonNumber, 
      ShipVia, UPSZone, IsTaxable, TaxCode, TaxCode2, warehouse, FOBCode, Division, syscreated, 
      syscreator, sysmodified, sysmodifier)
SELECT [Type], 'F5E81712-F40D-4D45-B2DB-568BA215FF38', '757B0329-DAE0-4BD5-B0BE-18BE95E66FD0', AddressLine1, AddressLine2, AddressLine3, PostCode, City, StateCode, 
      County, Country, Phone, Fax, Notes, KeepSameAsVisit, textfield1, Main, AddressCode, SalesPersonNumber, 
      ShipVia, UPSZone, IsTaxable, TaxCode, TaxCode2, warehouse, FOBCode, Division, syscreated, 
      syscreator, sysmodified, sysmodifier
FROM Addresses
WHERE account = 'DE584209-2C5A-48AC-A535-DA4A6070CC1D'


UPDATE  addresses
SET AddressLine1 = 'ATTN  MIRIAM WHITE'
where idcol IN (109986, 109988, 109985)


DELETE FROM dbo.Addresses
WHERE idcol = 124496