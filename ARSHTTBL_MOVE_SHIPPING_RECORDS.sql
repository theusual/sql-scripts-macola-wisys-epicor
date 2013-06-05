USE [001]
GO


		INSERT INTO ARSHTTBL (
								 [ord_no]
								,[shipment_no]
								,[carrier_cd]
								,[mode]
								,[ship_cost]
								,[total_cost]
								,[cod_amount]
								,[tracking_no]
								,[zone]
								,[ship_weight]
								,[void_fg]
								,[complete_fg]
								,[hand_chg]
								,[ship_dt]
								,[filler_0001]
								,[extra_1]
							)

select
			 ltrim(sh.ord_no)
			,pp.Line_no
			,CASE PP.ParcelType
									WHEN 'UPS' THEN 'UPG'
									WHEN 'FedEx' THEN 'FXG'
									ELSE CASE WHEN bl.ship_via_cd is null then OH.ship_via_cd ELSE bl.ship_via_cd END
			 END
			,CASE pp.Loc
				WHEN 'PS' THEN '1'
				WHEN 'WS' THEN '2'
				WHEN 'BC' THEN '3'
				WHEN 'MS' THEN '4'
				WHEN 'NE' THEN '5'
				WHEN 'MDC' THEN '6'
				ELSE '?'
			 END
			,sh.ship_cost
			,sh.total_cost
			,sh.ID
			,sh.tracking_no
			,sh.zone
			,sh.ship_weight
			,null
			,sh.complete_fg
			,pp.Qty
			,CONVERT(varchar(8),pp.ship_dt,112)
			,pp.Item_no
			,sh.tracking_no
--			,bl.ID

from		[001].dbo.ARSHTFIL_SQL sh 

inner join	[001].dbo.wsPikPak pp

			on pp.ord_no = sh.ord_no

inner join	[001].dbo.wsShipment ws

			on ws.Shipment = pp.shipment
			
left outer join [001].dbo.oeordhdr_sql OH

			on OH.ord_no = pp.ord_no

left outer join	oebolfil_sql bl

			on bl.bol_no = ws.bol_no	
				
where sh.ord_no <> '' and sh.void_fg <> 'V' and shipped = 'Y'

and sh.ID not in
					(
						select cod_amount as int from ARSHTTBL
					)
