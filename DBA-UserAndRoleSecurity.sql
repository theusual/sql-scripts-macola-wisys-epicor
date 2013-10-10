-- 1) create a role 2) set UPDATE permission to it  3) Add User to the role

CREATE ROLE [ProductionControl]
GO
GRANT UPDATE ON [001].dbo.[BG_shipping_Form] TO [MARCO\Domain Users]
GO
EXEC sp_addrolemember N'ProductionControl', N'MARCO\tcook'
GO

--Test role as that user
EXECUTE AS LOGIN = 'MARCO\lafiles'
UPDATE [001].dbo.[BG_LATE_ORDERS_NONWM]
SET [Late Order Comments 1] = 'test2'
WHERE [ord_no] = ' 2031524' AND ln = 1

SELECT * FROM BG_LATE_ORDERS_NONWM
WHERE [ord_no] = ' 2031524' AND ln = 1