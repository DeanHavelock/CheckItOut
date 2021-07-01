USE ADMINISTRATION
GO

CREATE PROCEDURE dbo.VaultCardMetadataProcessAlternative
AS

SET NOCOUNT ON

INSERT INTO dbo.VaultCardMetadataExecutionHistory VALUES('ALTERNATIVE', 'PROCESSING STARTED', GETUTCDATE())

/*
	Cleaning up the table before processing starts so removing all values we should have deleted in the last run and
	setting proccessed state back to 0
*/
DELETE FROM dbo.VaultAlternativeCardMetadata_Staging WHERE action_type = 'del'
UPDATE dbo.VaultAlternativeCardMetadata_Staging SET processed = 0

/*
	We are now updating the table based on the values we can match from the udpated data
*/
BEGIN TRY
	MERGE INTO dbo.VaultAlternativeCardMetadata_Staging AS TARGET 
	USING (
		SELECT 
			bi.BinNumber  bin_number,
			ISNULL(bi.IssuingBank, '') issuer,
			ISNULL(bi.CountryISOA2Code, '') issuer_country_iso2_code,
			ISNULL(bi.CardBrand, '') scheme,
			ISNULL(alt.CardType, '') type,
			ISNULL(bi.CardCategory, '') product_type,
			LOWER(CONVERT(VARCHAR(32), HASHBYTES('MD5', CONCAT(
				ISNULL(CAST(bi.BinNumber as VARCHAR(15)), ''),
				ISNULL(bi.IssuingBank, ''),
				ISNULL(bi.CountryISOA2Code, ''),
				ISNULL(bi.CardBrand, ''),		
				ISNULL(bi.CardType, ''),
				ISNULL(bi.CardCategory, '')
			)),2)) as hash
		FROM 
			dbo.BinInfo bi WITH(NOLOCK)
		LEFT JOIN dbo.VaultCardMetadataAlternativeCardType as alt ON alt.BinInfoCardType = UPPER(bi.CardType)
	) AS SOURCE
	ON  (SOURCE.hash = TARGET.hash)

	WHEN NOT MATCHED THEN 
		INSERT (
			bin_number, 
			issuer, 
			issuer_country_iso2_code, 
			scheme, 
			type, 
			product_type, 
			hash, 
			action_type,
			processed
		)
		VALUES (
			source.bin_number, 
			source.issuer, 
			source.issuer_country_iso2_code, 
			source.scheme, 
			source.type, 
			source.product_type, 
			source.hash, 
			'add',
			1)

	WHEN MATCHED AND target.processed = 0  THEN
		UPDATE SET 
			target.action_type = '',
			target.processed = 1;
END TRY
BEGIN CATCH
	INSERT INTO dbo.VaultCardMetadataExecutionHistory VALUES('ALTERNATIVE',ERROR_MESSAGE(), GETUTCDATE());
	THROW;
END CATCH
/*
	We are now at a point where all values that exist in the new file has been processed anything that exists in staging
	can now be marked for deletion since they did not appear in the updated data
*/

UPDATE dbo.VaultAlternativeCardMetadata_Staging

SET	action_type = 'del'

WHERE processed = 0

INSERT INTO dbo.VaultCardMetadataExecutionHistory VALUES('ALTERNATIVE', 'PROCESSING COMPLETED', GETUTCDATE())