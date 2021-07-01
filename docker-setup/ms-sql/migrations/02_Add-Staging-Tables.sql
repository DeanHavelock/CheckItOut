USE ADMINISTRATION

CREATE TABLE dbo.VaultCardMetadataMastercardFundingSource
(
	Id INT IDENTITY(1,1) CONSTRAINT MsFundingSourcePk PRIMARY KEY NOT NULL,
	AccountFundingSourceCode NVARCHAR(20),
	AccountFundingSource NVARCHAR(50)
)

CREATE UNIQUE INDEX IDX_AccountFundingSource ON dbo.VaultCardMetadataMastercardFundingSource(AccountFundingSource)

CREATE TABLE dbo.VaultCardMetadataMastercardCommericalProducts
(	
	Id INT IDENTITY(1,1) CONSTRAINT MsCommercialProductPk PRIMARY KEY NOT NULL,
	CommercialProductCode NVARCHAR(5),
	CommercialProduct NVARCHAR(50)
)

CREATE UNIQUE INDEX IDX_CommercialProductCode ON dbo.VaultCardMetadataMastercardCommericalProducts(CommercialProductCode)

CREATE TABLE dbo.VaultCardMetadataAlternativeCardType
(
	Id INT IDENTITY(1,1) CONSTRAINT AltCardTypePk PRIMARY KEY NOT NULL,
	BinInfoCardType NVARCHAR(50),
	CardType NVARCHAR(50)
)

CREATE UNIQUE INDEX IDX_BinInfoCardType ON dbo.VaultCardMetadataAlternativeCardType(BinInfoCardType)

CREATE TABLE dbo.VaultCardMetadataVisaFundingSource
(
	Id INT IDENTITY(1,1) CONSTRAINT VisaFundingSourcePk PRIMARY KEY NOT NULL,
	AccountFundingSourceCode NVARCHAR(20),
	AccountFundingSource NVARCHAR(50)
)

CREATE UNIQUE INDEX IDX_AccountFundingSource ON dbo.VaultCardMetadataVisaFundingSource(AccountFundingSource)

CREATE TABLE dbo.VaultCardMetadataVisaCommericalProducts
(
	Id INT IDENTITY(1,1) CONSTRAINT VisaCommercialProducts PRIMARY KEY NOT NULL,
	CommercialProductCode NVARCHAR(5)
)

CREATE UNIQUE INDEX IDX_CommericalProductCode ON dbo.VaultCardMetadataVisaCommericalProducts(CommercialProductCode)

CREATE TABLE dbo.VaultCardMetadataExecutionHistory
(
	Id BIGINT IDENTITY(1,1) CONSTRAINT MetadataExecutionHistoryPk PRIMARY KEY NOT NULL,
	ActionType VARCHAR(100) NOT NULL,
	Action VARCHAR(100) NOT NULL,
	ActionDate DATETIME2 NOT NULL
)

CREATE TABLE VaultAlternativeCardMetadata
(
	Id BIGINT IDENTITY(1,1) CONSTRAINT AltMetadataPk PRIMARY KEY NOT NULL,
	bin_number NUMERIC NOT NULL,
	issuer varchar(100) NOT NULL,
	issuer_country_iso2_code VARCHAR(2) NOT NULL,
	scheme VARCHAR(80) NOT NULL,
	type VARCHAR(100) NOT NULL,
	product_type VARCHAR(100) NOT NULL,
	hash VARCHAR(500),
	action_type VARCHAR(10) NOT NULL,
	file_materialized_on DATETIME2,
	uploaded_to_s3_on DATETIME2
)

CREATE UNIQUE INDEX IDX_VaultCardmetadata_Alternative_Hash ON dbo.VaultAlternativeCardMetadata(hash)
	INCLUDE(bin_number, issuer, issuer_country_iso2_code, scheme, type, product_type, action_type)

