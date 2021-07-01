USE ADMINISTRATION
GO

INSERT INTO dbo.VaultCardMetadataAlternativeCardType
VALUES
	('CHARGE CARD', 'Charge'),
	('DEBIT', 'Debit'),
	('CREDIT', 'Credit'),
	('DEBIT OR CREDIT', 'Credit')

INSERT INTO dbo.VaultCardMetadataVisaFundingSource
VALUES
	('Credit', 'C'),
	('Debit', 'D'),
	('Prepaid', 'P'),
	('Charge', 'H'),
	('Deferred Debit', 'R')

INSERT INTO dbo.VaultCardMetadataVisaCommericalProducts
VALUES
	('G'),('G1'),('G3'),('G4'),('K'),('K1'),('S'),('S1'),('S2'),('S3'),('S4'),('S5'),('S6')

INSERT INTO dbo.VaultCardMetadataMastercardFundingSource
VALUES
	('C', 'Credit'),
	('D', 'Debit'),
	('P', 'Prepaid')

INSERT INTO dbo.VaultCardMetadataMastercardCommericalProducts
VALUES
	('1', 'Consumer'),
	('2', 'Commercial'),
	('3', 'Commercial')