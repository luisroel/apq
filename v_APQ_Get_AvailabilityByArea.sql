USE [TIJ]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'v_APQ_Get_AvailabilityByArea') AND TYPE in (N'V'))
    DROP VIEW [dbo].[v_APQ_Get_AvailabilityByArea]
GO
CREATE  VIEW [dbo].[v_APQ_Get_AvailabilityByArea]
AS
	SELECT
			[PS].[IdRuntime]
		  , [PS].[PlannedProductionTime]			-- Workable time
		  , [PS].[Area]
		  , [PS].[ScheduleLoss]						-- Off time
		  , [PS].[PlannedStop]						-- Breaks
		  , [PS].[TotalTime]
		  , [ST].[StopTime]	/ 60.0				AS [StopTime]	-- Equipment Stop Time
	FROM
		[dbo].[v_APQ_Get_ProductionScheduleByArea] [PS]
		LEFT JOIN [dbo].[v_APQ_Get_StopsByArea] [ST] ON
				[ST].[IdRuntime] = [PS].[IdRuntime]
			AND [ST].[Area] = [PS].[Area]
GO


