--All ED* Tables in ES:

--Empty
SELECT * FROM dbo.edablkfl_sql 
--Empty
SELECT  * FROM    dbo.edacumfl_sql 
--Empty
SELECT * FROM dbo.edapkgfl_sql 
--Empty
SELECT  * FROM    dbo.edatmp03_sql 
--Empty
SELECT  *  FROM    dbo.edatpqfl_sql AS ES
--Empty
SELECT * FROM dbo.edatpsfl_sql 
--Empty
SELECT * FROM dbo.edbbcifl_sql
--EDI Audit Tables
SELECT * FROM EDCAUDFL_SQL AS EDIAudit
--Stores details of the inbound EDI document
SELECT CAST(date_created_yy AS VARCHAR) + CAST(date_created_mm AS VARCHAR) + CAST(date_created_dd AS VARCHAR) AS Date,* 
FROM dbo.edccapfl_sql AS EDI_Inbound
WHERE date_outbound_yy = 14  AND date_outbound_dd = 24  ORDER BY Date DESC
--?
SELECT  * FROM    dbo.edcchgfl_sql 
--EDI Setup File For Translator
SELECT  *  FROM    dbo.edcctlfl_sql AS ES
--EDI Item Cross Reference
SELECT * FROM dbo.edcitmfl_sql AS ES
--Log of last transactions that occurred
SELECT * FROM dbo.edclogfl_sql 
--maintains the OE relationship between the Macola sales order and the EDI PO
SELECT CAST(date_created_yy AS VARCHAR) + CAST(date_created_mm AS VARCHAR) + CAST(date_created_dd AS VARCHAR) AS Date, * 
FROM dbo.edcsdqfl_sql AS EDI_OE_Xref
WHERE ltrim(customer_num) != '1575'
--GLN Cross Reference -- Stores Shipping Addresses
SELECT * FROM dbo.edcshtfl_sql 
--Carrier code (SCAC) cross reference
SELECT * FROM dbo.edcshvfl_sql 
--Empty
SELECT * FROM dbo.edctmp02_sql 
--Trading Partner Setup File
SELECT * FROM dbo.edctp_fl_sql 
--Empty
SELECT * FROM dbo.edi_adfl_sql 
--Element Mapping?
SELECT * FROM dbo.edi_csfl_sql
--More Element Mapping?
SELECT  * FROM dbo.edi_ddfl_sql 
--More Element Mapping?
SELECT * FROM dbo.edi_edfl_sql 
--Segment Mapping?
SELECT  * FROM dbo.edi_epfl_sql 
--Empty
SELECT * FROM dbo.edi_eufl_sql 
--Empty
SELECT * FROM dbo.edi_sdfl_sql 
--Segment Mapping?
SELECT * FROM dbo.edi_ssfl_sql 
--Empty
SELECT  * FROM dbo.edi_sufl_sql 
--Empty
SELECT * FROM dbo.edi_tdfl_sql 
--Segment Mapping?
SELECT * FROM dbo.edi_tsfl_sql 
--?
SELECT * FROM dbo.edi_vdfl_sql 
--EDI Module Macola Screen Cross Reference
SELECT  * FROM dbo.edscrfil_sql 
--EDI Version File
SELECT  * FROM dbo.ED_CVTFL_SQL 
--Empty
SELECT * FROM dbo.ed_fmtcd_sql 
--Empty
SELECT * FROM dbo.ed_fmtce_sql 
--Empty
SELECT * FROM dbo.ed_fmtcf_sql 
--Empty
SELECT * FROM dbo.ed_fmtch_sql
--Empty 
SELECT * FROM dbo.ed_fmtcm_sql 
--Field mapping?
SELECT * FROM dbo.ed_fmtde_sql 
--Empty
SELECT  * FROM dbo.ed_fmtdf_sql
--Empty
SELECT  *  FROM dbo.ed_fmte2_sql
--Empty
SELECT * FROM dbo.ed_fmted_sql 
--Empty
SELECT * FROM dbo.ed_fmtef_sql 
--Empty
SELECT  * FROM   dbo.ed_fmtem_sql 
--Empty
SELECT  * FROM   dbo.ed_fmtfd_sql
--Empty
SELECT  * FROM    dbo.ed_fmtfx_sql 
--?
SELECT * FROM dbo.ed_fmti1_sql 
--?
SELECT * FROM dbo.ed_fmti2_sql 
--Empty
SELECT * FROM dbo.ed_fmtlt_sql
--Empty
SELECT * FROM dbo.ed_fmtsi_sql 
--Empty
SELECT * FROM dbo.ed_fmtsn_sql 
--Empty
SELECT * FROM dbo.ed_fmtxa_sql 
--Empty
SELECT * FROM dbo.ed_fmtxx_sql 
--Empty
SELECT * FROM dbo.ed_scrfl_sql 
--Empty
SELECT * FROM dbo.ed_tmp02_sql
--Empty 
SELECT * FROM dbo.ed_tmp03_sql 
