USE [TIJ]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'spAPQ_Create_EquipmentByLine') AND [TYPE] in (N'P'))
    DROP PROCEDURE [dbo].[spAPQ_Create_EquipmentByLine]
GO
CREATE PROCEDURE [dbo].[spAPQ_Create_EquipmentByLine]
	  @IdRuntime	BIGINT
AS
BEGIN
	IF EXISTS(SELECT * FROM [dbo].[APQ_EquipmentByLine] [EQ] WHERE [EQ].[IdRuntime] = @IdRuntime)
		DELETE FROM [dbo].[APQ_EquipmentByLine] WHERE [IdRuntime] = @IdRuntime

	INSERT INTO [dbo].[APQ_EquipmentByLine]
	SELECT
		  @IdRuntime
		, [EQ].[Area]
		, [EQ].[Line]
		, [EQ].[Power]
		, COUNT(*)
	FROM
		[dbo].[APQ_Equipment] [EQ]
	WHERE
		[EQ].[IdRuntime] = @IdRuntime
	GROUP BY
		  [EQ].[Area]
		, [EQ].[Line]
		, [EQ].[Power]
END
GO


