USE [TIJ]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'spAPQ_Create_SetupAndStart') AND TYPE in (N'P'))
    DROP PROCEDURE [dbo].[spAPQ_Create_SetupAndStart]
GO
CREATE PROCEDURE [dbo].[spAPQ_Create_SetupAndStart]
	  @IdRuntime	BIGINT
	, @FromDate		DATETIME
	, @ToDate		DATETIME
AS
BEGIN
	IF EXISTS(SELECT * FROM [dbo].[APQ_SetupAndStart] [ST] WHERE [ST].[IdRuntime] = @IdRuntime)
		DELETE FROM [dbo].[APQ_SetupAndStart] WHERE [IdRuntime] = @IdRuntime

	INSERT INTO [dbo].[APQ_SetupAndStart]
	SELECT
		  @IdRuntime
		, [CM].[IdCambioMolde]
		, [CM].[Maquina]
		, [CM].[fechacambio]
		, [PP].[US MOLD #]
		, DATEPART(HOUR, [ML].[STDInicio])*60*60 + DATEPART(MINUTE, [ML].[STDInicio])*60	AS [Start]
		, DATEPART(HOUR, [ML].[STDMolde])*60*60 + DATEPART(MINUTE, [ML].[STDMolde])*60		AS [Setup]
	FROM
		[dbo].[CAMBIOMOLDE] [CM]
		LEFT JOIN [PARTS_PLASTIC] [PP] ON
			[PP].[No_PP] = [CM].[No_PP]
		LEFT JOIN [MOLDS] [ML] ON
			[ML].[MoldeTXT] = [PP].[US MOLD #]
	WHERE
		[CM].[FechaCambio] >= @FromDate AND [CM].[FechaCambio] < @ToDate
END
GO


