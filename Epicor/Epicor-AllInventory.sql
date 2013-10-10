 SELECT IM.PartNum, IM.PartDescription,  IMcat2.ClassID AS [ClassID], IMcat2.Description[ClassID-Descr], IMCat.ProdCode AS [ProdCode], IMcat.Description[ProdCode-Descr], IM.IUM, IM.PUM, IM.TypeCode, IM.NonStock, IM.NetWeight, IM.PartLength, IM.PartWidth, IM.PartHeight, IMcost.AvgLaborCost, IMcost.AvgBurdenCost, IMcost.AvgMaterialCost, IMcost.AvgSubContCost, IMcost.AvgMtlBurCost, IMcost.StdLaborCost, IMcost.StdBurdenCost, IMcost.StdMaterialCost, IMcost.StdSubContCost, IMcost.StdMtlBurCost, IMcost.LastLaborCost, IMcost.LastBurdenCost, IMcost.LastMaterialCost, IMcost.LastSubContCost, IMcost.LastMtlBurCost, IMloc.DemandQty, IMloc.ReservedQty, IMloc.AllocatedQty, IMloc.PickingQty, IMloc.PickedQty, IMloc.WarehouseCode, IMloc.OnHandQty, IMLoc.CountedDate
 FROM   Part IM INNER JOIN PartCost IMcost ON (IM.Company=IMcost.Company) AND (IM.PartNum=IMcost.PartNum)
				LEFT OUTER JOIN PartWhse IMloc ON (IM.Company=IMloc.Company) AND (IM.PartNum=IMloc.PartNum)
				LEFT OUTER JOIN ProdGrup IMcat ON (IM.Company=IMcat.Company) AND (IM.ProdCode=IMcat.ProdCode) 
				INNER JOIN PartClass IMcat2 ON (IM.Company=IMcat2.Company) AND (IM.ClassID=IMcat2.ClassID)
				
				
SELECT * FROM PartWhse
SELECT * FROM Part


