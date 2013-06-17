USE [001]

SELECT item_no , qty_allocated AS [FINISHED NEED], CASE WHEN (qty_on_hand > 0) 
                                               THEN qty_on_hand WHEN (qty_on_hand <= 0) THEN '0' END AS [FINISHED QOH], 0 AS [RAW QOH], 0 AS [RAW ON ORDER], 0 AS [NEED TO ORDER]
FROM z_iminvloc
WHERE prod_cat = '1' and  qty_allocated > 0 AND (item_no NOT IN (
'11562 SLANT ABS'            
,'15569 CUTNG BRD'               
,'16894 BCKBRD PLST'             
,'ABSBK 0288X2350'               
,'ABSBK 0288X3200'               
,'ABSBK 0400X1438'               
,'ABSBK 0400X2000'               
,'ABSBK 0400X2881'               
,'ABSBK 0400X4650'               
,'ABSBK 0400X6000'               
,'ABSBK 1150X2450'               
,'ABSBK 1238X2838'               
,'ABSBK 1275X2138'               
,'ABSBK 1338X1313'               
,'ABSBK 1338X1338'               
,'ABSBK 1450X2850'               
,'ABSBK 1550X2288'               
,'ABSBK 1575X2138'               
,'ABSBK 1638X1638'               
,'ABSBK 2375X3200'               
,'ABSBK 2400X2400'               
,'ABSBK 2675X3350'               
,'ABSBK 2800X3350'               
,'ABSBK 2850X2850'               
,'ABSBK 4425X2838'               
,'ABSBK 4450X1406'               
,'CCF-FR 24X35 CL'               
,'CIP-01A ZBK'                   
,'CIP-01B ZBK'                   
,'DR-313 BK'                     
,'EC-02P BK'                     
,'EC-02P BZWH'                   
,'EC-02P CZPLY'                  
,'EC-02P DZBK'                   
,'EC-131B Z BK'                  
,'EC-239BL ZBK'                  
,'EC-239BR ZBK'                  
,'EC-313 BK'                     
,'EC-315 Z BK'                   
,'ECW-42X85N BK'                 
,'EZ-FB 12X16 BK'                
,'EZ-FB BK'                      
,'EZFB-12X16X2 BK'               
,'FBD-01'                        
,'FBD-01 C Z BK'                 
,'ZFDT-2 BL D BAS'
,'GTR-ICE HD BK'                 
,'ZGTR-ICE PN ABK'
,'GTR-ICE PN BK'                 
,'HU-01 BK'                      
,'KPC-6 90 BK'                   
,'LUG-16X24X5ZBBK'              
,'M5122282'                      
,'M5122282 BK'                   
,'M5203840BK L'                  
,'M5203840BK R'                  
,'ZMCT-18SR BK'
,'MET-4836 TF PUB'               
,'MKW13A12238 BK'                
,'ZOBLR-24X48AZBK'
,'ZOBP-36X36X8 BK'
,'ZOBP-40X48X3 BK'
,'OCT-FB25A ZBK'                 
,'OCT-FB25B ZBK'                 
,'OCT-FB25C ZBK'                 
,'PBU-10-32 BK'                  
,'PLASTIC SEE DWG'               
,'PPD-774 BK'                    
,'PTM-12X30X3 BK'                
,'PTM-16X30X3 BK'                
,'PTM-1X3 CL'                    
,'PTM-1X6 BK'                    
,'PTM-24X30X6 BK'                
,'SM-30PKSCALECAN'               
,'SM-30PKSCALECAN'               
,'ZST SHT .125 BK'
,'ZST SHT BK .125'
,'ZST SHT BK .187'
,'ZST SHT ER.125'
,'ST-01 12" CZBK'                
,'ST-01 12IN DZBK'               
,'TLB-01 BK'                     
,'VEG-106 EC#7 BK'               
,'VEG-106CAS MTZB'               
,'VEG-106RES LG B'               
,'VEG-173 41" BK'                
,'VEG-173 BK'                    
,'VEG-202 BK'                    
,'VEG-202Z C BK'                 
,'VEG-257 BK'                    
,'VEG-257C Z CL'                 
,'VEG-257ZC 24"CL'               
,'VEG-301 BK'                    
,'VEG-308B Z BK'                 
,'VEG-36 X BK/BK'                
,'VEG-384 BK'                    
,'VEG-400-36 BK'                 
,'VEG-467 BK'                    
,'VEG-484 BK'                    
,'VEG-485 BK'                    
,'VEG-52 BK-BK-BK'               
,'VEG-73'                        
,'VEG-75 4'                      
,'VEG-75Z A 4'                   
,'VEG-75Z B 4'                   
,'VEG-OBA FB'                    
,'Z-FLEX SGN CHNL'               
,'ZK129'                         
,'ZK458'                         
,'Z-SIGN CLIP CLR'               
,'ZX-BUMP ON')) 

UNION ALL

