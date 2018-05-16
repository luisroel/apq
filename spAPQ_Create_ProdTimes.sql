USE [TIJ]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'spAPQ_Create_ProdTimes') AND TYPE in (N'P'))
    DROP PROCEDURE [dbo].[spAPQ_Create_ProdTimes]
GO
CREATE PROCEDURE [dbo].[spAPQ_Create_ProdTimes]
	  @IdRuntime	BIGINT
	, @FromDate		DATETIME
	, @ToDate		DATETIME
AS
BEGIN
	IF EXISTS(SELECT * FROM [dbo].[APQ_ProdTimes] [ST] WHERE [ST].[IdRuntime] = @IdRuntime)
		DELETE FROM [dbo].[APQ_ProdTimes] WHERE [IdRuntime] = @IdRuntime

	INSERT INTO [dbo].[APQ_ProdTimes]
	SELECT
		  @IdRuntime
		, [CM].[IdCambioMolde]
		, [CM].[Maquina]
--		, [M3].[HrIniCambio]
--		, [M3].[HrFinCambio]
--		, [M3].[HrIniMaq]
		, ISNULL([M3].[HrIniProd],@FromDate)
		, (CASE WHEN ISNULL([CM].[FechaParo], @ToDate) > @ToDate THEN @ToDate ELSE ISNULL([CM].[FechaParo], @ToDate) END)
		, DATEDIFF(MINUTE, ISNULL([M3].[HrIniProd],@FromDate), (CASE WHEN ISNULL([CM].[FechaParo], @ToDate) > @ToDate THEN @ToDate ELSE ISNULL([CM].[FechaParo], @ToDate) END))	AS [Minutes]
	FROM
		[dbo].[CAMBIOMOLDE] [CM]
		LEFT JOIN [MOLDAT03] [M3] ON
			[M3].[WO] = [CM].[IdCambioMolde]
	WHERE
			[CM].[Estatus]	= 'A'
		AND [CM].[FechaCambio] >= @FromDate AND [CM].[FechaCambio] < @ToDate
END
GO