CREATE TABLE VaultAlternativeCardMetadata_Staging
(
	Id BIGINT IDENTITY(1,1) CONSTRAINT AltMetadataStagingPk PRIMARY KEY NOT NULL,
	bin_number NUMERIC NOT NULL,
	issuer varchar(100) NOT NULL,
	issuer_country_iso2_code VARCHAR(2) NOT NULL,
	scheme VARCHAR(80) NOT NULL,
	type VARCHAR(100) NOT NULL,
	product_type VARCHAR(100) NOT NULL,
	hash VARCHAR(500),
	action_type VARCHAR(10) NOT NULL,
	processed BIT NOT NULL,
	created DATETIME2
)

CREATE UNIQUE INDEX IDX_VaultCardmetadata_Alternative_Hash ON dbo.VaultAlternativeCardMetadata_Staging(hash) 
	INCLUDE(bin_number, issuer, issuer_country_iso2_code, scheme, type, product_type, action_type, processed)
CREATE INDEX IDX_VaultCardmetadata_Alternative_Processed ON dbo.VaultAlternativeCardMetadata_Staging(processed)

CREATE TABLE VaultVisaCardMetadata_Staging
(
	Id BIGINT IDENTITY(1,1) CONSTRAINT VisaMetadataStagingPk PRIMARY KEY NOT NULL,
	issuer VARCHAR(500) NOT NULL,
	issuer_country_iso2_code VARCHAR(2) NOT NULL,
	product_id VARCHAR(2) NOT NULL,
	type VARCHAR(100) NOT NULL,
	product_type VARCHAR(100) NOT NULL,
	category VARCHAR(50) NOT NULL,
	low_key_9 INT NOT NULL,
	high_key_9 INT NOT NULL,
	hash varchar(500) NOT NULL,
	action_type VARCHAR(10) NOT NULL,
	processed BIT NOT NULL,
	created DATETIME2
)

CREATE TABLE VaultVisaCardMetadata
(
	Id BIGINT IDENTITY(1,1) CONSTRAINT VisaMetadataPk PRIMARY KEY NOT NULL,
	issuer VARCHAR(500) NOT NULL,
	issuer_country_iso2_code VARCHAR(2) NOT NULL,
	product_id CHAR(1) NOT NULL,
	type VARCHAR(100) NOT NULL,
	product_type VARCHAR(100) NOT NULL,
	category VARCHAR(50) NOT NULL,
	low_key_9 INT NOT NULL,
	high_key_9 INT NOT NULL,
	hash varchar(500) NOT NULL,
	action_type VARCHAR(10) NOT NULL,
	file_materialized_on DATETIME2,
	uploaded_to_s3_on DATETIME2
)

CREATE TABLE VaultMastercardCardMetadata_Staging
(
	Id BIGINT IDENTITY(1,1) CONSTRAINT MastercardMetadataStagingPk PRIMARY KEY NOT NULL,
	category VARCHAR(50) NOT NULL,
	type VARCHAR(100) NOT NULL,
	issuer VARCHAR(500) NOT NULL,
	issuer_country_iso2_code VARCHAR(2) NOT NULL,
	product_type VARCHAR(100) NOT NULL,
	product_id VARCHAR(50) NOT NULL,
	low_key_9 INT NOT NULL,
	high_key_9 INT NOT NULL,
	hash varchar(500) NOT NULL,
	action_type VARCHAR(10) NOT NULL,
	processed BIT NOT NULL,
	created DATETIME2
)

CREATE TABLE VaultMastercardCardMetadata
(
	Id BIGINT IDENTITY(1,1) CONSTRAINT MastercardMetadataPk PRIMARY KEY NOT NULL,
	category VARCHAR(50) NOT NULL,
	type VARCHAR(100) NOT NULL,
	issuer VARCHAR(500) NOT NULL,
	issuer_country_iso2_code VARCHAR(2) NOT NULL,
	product_type VARCHAR(100) NOT NULL,
	product_id VARCHAR(50) NOT NULL,
	low_key_9 INT NOT NULL,
	high_key_9 INT NOT NULL,
	hash varchar(500) NOT NULL,
	action_type VARCHAR(10) NOT NULL,
	file_materialized_on DATETIME2,
	uploaded_to_s3_on DATETIME2
)
