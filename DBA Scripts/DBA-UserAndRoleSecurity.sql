-- 1) create a role 2) set UPDATE permission to it  3) Add User to the role

CREATE ROLE [Purchasing]
GO
GRANT UPDATE ON [001].dbo.[BG_PO_CH_VENDOR_VIEW-OTHERS] TO [Purchasing]
GO
EXEC sp_addrolemember N'Purchasing', N'MARCO\tkennedy'
GO

--Test role as that user
EXECUTE AS LOGIN = 'MARCO\knovick'
UPDATE [001].dbo.[BG_PO_CH_VENDOR_VIEW-AIFEI]
SET [Container] = 'SHIP SANK. RIP Marco Tables'
WHERE [PO #] = 119542 AND [Line Number] = 1

EXECUTE AS LOGIN = 'MARCO\slewelling'
SELECT * FROM BG_LATE_ORDERS_NONWM
WHERE [ord_no] = '  376169' AND ln = 1

SELECT * FROM dbo.[BG_PO_CH_VENDOR_VIEW-AIFEI]