USE [TIJ]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'spAPQ_Create_Counts') AND TYPE in (N'P'))
    DROP PROCEDURE [dbo].[spAPQ_Create_Counts]
GO
CREATE PROCEDURE [dbo].[spAPQ_Create_Counts]
	  @IdRuntime	BIGINT
	, @FromDate		DATETIME
	, @ToDate		DATETIME
AS
BEGIN
	IF EXISTS(SELECT * FROM [dbo].[APQ_Counts] [CT] WHERE [CT].[IdRuntime] = @IdRuntime)
		DELETE FROM [dbo].[APQ_Counts] WHERE [IdRuntime] = @IdRuntime

	INSERT INTO [dbo].[APQ_Counts]
	SELECT
		  @IdRuntime
		, [IO].[ItemId]
		, [CM].[Maquina]
		, [IO].[EntryDate]
		, [TP].[ProdTime]
		, (CASE WHEN [IO].[IdPlace] IN (6, 10, 16) THEN 0 ELSE [IO].[QtyOut] END)					AS [GoodCount]
		, (CASE WHEN [IO].[IdPlace] IN (6, 10, 16) THEN [IO].[QtyOut] ELSE 0 END)					AS [BadCount]
		, [IO].[QtyOut]																				AS [TotalCount]
		, (CASE WHEN [IO].[IdPlace] IN (6, 10, 16) THEN 0 ELSE [IO].[QtyOut] END) * [TP].[ProdTime] AS [GoodTime] 
		, (CASE WHEN [IO].[IdPlace] IN (6, 10, 16) THEN [IO].[QtyOut] ELSE 0 END) * [TP].[ProdTime] AS [LostTime]
		, [IO].[QtyOut] * [TP].[ProdTime]															AS [TotalTime]
	FROM
		[dbo].[InvtMold_Output] [IO]
		INNER JOIN [dbo].[MOLDAT05] [M5] ON
				[M5].[IdOut] = [IO].[IdOut]
			AND [M5].[Estatus] = 'A'
		INNER JOIN [dbo].[CambioMolde] [CM] ON
				[CM].[IdCambioMolde] = [M5].[WO]
			AND [CM].[Estatus] = 'A'
		INNER JOIN [dbo].[v_Table_Plastic] [TP] ON
			[TP].[ItemId] = [IO].[ItemId]
	WHERE
		[IO].[EntryDate] >= @FromDate AND [IO].[EntryDate] < @ToDate

	INSERT INTO [dbo].[APQ_Counts]
	SELECT
		  @IdRuntime
		, [IO].[ItemId]
		, [CM].[Maquina]
		, [IO].[EntryDate]
		, [TP].[ProdTime]
		, 0									AS [GoodCount]
		, [IO].[QtyOut]						AS [BadCount]
		, [IO].[QtyOut]						AS [TotalCount]
		, 0									AS [GoodTime] 
		, ([IO].[QtyOut]*[TP].[ProdTime])	AS [LostTime]
		, ([IO].[QtyOut]*[TP].[ProdTime])	AS [TotalTime]
	FROM
		[dbo].[InvtMold_Output] [IO]
		INNER JOIN [dbo].[MOLDAT02] [M2] ON
			[M2].[IdOut] = [IO].[IdOut]
		INNER JOIN [dbo].[CambioMolde] [CM] ON
				[CM].[IdCambioMolde] = [M2].[WO]
			AND [CM].[Estatus] = 'A'
		INNER JOIN [dbo].[v_Table_Plastic] [TP] ON
			[TP].[ItemId] = [IO].[ItemId]
	WHERE
		[IO].[EntryDate] >= @FromDate AND [IO].[EntryDate] < @ToDate
END
GO
