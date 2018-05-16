USE [TIJ]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'v_APQ_Get_Counts') AND TYPE in (N'V'))
    DROP VIEW [dbo].[v_APQ_Get_Counts]
GO
CREATE  VIEW [dbo].[v_APQ_Get_Counts]
AS
	SELECT
		  [CT].[IdRuntime]
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
		[dbo].[APQ_CountsSummary] [CT]
		INNER JOIN [dbo].[APQ_SetupAndStartSummary] [SS] ON
			[SS].[IdRuntime] = [CT].[IdRuntime]
		LEFT JOIN [dbo].[APQ_ProdTimesSummary] [PS] ON
			[PS].[IdRuntime] = [CT].[IdRuntime]
GO


