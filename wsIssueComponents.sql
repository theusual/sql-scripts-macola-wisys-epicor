USE [001]
GO

/****** Object:  StoredProcedure [dbo].[wsCreateEmptyPallets]    Script Date: 02/22/2011 18:00:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE Proc [dbo].[wsIssueComponents] (@qty int, @item varchar(20), @loc varchar(3))
As
Begin

Declare @oldqty int

Set @oldqty = (SELECT qty_on_hand FROM iminvloc_sql WHERE item_no = @item and @loc = loc)

/*If @store Is Null
  Set @store = ''*/

Begin Transaction

UPDATE iminvloc_sql
SET qty_on_hand = (@oldqty-@qty)
WHERE item_no = (@item AND loc = @loc
/*  
/*This section updated by Bryan: Insert Pallet and PalletUCC values into Carton and CartonUCC fields in addition to the pallet fields.
------*/
    Insert Into wspikpak (shipment, ord_no, line_no, item_no,item_desc,loc,qty,pallet,pallet_ucc128, Carton, Carton_UCC128, BinSLID, load_dt,shipped,[weight],length,width,height)
    Values ('', '', 0, '',@store,'',0, @pallet, @pallet_ucc128, @pallet, @pallet_ucc128, Newid(), GETDATE(), 'N', 0, 0, 0, 0)
/*------*/
    If @@error <> 0 Begin
      Rollback Transaction
      Goto on_error
    End

    Update wssettings_sql set longvalue = (Select Max(convert(int,pallet)) from wspikpak) + 1 Where settinggroup = 'pikpak' and settingname = 'nextpallet'

    If @@error <> 0 Begin
      Rollback Transaction
      Goto on_error
    End

    Set @cnt = @cnt + 1
*/


End

Commit Transaction

on_error:

Return 
GO


