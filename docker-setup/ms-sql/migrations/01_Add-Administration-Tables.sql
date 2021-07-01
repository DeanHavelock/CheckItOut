USE [ADMINISTRATION]
GO

CREATE TABLE [dbo].[BinInfo](
	[BinInfoId] [bigint] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[BinNumber] [numeric](18, 0) NULL,
	[CardBrand] [nvarchar](80) NULL,
	[IssuingBank] [nvarchar](100) NULL,
	[CardType] [nvarchar](100) NULL,
	[CardCategory] [nvarchar](100) NULL,
	[CountryISOName] [nvarchar](100) NULL,
	[CountryISOA2Code] [nvarchar](100) NULL,
	[CountryISOA3Code] [nvarchar](100) NULL,
	[CountryISONumber] [nvarchar](100) NULL,
	[CountryInfo] [nvarchar](100) NULL,
	[BankPhone] [nvarchar](100) NULL,
	[CorpCard] [nvarchar](1) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL
)

GO
--Mastercard
CREATE TABLE [dbo].[BinMCT068IP0016T1](
	[BinMCT068IP0016T1Id] [bigint] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[EffectiveTimestamp] [nvarchar](50) NULL,
	[ActiveInactiveCode] [nvarchar](50) NULL,
	[TableId] [nvarchar](50) NULL,
	[LicensedProductId] [nvarchar](50) NULL,
	[GCMSProductId] [nvarchar](50) NULL,
	[CardProgramIdentifier] [nvarchar](50) NULL,
	[ProductClass] [nvarchar](50) NULL,
	[ProductTypeId] [nvarchar](50) NULL,
	[ProductCategory] [nvarchar](50) NULL,
	[Filler] [nvarchar](500) NULL,
	[ProcessDate] [datetime] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL
)

GO

CREATE TABLE [dbo].[BinMCT068IP0040T1](
	[BinMCT068IP0040T1Id] [bigint] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[EffectiveTimestamp] [nvarchar](50) NULL,
	[ActiveInactiveCode] [nvarchar](50) NULL,
	[TableId] [nvarchar](50) NULL,
	[IssuerAccountRangeLow] [nvarchar](50) NULL,
	[GCMSProductId] [nvarchar](50) NULL,
	[IssuerAccountRangeHigh] [nvarchar](50) NULL,
	[CardProgramIdentier] [nvarchar](50) NULL,
	[IssuerCardProgramIdentierPriorityCode] [nvarchar](50) NULL,
	[MemberId] [nvarchar](50) NULL,
	[ProductTypeId] [nvarchar](50) NULL,
	[Endpoint] [nvarchar](50) NULL,
	[CountryCodeAlpha] [nvarchar](50) NULL,
	[CountryCodeNumeric] [nvarchar](50) NULL,
	[Region] [nvarchar](50) NULL,
	[ProductClass] [nvarchar](50) NULL,
	[TransctionRoutingIndicator] [nvarchar](50) NULL,
	[FirstPresentmentReassignmentSwitch] [nvarchar](50) NULL,
	[ProductReassignmentSwitch] [nvarchar](50) NULL,
	[PWCBOptInSwitch] [nvarchar](50) NULL,
	[LicensedProductId] [nvarchar](30) NULL,
	[MappingServiceIndicator] [nvarchar](50) NULL,
	[AccountLevelManagementParticipationIndicator] [nvarchar](50) NULL,
	[AccountLevelManagementActivationDate] [nvarchar](50) NULL,
	[CardholderBillingCurrencyDefault] [nvarchar](50) NULL,
	[CardholderBillingCurrencyExponentDefault] [nvarchar](50) NULL,
	[CardholderBillingPrimaryCurrency] [nvarchar](50) NULL,
	[ChipToMagneticConversionServiceIndicator] [nvarchar](50) NULL,
	[FloorExpirationDate] [nvarchar](60) NULL,
	[CoBrandParticipationSwitch] [nvarchar](50) NULL,
	[SpendControlSwitch] [nvarchar](50) NULL,
	[MerchantCleansingServiceParticipation] [nvarchar](30) NULL,
	[MerchantCleansingActivationDate] [nvarchar](60) NULL,
	[PayPassEnabledIndicator] [nvarchar](50) NULL,
	[RegulatedRateTypeIndicator] [nvarchar](50) NULL,
	[PSNRouteIndicator] [nvarchar](50) NULL,
	[CashBackWithoutPurchaseIndicator] [nvarchar](50) NULL,
	[Filler1] [nvarchar](200) NULL,
	[RePowerReloadParticipationIndicator] [nvarchar](50) NULL,
	[Filler2] [nvarchar](200) NULL,
	[ProcessesDate] [datetime] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[LowKey6] [int] NULL,
	[HighKey6] [int] NULL,
	[LowKey9] [int] NULL,
	[HighKey9] [int] NULL
)

GO