SELECT substring(item_no , 2 , len(item_no) - 1) + ' RAW' , 0 AS [FINISHED NEED], 0 AS [FINISHED QOH], CASE WHEN (qty_on_hand > 0) 
                                               THEN qty_on_hand WHEN (qty_on_hand <= 0) THEN '0' END AS  [RAW QOH], qty_on_ord AS [RAW ON ORDER], 0 AS [NEED TO ORDER]
FROM z_iminvloc
WHERE prod_cat = '20' AND item_no like 'z%' and  qty_on_ord > 0 AND (item_no NOT IN (
'11562 SLANT ABS'            
,'15569 CUTNG BRD'               
,'16894 BCKBRD PLST'             
,'ABSBK 0288X2350'               
,'ABSBK 0288X3200'               
,'ABSBK 0400X1438'               
,'ABSBK 0400X2000'               
,'ABSBK 0400X2881'               
,'ABSBK 0400X4650'               
,'ABSBK 0400X6000'               
,'ABSBK 1150X2450'               
,'ABSBK 1238X2838'               
,'ABSBK 1275X2138'               
,'ABSBK 1338X1313'               
,'ABSBK 1338X1338'               
,'ABSBK 1450X2850'               
,'ABSBK 1550X2288'               
,'ABSBK 1575X2138'               
,'ABSBK 1638X1638'               
,'ABSBK 2375X3200'               
,'ABSBK 2400X2400'               
,'ABSBK 2675X3350'               
,'ABSBK 2800X3350'               
,'ABSBK 2850X2850'               
,'ABSBK 4425X2838'               
,'ABSBK 4450X1406'               
,'CCF-FR 24X35 CL'               
,'CIP-01A ZBK'                   
,'CIP-01B ZBK'                   
,'DR-313 BK'                     
,'EC-02P BK'                     
,'EC-02P BZWH'                   
,'EC-02P CZPLY'                  
,'EC-02P DZBK'                   
,'EC-131B Z BK'                  
,'EC-239BL ZBK'                  
,'EC-239BR ZBK'                  
,'EC-313 BK'                     
,'EC-315 Z BK'                   
,'ECW-42X85N BK'                 
,'EZ-FB 12X16 BK'                
,'EZ-FB BK'                      
,'EZFB-12X16X2 BK'               
,'FBD-01'                        
,'FBD-01 C Z BK'                 
,'ZFDT-2 BL D BAS'
,'GTR-ICE HD BK'                 
,'ZGTR-ICE PN ABK'
,'GTR-ICE PN BK'                 
,'HU-01 BK'                      
,'KPC-6 90 BK'                   
,'LUG-16X24X5ZBBK'              
,'M5122282'                      
,'M5122282 BK'                   
,'M5203840BK L'                  
,'M5203840BK R'                  
,'ZMCT-18SR BK'
,'MET-4836 TF PUB'               
,'MKW13A12238 BK'                
,'ZOBLR-24X48AZBK'
,'ZOBP-36X36X8 BK'
,'ZOBP-40X48X3 BK'
,'OCT-FB25A ZBK'                 
,'OCT-FB25B ZBK'                 
,'OCT-FB25C ZBK'                 
,'PBU-10-32 BK'                  
,'PLASTIC SEE DWG'               
,'PPD-774 BK'                    
,'PTM-12X30X3 BK'                
,'PTM-16X30X3 BK'                
,'PTM-1X3 CL'                    
,'PTM-1X6 BK'                    
,'PTM-24X30X6 BK'                
,'SM-30PKSCALECAN'               
,'SM-30PKSCALECAN'               
,'ZST SHT .125 BK'
,'ZST SHT BK .125'
,'ZST SHT BK .187'
,'ZST SHT ER.125'
,'ST-01 12" CZBK'                
,'ST-01 12IN DZBK'               
,'TLB-01 BK'                     
,'VEG-106 EC#7 BK'               
,'VEG-106CAS MTZB'               
,'VEG-106RES LG B'               
,'VEG-173 41" BK'                
,'VEG-173 BK'                    
,'VEG-202 BK'                    
,'VEG-202Z C BK'                 
,'VEG-257 BK'                    
,'VEG-257C Z CL'                 
,'VEG-257ZC 24"CL'               
,'VEG-301 BK'                    
,'VEG-308B Z BK'                 
,'VEG-36 X BK/BK'                
,'VEG-384 BK'                    
,'VEG-400-36 BK'                 
,'VEG-467 BK'                    
,'VEG-484 BK'                    
,'VEG-485 BK'                    
,'VEG-52 BK-BK-BK'               
,'VEG-73'                        
,'VEG-75 4'                      
,'VEG-75Z A 4'                   
,'VEG-75Z B 4'                   
,'VEG-OBA FB'                    
,'Z-FLEX SGN CHNL'               
,'ZK129'                         
,'ZK458'                         
,'Z-SIGN CLIP CLR'               
,'ZX-BUMP ON')) 