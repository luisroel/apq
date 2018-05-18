USE [TIJ]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'spAPQ_Rpt_APQByArea') AND TYPE in (N'P'))
    DROP PROCEDURE [dbo].[spAPQ_Rpt_APQByArea]
GO
CREATE PROCEDURE [dbo].[spAPQ_Rpt_APQByArea]
		@IdRuntime		BIGINT
	,	@Area			INT
AS
BEGIN
	IF @IdRuntime = -1			-- Latest run
		IF @Area = 0
			SELECT
				*
			FROM
				[dbo].[v_APQ_Get_IndexByArea] [ND]
				INNER JOIN [dbo].[v_APQ_Get_DataChartByArea] [DC] ON
						[DC].[IdRuntime]	= [ND].[IdRuntime]
					AND [DC].[Area]			= [ND].[Area]
			WHERE
				[ND].[IdRuntime] IN (
					SELECT TOP 1 [IdRuntime] FROM [dbo].[APQ_Runtime] ORDER BY [IdRuntime] DESC
				)
			ORDER BY
				  [DC].[Area]
				, [DC].[Title]
				, [DC].[Pos]
		ELSE
			SELECT
				*
			FROM
				[dbo].[v_APQ_Get_IndexByArea] [ND]
				INNER JOIN [dbo].[v_APQ_Get_DataChartByArea] [DC] ON
						[DC].[IdRuntime]	= [ND].[IdRuntime]
					AND [DC].[Area]			= [ND].[Area]
			WHERE
					[ND].[IdRuntime] IN (
						SELECT TOP 1 [IdRuntime] FROM [dbo].[APQ_Runtime] ORDER BY [IdRuntime] DESC
					)
				AND [ND].[Area]	= @Area
			ORDER BY
				  [DC].[Area]
				, [DC].[Title]
				, [DC].[Pos]			
	ELSE IF @Area = 0
		SELECT
			*
		FROM
			[dbo].[v_APQ_Get_IndexByArea] [ND]
			INNER JOIN [dbo].[v_APQ_Get_DataChartByArea] [DC] ON
					[DC].[IdRuntime]	= [ND].[IdRuntime]
				AND [DC].[Area]			= [ND].[Area]
		WHERE
			[ND].[IdRuntime] = @IdRuntime
		ORDER BY
			  [DC].[Area]
			, [DC].[Title]
			, [DC].[Pos]
	ELSE
		SELECT
			*
		FROM
			[dbo].[v_APQ_Get_IndexByArea] [ND]
			INNER JOIN [dbo].[v_APQ_Get_DataChartByArea] [DC] ON
					[DC].[IdRuntime]	= [ND].[IdRuntime]
				AND [DC].[Area]			= [ND].[Area]
		WHERE
				[ND].[IdRuntime]	= @IdRuntime
			AND [ND].[Area]			= @Area
		ORDER BY
			  [DC].[Area]
			, [DC].[Title]
			, [DC].[Pos]
END
GO


