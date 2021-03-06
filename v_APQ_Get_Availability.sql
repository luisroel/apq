USE [TIJ]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'v_APQ_Get_Availability') AND TYPE in (N'V'))
    DROP VIEW [dbo].[v_APQ_Get_Availability]
GO
CREATE  VIEW [dbo].[v_APQ_Get_Availability]
AS
	SELECT
			[PS].[IdRuntime]
		  , [PS].[PlannedProductionTime]						-- Workable time
		  , [PS].[ScheduleLoss]									-- Off time
		  , [PS].[PlannedStop]									-- Breaks
		  , [PS].[TotalTime]
		  , [ST].[StopTime] / 60.0			AS [StopTime]		-- Equipment Stop Time
	FROM
		[dbo].[v_APQ_Get_ProductionSchedule] [PS]
		LEFT JOIN [dbo].[v_APQ_Get_Stops] [ST] ON
			[ST].[IdRuntime] = [PS].[IdRuntime]
GO


