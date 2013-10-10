ALTER PROC BG_BuildShipment
(
    @txtShipment    VARCHAR(30),
    @NextBOLNo VARCHAR(8)
)
AS
BEGIN

	-- UPDATED:  7/11/12      BY: BG
	-- Purpose: Write back data to wsShipment and update control tables -- For Wisys build shipment App
	
	BEGIN TRANSACTION
	
	  --Select @txtShipment = (Select Right(Replicate(' ', 30) + Convert(varchar, Max(Convert(int, IsNull(wssettings_sql.LongValue , 0)))), 30))
	  --From wssettings_sql
	  --Where wssettings_sql.SettingGroup = 'PikPak' And wssettings_sql.SettingName ='NextTruck'
  
	SELECT @NextBOLNo = Right(Replicate(' ', 8) + @NextBOLNo, 8)
	
  --Next, create the entry in wsshipment
	insert into wsshipment
	(shipment,trailer,created_dt,bol_no,pro_no)
	values
	(substring(space(30)+@txtShipment,len(space(30)+@txtShipment)-29,30),'',getdate(),@NextBolNo,'')
	
  --Last, update the control tables with next in line BOL and Shipment
	--Added to test BOLNo write back:--------------------------------------
	INSERT INTO [BG_BACKUP].dbo.DevTesting	VALUES  (@NextBOLNo,@txtShipment,@NextBOLNo+1,NULL)	
	-----------------------------------------------------------------------
	Update oectlfil_sql set next_bol_no = @NextBOLNo + 1
	Update wssettings_sql set longvalue = @txtShipment + 1 where settinggroup = 'PikPak' and settingname = 'NextTruck'
	        
	If @@error <> 0 Begin
		Rollback Transaction
	End
	    
	COMMIT TRANSACTION
	
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
	   