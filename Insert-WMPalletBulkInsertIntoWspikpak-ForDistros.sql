Insert Into wspikpak (shipment, ord_no, line_no, item_no,item_desc,loc,qty,pallet,pallet_ucc128, Carton, Carton_UCC128, BinSLID, load_dt,shipped,[weight],length,width,height)
SELECT '', [ord_no], 1, 'DVD DUMPKIT1RS',[Store],'MDC',1, 
Right(Replicate(' ', 30) + Convert(varchar, Convert(int, IsNull(pallet, 0))), 30), 
Right(Replicate(' ', 50) + Convert(varchar, Convert(int, IsNull(pallet, 0))), 50), 
Right(Replicate(' ', 30) + Convert(varchar, Convert(int, IsNull(pallet, 0))), 30), 
Right(Replicate(' ', 50) + Convert(varchar, Convert(int, IsNull(pallet, 0))), 50),
Newid(), 
GETDATE(), 
'N', 
198, 
0, 
0, 
0
FROM BG_WM_DISTRO_060612

DELETE FROM wspikpak WHERE ord_no IN (SELECT ord_no FROM BG_WM_DISTRO_060612)

SELECT * FROM BG_WM_DISTRO_060612

