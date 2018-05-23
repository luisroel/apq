USE [TIJ]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'spAPQ_Create_Availability') AND TYPE in (N'P'))
    DROP PROCEDURE [dbo].[spAPQ_Create_Availability]
GO
CREATE    PROCEDURE [dbo].[spAPQ_Create_Availability]
	  @IdRuntime	BIGINT
	, @FromDate		DATETIME
	, @ToDate		DATETIME
AS
BEGIN
	DECLARE @CurrentDate DATETIME
	DECLARE @DayOfWeek	INT
	DECLARE @Working	DECIMAL
	DECLARE @Off		DECIMAL
	DECLARE @Break		DECIMAL

	SELECT
		@CurrentDate = @FromDate

	WHILE @CurrentDate <= @ToDate
	BEGIN
		SELECT
			@DayOfWeek = DATEPART(WEEKDAY, @CurrentDate)

		IF EXISTS(SELECT * FROM [dbo].[APQ_ScheduleTemplate] [ST] WHERE [ST].[DayOfWeek] = @DayOfWeek)
			SELECT
				  @Working	= [ST].[Working]
				, @Off		= [ST].[Off]
				, @Break	= [ST].[Break]
			FROM
				[dbo].[APQ_ScheduleTemplate] [ST]
			WHERE 
				[ST].[DayOfWeek] = @DayOfWeek
		ELSE
			SELECT
				  @Working	= 0
				, @Off		= 0
				, @Break	= 0

		INSERT INTO [dbo].[APQ_Availability] ([IdRuntime], [Date], [DayOfWeek], [Working], [Off], [Break]) VALUES (@IdRuntime, @CurrentDate, @DayOfWeek, @Working, @Break, @Off)

		SELECT
			@CurrentDate = DATEADD(DAY, 1, @CurrentDate)
	END
END
GO


