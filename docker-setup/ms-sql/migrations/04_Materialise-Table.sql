USE ADMINISTRATION
GO

CREATE PROCEDURE dbo.VaultCardMetadataMaterialiseTable @ProcessName VARCHAR(100)
AS

SET NOCOUNT ON

SET @ProcessName = UPPER(@ProcessName)

IF @ProcessName = 'MASTERCARD'
BEGIN
	INSERT INTO dbo.VaultCardMetadataExecutionHistory VALUES(@ProcessName, 'MATERILISATION STARTED', GETUTCDATE())
	DELETE FROM  dbo. VaultMastercardCardMetadata

	INSERT INTO dbo. VaultMastercardCardMetadata (
		issuer,
		issuer_country_iso2_code,
		product_id,
		type,
		product_type,
		category,
		low_key_9,
		high_key_9,
		hash,
		action_type,
		file_materialized_on
	) 

	SELECT	issuer,
			issuer_country_iso2_code,
			product_id,
			type,
			product_type,
			category,
			low_key_9,
			high_key_9,
			hash,
			action_type,
			GETUTCDATE()

	FROM dbo.VaultMastercardCardMetadata_Staging

	INSERT INTO dbo.VaultCardMetadataExecutionHistory VALUES(@ProcessName, 'MATERILISATION COMPLETED', GETUTCDATE())
END

IF @ProcessName = 'VISA'
BEGIN
	INSERT INTO dbo.VaultCardMetadataExecutionHistory VALUES(@ProcessName, 'MATERILISATION STARTED', GETUTCDATE())
	DELETE FROM  dbo. VaultVisaCardMetadata

	INSERT INTO dbo.VaultVisaCardMetadata (
		issuer,
		issuer_country_iso2_code,
		product_id,
		type,
		product_type,
		category,
		low_key_9,
		high_key_9,
		hash,
		action_type,
		file_materialized_on
	)

	SELECT	issuer,
			issuer_country_iso2_code,
			product_id,
			type,
			product_type,
			category,
			low_key_9,
			high_key_9,
			hash,
			action_type,
			GETUTCDATE()

	FROM dbo.VaultVisaCardMetadata_Staging

	INSERT INTO dbo.VaultCardMetadataExecutionHistory VALUES(@ProcessName, 'MATERILISATION COMPLETED', GETUTCDATE())
END

IF @ProcessName = 'ALTERNATIVE'
BEGIN
	INSERT INTO dbo.VaultCardMetadataExecutionHistory VALUES(@ProcessName, 'MATERILISATION STARTED', GETUTCDATE())
	DELETE FROM  dbo. VaultAlternativeCardMetadata

	INSERT INTO dbo. VaultAlternativeCardMetadata (
		bin_number,
		issuer,
		issuer_country_iso2_code,
		scheme,
		type,
		product_type,
		hash,
		action_type,
		file_materialized_on
	)

	SELECT	bin_number,
			issuer,
			issuer_country_iso2_code,
			scheme,
			type,
			product_type,
			hash,
			action_type,
			GETUTCDATE()

	FROM dbo.VaultAlternativeCardMetadata_Staging

	INSERT INTO dbo.VaultCardMetadataExecutionHistory VALUES(@ProcessName, 'MATERILISATION COMPLETED', GETUTCDATE())
END

IF @ProcessName NOT IN ('ALTERNATIVE', 'VISA', 'MASTERCARD')
BEGIN
	INSERT INTO dbo.VaultCardMetadataExecutionHistory VALUES(@ProcessName, 'MATERILISATION ABORTED UNKNOWN TYPE', GETUTCDATE())
	RETURN 1;
END