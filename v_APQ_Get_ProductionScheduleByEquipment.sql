USE [TIJ]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'v_APQ_Get_ProductionScheduleByEquipment') AND TYPE in (N'V'))
    DROP VIEW [dbo].[v_APQ_Get_ProductionScheduleByEquipment]
GO
CREATE  VIEW [dbo].[v_APQ_Get_ProductionScheduleByEquipment]
AS
	SELECT
		  [EQ].[IdRuntime]
		, [EQ].[Area]
		, [EQ].[Line]
		, [EQ].[IdEquipment]
		, SUM([AS].[Working])								AS [PlannedProductionTime]
		, SUM([AS].[Off])									AS [ScheduleLoss]
		, SUM([AS].[Break])									AS [PlannedStop]
		, SUM([AS].[Working] + [AS].[Off] + [AS].[Break])	AS [TotalTime]
	FROM
		[dbo].[APQ_Equipment] [EQ]
		INNER JOIN [dbo].[APQ_Availability] [AS] ON
			[AS].[IdRuntime] = [EQ].[IdRuntime]
	GROUP BY
		  [EQ].[IdRuntime]
		, [EQ].[Area]
		, [EQ].[Line]
		, [EQ].[IdEquipment]
GO
