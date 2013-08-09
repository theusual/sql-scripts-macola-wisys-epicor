BEGIN TRAN

Insert into wsCategory (CategoryID, ProjectID, ParentID, Name, Type, Image, SeqNo, SecurityLvl, IsDeleted)
Select NEWID(), ProjectID, ParentID, 'Lookup', Type, Image, 5, SecurityLvl, IsDeleted
From wsCategory
Where Name = 'Distribution' And Type = 'WMS'

UPDATE wsCategory set Name = 'Prod'
WHERE Name = 'Build'

DELETE wsCategory WHERE Name = 'Distribution'

SELECT  *
FROM    wsCategory

SELECT  *
FROM    wsusersforms


ROLLBACK