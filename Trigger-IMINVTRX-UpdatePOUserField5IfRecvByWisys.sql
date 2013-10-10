ALTER TRIGGER trigUpdatePOUserField5IfRecvByWisys
ON IMINVTRX_SQL

--Create: 6/29/11  By: BG
--Last Updated: 6/29/11 By: BG
--Purpose: To populate user_def_fld_5 on the PO order line with info stating that the PO was received in Wisys, so that a Macola user can determine if a PO was received via Macola or via Wisys

AFTER INSERT

AS

DECLARE @comment1 varchar(60)
DECLARE @comment2 varchar(60)
DECLARE @source varchar(2)
DECLARE @item_no varchar(30)
DECLARE @ord_no varchar(10)

SELECT @comment1 = comment FROM inserted
SELECT @comment2 = comment_2 FROM inserted
SELECT @source = source FROM inserted
SELECT @item_no = item_no FROM inserted
SELECT @ord_no = doc_ord_no FROM inserted

if @source = 'R'

BEGIN

	if ltrim(rtrim(@comment1)) IN ('PO Received By Agility')

	BEGIN

	UPDATE POORDLIN_SQL
	SET user_def_fld_5 = 'PO Received By Wisys-Desktop'
	WHERE item_no = @item_no AND ord_no = @ord_no
	
	END
	
	if ltrim(rtrim(@comment1)) IN ('PO Received By Wisys', '0')

	BEGIN

	UPDATE POORDLIN_SQL
	SET user_def_fld_5 = 'PO Received By Wisys-Gun'
	WHERE item_no = @item_no AND ord_no = @ord_no

	END

END

Return