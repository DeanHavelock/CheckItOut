USE [GATEWAY]
GO

CREATE FUNCTION [dbo].[MaskCardNumber](@CCNumber nvarchar(50))

RETURNS NVARCHAR(50)

AS 

BEGIN
	IF (@CCNumber IS NOT NULL)
	BEGIN
		SET @CCNumber = LTRIM(RTRIM(@CCNumber))

		IF (LEN(@CCNumber) > 10)
		BEGIN
			RETURN SUBSTRING(@CCNumber,1,6) + REPLICATE('*', LEN(@CCNumber) - 10) + SUBSTRING(@CCNumber,LEN(@CCNumber) - 3,4)
		END
	END

	RETURN @CCNumber
END;

GO

