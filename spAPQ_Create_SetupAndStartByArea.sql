USE [TIJ]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'spAPQ_Create_SetupAndStartByArea') AND TYPE in (N'P'))
    DROP PROCEDURE [dbo].[spAPQ_Create_SetupAndStartByArea]
GO
CREATE PROCEDURE [dbo].[spAPQ_Create_SetupAndStartByArea]
	  @IdRuntime	BIGINT
AS
BEGIN
	IF EXISTS(SELECT * FROM [dbo].[APQ_SetupAndStartByArea] [ST] WHERE [ST].[IdRuntime] = @IdRuntime)
		DELETE FROM [dbo].[APQ_SetupAndStartByArea] WHERE [IdRuntime] = @IdRuntime

	INSERT INTO [dbo].[APQ_SetupAndStartByArea]
	SELECT
		  @IdRuntime
		, [EQ].[Area]
		, SUM([SS].[StdSetupTime]) AS [StdSetupTime]
		, SUM([SS].[StdStartTime]) AS [StdStartTime]
	FROM
		[dbo].[APQ_SetupAndStart] [SS]
		INNER JOIN [dbo].[APQ_Equipment] [EQ] ON
			[EQ].[IdEquipment] = [SS].[IdEquipment]
	WHERE
		[SS].[IdRuntime] = @IdRuntime
	GROUP BY
		[EQ].[Area]
END
GO
