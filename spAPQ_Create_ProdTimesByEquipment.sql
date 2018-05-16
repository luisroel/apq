USE [TIJ]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'spAPQ_Create_ProdTimesByEquipment') AND TYPE in (N'P'))
    DROP PROCEDURE [dbo].[spAPQ_Create_ProdTimesByEquipment]
GO
CREATE PROCEDURE [dbo].[spAPQ_Create_ProdTimesByEquipment]
	  @IdRuntime	BIGINT
AS
BEGIN
	IF EXISTS(SELECT * FROM [dbo].[APQ_ProdTimesByEquipment] [ST] WHERE [ST].[IdRuntime] = @IdRuntime)
		DELETE FROM [dbo].[APQ_ProdTimesByEquipment] WHERE [IdRuntime] = @IdRuntime

	INSERT INTO [dbo].[APQ_ProdTimesByEquipment]
	SELECT
	 	  [CT].[IdRuntime]
		, [EQ].[Area]
		, [EQ].[Line]
		, [EQ].[IdEquipment]
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
		, [EQ].[IdEquipment]
END
GO
