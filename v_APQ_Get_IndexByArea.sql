USE [TIJ]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'v_APQ_Get_IndexByArea') AND [TYPE] in (N'V'))
    DROP VIEW [dbo].[v_APQ_Get_IndexByArea]
GO
CREATE  VIEW [dbo].[v_APQ_Get_IndexByArea]
AS
	SELECT
		  [RT].[IdRuntime]
		, [RT].[To]																									AS [Time]

		, [AV].[Area]
		, [AV].[TotalTime]
		
		, [AV].[PlannedProductionTime]				-- Workable time
		, [AV].[PlannedProductionTime] / [AV].[TotalTime]															AS [PPT_Porc]

		, [AV].[PlannedStop]						-- Breaks
		, [AV].[PlannedStop] / [AV].[TotalTime]																		AS [PlannedStop_Porc]

		, [AV].[ScheduleLoss]						-- Off time
		, [AV].[ScheduleLoss] / [AV].[TotalTime]																	AS [ScheduleLoss_Porc]

		, ([AV].[PlannedProductionTime] - [CT].[StdSetupTime] - [CT].[StdStartTime])								AS [Productiontime]
		, ([AV].[PlannedProductionTime] - [CT].[StdSetupTime] - [CT].[StdStartTime]) / [AV].[PlannedProductionTime]	AS [Productiontime_Porc]

		, [CT].[StdSetupTime]
		, [CT].[StdSetupTime] / [AV].[PlannedProductionTime]														AS [StdSetupTime_Porc]
		, [CT].[StdStartTime]
		, [CT].[StdStartTime] / [AV].[PlannedProductionTime]														AS [StdStartTime_Porc]


		, ([AV].[PlannedProductionTime] - [CT].[StdSetupTime] - [CT].[StdStartTime] - [AV].[StopTime])				AS [Runtime]
		, ([AV].[PlannedProductionTime] - [CT].[StdSetupTime] - [CT].[StdStartTime] - [AV].[StopTime]) 
		/ ([AV].[PlannedProductionTime] - [CT].[StdSetupTime] - [CT].[StdStartTime])								AS [Runtime_Porc]

		, [AV].[StopTime]							-- Equipment Stop Time
		, [AV].[StopTime] / ([AV].[PlannedProductionTime] - [CT].[StdSetupTime] - [CT].[StdStartTime])				AS [Stoptime_Porc]

		, [CT].[TotalCount]
		, [CT].[GoodCount]
		, [CT].[BadCount]

		, [CT].[ProducedTime]
		, [CT].[GoodTime]
		, [CT].[LossTime]
		, [CT].[LossTime] / [CT].[GoodTime]																			AS [LossTime_Porc]

		, [CT].[ActualProdTime]

		, [CT].[ActualProdTime] - [CT].[ProducedTime]																AS [PerformanceLoss]
		, ([CT].[ActualProdTime] - [CT].[ProducedTime]) / [CT].[ActualProdTime]										AS [PerformanceLoss_Porc]

		, (([AV].[PlannedProductionTime] - [CT].[StdSetupTime] - [CT].[StdStartTime] - [AV].[StopTime]) * 100.0)
		/ ([AV].[PlannedProductionTime] - [CT].[StdSetupTime] - [CT].[StdStartTime])								AS [IA]

		, (([AV].[PlannedProductionTime] - [CT].[StdSetupTime] - [CT].[StdStartTime] - [AV].[StopTime]))
		/ ([AV].[PlannedProductionTime] - [CT].[StdSetupTime] - [CT].[StdStartTime])								AS [IA_Porc]

--		, ([CT].[ProducedTime] * 100.0) 
--		/ ([AV].[PlannedProductionTime] - [CT].[StdSetupTime] - [CT].[StdStartTime] - [AV].[StopTime])				AS [IP]
--		, [CT].[ProducedTime]
--		/ ([AV].[PlannedProductionTime] - [CT].[StdSetupTime] - [CT].[StdStartTime] - [AV].[StopTime])				AS [IP_Porc]

		, [CT].[ProducedTime] * 100.0 / [CT].[ActualProdTime]														AS [IP]
		, [CT].[ProducedTime] / [CT].[ActualProdTime]																AS [IP_Porc]

		, ([CT].[GoodTime] * 100.0) / [CT].[ProducedTime]															AS [IQ]
		, [CT].[GoodTime] / [CT].[ProducedTime]																		AS [IQ_Porc]

		, (([AV].[PlannedProductionTime] - [CT].[StdSetupTime] - [CT].[StdStartTime] - [AV].[StopTime])
		/ ([AV].[PlannedProductionTime] - [CT].[StdSetupTime] - [CT].[StdStartTime]))
		* ([CT].[ProducedTime]
		/ ([AV].[PlannedProductionTime] - [CT].[StdSetupTime] - [CT].[StdStartTime] - [AV].[StopTime]))
		* ([CT].[GoodTime] / [CT].[ProducedTime])
		* 100.0																										AS [Index]

		, (([AV].[PlannedProductionTime] - [CT].[StdSetupTime] - [CT].[StdStartTime] - [AV].[StopTime])
		/ ([AV].[PlannedProductionTime] - [CT].[StdSetupTime] - [CT].[StdStartTime]))
		* ([CT].[ProducedTime]
		/ ([AV].[PlannedProductionTime] - [CT].[StdSetupTime] - [CT].[StdStartTime] - [AV].[StopTime]))
		* ([CT].[GoodTime] / [CT].[ProducedTime])																	AS [Index_Porc]

		, (([AV].[PlannedProductionTime] - [CT].[StdSetupTime] - [CT].[StdStartTime] - [AV].[StopTime])
		/ ([AV].[PlannedProductionTime] - [CT].[StdSetupTime] - [CT].[StdStartTime]))
		* ([CT].[ProducedTime]
		/ ([AV].[PlannedProductionTime] - [CT].[StdSetupTime] - [CT].[StdStartTime] - [AV].[StopTime]))
		* ([CT].[GoodTime] / [CT].[ProducedTime])
		* [AV].[TotalTime]																							AS [IndexTime]
	FROM
		[dbo].[APQ_Runtime] [RT]
		INNER JOIN [dbo].[v_APQ_Get_AvailabilityByArea] [AV] ON
			[AV].[IdRuntime] = [RT].[IdRuntime]
		INNER JOIN [dbo].[v_APQ_Get_CountsByArea] [CT] ON
				[CT].[IdRuntime]	= [AV].[IdRuntime]
			AND [CT].[Area]			= [AV].[Area]
GO


