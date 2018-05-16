USE [TIJ]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'spAPQ_Create_SetupAndStartSummary') AND TYPE in (N'P'))
    DROP PROCEDURE [dbo].[spAPQ_Create_SetupAndStartSummary]
GO
CREATE PROCEDURE [dbo].[spAPQ_Create_SetupAndStartSummary]
	  @IdRuntime	BIGINT
AS
BEGIN
	IF EXISTS(SELECT * FROM [dbo].[APQ_SetupAndStartSummary] [ST] WHERE [ST].[IdRuntime] = @IdRuntime)
		DELETE FROM [dbo].[APQ_SetupAndStartSummary] WHERE [IdRuntime] = @IdRuntime

	INSERT INTO [dbo].[APQ_SetupAndStartSummary]
	SELECT
	 	  @IdRuntime
		, SUM([SS].[StdSetupTime])
		, SUM([SS].[StdStartTime])
	FROM
		[dbo].[APQ_SetupAndStart] [SS]
	WHERE
		[SS].[IdRuntime] = @IdRuntime
END
GO


