USE ADMINISTRATION
GO

CREATE PROCEDURE dbo.VaultCardMetadataProcessVisa
AS

SET NOCOUNT ON

INSERT INTO dbo.VaultCardMetadataExecutionHistory VALUES('VISA', 'PROCESSING STARTED', GETUTCDATE())

/*
	Cleaning up the table before processing starts so removing all values we should have deleted in the last run and
	setting proccessed state back to 0
*/
DELETE FROM dbo.VaultVisaCardMetadata_Staging WHERE action_type = 'del'
UPDATE dbo.VaultVisaCardMetadata_Staging SET processed = 0

/*
	We are now updating the table based on the values we can match from the udpated data
*/
BEGIN TRY
	MERGE INTO dbo.VaultVisaCardMetadata_Staging AS TARGET 
	USING (
		SELECT
			ISNULL(bi.IssuingBank, '') as issuer,
			ISNULL(bv.ARDEFCountry, '') as issuer_country_iso2_code,
			ISNULL(bv.ProductId, '') as product_id,
			ISNULL(fs.AccountFundingSourceCode, '') as 'type',
			ISNULL(vpt.ProductType, '') as product_type,
			ISNULL(IIF((SELECT COUNT(1) FROM dbo.VaultCardMetadataVisaCommericalProducts as cp WHERE cp.CommercialProductCode = bv.ProductId) > 0, 'Commercial', 'Consumer'), '') as category,
			ISNULL(bv.LowKey9, '') as low_key_9,
			ISNULL(bv.HighKey9, '') as high_key_9,	
			LOWER(CONVERT(VARCHAR(32), HashBytes('MD5', CONCAT(
				ISNULL(bi.IssuingBank, ''),
				ISNULL(bv.ARDEFCountry, ''),
				ISNULL(bv.ProductId, ''),
				ISNULL(fs.AccountFundingSource, ''),
				ISNULL(ProductType, ''),
				ISNULL(IIF((SELECT COUNT(1) FROM dbo.VaultCardMetadataVisaCommericalProducts as cp WHERE cp.CommercialProductCode = bv.ProductId) > 0, 'Commercial', 'Consumer'), ''), 
				ISNULL(bv.LowKey9, ''),
				ISNULL(bv.HighKey9, '')
			)), 2)) as hash
        
		FROM dbo.BinVisa bv WITH(NOLOCK)
			LEFT JOIN dbo.BinInfo bi WITH(NOLOCK) ON bi.BinNumber = bv.LowKey6
			LEFT JOIN dbo.VaultCardMetadataVisaFundingSource fs WITH(NOLOCK) on bv.AccountFundingSource = fs.AccountFundingSource
			LEFT JOIN dbo.Country c WITH(NOLOCK) ON c.CountryISO2Code = bv.ARDEFCountry
			LEFT JOIN VisaProductType vpt WITH(NOLOCK) ON vpt.ProductId = bv.ProductId
		WHERE bv.LowKey9 IS NOT NULL
		AND bv.HighKey9 IS NOT NULL

		GROUP BY 
			bi.IssuingBank,
			bv.ARDEFCountry,
			bv.ProductId,
			fs.AccountFundingSourceCode,
			fs.AccountFundingSource,
			vpt.ProductType,
			bv.LowKey9,
			bv.HighKey9
	) AS SOURCE
	ON  (SOURCE.hash = TARGET.hash)

	WHEN NOT MATCHED THEN 
		INSERT (
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
			processed
		)
		VALUES (
			source.issuer,
			source.issuer_country_iso2_code,
			source.product_id,
			source.type,
			source.product_type,
			source.category,
			source.low_key_9,
			source.high_key_9,
			source.hash, 
			'add',
			1)

	WHEN MATCHED AND target.processed = 0  THEN
		UPDATE SET 
			target.action_type = '',
			target.processed = 1;
END TRY
BEGIN CATCH
	INSERT INTO dbo.VaultCardMetadataExecutionHistory VALUES('VISA',ERROR_MESSAGE(), GETUTCDATE());
	THROW;
END CATCH
/*
	We are now at a point where all values that exist in the new file has been processed anything that exists in staging
	can now be marked for deletion since they did not appear in the updated data
*/

UPDATE dbo.VaultVisaCardMetadata_Staging

SET	action_type = 'del'

WHERE processed = 0

INSERT INTO dbo.VaultCardMetadataExecutionHistory VALUES('VISA', 'PROCESSING COMPLETED', GETUTCDATE())