--ALTER VIEW Z_IMINVLOC_QOH_CHECK_CH AS

--Created:	4/27/11			 By:	BG
--Last Updated:	07/03/13	 By:	BG
--Purpose:	View for Inventory Check comparing expected QOH vs counts
--1) First, update the usage_quarterly_with_levels view
--2) Second, update the z_iminvloc_qoh_recd view
--3) Last, update the inventory table references

SELECT			IM.item_no, 
				INV_OLD.qty AS [10/01 QOH], 
				IM.QOH AS [12/29 QOH], 
				IM2.frz_qty AS [01/01 COUNT],
				PO.Recvd AS QuarterlyRecvd, 
				QU.Q_USAGE AS QuarterlyShipped, 
				CASE WHEN PO.recvd IS NULL AND Q_USAGE IS NULL 
					 THEN IM.frz_qty WHEN PO.recvd IS NULL 
					 THEN (IM.frz_qty - QU.Q_USAGE) WHEN Q_USAGE IS NULL 
					 THEN (IM.frz_qty + PO.recvd) 
                ELSE (IM.frz_qty - QU.Q_USAGE + PO.Recvd) END AS [QOH CHECK], 
                IM2.qty_on_hand AS [Macola QOH], 
                --IM2.frz_qty AS [Frozen QTY],
                IM2.frz_qty AS [Updated FRZQTY], 
                IM2.pur_or_mfg, IM2.item_desc_1, IM2.item_desc_2,
                prod_cat
FROM  (SELECT item_no, SUM(frz_qty) AS frz_qty, SUM(qty_on_hand) AS QOH
               FROM   [BG_Backup].dbo.iminvloc_prepost_01062014
               WHERE loc NOT IN ('BR', 'IN','CAN','ID')
               GROUP BY item_no) AS IM LEFT OUTER JOIN
	  (Select [F2] AS item_no, SUM([F3]) AS qty
			  FROM [BG_BACKUP].[dbo].[inventory_100113_corrected]
			  GROUP BY [f2]
				) AS INV_OLD ON INV_OLD.item_no = IM.item_no LEFT OUTER JOIN   
               dbo.Z_IMINVLOC_USAGE_QUARTERLY AS QU ON QU.item_no = IM.item_no LEFT OUTER JOIN
               dbo.Z_IMINVLOC_QOH_RECVD AS PO ON PO.item_no = IM.item_no LEFT OUTER JOIN
               dbo.Z_IMINVLOC AS IM2 ON IM2.item_no = IM.item_no
               --LEFT OUTER JOIN [BG_Backup].dbo.inv_upload_04032013 AS UpdatedInv ON UpdatedInv.Item = IM2.item_no
WHERE ((IM.frz_qty > 0) OR
               (IM2.qty_on_hand > 0)) 
               AND IM2.item_no IN (SELECT item_no FROM dbo.poordlin_sql WHERE LTRIM(vend_no) IN (SELECT vend_no FROM dbo.BG_CH_Vendors) AND request_dt > '01/01/2010') 
               AND IM2.item_no NOT IN (SELECT item_no FROM imitmidx_sql WHERE prod_cat IN ('336','111','036','037','2','102'))
               AND IM2.item_no IN (SELECT item_no FROM dbo.Z_IMINVLOC_USAGE)
               AND NOT(IM.item_no LIKE 'INF-METAL%')
               AND NOT(IM.item_no LIKE '%PROTO%')
               --AND IM2.item_no LIKE 'ec-78%'

