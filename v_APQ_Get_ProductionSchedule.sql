USE [TIJ]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'v_APQ_Get_ProductionSchedule') AND [TYPE] in (N'V'))
    DROP VIEW [dbo].[v_APQ_Get_ProductionSchedule]
GO
CREATE  VIEW [dbo].[v_APQ_Get_ProductionSchedule]
AS
	SELECT
		  [AS].[IdRuntime]
		, [AS].[PlannedProductionTime]
		, [AS].[PlannedStop]
		, [AS].[ScheduleLoss]
		, ([AS].[PlannedProductionTime] + [AS].[ScheduleLoss] + [AS].[PlannedStop]) AS [TotalTime]
	FROM
		[dbo].[APQ_AvailabilitySummary] [AS]
GO


