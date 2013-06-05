ALTER PROC BG_BuildShipmentPikPak
(
	@Item_no        char(30),
    @Loc            char(3),
    @ord_no         char(8),
    @line_no        int,
    @Qty            decimal(16,4),
    @Weight         Decimal(12,4),
    @txtShipment    VARCHAR(30),
    @NextBOLNo VARCHAR(8),
    @NextPallet VARCHAR(30)
)
AS
BEGIN

	-- UPDATED:  7/12/12      BY: BG
	-- Purpose: Build Shipment Info in PikPak -- For Wisys build shipment App
	
  --First, create the shipment lines in wspikpak
	  Declare @load_dt        datetime
	  Declare @BinSLID        uniqueidentifier 
	  Declare @ship_dt        datetime 
	  Declare @TrackingNo     char(20) 
	  Declare @ParcelType     char(10) 
	  Declare @Status         char(3) 
	  Declare @seq_no         int 
	  Declare @Height         int
	  Declare @Length         int
	  Declare @Width          int
	  Declare @Shipped        char(1)
	  Declare @item_desc      char(30)
	  Declare @pallet Varchar(30)
	  Declare @pallet_ucc128 Varchar(50)
	  --DECLARE @txtShipment VARCHAR(30)
	  --DECLARE @NextBOLNo VARCHAR(8)

	  Set @Shipped = 'N'
	  Set @Height = 0
	  Set @Length = 0
	  Set @Width = 0
	  Set @load_dt = Getdate()
	  Set @BinSLID = Newid()
	  Set @ship_dt = Null
	  Set @TrackingNo = Null
	  Set @ParcelType = Null
	  Set @Status = Null
	  Set @seq_no = NULL
	  
	BEGIN TRANSACTION
	
	  --Select @txtShipment = (Select Right(Replicate(' ', 30) + Convert(varchar, Max(Convert(int, IsNull(wssettings_sql.LongValue , 0)))), 30))
	  --From wssettings_sql
	  --Where wssettings_sql.SettingGroup = 'PikPak' And wssettings_sql.SettingName ='NextTruck'
  
	  --SELECT @NextBOLNo = Right(Replicate(' ', 8) + Convert(varchar,MAX(Convert(int,bol_no)) + 1), 8)
      --From wsShipment
	  
	  Select @item_desc = item_desc_1
	  From imitmidx_sql
	  Where item_no = @item_no 
	  
	  Set @pallet        = (Select Right(Replicate(' ', 30) + Convert(varchar, Max(Convert(int, IsNull(@NextPallet, 0)))), 30) 
	  From wspikpak)
	  
      Set @pallet_ucc128 = (Select Right(Replicate(' ', 50) + Convert(varchar, Max(Convert(int, IsNull(@pallet, 0)))), 50))

	  Insert Into wspikpak (shipment, ord_no, line_no, item_no,item_desc,loc,qty,pallet,pallet_ucc128, Carton, Carton_UCC128, binslid,load_dt,shipped,[weight],length,width,height)
	  Values (@txtShipment, @ord_no, @line_no, @item_no, @item_desc, @loc, @qty, @pallet, @pallet_ucc128, @pallet, @pallet_ucc128, @binslid, @load_dt, @shipped, @weight, @length, @width, @height)
	  
	        
	  If @@error <> 0 Begin
		Rollback Transaction
	  End
	    
	COMMIT TRANSACTION
	
	
	--BEGIN TRANSACTION
	
  --Next, create the entry in wsshipment
	--insert into wsshipment
	--(shipment,trailer,created_dt,bol_no,pro_no)
	--values
	--(substring(space(30)+@txtShipment,len(space(30)+@txtShipment)-29,30),'',getdate(),@NextBolNo,'')
	
  --Last, update the control tables with next in line BOL and Shipment
	--Update oectlfil_sql set next_bol_no = @NextBOLNo + 1
	--Update wssettings_sql set longvalue = longvalue + 1 where settinggroup = 'PikPak' and settingname = 'NextTruck'
	        
	--If @@error <> 0 Begin
		--Rollback Transaction
	--End
	    
	--COMMIT TRANSACTION
	
	RETURN @txtShipment
END


/*
EXEC BG_BuildShipment 'TEST ITEM', 'FW','12222221','1','1','5000'

SELECT * FROM dbo.wsSettings_sql
SELECT next_bol_no, * FROM dbo.oectlfil_sql

SELECT RTRIM(LTRIM(shipment)), * FROM wspikpak WHERE shipment = '                         53263'

SELECT RTRIM(LTRIM(shipment)), *FROM dbo.wsShipment  WHERE RTRIM(LTRIM(Shipment)) = '53332'

	  SELECT Max(wsShipment.bol_no)
      From wsShipment

      Select Right(Replicate(' ', 8) + Convert(varchar,Convert(int,bol_no) + 1), 8), bol_no, *  FROM dbo.wsShipment WHERE CAST(bol_no AS INT) < 1280
      
      UPDATE dbo.wsShipment 
      SET bol_no = Right(Replicate(' ', 8) + Convert(varchar,Convert(int,bol_no) + 1), 8)
      WHERE CAST(bol_no AS INT) < 1280
      
      SELECT * FROM dbo.wsShipment JOIN wspikpak pp ON pp.shipment = dbo.wsShipment.Shipment WHERE CAST(bol_no AS INT) < 1280 AND shipped = 'N'
      SELECT * FROM dbo.wsShipment WHERE CAST(bol_no AS INT) < 128
      
      
      Select MAX(CAST(bol_no AS INT))
	  From wsshipment
	  
	  SELECT * FROM dbo.wsShipment ORDER BY bol_no
	  
	  SELECT * FROM wspikpak WHERE shipment = ''
	  SELECT * FROM wspikpak WHERE shipment LIKE '%53383%'
	  
	  
	  Select Right(Replicate(' ', 30) + Convert(varchar, Max(Convert(int, IsNull(wssettings_sql.LongValue , 0)))), 30)
	  From wssettings_sql
	  Where wssettings_sql.SettingGroup = 'PikPak' And wssettings_sql.SettingName ='NextTruck'
	  
	  SELECT Right(Replicate(' ', 8) + Convert(varchar,MAX(Convert(int,bol_no)) + 1), 8)
      From wsShipment
      
      SELECT * FROM dbo.wsSettings_sql
	  SELECT next_bol_no, * FROM dbo.oectlfil_sql
	  
	  SELECT next_bol_no + 1 FROM  oectlfil_sql 
	  SELECT longvalue + 1 FROM  wssettings_sql where settinggroup = 'PikPak' and settingname = 'NextTruck'
	  
	  SELECT * FROM wsshipment ORDER BY bol_no desc
*/
	   