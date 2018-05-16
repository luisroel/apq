USE [TIJ]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'v_APQ_Get_StopsByLine') AND TYPE in (N'V'))
    DROP VIEW [dbo].[v_APQ_Get_StopsByLine]
GO
CREATE  VIEW [dbo].[v_APQ_Get_StopsByLine]
AS
	SELECT
		  [SS].[IdRuntime]
		, [SS].[Area]
		, [SS].[Line]
		, SUM([SS].[Time]) AS [StopTime]
	FROM
		[dbo].[APQ_StopsByLine] [SS]
	GROUP BY
		  [SS].[IdRuntime]
		, [SS].[Area]
		, [SS].[Line]
GO


