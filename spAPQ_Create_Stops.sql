USE [TIJ]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'spAPQ_Create_Stops') AND TYPE in (N'P'))
    DROP PROCEDURE [dbo].[spAPQ_Create_Stops]
GO
CREATE PROCEDURE [dbo].[spAPQ_Create_Stops]
	  @IdRuntime	BIGINT
	, @FromDate		DATETIME
	, @ToDate		DATETIME
AS
BEGIN
	IF EXISTS(SELECT * FROM [dbo].[APQ_Stops] [ST] WHERE [ST].[IdRuntime] = @IdRuntime)
		DELETE FROM [dbo].[APQ_Stops] WHERE [IdRuntime] = @IdRuntime

	INSERT INTO [dbo].[APQ_Stops]
	SELECT
	 	  @IdRuntime
		, [M6].[Maquina]
		, [M6].[INICIOPARO]
		, [MP].[IdParo]
		, [MP].[TipoParo]
		, [MP].[Clasificacion]
		, DATEDIFF(MINUTE,[M6].[INICIOPARO],(CASE WHEN [M6].[FINPARO] > @ToDate THEN @ToDate ELSE [M6].[FinParo] END)) AS [StopTime]
	FROM
		[dbo].[MOLDAT06] [M6]
		LEFT JOIN [dbo].[MOLDEO_PAROS] [MP] ON
			[MP].[IdParo] = [M6].[IDPARO]
	WHERE 
		[M6].[INICIOPARO] >= @FromDate AND [M6].[INICIOPARO] < @ToDate
		AND [MP].[IdParo] <> 'PFIN'
END
GO


