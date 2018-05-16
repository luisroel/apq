USE [TIJ]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'v_APQ_Get_ProductionScheduleByArea') AND TYPE in (N'V'))
    DROP VIEW [dbo].[v_APQ_Get_ProductionScheduleByArea]
GO
CREATE  VIEW [dbo].[v_APQ_Get_ProductionScheduleByArea]
AS
	SELECT
		  [AS].[IdRuntime]
		, [AS].[Area]
		, [AS].[PlannedProductionTime]
		, [AS].[ScheduleLoss]
		, [AS].[PlannedStop]
		, ([AS].[PlannedProductionTime] + [AS].[ScheduleLoss] + [AS].[PlannedStop]) AS [TotalTime]
	FROM
		[dbo].[APQ_AvailabilityByArea] [AS]
GO


