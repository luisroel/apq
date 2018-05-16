USE [TIJ]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'spAPQ_Create_CountsByArea') AND TYPE in (N'P'))
    DROP PROCEDURE [dbo].[spAPQ_Create_CountsByArea]
GO
CREATE PROCEDURE [dbo].[spAPQ_Create_CountsByArea]
	  @IdRuntime	BIGINT
AS
BEGIN
	IF EXISTS(SELECT * FROM [dbo].[APQ_CountsByArea] [ST] WHERE [ST].[IdRuntime] = @IdRuntime)
		DELETE FROM [dbo].[APQ_CountsByArea] WHERE [IdRuntime] = @IdRuntime

	INSERT INTO [dbo].[APQ_CountsByArea]
	SELECT
	 	  @IdRuntime
		, [EQ].[Area]
		, SUM([CT].[GoodCount])
		, SUM([CT].[BadCount])
		, SUM([CT].[TotalCount])
		, SUM([CT].[GoodTime])
		, SUM([CT].[LossTime])
		, SUM([CT].[TotalTime])
	FROM
		[dbo].[APQ_Counts] [CT]
		INNER JOIN [dbo].[APQ_Equipment] [EQ] ON
			[EQ].[IdEquipment] = [CT].[IdEquipment]
	WHERE
		[CT].[IdRuntime] = @IdRuntime
	GROUP BY
		[EQ].[Area]
END
GO
