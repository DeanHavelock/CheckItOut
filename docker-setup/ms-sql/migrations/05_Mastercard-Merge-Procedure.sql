USE ADMINISTRATION
GO

CREATE PROCEDURE dbo.VaultCardMetadataProcessMastercard
AS

SET NOCOUNT ON

INSERT INTO dbo.VaultCardMetadataExecutionHistory VALUES('MASTERCARD', 'PROCESSING STARTED', GETUTCDATE())

/*
	Cleaning up the table before processing starts so removing all values we should have deleted in the last run and
	setting proccessed state back to 0
*/
DELETE FROM dbo.VaultMastercardCardMetadata_Staging WHERE action_type = 'del'
UPDATE dbo.VaultMastercardCardMetadata_Staging SET processed = 0

/*
	We are now updating the table based on the values we can match from the udpated data
*/
BEGIN TRY
	MERGE INTO dbo.VaultMastercardCardMetadata_Staging AS TARGET 
	USING (
		SELECT 
			category,
			type,
			issuer,
			issuer_country_iso2_code,
			product_type,
			product_id,
			low_key_9,
			high_key_9,
			hash
		FROM
		(
			SELECT
				ISNULL(cp.CommercialProduct, '') as category,
				ISNULL(fs.AccountFundingSource, '') as type,
				ISNULL(bi.IssuingBank, '') as issuer,
				ISNULL(country.CountryISO2Code, '') as issuer_country_iso2_code,	
				ISNULL(mpt.ProductType, '') as product_type,
				ISNULL(mc40t1.LicensedProductId, '') as product_id,	
				ISNULL(mc40t1.LowKey9, '') as low_key_9,
				ISNULL(mc40t1.HighKey9, '') as high_key_9, 
				ROW_NUMBER() OVER(PARTITION BY CONCAT(CONVERT(VARCHAR(9),mc40t1.LowKey9), CONVERT(VARCHAR(9), mc40t1.HighKey9)) ORDER BY mc40t1.IssuerCardProgramIdentierPriorityCode ASC) AS priority,
				LOWER(CONVERT(VARCHAR(32), HashBytes('MD5', CONCAT(
					ISNULL(cp.CommercialProduct, ''),
					ISNULL(fs.AccountFundingSource, ''),
					ISNULL(bi.IssuingBank, ''),
					ISNULL(country.CountryISO2Code, ''),	
					ISNULL(mpt.ProductType, ''),
					ISNULL(mc40t1.LicensedProductId, ''),
					ISNULL(mc40t1.LowKey9, ''),
					ISNULL(mc40t1.HighKey9, '')
				)), 2)) as hash
			FROM 
				dbo.BinMCT068IP0040T1 mc40t1 WITH(NOLOCK)
			LEFT JOIN   
				dbo.BinMCT068IP0016T1 mc16t1 WITH(NOLOCK) ON mc16t1.GCMSProductId = mc40t1.GCMSProductId
				AND	mc16t1.CardProgramIdentifier = mc40t1.CardProgramIdentier
				AND	mc16t1.ProductTypeId = mc40t1.ProductTypeId
				AND	mc16t1.LicensedProductId = mc40t1.LicensedProductId
				AND	mc16t1.ProductClass = mc40t1.ProductClass
			LEFT JOIN dbo.BinInfo BI WITH(NOLOCK) ON bi.BinNumber = mc40t1.LowKey6
			LEFT JOIN dbo.Country country WITH(NOLOCK) ON country.CountryISO3Code = mc40t1.CountryCodeAlpha
				OR country.CountryISONumber = mc40t1.CountryCodeNumeric
			LEFT JOIN MastercardProductType mpt WITH(NOLOCK) ON mpt.LicensedProductId COLLATE DATABASE_DEFAULT = mc40t1.LicensedProductId COLLATE DATABASE_DEFAULT
				AND mpt.GCMSProductId COLLATE DATABASE_DEFAULT = mc40t1.GCMSProductId COLLATE DATABASE_DEFAULT
			LEFT JOIN dbo.VaultCardMetadataMastercardFundingSource fs WITH(NOLOCK) ON fs.AccountFundingSourceCode = mc16t1.ProductCategory
			LEFT JOIN dbo.VaultCardMetadataMastercardCommericalProducts cp WITH(NOLOCK) ON cp.CommercialProductCode = mc40t1.ProductTypeId
			WHERE mc40t1.ActiveInactiveCode = 'A'
			AND mc40t1.LowKey9 IS NOT NULL
			AND mc40t1.HighKey9 IS NOT NULL
		) x
		WHERE x.priority = 1
	) AS SOURCE
	ON  (SOURCE.hash = TARGET.hash)

	WHEN NOT MATCHED THEN 
		INSERT (
			category,
			type,
			issuer,
			issuer_country_iso2_code,
			product_type,
			product_id,
			low_key_9,
			high_key_9,
			hash, 
			action_type,
			processed
		)
		VALUES (
			source.category,
			source.type,
			source.issuer,
			source.issuer_country_iso2_code,
			source.product_type,
			source.product_id,
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
	INSERT INTO dbo.VaultCardMetadataExecutionHistory VALUES('MASTERCARD',ERROR_MESSAGE(), GETUTCDATE());
	THROW;
END CATCH
/*
	We are now at a point where all values that exist in the new file has been processed anything that exists in staging
	can now be marked for deletion since they did not appear in the updated data
*/

UPDATE dbo.VaultMastercardCardMetadata_Staging

SET	action_type = 'del'

WHERE processed = 0

INSERT INTO dbo.VaultCardMetadataExecutionHistory VALUES('MASTERCARD', 'PROCESSING COMPLETED', GETUTCDATE())