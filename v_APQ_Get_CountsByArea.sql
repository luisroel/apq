USE [TIJ]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'v_APQ_Get_CountsByArea') AND [TYPE] in (N'V'))
    DROP VIEW [dbo].[v_APQ_Get_CountsByArea]
GO
CREATE  VIEW [dbo].[v_APQ_Get_CountsByArea]
AS
	SELECT
		  [CT].[IdRuntime]
		, [CT].[Area]
		, [CT].[GoodCount]
		, [CT].[BadCount]
		, [CT].[TotalCount]
		, ([CT].[GoodTime] / 60.0 / 60.0)		AS [GoodTime]
		, ([CT].[LossTime] / 60.0 / 60.0)		AS [LossTime]
		, ([CT].[TotalTime] / 60.0 / 60.0)		AS [ProducedTime]
		, ([SS].[StdSetupTime] / 60.0 / 60.0)	AS [StdSetupTime]
		, ([SS].[StdStartTime] / 60.0 / 60.0)	AS [StdStartTime]
		, [PS].[Time] / 60.0					AS [ActualProdTime]
	FROM
		[dbo].[APQ_CountsByArea] [CT]
		INNER JOIN [dbo].[APQ_SetupAndStartByArea] [SS] ON
				[SS].[IdRuntime]	= [CT].[IdRuntime]
			AND [SS].[Area]			= [CT].[Area]
		LEFT JOIN [dbo].[APQ_ProdTimesByArea] [PS] ON
				[PS].[IdRuntime]	= [CT].[IdRuntime]
			AND [PS].[Area]			= [CT].[Area]
GO


