USE [TIJ]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'spAPQ_Create_EquipmentSummary') AND TYPE in (N'P'))
    DROP PROCEDURE [dbo].[spAPQ_Create_EquipmentSummary]
GO
CREATE PROCEDURE [dbo].[spAPQ_Create_EquipmentSummary]
	  @IdRuntime	BIGINT
AS
BEGIN
	IF EXISTS(SELECT * FROM [dbo].[APQ_EquipmentSummary] [EQ] WHERE [EQ].[IdRuntime] = @IdRuntime)
		DELETE FROM [dbo].[APQ_EquipmentSummary] WHERE [IdRuntime] = @IdRuntime

	INSERT INTO [dbo].[APQ_EquipmentSummary]
	SELECT
		  @IdRuntime
		, [EQ].[Power]
		, COUNT(*)
	FROM
		[dbo].[APQ_Equipment] [EQ]
	WHERE
		[EQ].[IdRuntime] = @IdRuntime
	GROUP BY
		[EQ].[Power]
END
GO


