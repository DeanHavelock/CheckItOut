USE [ADMINISTRATION]
GO

SET IDENTITY_INSERT dbo.BinVisa ON

INSERT INTO [dbo].[BinVisa]
           (
		   [BinVisaId],
		   [HighKey],
           [ReserveField1],
           [LowKey],
           [ReserveField2],
           [IssuerBin],
           [CheckDigitAlgorithm],
           [AccountNumberLength],
           [ReserveField3],
           [ReserveField4],
           [ProcessorBin],
           [Domain],
           [Region],
           [Country],
           [LargeTicket],
           [TechnologyIndicator],
           [ARDEFRegion],
           [ARDEFCountry],
           [CommCCLvl2DataIndicator],
           [CommCCLvl3EnhancedDataIndicator],
           [CommCCPOSPromptingIndicator],
           [VATEvidence],
           [OriginalCredit],
           [AccountLvlProcessingIndicator],
           [OriginalCreditMoneyTransfer],
           [OriginalCreditOnlineGambling],
           [ProductId],
           [ComboCard],
           [FastFunds],
           [TravelIndicator],
           [R1R2R3],
           [AccountFundingSource],
           [SettlementMatch],
           [TravelAccountData],
           [AccountRestrictedUse],
           [NNSSIndicator],
           [ProductSubtype],
           [ReserveField5],
           [TestIndicator],
           [ReserveField6],
           [CreatedDate],
           [ModifiedDate],
           [LowKey6],
           [HighKey6],
           [LowKey9],
           [HighKey9])

VALUES 
(157230,424242424,'',424242424,'',424242,1,16,'','',424242,'W',1,'US','','',1,'US','','','','','','','A','A','A','','','','','C','','','','','','','','','2018-01-29 14:43:51.687','2018-01-29 14:43:51.687',424242,424242,424242424,424242424),
(29503,427314999,'   ',427314000,'   ',427314,1,16,' ',' ',492193,'W',3,'TR',' ',' ',3,'TR',' ',' ',' ',' ',' ',' ',' ',' ','G ',' ',' ',' ','      ','C',' ',' ',' ',' ','  ','  ',' ','                                                             ',
	'2017-04-25 10:05:30.410','2017-04-25 10:05:30.410',427314,427314,427314000,427314999)


SET IDENTITY_INSERT dbo.BinVisa OFF
