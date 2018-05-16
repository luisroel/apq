USE [TIJ]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'spAPQ_Create_CountsByEquipment') AND TYPE in (N'P'))
    DROP PROCEDURE [dbo].[spAPQ_Create_CountsByEquipment]
GO
CREATE PROCEDURE [dbo].[spAPQ_Create_CountsByEquipment]
	  @IdRuntime	BIGINT
AS
BEGIN
	IF EXISTS(SELECT * FROM [dbo].[APQ_CountsByEquipment] [ST] WHERE [ST].[IdRuntime] = @IdRuntime)
		DELETE FROM [dbo].[APQ_CountsByEquipment] WHERE [IdRuntime] = @IdRuntime

	INSERT INTO [dbo].[APQ_CountsByEquipment]
	SELECT
	 	  @IdRuntime
		, [EQ].[Area]
		, [EQ].[Line]
		, [EQ].[IdEquipment]
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
		, [EQ].[Line]
		, [EQ].[IdEquipment]
END
GO
