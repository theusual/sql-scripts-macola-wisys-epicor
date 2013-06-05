---------------------------------------------------------------------------
--Indexes and statistics added to improve performance of ES Invoice Posting
---------------------------------------------------------------------------

Use [001]
go

-----------------
--Create Indexes 
-----------------

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

-------------------
--Create Statistics
-------------------

CREATE STATISTICS [_dta_stat_2099797661_14_79_3] ON [dbo].[gbkmut]([debnr], [transtype], [reknr])
go

CREATE STATISTICS [_dta_stat_2099797661_6_15_1] ON [dbo].[gbkmut]([bkstnr], [crdnr], [ID])
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

CREATE STATISTICS [_dta_stat_1335465338_3_7_4] ON [dbo].[EbcComponentRelations]([CompRelationName], [Enabled], [CompId1])
go


CREATE STATISTICS [_dta_stat_1321418950_1_2_4_5_6_19] ON [dbo].[iminvtrx_sql]([source], [ord_no], [line_no], [lev_no], [seq_no], [doc_type])
go


CREATE STATISTICS [_dta_stat_47598331_3_8] ON [dbo].[amutak]([periode], [bkstnr])
go


