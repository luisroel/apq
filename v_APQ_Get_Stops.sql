USE [TIJ]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'v_APQ_Get_Stops') AND TYPE in (N'V'))
    DROP VIEW [dbo].[v_APQ_Get_Stops]
GO
CREATE  VIEW [dbo].[v_APQ_Get_Stops]
AS
	SELECT
		  [SS].[IdRuntime]
		, SUM([SS].[Time]) AS [StopTime]
	FROM
		[dbo].[APQ_StopsSummary] [SS]
	GROUP BY
		[SS].[IdRuntime]
GO


