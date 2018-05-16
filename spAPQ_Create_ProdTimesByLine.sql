USE [TIJ]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'spAPQ_Create_ProdTimesByLine') AND TYPE in (N'P'))
    DROP PROCEDURE [dbo].[spAPQ_Create_ProdTimesByLine]
GO
CREATE PROCEDURE [dbo].[spAPQ_Create_ProdTimesByLine]
	  @IdRuntime	BIGINT
AS
BEGIN
	IF EXISTS(SELECT * FROM [dbo].[APQ_ProdTimesByLine] [ST] WHERE [ST].[IdRuntime] = @IdRuntime)
		DELETE FROM [dbo].[APQ_ProdTimesByLine] WHERE [IdRuntime] = @IdRuntime

	INSERT INTO [dbo].[APQ_ProdTimesByLine]
	SELECT
	 	  [CT].[IdRuntime]
		, [EQ].[Area]
		, [EQ].[Line]
		, SUM([CT].[Time])
	FROM
		[dbo].[APQ_ProdTimes] [CT]
		LEFT JOIN [dbo].[APQ_Equipment] [EQ] ON
			[EQ].[IdEquipment] = [CT].[IdEquipment]
	WHERE
		[CT].[IdRuntime] = @IdRuntime
	GROUP BY
		  [CT].[IdRuntime]
		, [EQ].[Area]
		, [EQ].[Line]
END
GO
