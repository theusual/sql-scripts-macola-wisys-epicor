USE [001]
GO

/****** Object:  View [dbo].[Z_IMINVLOC_QOH_CHECK]    Script Date: 1/14/2014 3:02:39 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[Z_IMINVLOC_QOH_CHECK] AS

--Created:	2/15/13			 By:	BG
--Last Updated:	08/14/13	 By:	BG
--Purpose:	View for QOH Check
--Last changes: 1) 

SELECT     IM2.item_no,  PO.Recvd AS QuarterlyRecvd, QU.Q_USAGE AS QuarterlyShipped, 
		CASE WHEN PO.recvd IS NULL AND Q_USAGE IS NULL 
          THEN IM2.frz_qty WHEN PO.recvd IS NULL THEN (IM2.frz_qty - QU.Q_USAGE) WHEN Q_USAGE IS NULL THEN (IM2.frz_qty + PO.recvd) 
          ELSE (IM2.frz_qty - QU.Q_USAGE + PO.Recvd) 
        END AS [QOH CHECK], 
          IM2.qty_on_hand AS [Macola QOH], 
          IM2.frz_qty AS [Current FRZQTY], IM2.pur_or_mfg, 
          IM2.item_desc_1, IM2.item_desc_2
FROM                  dbo.imitmidx_sql IM3 WITH(NOLOCK) LEFT OUTER JOIN
					  dbo.Z_IMINVLOC_USAGE_QUARTERLY AS QU WITH(NOLOCK) ON QU.item_no = IM3.item_no LEFT OUTER JOIN
                      dbo.Z_IMINVLOC_QOH_RECVD AS PO WITH(NOLOCK) ON PO.item_no = IM3.item_no LEFT OUTER JOIN
                      dbo.Z_IMINVLOC AS IM2 WITH(NOLOCK) ON IM2.item_no = IM3.item_no
WHERE (IM3.item_note_1 = 'CH') 
	   OR (QU.Q_USAGE > 0)   
	   OR (IM2.frz_qty > 0) 
	   OR (IM2.qty_on_hand > 0)

GO


