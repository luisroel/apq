USE [TIJ]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'spAPQ_Create_StopsByEquipment') AND TYPE in (N'P'))
    DROP PROCEDURE [dbo].[spAPQ_Create_StopsByEquipment]
GO
CREATE PROCEDURE [dbo].[spAPQ_Create_StopsByEquipment]
	  @IdRuntime	BIGINT
AS
BEGIN
	IF EXISTS(SELECT * FROM [dbo].[APQ_StopsByEquipment] [ST] WHERE [ST].[IdRuntime] = @IdRuntime)
		DELETE FROM [dbo].[APQ_StopsByEquipment] WHERE [IdRuntime] = @IdRuntime

	INSERT INTO [dbo].[APQ_StopsByEquipment]
	SELECT
	 	  @IdRuntime
		, [EQ].[Area]
		, [EQ].[Line]
		, [EQ].[IdEquipment]
		, [SS].[Clasification]
		, SUM([SS].[Time])
	FROM
		[dbo].[APQ_Stops] [SS]
		INNER JOIN [dbo].[APQ_Equipment] [EQ] ON
			[EQ].[IdEquipment] = [SS].[IdEquipment]
	WHERE
		[SS].[IdRuntime] = @IdRuntime
	GROUP BY
		  [EQ].[Area]
		, [EQ].[Line]
		, [EQ].[IdEquipment]
		, [SS].[Clasification]
END
GO
