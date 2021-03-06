USE [TIJ]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'spAPQ_Create_StopsSummary') AND TYPE in (N'P'))
    DROP PROCEDURE [dbo].[spAPQ_Create_StopsSummary]
GO
CREATE PROCEDURE [dbo].[spAPQ_Create_StopsSummary]
	  @IdRuntime	BIGINT
AS
BEGIN
	IF EXISTS(SELECT * FROM [dbo].[APQ_StopsSummary] [ST] WHERE [ST].[IdRuntime] = @IdRuntime)
		DELETE FROM [dbo].[APQ_StopsSummary] WHERE [IdRuntime] = @IdRuntime

	INSERT INTO [dbo].[APQ_StopsSummary]
	SELECT
	 	  @IdRuntime
		, [SS].[Clasification]
		, SUM([SS].[Time])
	FROM
		[dbo].[APQ_Stops] [SS]
	WHERE
		[SS].[IdRuntime] = @IdRuntime
	GROUP BY
		[SS].[Clasification]
END
GO


