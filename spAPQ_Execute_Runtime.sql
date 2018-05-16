USE [TIJ]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'spAPQ_Execute_Runtime') AND TYPE in (N'P'))
    DROP PROCEDURE [dbo].[spAPQ_Execute_Runtime]
GO
CREATE PROCEDURE [dbo].[spAPQ_Execute_Runtime]
	@CutOfDate	DATETIME
AS
BEGIN
	DECLARE @IdRuntime	BIGINT
	DECLARE @FromDate	DATETIME
	DECLARE @ToDate		DATETIME
	DECLARE @Period		INT

	SELECT
		@Period = [ST].[Period]
	FROM
		[dbo].[APQ_Settings] [ST]

	SELECT
		  @ToDate = @CutOfDate
		, @FromDate	= DATEADD(DAY, -1*@Period, @ToDate)

	INSERT INTO [dbo].[APQ_Runtime] ([From], [To], [Period]) VALUES( @FromDate, @ToDate, @Period)

	SELECT
		@IdRuntime = @@IDENTITY

	-- Raw data
	EXECUTE [dbo].[spAPQ_Create_Availability] @IdRuntime, @FromDate, @ToDate
	EXECUTE [dbo].[spAPQ_Create_Equipment] @IdRuntime
	EXECUTE [dbo].[spAPQ_Create_ProdTimes] @IdRuntime, @FromDate, @ToDate
	EXECUTE [dbo].[spAPQ_Create_Stops] @IdRuntime, @FromDate, @ToDate
	EXECUTE [dbo].[spAPQ_Create_Counts] @IdRuntime, @FromDate, @ToDate
	EXECUTE [dbo].[spAPQ_Create_SetupAndStart] @IdRuntime, @FromDate, @ToDate


	-- Summary
	EXECUTE [dbo].[spAPQ_Create_EquipmentSummary] @IdRuntime
	EXECUTE [dbo].[spAPQ_Create_AvailabilitySummary] @IdRuntime
	EXECUTE [dbo].[spAPQ_Create_ProdTimesSummary] @IdRuntime
	EXECUTE [dbo].[spAPQ_Create_StopsSummary] @IdRuntime
	EXECUTE [dbo].[spAPQ_Create_CountsSummary] @IdRuntime
	EXECUTE [dbo].[spAPQ_Create_SetupAndStartSummary] @IdRuntime

	-- By area
	EXECUTE [dbo].[spAPQ_Create_EquipmentByArea] @IdRuntime
	EXECUTE [dbo].[spAPQ_Create_AvailabilityByArea] @IdRuntime
	EXECUTE [dbo].[spAPQ_Create_ProdTimesByArea] @IdRuntime
	EXECUTE [dbo].[spAPQ_Create_StopsByArea] @IdRuntime
	EXECUTE [dbo].[spAPQ_Create_CountsByArea] @IdRuntime
	EXECUTE [dbo].[spAPQ_Create_SetupAndStartByArea] @IdRuntime

	-- By Line
	EXECUTE [dbo].[spAPQ_Create_EquipmentByLine] @IdRuntime
	EXECUTE [dbo].[spAPQ_Create_AvailabilityByLine] @IdRuntime
	EXECUTE [dbo].[spAPQ_Create_ProdTimesByLine] @IdRuntime
	EXECUTE [dbo].[spAPQ_Create_StopsByLine] @IdRuntime
	EXECUTE [dbo].[spAPQ_Create_CountsByLine] @IdRuntime
	EXECUTE [dbo].[spAPQ_Create_SetupAndStartByLine] @IdRuntime

	-- By Equipment
	EXECUTE [dbo].[spAPQ_Create_StopsByEquipment] @IdRuntime
	EXECUTE [dbo].[spAPQ_Create_CountsByEquipment] @IdRuntime
	EXECUTE [dbo].[spAPQ_Create_ProdTimesByEquipment] @IdRuntime
	EXECUTE [dbo].[spAPQ_Create_SetupAndStartByEquipment] @IdRuntime

END
GO


