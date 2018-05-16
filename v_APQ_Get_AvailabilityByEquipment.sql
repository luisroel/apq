USE [TIJ]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'v_APQ_Get_AvailabilityByEquipment') AND [TYPE] in (N'V'))
    DROP VIEW [dbo].[v_APQ_Get_AvailabilityByEquipment]
GO
CREATE  VIEW [dbo].[v_APQ_Get_AvailabilityByEquipment]
AS
	SELECT
			[PS].[IdRuntime]
		  , [PS].[Area]
		  , [PS].[Line]
		  , [PS].[IdEquipment]
		  , [PS].[PlannedProductionTime]												-- Workable time
		  , [PS].[ScheduleLoss]															-- Off time
		  , [PS].[PlannedStop]															-- Breaks
		  , [PS].[TotalTime]
		  , ISNULL([ST].[StopTime],0.0) / 60.0 AS [StopTime]							-- Equipment Stop Time
	FROM
		[dbo].[v_APQ_Get_ProductionScheduleByEquipment] [PS]
		LEFT JOIN [dbo].[v_APQ_Get_StopsByEquipment] [ST] ON
			[ST].[IdRuntime]		= [PS].[IdRuntime]
			AND [ST].[Area]			= [PS].[Area]
			AND [ST].[Line]			= [PS].[Line]
			AND [ST].[IdEquipment]	= [PS].[IdEquipment]
GO


