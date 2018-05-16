USE [TIJ]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'spAPQ_Rpt_APQByEquipment') AND TYPE in (N'P'))
    DROP PROCEDURE [dbo].[spAPQ_Rpt_APQByEquipment]
GO
CREATE PROCEDURE [dbo].[spAPQ_Rpt_APQByEquipment]
	  @IdRuntime	BIGINT
	, @Area			INT
	, @Line			INT
	, @IdEquipment	VARCHAR(20)
AS
BEGIN
	IF @IdRuntime = -1
		IF @Area = 0
			IF @Line = 0				
				IF @IdEquipment = '' OR @IdEquipment = '%'		-- ALL
					SELECT
						*
					FROM
						[dbo].[v_APQ_Get_IndexByEquipment] [ND]
						INNER JOIN [dbo].[v_APQ_Get_DataChartByEquipment] [DC] ON
								[DC].[IdRuntime]	= [ND].[IdRuntime]
							AND [DC].[Area]			= [ND].[Area]
							AND [DC].[Line]			= [ND].[Line]
							AND [DC].[IdEquipment]	= [ND].[IdEquipment]
					WHERE
						[ND].[IdRuntime] IN (
							SELECT TOP 1 [IdRuntime] FROM [dbo].[APQ_Runtime] ORDER BY [IdRuntime] DESC
						)
					ORDER BY
						  [DC].[Area]
						, [DC].[Line]
						, [DC].[IdEquipment]
						, [DC].[Title]
						, [DC].[Pos]
				ELSE					-- @IdRuntime = -1, @Area = 0,  @Line = 0, @IdEquipment <> 0
					SELECT
						*
					FROM
						[dbo].[v_APQ_Get_IndexByEquipment] [ND]
						INNER JOIN [dbo].[v_APQ_Get_DataChartByEquipment] [DC] ON
								[DC].[IdRuntime]	= [ND].[IdRuntime]
							AND [DC].[Area]			= [ND].[Area]
							AND [DC].[Line]			= [ND].[Line]
							AND [DC].[IdEquipment]	= [ND].[IdEquipment]
					WHERE
						[ND].[IdRuntime] IN (
							SELECT TOP 1 [IdRuntime] FROM [dbo].[APQ_Runtime] ORDER BY [IdRuntime] DESC
						)
						AND [ND].[IdEquipment] = @IdEquipment
					ORDER BY
						  [DC].[Area]
						, [DC].[Line]
						, [DC].[IdEquipment]
						, [DC].[Title]
						, [DC].[Pos]
			ELSE IF @IdEquipment = '' OR @IdEquipment = '%'	-- @IdRuntime = -1, @Area = 0,  @Line <> 0, @IdEquipment = 0
				SELECT
					*
				FROM
					[dbo].[v_APQ_Get_IndexByEquipment] [ND]
					INNER JOIN [dbo].[v_APQ_Get_DataChartByEquipment] [DC] ON
							[DC].[IdRuntime]	= [ND].[IdRuntime]
						AND [DC].[Area]			= [ND].[Area]
						AND [DC].[Line]			= [ND].[Line]
						AND [DC].[IdEquipment]	= [ND].[IdEquipment]
				WHERE
					[ND].[IdRuntime] IN (
						SELECT TOP 1 [IdRuntime] FROM [dbo].[APQ_Runtime] ORDER BY [IdRuntime] DESC
					)
					AND [ND].[Line] = @Line
				ORDER BY
						[DC].[Area]
					, [DC].[Line]
					, [DC].[IdEquipment]
					, [DC].[Title]
					, [DC].[Pos]
			ELSE						-- @IdRuntime = -1, @Area = 0,  @Line <> 0, @IdEquipment <> 0
				SELECT
					*
				FROM
					[dbo].[v_APQ_Get_IndexByEquipment] [ND]
					INNER JOIN [dbo].[v_APQ_Get_DataChartByEquipment] [DC] ON
							[DC].[IdRuntime]	= [ND].[IdRuntime]
						AND [DC].[Area]			= [ND].[Area]
						AND [DC].[Line]			= [ND].[Line]
						AND [DC].[IdEquipment]	= [ND].[IdEquipment]
				WHERE
					[ND].[IdRuntime] IN (
						SELECT TOP 1 [IdRuntime] FROM [dbo].[APQ_Runtime] ORDER BY [IdRuntime] DESC
					)
					AND [ND].[Line]			= @Line
					AND [ND].[IdEquipment]	= @IdEquipment
				ORDER BY
					  [DC].[Area]
					, [DC].[Line]
					, [DC].[IdEquipment]
					, [DC].[Title]
					, [DC].[Pos]
		ELSE IF @Line = 0
			IF @IdEquipment = '' OR @IdEquipment = '%'			-- @IdRuntime = -1, @Area <> 0,  @Line = 0, @IdEquipment = 0
				SELECT
					*
				FROM
					[dbo].[v_APQ_Get_IndexByEquipment] [ND]
					INNER JOIN [dbo].[v_APQ_Get_DataChartByEquipment] [DC] ON
							[DC].[IdRuntime]	= [ND].[IdRuntime]
						AND [DC].[Area]			= [ND].[Area]
						AND [DC].[Line]			= [ND].[Line]
						AND [DC].[IdEquipment]	= [ND].[IdEquipment]
				WHERE
					[ND].[IdRuntime] IN (
						SELECT TOP 1 [IdRuntime] FROM [dbo].[APQ_Runtime] ORDER BY [IdRuntime] DESC
					)
					AND [ND].[Area]	= @Area
				ORDER BY
					  [DC].[Area]
					, [DC].[Line]
					, [DC].[IdEquipment]
					, [DC].[Title]
					, [DC].[Pos]
			ELSE						-- @IdRuntime = -1, @Area <> 0,  @Line = 0, @IdEquipment <> 0
				SELECT
					*
				FROM
					[dbo].[v_APQ_Get_IndexByEquipment] [ND]
					INNER JOIN [dbo].[v_APQ_Get_DataChartByEquipment] [DC] ON
							[DC].[IdRuntime]	= [ND].[IdRuntime]
						AND [DC].[Area]			= [ND].[Area]
						AND [DC].[Line]			= [ND].[Line]
						AND [DC].[IdEquipment]	= [ND].[IdEquipment]
				WHERE
					[ND].[IdRuntime] IN (
						SELECT TOP 1 [IdRuntime] FROM [dbo].[APQ_Runtime] ORDER BY [IdRuntime] DESC
					)
					AND [ND].[Area]			= @Area
					AND [ND].[IdEquipment]	= @IdEquipment
				ORDER BY
					  [DC].[Area]
					, [DC].[Line]
					, [DC].[IdEquipment]
					, [DC].[Title]
					, [DC].[Pos]
		ELSE IF @IdEquipment = '' OR @IdEquipment = '%'		-- @IdRuntime = -1, @Area <> 0,  @Line <> 0, @IdEquipment = 0
			SELECT
				*
			FROM
				[dbo].[v_APQ_Get_IndexByEquipment] [ND]
				INNER JOIN [dbo].[v_APQ_Get_DataChartByEquipment] [DC] ON
						[DC].[IdRuntime]	= [ND].[IdRuntime]
					AND [DC].[Area]			= [ND].[Area]
					AND [DC].[Line]			= [ND].[Line]
					AND [DC].[IdEquipment]	= [ND].[IdEquipment]
			WHERE
				[ND].[IdRuntime] IN (
					SELECT TOP 1 [IdRuntime] FROM [dbo].[APQ_Runtime] ORDER BY [IdRuntime] DESC
				)
				AND [ND].[Area]	= @Area
				AND [ND].[Line]	= @Line
			ORDER BY
					[DC].[Area]
				, [DC].[Line]
				, [DC].[IdEquipment]
				, [DC].[Title]
				, [DC].[Pos]
		ELSE							-- @IdRuntime = -1, @Area <> 0,  @Line <> 0, @IdEquipment <> 0
			SELECT
				*
			FROM
				[dbo].[v_APQ_Get_IndexByEquipment] [ND]
				INNER JOIN [dbo].[v_APQ_Get_DataChartByEquipment] [DC] ON
						[DC].[IdRuntime]	= [ND].[IdRuntime]
					AND [DC].[Area]			= [ND].[Area]
					AND [DC].[Line]			= [ND].[Line]
					AND [DC].[IdEquipment]	= [ND].[IdEquipment]
			WHERE
				[ND].[IdRuntime] IN (
					SELECT TOP 1 [IdRuntime] FROM [dbo].[APQ_Runtime] ORDER BY [IdRuntime] DESC
				)
				AND [ND].[Area]			= @Area
				AND [ND].[Line]			= @Line
				AND [ND].[IdEquipment]	= @IdEquipment
			ORDER BY
				  [DC].[Area]
				, [DC].[Line]
				, [DC].[IdEquipment]
				, [DC].[Title]
				, [DC].[Pos]
	ELSE IF @Area = 0
		IF @Line = 0
			IF @IdEquipment = '' OR @IdEquipment = '%'			-- @IdRuntime <> -1, @Area = 0,  @Line = 0, @IdEquipment = 0
				SELECT
					*
				FROM
					[dbo].[v_APQ_Get_IndexByEquipment] [ND]
					INNER JOIN [dbo].[v_APQ_Get_DataChartByEquipment] [DC] ON
							[DC].[IdRuntime]	= [ND].[IdRuntime]
						AND [DC].[Area]			= [ND].[Area]
						AND [DC].[Line]			= [ND].[Line]
						AND [DC].[IdEquipment]	= [ND].[IdEquipment]
				WHERE
					[ND].[IdRuntime]	= @IdRuntime
				ORDER BY
					  [DC].[Area]
					, [DC].[Line]
					, [DC].[IdEquipment]
					, [DC].[Title]
					, [DC].[Pos]
			ELSE						-- @IdRuntime <> -1, @Area = 0,  @Line = 0, @IdEquipment <> 0
				SELECT
					*
				FROM
					[dbo].[v_APQ_Get_IndexByEquipment] [ND]
					INNER JOIN [dbo].[v_APQ_Get_DataChartByEquipment] [DC] ON
							[DC].[IdRuntime]	= [ND].[IdRuntime]
						AND [DC].[Area]			= [ND].[Area]
						AND [DC].[Line]			= [ND].[Line]
						AND [DC].[IdEquipment]	= [ND].[IdEquipment]
				WHERE
						[ND].[IdRuntime]	= @IdRuntime
					AND [ND].[IdEquipment]	= @IdEquipment
				ORDER BY
					  [DC].[Area]
					, [DC].[Line]
					, [DC].[IdEquipment]
					, [DC].[Title]
					, [DC].[Pos]
		ELSE IF @IdEquipment = '' OR @IdEquipment = '%'		-- @IdRuntime <> -1, @Area = 0,  @Line <> 0, @IdEquipment = 0
			SELECT
				*
			FROM
				[dbo].[v_APQ_Get_IndexByEquipment] [ND]
				INNER JOIN [dbo].[v_APQ_Get_DataChartByEquipment] [DC] ON
						[DC].[IdRuntime]	= [ND].[IdRuntime]
					AND [DC].[Area]			= [ND].[Area]
					AND [DC].[Line]			= [ND].[Line]
					AND [DC].[IdEquipment]	= [ND].[IdEquipment]
			WHERE
					[ND].[IdRuntime]	= @IdRuntime
				AND [ND].[Line]			= @Line
			ORDER BY
					[DC].[Area]
				, [DC].[Line]
				, [DC].[IdEquipment]
				, [DC].[Title]
				, [DC].[Pos]
		ELSE							-- @IdRuntime <> -1, @Area = 0,  @Line <> 0, @IdEquipment <> 0
			SELECT
				*
			FROM
				[dbo].[v_APQ_Get_IndexByEquipment] [ND]
				INNER JOIN [dbo].[v_APQ_Get_DataChartByEquipment] [DC] ON
						[DC].[IdRuntime]	= [ND].[IdRuntime]
					AND [DC].[Area]			= [ND].[Area]
					AND [DC].[Line]			= [ND].[Line]
					AND [DC].[IdEquipment]	= [ND].[IdEquipment]
			WHERE
					[ND].[IdRuntime]	= @IdRuntime
				AND [ND].[Line]			= @Line
				AND [ND].[IdEquipment]	= @IdEquipment
			ORDER BY
				  [DC].[Area]
				, [DC].[Line]
				, [DC].[IdEquipment]
				, [DC].[Title]
				, [DC].[Pos]
	ELSE IF @Line = 0					
		IF @IdEquipment = '' OR @IdEquipment = '%'			-- @IdRuntime <> -1, @Area <> 0,  @Line = 0, @IdEquipment = 0
			SELECT
				*
			FROM
				[dbo].[v_APQ_Get_IndexByEquipment] [ND]
				INNER JOIN [dbo].[v_APQ_Get_DataChartByEquipment] [DC] ON
						[DC].[IdRuntime]	= [ND].[IdRuntime]
					AND [DC].[Area]			= [ND].[Area]
					AND [DC].[Line]			= [ND].[Line]
					AND [DC].[IdEquipment]	= [ND].[IdEquipment]
			WHERE
					[ND].[IdRuntime]	= @IdRuntime
				AND [ND].[Area]			= @Area
			ORDER BY
				  [DC].[Area]
				, [DC].[Line]
				, [DC].[IdEquipment]
				, [DC].[Title]
				, [DC].[Pos]
		ELSE							-- @IdRuntime <> -1, @Area <> 0,  @Line = 0, @IdEquipment <> 0
			SELECT
				*
			FROM
				[dbo].[v_APQ_Get_IndexByEquipment] [ND]
				INNER JOIN [dbo].[v_APQ_Get_DataChartByEquipment] [DC] ON
						[DC].[IdRuntime]	= [ND].[IdRuntime]
					AND [DC].[Area]			= [ND].[Area]
					AND [DC].[Line]			= [ND].[Line]
					AND [DC].[IdEquipment]	= [ND].[IdEquipment]
			WHERE
					[ND].[IdRuntime]	= @IdRuntime
				AND [ND].[Area]			= @Area
				AND [ND].[IdEquipment]	= @IdEquipment
			ORDER BY
				  [DC].[Area]
				, [DC].[Line]
				, [DC].[IdEquipment]
				, [DC].[Title]
				, [DC].[Pos]
	ELSE IF @IdEquipment = '' OR @IdEquipment = '%'			-- @IdRuntime <> -1, @Area <> 0,  @Line <> 0, @IdEquipment = 0
		SELECT
			*
		FROM
			[dbo].[v_APQ_Get_IndexByEquipment] [ND]
			INNER JOIN [dbo].[v_APQ_Get_DataChartByEquipment] [DC] ON
					[DC].[IdRuntime]	= [ND].[IdRuntime]
				AND [DC].[Area]			= [ND].[Area]
				AND [DC].[Line]			= [ND].[Line]
				AND [DC].[IdEquipment]	= [ND].[IdEquipment]
		WHERE
				[ND].[IdRuntime]	= @IdRuntime
			AND [ND].[Area]			= @Area
			AND [ND].[Line]			= @Line
		ORDER BY
				[DC].[Area]
			, [DC].[Line]
			, [DC].[IdEquipment]
			, [DC].[Title]
			, [DC].[Pos]
	ELSE								-- @IdRuntime <> -1, @Area <> 0,  @Line <> 0, @IdEquipment <> 0
		SELECT
			*
		FROM
			[dbo].[v_APQ_Get_IndexByEquipment] [ND]
			INNER JOIN [dbo].[v_APQ_Get_DataChartByEquipment] [DC] ON
					[DC].[IdRuntime]	= [ND].[IdRuntime]
				AND [DC].[Area]			= [ND].[Area]
				AND [DC].[Line]			= [ND].[Line]
				AND [DC].[IdEquipment]	= [ND].[IdEquipment]
		WHERE
				[ND].[IdRuntime]	= @IdRuntime
			AND [ND].[Area]			= @Area
			AND [ND].[Line]			= @Line
			AND [ND].[IdEquipment]	= @IdEquipment
		ORDER BY
			  [DC].[Area]
			, [DC].[Line]
			, [DC].[IdEquipment]
			, [DC].[Title]
			, [DC].[Pos]
END
GO


