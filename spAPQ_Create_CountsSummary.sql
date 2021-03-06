USE [TIJ]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'spAPQ_Create_CountsSummary') AND TYPE in (N'P'))
    DROP PROCEDURE [dbo].[spAPQ_Create_CountsSummary]
GO
CREATE PROCEDURE [dbo].[spAPQ_Create_CountsSummary]
	  @IdRuntime	BIGINT
AS
BEGIN
	IF EXISTS(SELECT * FROM [dbo].[APQ_CountsSummary] [ST] WHERE [ST].[IdRuntime] = @IdRuntime)
		DELETE FROM [dbo].[APQ_CountsSummary] WHERE [IdRuntime] = @IdRuntime

	INSERT INTO [dbo].[APQ_CountsSummary]
	SELECT
	 	  @IdRuntime
		, SUM([CT].[GoodCount])
		, SUM([CT].[BadCount])
		, SUM([CT].[TotalCount])
		, SUM([CT].[GoodTime])
		, SUM([CT].[LossTime])
		, SUM([CT].[TotalTime])
	FROM
		[dbo].[APQ_Counts] [CT]
	WHERE
		[CT].[IdRuntime] = @IdRuntime
END
GO


