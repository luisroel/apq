USE [TIJ]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'spAPQ_Create_AvailabilityByLine') AND [TYPE] in (N'P'))
    DROP PROCEDURE [dbo].[spAPQ_Create_AvailabilityByLine]
GO
CREATE PROCEDURE [dbo].[spAPQ_Create_AvailabilityByLine]
	  @IdRuntime	BIGINT
AS
BEGIN
	IF EXISTS(SELECT * FROM [dbo].[APQ_AvailabilityByLine] [AS] WHERE [AS].[IdRuntime] = @IdRuntime)
		DELETE FROM [dbo].[APQ_AvailabilityByLine] WHERE [IdRuntime] = @IdRuntime

	INSERT INTO [dbo].[APQ_AvailabilityByLine]
	SELECT
		  [VL].[IdRuntime]
		, [QP].[Area]
		, [QP].[Line]
		, [QP].[NumEquipments]
		, [VL].[Working] * [QP].[NumEquipments] AS [Working]
		, [VL].[Break] * [QP].[NumEquipments]	AS [Break]
		, [VL].[Off] * [QP].[NumEquipments]		AS [Off]
	FROM (
		SELECT
			  [EQ].[IdRuntime]
			, [EQ].[Area]
			, [EQ].[Line]
			, COUNT(*)				AS [NumEquipments]
		FROM
			[dbo].[APQ_Equipment] [EQ]
		GROUP BY
			  [EQ].[IdRuntime]
			, [EQ].[Area]
			, [EQ].[Line]
	) [QP]
	LEFT JOIN (
		SELECT
			  [AV].[IdRuntime]
			, SUM([AV].[Working])	AS [Working]
			, SUM([AV].[Break])		AS [Break]
			, SUM([AV].[Off])		AS [Off]
		FROM
			[dbo].[APQ_Availability] [AV]
		GROUP BY
			[AV].[IdRuntime]
	) [VL] ON
		[VL].[IdRuntime] = [QP].[IdRuntime]
	WHERE
		[VL].[IdRuntime] = @IdRuntime
END
GO


