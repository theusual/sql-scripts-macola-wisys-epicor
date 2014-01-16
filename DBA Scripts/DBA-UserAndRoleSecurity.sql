-- 1) create a role 2) set UPDATE permission to it  3) Add User to the role

--Create Role
CREATE ROLE [Purchasing]

--Edit role by granting or revoking privileges
GRANT UPDATE ON [001].dbo.[BG_ACCESS_PURCHASING_IMINV] TO [Purchasing]
GRANT UPDATE ON [060].dbo.[BG_MASTER_SCHEDULE] TO [Public]
--Add members to the role
EXEC sp_addrolemember N'Purchasing', N'MARCO\tkennedy'

--Test role as that user
EXECUTE AS LOGIN = 'MARCO\tkennedy'
UPDATE [001].dbo.[BG_ACCESS_PURCHASING_IMINV]
SET [item_weight] = 1
WHERE [item_no] = '*EDI-ITEM'

EXECUTE AS LOGIN = 'MARCO\jnoire'
SELECT * FROM [BG_MASTER_SCHEDULE]
--WHERE [ord_no] = '  376169' AND ln = 1

SELECT * FROM dbo.[BG_PO_CH_VENDOR_VIEW-AIFEI]