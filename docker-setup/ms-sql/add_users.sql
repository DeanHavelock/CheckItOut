USE master
GO

IF NOT EXISTS (SELECT name FROM master.sys.server_principals WHERE name = 'administration_user')
	CREATE LOGIN [administration_user] WITH PASSWORD = N'administration_user', DEFAULT_DATABASE = [ADMINISTRATION], DEFAULT_LANGUAGE = [us_english], CHECK_POLICY = OFF;

USE ADMINISTRATION
GO
CREATE USER [administration_user] FOR LOGIN [administration_user] WITH DEFAULT_SCHEMA=[dbo]
GO

USE ADMINISTRATION
GO
ALTER ROLE [db_owner] ADD MEMBER [administration_user]
GO

IF NOT EXISTS (SELECT name FROM master.sys.server_principals WHERE name = 'gateway_user')
	CREATE LOGIN [gateway_user] WITH PASSWORD = N'gateway_user', DEFAULT_DATABASE = [GATEWAY], DEFAULT_LANGUAGE = [us_english], CHECK_POLICY = OFF;

USE GATEWAY
GO
CREATE USER [gateway_user] FOR LOGIN [gateway_user] WITH DEFAULT_SCHEMA=[dbo]
GO

USE GATEWAY
GO
ALTER ROLE [db_owner] ADD MEMBER [gateway_user]
GO

IF NOT EXISTS (SELECT name FROM master.sys.server_principals WHERE name = 'instrument_importer_user')
	CREATE LOGIN [instrument_importer_user] WITH PASSWORD = N'instrument_importer_user', DEFAULT_DATABASE = [GATEWAY], DEFAULT_LANGUAGE = [us_english], CHECK_POLICY = OFF;

IF NOT EXISTS (SELECT name FROM master.sys.server_principals WHERE name = 'vault_sync_user')
	CREATE LOGIN [vault_sync_user] WITH PASSWORD = N'vault_sync_user', DEFAULT_DATABASE = [GATEWAY], DEFAULT_LANGUAGE = [us_english], CHECK_POLICY = OFF;

USE GATEWAY
GO
CREATE USER [instrument_importer_user] FOR LOGIN [instrument_importer_user] WITH DEFAULT_SCHEMA=[dbo]
CREATE USER [vault_sync_user] for LOGIN [vault_sync_user] WITH DEFAULT_SCHEMA=[dbo]
GO

USE ADMINISTRATION
GO
CREATE USER [instrument_importer_user] FOR LOGIN [instrument_importer_user] WITH DEFAULT_SCHEMA=[dbo]
CREATE USER [vault_sync_user] for LOGIN [vault_sync_user] WITH DEFAULT_SCHEMA=[dbo]
GO

USE GATEWAY
GO
ALTER ROLE [db_owner] ADD MEMBER [instrument_importer_user]
ALTER ROLE [db_owner] ADD MEMBER [vault_sync_user]
GO

USE ADMINISTRATION
GO
ALTER ROLE [db_owner] ADD MEMBER [instrument_importer_user]
ALTER ROLE [db_owner] ADD MEMBER [vault_sync_user]
GO