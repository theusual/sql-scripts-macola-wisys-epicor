SELECT  RTRIM(IL.item_no) AS [Parent Item], 
            RTRIM(BM.comp_item_no) AS [Components], 
            RTRIM(IMPAR.item_desc_1) AS [Parent Desc 1], 
            RTRIM(IMPAR.item_desc_2) AS [Parent Desc 2], 
            IL.qty_on_hand AS [Par QOH], 
            ILCOMP.qty_on_hand AS [Comp QOH], 
            IL.qty_on_ord AS [Par QOO], 
            ILCOMP.qty_on_ord AS [Comp QOO], 
            IL.qty_allocated AS [Par QALL], 
            QALLCOMP.qty_allocated AS [Comp QALL], 
            cast(qty_per_par as int) AS [Qty Per Parent], 
            RTRIM(ILCOMP.item_desc_1) AS [CompDesc1], 
            RTRIM(ILCOMP.item_desc_2) AS [CompDesc2], 
            ILCOMP.prod_cat AS [CompProdCat], 
            IMPAR.prod_cat AS [ParProdCat], IM2.drawing_release_no + IM2.drawing_revision_no AS [CompDWG], IMPAR.drawing_release_no + IMPAR.drawing_revision_no AS [ParDWG]
FROM              (SELECT IL.item_no, qty_on_hand, qty_on_ord, qty_allocated 
				   FROM z_iminvloc IL JOIN dbo.imitmidx_sql AS IMPAR ON IMPAR.item_no = IL.item_no
				   WHERE  (IL.item_no NOT IN
				                    (SELECT comp_item_no FROM dbo.bmprdstr_sql AS BM)) 
				        AND IL.prod_cat = 'AP' AND IMPAR.activity_cd = 'A' AND IMPAR.item_no NOT IN ('AP PROTOTYPE', 
				'APCORRAL13 INST', 
				'AP-INSTALL 12X6', 
				'AP-INSTALL 19X6', 
				'AP-INSTALL 23X6', 
				'AP-INSTALL 24X8', 
				'AP-INSTALL 27X6', 
				'AP-INSTALL 31X6', 
				'AP-INSTALL 8X4', 
				'AP-INSTALL 8X8', 
				'ASSET-INSTALLA', 
				'ASSET-INSTALLC', 
				'ASSET-INSTALLD', 
				'ASSET-TRIPFEE', 
				'CORRAL01INSTALL', 
				'CORRAL02INSTALL', 
				'CUTTING FEE', 
				'FREIGHT-4967', 
				'FREIGHT-4974', 
				'FREIGHT-4983', 
				'KELIGROUT RESIN', 
				'KELKEN CATALAST', 
				'RSS-4967INSTALL', 
				'SIGNDNSEALD DWG', 
				'X-METAL 1X3X58.250 16G', 
				'X-METAL 1X3X98.5', 
				'X-METAL 2"GALV', 
				'X-METAL 2"SCH10', 
				'X-METAL 2.5SC40', 
				'X-METAL 3"SCH40', 
				'X-MOLD BOLLARD3', 
				'Z-INJ MOLD 056')) AS IL
JOIN              imitmidx_sql IMPAR
                  ON    IMPAR.item_no = IL.item_no
left outer join bmprdstr_sql BM 
                  on BM.item_no = IL.item_no 
left outer join Z_IMINVLOC_QALL QALLCOMP 
                  on    QALLCOMP.item_no = BM.comp_item_no
LEFT OUTER JOIN Z_IMINVLOC ILCOMP 
                  ON ILCOMP.item_no = BM.comp_item_no 
LEFT OUTER JOIN imitmidx_sql IM2 
                  ON IM2.item_no = BM.comp_item_no 
WHERE  IMPAR.prod_cat = 'AP' AND IMPAR.activity_cd = 'A' AND IMPAR.item_no NOT IN ('AP PROTOTYPE', 
'APCORRAL13 INST', 
'AP-INSTALL 12X6', 
'AP-INSTALL 19X6', 
'AP-INSTALL 23X6', 
'AP-INSTALL 24X8', 
'AP-INSTALL 27X6', 
'AP-INSTALL 31X6', 
'AP-INSTALL 8X4', 
'AP-INSTALL 8X8', 
'ASSET-INSTALLA', 
'ASSET-INSTALLC', 
'ASSET-INSTALLD', 
'ASSET-TRIPFEE', 
'CORRAL01INSTALL', 
'CORRAL02INSTALL', 
'CUTTING FEE', 
'FREIGHT-4967', 
'FREIGHT-4974', 
'FREIGHT-4983', 
'KELIGROUT RESIN', 
'KELKEN CATALAST', 
'RSS-4967INSTALL', 
'SIGNDNSEALD DWG', 
'X-METAL 1X3X58.250 16G', 
'X-METAL 1X3X98.5', 
'X-METAL 2"GALV', 
'X-METAL 2"SCH10', 
'X-METAL 2.5SC40', 
'X-METAL 3"SCH40', 
'X-MOLD BOLLARD3', 
'Z-INJ MOLD 056')
ORDER BY IL.item_no, comp_item_no
