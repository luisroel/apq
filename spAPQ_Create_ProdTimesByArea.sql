USE [TIJ]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'spAPQ_Create_ProdTimesByArea') AND TYPE in (N'P'))
    DROP PROCEDURE [dbo].[spAPQ_Create_ProdTimesByArea]
GO
CREATE PROCEDURE [dbo].[spAPQ_Create_ProdTimesByArea]
	  @IdRuntime	BIGINT
AS
BEGIN
	IF EXISTS(SELECT * FROM [dbo].[APQ_ProdTimesByArea] [ST] WHERE [ST].[IdRuntime] = @IdRuntime)
		DELETE FROM [dbo].[APQ_ProdTimesByArea] WHERE [IdRuntime] = @IdRuntime

	INSERT INTO [dbo].[APQ_ProdTimesByArea]
	SELECT
	 	  [CT].[IdRuntime]
		, [EQ].[Area]
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
END
GO
