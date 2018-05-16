USE [TIJ]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'v_APQ_Get_DataChartByArea') AND [TYPE] in (N'V'))
    DROP VIEW [dbo].[v_APQ_Get_DataChartByArea]
GO
CREATE  VIEW [dbo].[v_APQ_Get_DataChartByArea]
AS
	SELECT
		*
	FROM (
		SELECT 
			  [ND].[IdRuntime]
			, [ND].[Area]
			, '1. Total Time'	AS [Title]
			, 100.0 AS [Value1]
			, 'First'			AS [Pos]
		FROM [dbo].[v_APQ_Get_IndexByArea] [ND]
		UNION ALL
		SELECT
			  [ND].[IdRuntime]
			, [ND].[Area]
			, '1. Total Time'	AS [Title]
			, 0.0 AS [Value2]
			, 'Second'			AS [Pos]
		FROM [dbo].[v_APQ_Get_IndexByArea] [ND]
		UNION ALL
		SELECT
			  [ND].[IdRuntime]
			, [ND].[Area]
			, '1. Total Time'	AS [Title]
			, 0.0 AS [Value3]
			, 'Third'			AS [Pos]
		FROM [dbo].[v_APQ_Get_IndexByArea] [ND]
		UNION ALL
		SELECT 
			  [ND].[IdRuntime]
			, [ND].[Area]
			, '2. Schedule'
			, [ND].[PlannedProductionTime] * 100.0 / [ND].[TotalTime]
			, 'First'			AS [Pos]
		FROM [dbo].[v_APQ_Get_IndexByArea] [ND]
		UNION ALL
		SELECT 
			  [ND].[IdRuntime]
			, [ND].[Area]
			, '2. Schedule'
			, [ND].[PlannedStop] * 100.0 / [ND].[TotalTime]
			, 'Second'			AS [Pos]
		FROM [dbo].[v_APQ_Get_IndexByArea] [ND]
		UNION ALL
		SELECT 
			  [ND].[IdRuntime]
			, [ND].[Area]
			, '2. Schedule'
			, [ND].[ScheduleLoss] * 100.0 / [ND].[TotalTime] 
			, 'Third'			AS [Pos]
		FROM [dbo].[v_APQ_Get_IndexByArea] [ND]
		UNION ALL
		SELECT 
			  [ND].[IdRuntime]
			, [ND].[Area]
			, '3. Production'
			, [ND].[ProductionTime] * 100.0 / [ND].[TotalTime]
			, 'First'			AS [Pos]
		FROM [dbo].[v_APQ_Get_IndexByArea] [ND]
		UNION ALL
		SELECT 
			  [ND].[IdRuntime]
			, [ND].[Area]
			, '3. Production'
			, [ND].[StdSetupTime] * 100.0 / [ND].[TotalTime]
			, 'Second'			AS [Pos]
		FROM [dbo].[v_APQ_Get_IndexByArea] [ND]
		UNION ALL
		SELECT 
			  [ND].[IdRuntime]
			, [ND].[Area]
			, '3. Production'
			, [ND].[StdStartTime] * 100.0 / [ND].[TotalTime] 
			, 'Third'			AS [Pos]
		FROM [dbo].[v_APQ_Get_IndexByArea] [ND]
		UNION ALL
		SELECT 
			  [ND].[IdRuntime]
			, [ND].[Area]
			, '4. Availability'
			, [ND].[Runtime] * 100.0 / [ND].[TotalTime]
			, 'First'			AS [Pos]
		FROM [dbo].[v_APQ_Get_IndexByArea] [ND]
		UNION ALL
		SELECT 
			  [ND].[IdRuntime]
			, [ND].[Area]
			, '4. Availability'
			, [ND].[StopTime] * 100.0 / [ND].[TotalTime]
			, 'Second'			AS [Pos]
		FROM [dbo].[v_APQ_Get_IndexByArea] [ND]
		UNION ALL
		SELECT 
			  [ND].[IdRuntime]
			, [ND].[Area]
			, '4. Availability'
			, 0.0 
			, 'Third'			AS [Pos]
		FROM [dbo].[v_APQ_Get_IndexByArea] [ND]
		UNION ALL
		SELECT 
			  [ND].[IdRuntime]
			, [ND].[Area]
			, '5. Performance'
			, [ND].[ProducedTime] * 100.0 / [ND].[TotalTime]
			, 'First'	AS [Pos]
		FROM [dbo].[v_APQ_Get_IndexByArea] [ND]
		UNION ALL
		SELECT 
			  [ND].[IdRuntime]
			, [ND].[Area]
			, '5. Performance'
			, 0.0
			, 'Second'	AS [Pos]
		FROM [dbo].[v_APQ_Get_IndexByArea] [ND]
		UNION ALL
		SELECT 
			  [ND].[IdRuntime]
			, [ND].[Area]
			, '5. Performance'
			, 0.0 
			, 'Third'	AS [Pos]
		FROM [dbo].[v_APQ_Get_IndexByArea] [ND]
		UNION ALL
		SELECT 
			  [ND].[IdRuntime]
			, [ND].[Area]
			, '6. Quality'
			, [ND].[GoodTime] * 100.0 / [ND].[TotalTime]
			, 'First'	AS [Pos]
		FROM [dbo].[v_APQ_Get_IndexByArea] [ND]
		UNION ALL
		SELECT 
			  [ND].[IdRuntime]
			, [ND].[Area]
			, '6. Quality'
			, 0.0
			, 'Second'	AS [Pos]
		FROM [dbo].[v_APQ_Get_IndexByArea] [ND]
		UNION ALL
		SELECT 
			  [ND].[IdRuntime]
			, [ND].[Area]
			, '6. Quality'
			, 0.0 
			, 'Third'	AS [Pos]
		FROM [dbo].[v_APQ_Get_IndexByArea] [ND]
		UNION ALL
		SELECT 
			  [ND].[IdRuntime]
			, [ND].[Area]
			, '7. Index'
			, [ND].[IndexTime] * 100.0 / [ND].[TotalTime]
			, 'First'	AS [Pos]
		FROM [dbo].[v_APQ_Get_IndexByArea] [ND]
		UNION ALL
		SELECT 
			  [ND].[IdRuntime]
			, [ND].[Area]
			, '7. Index'
			, 0.0
			, 'Second'	AS [Pos]
		FROM [dbo].[v_APQ_Get_IndexByArea] [ND]
		UNION ALL
		SELECT 
			  [ND].[IdRuntime]
			, [ND].[Area]
			, '7. Index'
			, 0.0 
			, 'Third'	AS [Pos]
		FROM [dbo].[v_APQ_Get_IndexByArea] [ND]
	) [TT]
GO