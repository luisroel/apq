USE [TIJ]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'spAPQ_Create_AvailabilitySummary') AND TYPE in (N'P'))
    DROP PROCEDURE [dbo].[spAPQ_Create_AvailabilitySummary]
GO
CREATE    PROCEDURE [dbo].[spAPQ_Create_AvailabilitySummary]
	  @IdRuntime	BIGINT
AS
BEGIN
	IF EXISTS(SELECT * FROM [dbo].[APQ_AvailabilitySummary] [AS] WHERE [AS].[IdRuntime] = @IdRuntime)
		DELETE FROM [dbo].[APQ_AvailabilitySummary] WHERE [IdRuntime] = @IdRuntime

	DECLARE @NumEquipment INT

	SELECT
		@NumEquipment = COUNT(*)
	FROM
		[dbo].[APQ_Equipment] [EQ]
	WHERE
		[EQ].[IdRuntime] = @IdRuntime

	INSERT INTO [dbo].[APQ_AvailabilitySummary]
	SELECT
		  [AV].[IdRuntime]
		, SUM([AV].[Working]) * @NumEquipment
		, SUM([AV].[Off])  * @NumEquipment
		, SUM([AV].[Break]) * @NumEquipment
	FROM
		[dbo].[APQ_Availability] [AV]
	WHERE
		[AV].[IdRuntime] = @IdRuntime
	GROUP BY
		[AV].[IdRuntime]
END
GO


