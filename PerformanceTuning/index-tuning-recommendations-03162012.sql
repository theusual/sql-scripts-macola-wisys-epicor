use [001]
go

CREATE NONCLUSTERED INDEX [_dta_index_gbkmut_7_2099797661__K3_K14_K79_9_9987] ON [dbo].[gbkmut] 
(
	[reknr] ASC,
	[debnr] ASC,
	[transtype] ASC
)
INCLUDE ( [bdr_hfl]) WITH (SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
go

CREATE NONCLUSTERED INDEX [_dta_index_amutas_7_511599984__K8_K14_K33_K2_K3_K4_K5_K6_34_2533] ON [dbo].[amutas] 
(
	[bkstnr] ASC,
	[faktuurnr] ASC,
	[kredbep] ASC,
	[bkjrcode] ASC,
	[periode] ASC,
	[dagbknr] ASC,
	[volgnr5] ASC,
	[regel] ASC
)
INCLUDE ( [bdrkredbep]) WITH (SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
go

CREATE NONCLUSTERED INDEX [_dta_index_iminvloc_sql_7_1305418893__K2_K1_6_5201] ON [dbo].[iminvloc_sql] 
(
	[loc] ASC,
	[item_no] ASC
)
INCLUDE ( [qty_on_hand]) WITH (SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
go

CREATE NONCLUSTERED INDEX [_dta_index_wsPikPak_7_459849711__K9_K8_K10_K11_1_2_3_4_6_15_22] ON [dbo].[wsPikPak] 
(
	[Pallet_UCC128] ASC,
	[Pallet] ASC,
	[Carton] ASC,
	[Carton_UCC128] ASC
)
INCLUDE ( [Shipment],
[Ord_no],
[Line_no],
[Item_no],
[Loc],
[Shipped],
[ID]) WITH (SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
go

CREATE STATISTICS [_dta_stat_459849711_6_4] ON [dbo].[wsPikPak]([Loc], [Item_no])
go

CREATE STATISTICS [_dta_stat_459849711_2_15_1_4_9] ON [dbo].[wsPikPak]([Ord_no], [Shipped], [Shipment], [Item_no], [Pallet_UCC128])
go

CREATE STATISTICS [_dta_stat_1337419007_118_1] ON [dbo].[imitmidx_sql]([web_item], [item_no])
go


CREATE NONCLUSTERED INDEX [_dta_index_EbcPropRelations_7_1463465794__K9_K4_K1_2_3_5_6_7_8] ON [dbo].[EbcPropRelations] 
(
	[Enabled] ASC,
	[CompRelationId] ASC,
	[PropRelationId] ASC
)
INCLUDE ( [PropRelationStateId],
[PropRelationTypeId],
[PropId],
[PropValue],
[PropName],
[PropRelationValue]) WITH (SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
go


CREATE NONCLUSTERED INDEX [_dta_index_imrechst_sql_7_1417419292__K3] ON [dbo].[imrechst_sql] 
(
	[ctl_no] ASC
)WITH (SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
go

CREATE NONCLUSTERED INDEX [_dta_index_EbcProps_7_1063464369__K2_K3_K1_K9_5_6_7_8_10_11_12_13_14_15_16_17_18_20_21_22] ON [dbo].[EbcProps] 
(
	[CompId] ASC,
	[PropName] ASC,
	[PropId] ASC,
	[PropTypeId] ASC
)
INCLUDE ( [Caption],
[CaptionTermId],
[CaptionSuffix],
[CaptionSuffixTermID],
[BrowseId],
[EnabledStateId],
[NoEmpty],
[ValidationQuery],
[DefaultTypeId],
[DefaultStateId],
[DefaultValue],
[LowerRange],
[UpperRange],
[SelectionValues],
[Options],
[Log]) WITH (SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
go

CREATE STATISTICS [_dta_stat_1063464369_9_1_2] ON [dbo].[EbcProps]([PropTypeId], [PropId], [CompId])
go

CREATE NONCLUSTERED INDEX [_dta_index_oeordlin_sql_7_1577419862__K4_K2_5_7_8_9_11_18_50_9850] ON [dbo].[oeordlin_sql] 
(
	[item_no] ASC,
	[ord_no] ASC
)
INCLUDE ( [loc],
[cus_item_no],
[item_desc_1],
[item_desc_2],
[qty_to_ship],
[uom],
[prod_cat]) WITH (SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
go

CREATE STATISTICS [_dta_stat_1577419862_1_2_73_70] ON [dbo].[oeordlin_sql]([ord_type], [ord_no], [line_no], [cus_no])
go

CREATE NONCLUSTERED INDEX [_dta_index_poordhdr_sql_7_1113418209__K2] ON [dbo].[poordhdr_sql] 
(
	[vend_no] ASC
)WITH (SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
go

CREATE NONCLUSTERED INDEX [_dta_index_oeordhdr_sql_7_1049417981__K1_K2_7_8_17_18_19_20_21_22_23_1771] ON [dbo].[oeordhdr_sql] 
(
	[ord_type] ASC,
	[ord_no] ASC
)
INCLUDE ( [oe_po_no],
[cus_no],
[ship_to_name],
[ship_to_addr_1],
[ship_to_addr_2],
[ship_to_addr_3],
[ship_to_addr_4],
[ship_to_country],
[shipping_dt]) WITH (SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
go

CREATE STATISTICS [_dta_stat_704316692_79_17_2] ON [dbo].[grtbk]([UseCreditor], [omzrek], [reknr])
go

CREATE STATISTICS [_dta_stat_917225491_3_2] ON [dbo].[verslg]([bkjrcode], [verwerknr])
go

CREATE STATISTICS [_dta_stat_487462317_3_1] ON [dbo].[EbcComponents]([ComponentTypeId], [CompId])
go

CREATE STATISTICS [_dta_stat_615462773_1_4] ON [dbo].[EbcPropTypes]([PropTypeId], [TypeName])
go

CREATE STATISTICS [_dta_stat_2091152247_9] ON [dbo].[oeinqord_sql]([extra_1])
go

CREATE STATISTICS [_dta_stat_1657420147_1_5_2_39_42_99_3_55_6_7_27_52_53_63_64_65] ON [dbo].[poordlin_sql]([ord_no], [item_no], [line_no], [qty_ordered], [qty_received], [extra_8], [vend_no], [byr_plnr], [item_desc_1], [item_desc_2], [exp_unit_cost], [request_dt], [promise_dt], [user_def_fld_1], [user_def_fld_2], [user_def_fld_3])
go


CREATE STATISTICS [_dta_stat_1335465338_3_7_4] ON [dbo].[EbcComponentRelations]([CompRelationName], [Enabled], [CompId1])
go


CREATE STATISTICS [_dta_stat_1321418950_1_2_4_5_6_19] ON [dbo].[iminvtrx_sql]([source], [ord_no], [line_no], [lev_no], [seq_no], [doc_type])
go


CREATE STATISTICS [_dta_stat_47598331_3_8] ON [dbo].[amutak]([periode], [bkstnr])
go

use [020]
go

CREATE STATISTICS [_dta_stat_956178802_2_10] ON [dbo].[DDColumns]([Tablename], [SeqNr])
go

CREATE STATISTICS [_dta_stat_1680373401_6_28] ON [dbo].[cicmpy]([cmp_name], [cmp_status])
go

CREATE STATISTICS [_dta_stat_1180179600_4_9] ON [dbo].[DDTests]([FieldName], [SeqNr])
go

CREATE STATISTICS [_dta_stat_1036179087_5_2] ON [dbo].[DDIndexColumns]([SeqNr], [Tablename])
go

use [RedGateMonitor]
go

CREATE STATISTICS [_dta_stat_1525580473_2_1] ON [alert].[Alert]([AlertType], [AlertId])
go

