USE [001]
GO

/****** Object:  Table [dbo].[ARSHTTBL]    Script Date: 03/29/2011 11:47:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[ARSHTTBL](
	[ord_no] [char](8) NOT NULL,
	[shipment_no] [smallint] NOT NULL,
	[carrier_cd] [char](3) NULL,
	[mode] [char](1) NULL,
	[ship_cost] [decimal](14, 2) NULL,
	[total_cost] [decimal](14, 2) NULL,
	[cod_amount] [decimal](14, 2) NULL,
	[tracking_no] [char](25) NULL,
	[zone] [char](2) NULL,
	[ship_weight] [decimal](10, 3) NULL,
	[void_fg] [char](1) NULL,
	[complete_fg] [char](1) NULL,
	[hand_chg] [decimal](14, 2) NULL,
	[ship_dt] [int] NULL,
	[filler_0001] [char](84) NULL,
	[extra_1] [char](25) NULL,
	[A4GLIdentity] [numeric](9, 0) IDENTITY(1,1) NOT NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


