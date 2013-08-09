 SELECT BOM.PartNum, PartParent.IUM AS [Parent IUM], PartParent.PUM AS [Parent PUM], PartParent.PartDescription AS [ParentDescr], BOM.RevisionNum, 
        BOM.MtlSeq, BOM.MtlPartNum, PartComp.IUM AS [Comp IUM], PartComp.PUM AS [Comp PUM], PartComp.PartDescription AS [CompDescr],  
		BOM.QtyPer, ParentCost.AvgLaborCost [Par-AvgLaborCost], ParentCost.AvgBurdenCost [Par-AvgBurdenCost], 
		ParentCost.AvgMaterialCost [Par-AvgMaterialCost], ParentCost.AvgSubContCost AS [Par-AvgSubContCost],
		CompCost.AvgLaborCost [Comp-AvgLaborCost], CompCost.AvgBurdenCost [Comp-AvgBurdenCost], 
		CompCost.AvgMaterialCost [Comp-AvgMaterialCost], CompCost.AvgSubContCost AS [Comp-AvgSubContCost]
 FROM   PartMtl BOM JOIN Part AS PartParent ON PartParent.PartNum = BOM.PartNum 
				    JOIN Part AS PartComp ON PartComp.PartNum = BOM.MtlPartNum
				    LEFT OUTER JOIN PartCost ParentCost ON (BOM.Company=ParentCost.Company) AND (BOM.PartNum=ParentCost.PartNum)
				    LEFT OUTER JOIN PartCost CompCost ON (BOM.Company=CompCost.Company) AND (BOM.MtlPartNum=CompCost.PartNum)
 


