USE [TIJ]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'spAPQ_Create_AvailabilityByArea') AND TYPE in (N'P'))
    DROP PROCEDURE [dbo].[spAPQ_Create_AvailabilityByArea]
GO
CREATE    PROCEDURE [dbo].[spAPQ_Create_AvailabilityByArea]
	  @IdRuntime	BIGINT
AS
BEGIN
	IF EXISTS(SELECT * FROM [dbo].[APQ_AvailabilityByArea] [AS] WHERE [AS].[IdRuntime] = @IdRuntime)
		DELETE FROM [dbo].[APQ_AvailabilityByArea] WHERE [IdRuntime] = @IdRuntime

	INSERT INTO [dbo].[APQ_AvailabilityByArea]
	SELECT
		  [VL].[IdRuntime]
		, [QP].[Area]
		, [QP].[NumEquipments]
		, [VL].[Working] * [QP].[NumEquipments] AS [Working]
		, [VL].[Break] * [QP].[NumEquipments]	AS [Break]
		, [VL].[Off] * [QP].[NumEquipments]		AS [Off]
	FROM (
		SELECT
			  [AV].[IdRuntime]
			, SUM([AV].[Working])	AS [Working]
			, SUM([AV].[Break])		AS [Break]
			, SUM([AV].[Off])		AS [Off]
		FROM
			[dbo].[APQ_Availability] [AV]
		GROUP BY
			[AV].[IdRuntime]
	) [VL]
	INNER JOIN (
		SELECT
			  [EQ].[IdRuntime]
			, [EQ].[Area]
			, COUNT(*)				AS [NumEquipments]
		FROM
			[dbo].[APQ_Equipment] [EQ]
		GROUP BY
			  [EQ].[IdRuntime]
			, [EQ].[Area]
	) [QP] ON
		[QP].[IdRuntime] = [VL].[IdRuntime]
	WHERE
		[VL].[IdRuntime] = @IdRuntime
END
GO


