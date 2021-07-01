USE GATEWAY

GO

INSERT INTO dbo.Customer
(
	CustomerEmail,
	CustomerName,
	CustomerToken,
	IPAddress,
	CustomerPhoneNumCountryCode,
	CustomerPhoneNum,
	Description, 
	FingerPrint,
	LiveMode,
	Device,
	IsActive,
	DelFlag,
	CreatedBy,
	CreatedDate,
	ModifiedBy,
	ModifiedDate
)
VALUES
(	
	'test-user1@email.com',
	'Test User 1',
	'EC403C7E-2D7F-4607-92C4-438E62D93EDD',
	null,
	'44',
	'12345678',
	null,
	0x8D565A147421091824035C68B223447C9972EAC9C1EF0C71DDC207413EC9EC8F,
	1,
	null,
	1,
	0,
	0,
	GETUTCDATE(),
	0,
	GETUTCDATE()
),
(	
	'test-user2@email.com',
	'Test User 2',
	'FD47A207-43AD-4743-8803-746E35439894',
	null,
	'44',
	'87654321',
	null,
	0x8D565A147421091824035C68B223447C9972EAC9C1EF0C71DDC207413EC9EC8F,
	1,
	null,
	1,
	0,
	0,
	GETUTCDATE(),
	0,
	GETUTCDATE()
)

GO

INSERT INTO dbo.CustomerMerchantAccount
(
	CustomerId,
	MerchantAccountId,
	BusinessId,
	ChannelId,
	LiveMode,
	IsActive,
	DelFlag,
	CreatedBy,
	CreatedDate,
	ModifiedBy,
	ModifiedDate
)
VALUES 
(
	1,
	100001,
	100001,
	100001,
	1,
	1,
	0,
	0,
	GETUTCDATE(),
	0,
	GETUTCDATE()
),
(
	2,
	100001,
	100001,
	100001,
	1,
	1,
	0,
	0,
	GETUTCDATE(),
	0,
	GETUTCDATE()
)

GO

DECLARE @cipherKey varchar(max) = 'testing'

DECLARE @VisaCard varchar(50) = '4242424242424242'
DECLARE @MasterCard varchar(50) = '5436031030606378'

DECLARE @VisaCCHash Varbinary(4000)
DECLARE @MastercardCCHash Varbinary(4000)

EXEC GetHashCard 'ENCR', @cipherKey, @VisaCard, @VisaCCHash OUTPUT, null, null
EXEC GetHashCard 'ENCR', @cipherKey, @MasterCard, @MastercardCCHash OUTPUT, null, null

INSERT INTO dbo.Cards
(
	Token,
	PaymentMethodId,
	Number,
	Name,
	ExpMonth,
	ExpYear,
	CCHash,
	IsActive,
	DelFlag,
	CreatedBy,
	CreatedDate,
	ModifiedBy,
	ModifiedDate,
	AddressLine1,
    AddressLine2,
    AddressPostal,
    AddressCountry,
    AddressCity,
    AddressState,
    AddressPhoneCountryCode,
    AddressPhone,
	Wallet
)
VALUES 
(
	'A54DA45F-B344-470A-9DD3-4D604C0EC072',
	1,
	'4242********4242',
	'Test User 1',
	06,
	2025,
	@VisaCCHash,
	1,
	0,
	0,
	GETUTCDATE(),
	0,
	GETUTCDATE(),
	"Address Line 1",
	"Address Line 2",
	"PO1 ST2",
	"GB",
	"City",
	"State",
	null,
	null,
	0
),
(
	'B80FABE2-BADE-4AB1-B9F5-F43B54E924A7',
	1,
	'5436********6378',
	'Test User 2',
	06,
	2030, --updated as this is the digital wallet card and needs to be a new stored card in Vault
	@MastercardCCHash,
	1,
	0,
	0,
	GETUTCDATE(),
	0,
	GETUTCDATE(),
	null,
	null,
	null,
	null,
	null,
	null,
	'44',
	'87654321',
	1 -- indicated applepay
),
(
	'484EE171-56AA-436D-9879-38EFFAA23FF1',
	1,
	'5436********6378',
	'Test User 3',
	06,
	2025,
	@MastercardCCHash,
	1,
	0,
	0,
	GETUTCDATE(),
	0,
	GETUTCDATE(),
	null,
	null,
	null,
	null,
	null,
	null,
	'44',
	'87654321',
	0
),
(
	'B2A30509-C5FA-4909-9459-BED0314F8DB5',
	4,
	'5436********6378',
	'Test User 4',
	06,
	2025,
	@MastercardCCHash,
	1,
	0,
	0,
	GETUTCDATE(),
	0,
	GETUTCDATE(),
	null,
	null,
	null,
	null,
	null,
	null,
	'44',
	'87654321',
	0
)

GO

INSERT INTO dbo.CustomerCards
(
	CustomerId,
	CardsId,
	IsDefault,
	LiveMode,
	IsActive,
	DelFlag,
	CreatedBy,
	CreatedDate,
	ModifiedBy,
	ModifiedDate,
	InitialChargeId
)
VALUES
(
	1,
	100000,
	1,
	1,
	1,
	0,
	0,
	GETUTCDATE(),
	0,
	GETUTCDATE(),
	null
),
(
	2,
	100001,
	0,
	1,
	1,
	0,
	0,
	GETUTCDATE(),
	0,
	GETUTCDATE(),
	null
),
(
	1,
	100002,
	0,
	1,
	1,
	0,
	0,
	GETUTCDATE(),
	0,
	GETUTCDATE(),
	null
),
(
	1,
	100003,
	0,
	1,
	1,
	0,
	0,
	GETUTCDATE(),
	0,
	GETUTCDATE(),
	null
)
