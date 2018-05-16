USE [TIJ]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'spAPQ_Create_EquipmentByArea') AND TYPE in (N'P'))
    DROP PROCEDURE [dbo].[spAPQ_Create_EquipmentByArea]
GO
CREATE PROCEDURE [dbo].[spAPQ_Create_EquipmentByArea]
	  @IdRuntime	BIGINT
AS
BEGIN
	IF EXISTS(SELECT * FROM [dbo].[APQ_EquipmentByArea] [EQ] WHERE [EQ].[IdRuntime] = @IdRuntime)
		DELETE FROM [dbo].[APQ_EquipmentByArea] WHERE [IdRuntime] = @IdRuntime

	INSERT INTO [dbo].[APQ_EquipmentByArea]
	SELECT
		  @IdRuntime
		, [EQ].[Area]
		, [EQ].[Power]
		, COUNT(*)
	FROM
		[dbo].[APQ_Equipment] [EQ]
	WHERE
		[EQ].[IdRuntime] = @IdRuntime
	GROUP BY
		  [EQ].[Area]
		, [EQ].[Power]
END
GO


