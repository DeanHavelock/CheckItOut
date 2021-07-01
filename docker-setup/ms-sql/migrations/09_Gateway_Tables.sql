USE [GATEWAY]
GO

CREATE TABLE [dbo].[Customer](
	[CustomerId] [bigint] IDENTITY(1,1) NOT NULL,
	[CustomerEmail] [nvarchar](255) NULL,
	[CustomerName] [nvarchar](255) NULL,
	[CustomerToken] [uniqueidentifier] NOT NULL,
	[IPAddress] [nvarchar](50) NULL,
	[CustomerPhoneNumCountryCode] [nvarchar](7) NULL,
	[CustomerPhoneNum] [nvarchar](50) NULL,
	[Description] [nvarchar](255) NULL,
	[FingerPrint] [binary](32) NULL,
	[LiveMode] [bit] NULL,
	[Device] [nvarchar](255) NULL,
	[IsActive] [bit] NOT NULL,
	[DelFlag] [bit] NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [bigint] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC
),
 CONSTRAINT [UQ_Customer_CustomerToken] UNIQUE NONCLUSTERED 
(
	[CustomerToken] ASC
))

GO

CREATE TABLE [dbo].[Cards](
	[CardsId] [bigint] IDENTITY(100000,1) NOT NULL,
	[Token] [uniqueidentifier] NOT NULL,
	[PaymentMethodId] [bigint] NULL,
	[Email] [nvarchar](255) NULL,
	[Number] [nvarchar](50) NULL,
	[Name] [nvarchar](255) NULL,
	[ExpMonth] [nvarchar](50) NULL,
	[ExpYear] [nvarchar](50) NULL,
	[ExpDay] [nvarchar](50) NULL,
	[AddressLine1] [nvarchar](200) NULL,
	[AddressLine2] [nvarchar](200) NULL,
	[AddressPostal] [nvarchar](200) NULL,
	[AddressCountry] [nvarchar](50) NULL,
	[AddressCity] [nvarchar](50) NULL,
	[AddressState] [nvarchar](50) NULL,
	[AddressPhoneCountryCode] [nvarchar](7) NULL,
	[AddressPhone] [nvarchar](50) NULL,
	[AddressFax] [nvarchar](50) NULL,
	[CvcCheck] [nvarchar](10) NULL,
	[AvsCheck] [nvarchar](10) NULL,
	[CCHash] [varbinary](4000) NULL,
	[Cvv2] [nvarchar](5) NULL,
	[GatewayResponseCode] [nvarchar](50) NULL,
	[AuthCode] [nvarchar](50) NULL,
	[LiveMode] [bit] NULL,
	[AddressCountryISO3] [nvarchar](3) NULL,
	[FingerPrint] [binary](32) NULL,
	[NumberHash] [binary](32) NULL,
	[IsActive] [bit] NOT NULL,
	[DelFlag] [bit] NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [bigint] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[Wallet] [smallint] NULL,
	[Disabled] [bit] NULL,
	[Expired] [bit] NULL,
 CONSTRAINT [PK_CardsId] PRIMARY KEY CLUSTERED 
(
	[CardsId] ASC
))
GO

ALTER TABLE [dbo].[Cards] ADD  DEFAULT ((0)) FOR [Disabled]
GO

ALTER TABLE [dbo].[Cards] ADD  DEFAULT ((0)) FOR [Expired]
GO

CREATE TABLE [dbo].[CustomerMerchantAccount](
	[CustomerMerchantAccountId] [bigint] IDENTITY(1,1) NOT NULL,
	[CustomerId] [bigint] NOT NULL,
	[MerchantAccountId] [bigint] NOT NULL,
	[BusinessId] [bigint] NOT NULL,
	[ChannelId] [bigint] NOT NULL,
	[LiveMode] [bit] NULL,
	[IsActive] [bit] NOT NULL,
	[DelFlag] [bit] NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [bigint] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_CustomerMerchantAccount] PRIMARY KEY CLUSTERED 
(
	[CustomerMerchantAccountId] ASC
))

GO

ALTER TABLE [dbo].[CustomerMerchantAccount]  WITH CHECK ADD  CONSTRAINT [FK_CustomerMerchantAccount_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([CustomerId])
GO

ALTER TABLE [dbo].[CustomerMerchantAccount] CHECK CONSTRAINT [FK_CustomerMerchantAccount_Customer]
GO

CREATE TABLE [dbo].[CustomerCards](
	[CustomerCardsId] [bigint] IDENTITY(1,1) NOT NULL,
	[CustomerId] [bigint] NOT NULL,
	[CardsId] [bigint] NOT NULL,
	[IsDefault] [bit] NULL,
	[LiveMode] [bit] NULL,
	[IsActive] [bit] NOT NULL,
	[DelFlag] [bit] NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [bigint] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[InitialChargeId] [nvarchar](20) NULL,
 CONSTRAINT [PK_CustomerCards] PRIMARY KEY CLUSTERED 
(
	[CustomerCardsId] ASC
))

GO

ALTER TABLE [dbo].[CustomerCards]  WITH CHECK ADD  CONSTRAINT [FK_CustomerCards_Cards] FOREIGN KEY([CardsId])
REFERENCES [dbo].[Cards] ([CardsId])
GO

ALTER TABLE [dbo].[CustomerCards] CHECK CONSTRAINT [FK_CustomerCards_Cards]
GO

ALTER TABLE [dbo].[CustomerCards]  WITH CHECK ADD  CONSTRAINT [FK_CustomerCards_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([CustomerId])
GO

ALTER TABLE [dbo].[CustomerCards] CHECK CONSTRAINT [FK_CustomerCards_Customer]
GO

CREATE TABLE [dbo].[VaultInstrumentMigration](
	[VaultInstrumentMigrationId] [bigint] IDENTITY(1,1) NOT NULL,
	[MerchantId] [bigint] NOT NULL,
	[MigrationId] [uniqueidentifier] NOT NULL,
	[VaultAccountId] [varchar](100) NOT NULL,
	[StartingCustomerCardsId] [bigint] NOT NULL,
	[FinishingCustomerCardsId] [bigint] NOT NULL,
	[LastProcessedCustomerCardsId] [bigint] NULL,
	[CreatedOn] [datetime2](7) NOT NULL,
	[UpdatedOn] [datetime2](7) NULL,
 CONSTRAINT [PK_VaultInstrumentMigration] PRIMARY KEY CLUSTERED 
(
	[VaultInstrumentMigrationId] ASC
))
GO

CREATE UNIQUE INDEX IDX_MerchantId_MigrationId ON dbo.VaultInstrumentMigration(MerchantId ASC, MigrationId ASC)
GO