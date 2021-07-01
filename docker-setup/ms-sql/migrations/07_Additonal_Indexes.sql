USE ADMINISTRATION

CREATE NONCLUSTERED INDEX [idx_BinInfo_CardType] ON [dbo].[BinInfo]
(
 [CardType] ASC
)
INCLUDE
( [BinNumber],
 [CardBrand],
 [IssuingBank],
 [CardCategory],
 [CountryISOA2Code]
)
GO
DROP INDEX [IDX_BinInfo_BinNumber] ON [dbo].[BinInfo]
GO
CREATE NONCLUSTERED INDEX [IDX_BinInfo_BinNumber] ON [dbo].[BinInfo]
(
 [BinNumber] ASC
)
INCLUDE ([IssuingBank])
GO
CREATE NONCLUSTERED INDEX [idx_BinVisa_LowKey9_HighKey9]
ON [dbo].[BinVisa] ([LowKey9],[HighKey9])
INCLUDE ([ARDEFCountry],[ProductId],[AccountFundingSource],[LowKey6])