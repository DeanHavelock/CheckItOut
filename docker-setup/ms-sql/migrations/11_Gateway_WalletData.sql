USE [GATEWAY]
GO

CREATE TABLE [dbo].[WalletData](
	[WalletDataId] [int] IDENTITY(1,1) NOT NULL,
	[CardId] [bigint] NOT NULL,
	[Cryptogram] [nvarchar](200) NULL,
	[Eci] [nvarchar](5) NULL,
PRIMARY KEY CLUSTERED 
(
	[WalletDataId] ASC
))
GO

ALTER TABLE [dbo].[WalletData]  WITH NOCHECK ADD  CONSTRAINT [FK_DigitalWallet_ToCards] FOREIGN KEY([CardId])
REFERENCES [dbo].[Cards] ([CardsId])
GO

ALTER TABLE [dbo].[WalletData] CHECK CONSTRAINT [FK_DigitalWallet_ToCards]
GO