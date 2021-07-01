USE GATEWAY

GO
PRINT N'Creating Master Key...';

GO
CREATE MASTER KEY ENCRYPTION BY PASSWORD= N'Password2014e';

GO
CREATE CERTIFICATE certKey
    AUTHORIZATION [dbo]
    ENCRYPTION BY PASSWORD = N'Password2014e'
    WITH SUBJECT = N'Encryption Certificate';

GO
PRINT N'Creating [PassFieldSymKey]...';

CREATE SYMMETRIC KEY PassFieldSymKey WITH
IDENTITY_VALUE = 'TestIdentityValue',
ALGORITHM = AES_256,
KEY_SOURCE = 'a very secure strong password or phrase'
ENCRYPTION BY CERTIFICATE certKey;
    
    
