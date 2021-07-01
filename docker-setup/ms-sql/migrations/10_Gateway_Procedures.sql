USE [GATEWAY]
GO

CREATE Procedure [dbo].[GetHashCard](@Action VARCHAR(4), @CipherKey NVARCHAR(MAX),
							 @CCNumber NVARCHAR(50), @HashCardENCR Varbinary(4000) OUTPUT,
							 @HashCard Varbinary(4000), @CCNumberDECR NVARCHAR(50) OUTPUT)

AS 
BEGIN

IF @Action = 'ENCR'
	BEGIN
		OPEN SYMMETRIC KEY PassFieldSymKey 
			DECRYPTION BY CERTIFICATE certKey with password = N'Password2014e'
			SET @HashCardENCR = EncryptByKey(Key_GUID(N'PassFieldSymKey'), @CCNumber)
		CLOSE SYMMETRIC KEY PassFieldSymKey
	END
ELSE IF @Action = 'DECR'
	BEGIN
		OPEN SYMMETRIC KEY PassFieldSymKey 
			DECRYPTION BY CERTIFICATE certKey with password = N'Password2014e'
			SET @CCNumberDECR = DecryptByKey(@HashCard)
		CLOSE SYMMETRIC KEY PassFieldSymKey
	END

END;

GO

CREATE PROCEDURE [dbo].[InsertCard]
(
	@Id bigint OUT,
	@Token uniqueidentifier = NULL,
	@PaymentMethodId bigint = NULL,
	@Email nvarchar(255)  = NULL,
	@Number nvarchar(50) =  NULL,
	@Name nvarchar(255)=  NULL,
	@Cvv2 nvarchar(5) = null,
	@ExpMonth nvarchar(50) = NULL,
	@ExpYear nvarchar(50) =  NULL,
	@ExpDay nvarchar(50) = NULL,
	@AddressLine1 nvarchar(200) = NULL,
	@AddressLine2 nvarchar(200) = NULL,
	@AddressPostal nvarchar(200) = NULL,
	@AddressCountry nvarchar(50) = NULL,
	@AddressCity nvarchar(50) = NULL,
	@AddressState nvarchar(50) = NULL,
	@AddressPhone nvarchar(50) = NULL,
	@AddressFax nvarchar(50) = NULL,
	@CvcCheck nvarchar(10) = NULL,
	@AvsCheck nvarchar(10) = NULL,
	@Fingerprint binary(32) = NULL,
	@NumberHash binary(32) = NULL,
	@AddressCountryISO3 nvarchar(3) = NULL,
	@LiveMode bit = 0,
	@GatewayResponseCode nvarchar(50) = NULL,
	@AuthCode nvarchar(50) = NULL,
	@CCHash VARBINARY(4000) = NULL OUT,
	@AddressPhoneCountryCode nvarchar(7) = null,
	@DelFlag bit,
	@Wallet smallint = NULL,
	@cipherKey NVARCHAR(MAX) = NULL,
	@paymentAccountReference nvarchar(29) = null,
	@NetworkTokenType NVARCHAR(20) = NULL
)
 AS
 DECLARE @CCNumber	NVARCHAR(50) 
 EXEC GetHashCard 'ENCR', @cipherKey, @Number, @CCHash OUTPUT, null,null
 SELECT  @CCNumber = dbo.MaskCardNumber(@Number)
 INSERT INTO [dbo].[Cards]
	(Token
	,PaymentMethodId
	,Email
	,Number
	,CCHash
	,Name
	,Cvv2
	,ExpMonth
	,ExpYear
	,ExpDay
	,AddressLine1
	,AddressLine2
	,AddressPostal
	,AddressCountry
	,AddressCity
	,AddressState
	,AddressPhone
	,AddressFax
	,CvcCheck
	,AvsCheck
	,LiveMode
	,FingerPrint
	,NumberHash
	,AddressCountryISO3
	,GatewayResponseCode
	,AuthCode
	,AddressPhoneCountryCode
	,DelFlag
	,CreatedDate
	,ModifiedDate
	,CreatedBy
	,ModifiedBy
	,IsActive
	,Wallet
	)
VALUES
	(@Token
	,@PaymentMethodId
	,@Email
	,@CCNumber
	,@CCHash
	,@Name
	,@Cvv2
	,@ExpMonth
	,@ExpYear
	,@ExpDay
	,@AddressLine1
	,@AddressLine2
	,@AddressPostal
	,@AddressCountry
	,@AddressCity
	,@AddressState
	,@AddressPhone
	,@AddressFax
	,@CvcCheck
	,@AvsCheck
	,@LiveMode
	,@Fingerprint
	,@NumberHash
	,@AddressCountryISO3
	,@GatewayResponseCode
	,@AuthCode
	,@AddressPhoneCountryCode
	,@DelFlag 
	,GETDATE()
	,GETDATE() 
	,0
	,0
	,1
	,@Wallet
	);
 SET @Id = SCOPE_IDENTITY();
 
 GO

