USE [TIJ]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'v_APQ_Get_StopsByEquipment') AND TYPE in (N'V'))
    DROP VIEW [dbo].[v_APQ_Get_StopsByEquipment]
GO
CREATE  VIEW [dbo].[v_APQ_Get_StopsByEquipment]
AS
	SELECT
		  [SS].[IdRuntime]
		, [SS].[Area]
		, [SS].[Line]
		, [SS].[IdEquipment]
		, SUM([SS].[Time]) AS [StopTime]
	FROM
		[dbo].[APQ_StopsByEquipment] [SS]
	GROUP BY
		  [SS].[IdRuntime]
		, [SS].[Area]
		, [SS].[Line]
		, [SS].[IdEquipment]
GO