CREATE TABLE [dbo].[Country](
	[CountryId] [bigint] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[CountryISOName] [nvarchar](100) NULL,
	[CountryISO2Code] [nvarchar](100) NULL,
	[CountryISO3Code] [nvarchar](100) NULL,
	[CountryISONumber] [int] NULL,
	[CountryInfo] [nvarchar](255) NULL,
	[IsRisky] [bit] NULL,
	[RegionId] [bigint] NOT NULL,
	[Region] [nvarchar](50) NOT NULL,
	[SubRegion] [nvarchar](50) NOT NULL,
	[IBANSize] [int] NULL,
	[IsEEA] [bit] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[PhoneCountryCode] [nvarchar](10) NULL,
	[CountryAttributeId] [bigint] NULL,
	[DelFlag] [bit] NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [bigint] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[IsVIEU] [bit] NOT NULL,
	[IsMCEU] [bit] NOT NULL,
	[IsMCWS] [bit] NOT NULL,
	[IsMCES] [bit] NOT NULL
)

GO

CREATE TABLE [dbo].[MastercardProductType](
	[LicensedProductId] [varchar](100) NOT NULL,
	[GCMSProductId] [varchar](100) NOT NULL,
	[ProductType] [varchar](255) NULL
)

GO

--VISA
CREATE TABLE [dbo].[BinVisa](
	[BinVisaId] [bigint] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[HighKey] [nvarchar](9) NULL,
	[ReserveField1] [nvarchar](3) NULL,
	[LowKey] [nvarchar](9) NULL,
	[ReserveField2] [nvarchar](3) NULL,
	[IssuerBin] [nvarchar](6) NULL,
	[CheckDigitAlgorithm] [nvarchar](1) NULL,
	[AccountNumberLength] [nvarchar](2) NULL,
	[ReserveField3] [nvarchar](1) NULL,
	[ReserveField4] [nvarchar](1) NULL,
	[ProcessorBin] [nvarchar](6) NULL,
	[Domain] [nvarchar](1) NULL,
	[Region] [nvarchar](1) NULL,
	[Country] [nvarchar](2) NULL,
	[LargeTicket] [nvarchar](1) NULL,
	[TechnologyIndicator] [nvarchar](1) NULL,
	[ARDEFRegion] [nvarchar](1) NULL,
	[ARDEFCountry] [nvarchar](2) NULL,
	[CommCCLvl2DataIndicator] [nvarchar](1) NULL,
	[CommCCLvl3EnhancedDataIndicator] [nvarchar](1) NULL,
	[CommCCPOSPromptingIndicator] [nvarchar](1) NULL,
	[VATEvidence] [nvarchar](1) NULL,
	[OriginalCredit] [nvarchar](1) NULL,
	[AccountLvlProcessingIndicator] [nvarchar](1) NULL,
	[OriginalCreditMoneyTransfer] [nvarchar](1) NULL,
	[OriginalCreditOnlineGambling] [nvarchar](1) NULL,
	[ProductId] [nvarchar](2) NULL,
	[ComboCard] [nvarchar](1) NULL,
	[FastFunds] [nvarchar](1) NULL,
	[TravelIndicator] [nvarchar](1) NULL,
	[R1R2R3] [nvarchar](6) NULL,
	[AccountFundingSource] [nvarchar](1) NULL,
	[SettlementMatch] [nvarchar](1) NULL,
	[TravelAccountData] [nvarchar](1) NULL,
	[AccountRestrictedUse] [nvarchar](1) NULL,
	[NNSSIndicator] [nvarchar](1) NULL,
	[ProductSubtype] [nvarchar](2) NULL,
	[ReserveField5] [nvarchar](2) NULL,
	[TestIndicator] [nvarchar](1) NULL,
	[ReserveField6] [nvarchar](61) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[LowKey6] [int] NULL,
	[HighKey6] [int] NULL,
	[LowKey9] [int] NULL,
	[HighKey9] [int] NULL
)

GO

CREATE TABLE [dbo].[VisaProductType](
	[ProductId] [varchar](100) NOT NULL PRIMARY KEY,
	[ProductType] [varchar](255) NOT NULL,
	[Type] [varchar](255) NULL
)

CREATE TABLE [dbo].[PaymentMethod](
	[PaymentMethodId] [bigint] IDENTITY(1,1) NOT NULL,
	[PaymentTypeId] [bigint] NULL,
	[PaymentMethodCode] [int] NOT NULL,
	[PaymentMethodName] [nvarchar](100) NOT NULL,
	[PaymentMethodStatementName] [nvarchar](100) NULL,
	[LPType] [nvarchar](100) NULL,
	[ActionPermission] [int] NOT NULL,
	[AllowChargeback] [bit] NULL,
	[IsIFrame] [bit] NULL,
	[IsActive] [bit] NOT NULL,
	[DelFlag] [bit] NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [bigint] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_PaymentMethod_PaymentMethodId] PRIMARY KEY CLUSTERED 
(
	[PaymentMethodId] ASC
))
GO