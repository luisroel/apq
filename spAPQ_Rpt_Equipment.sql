USE [TIJ]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'spAPQ_Rpt_Equipment') AND TYPE in (N'P'))
    DROP PROCEDURE [dbo].[spAPQ_Rpt_Equipment]
GO
CREATE    PROCEDURE [dbo].[spAPQ_Rpt_Equipment]
	    @IdRuntime		BIGINT
	  , @Area			INT
	  , @Line			INT
	  , @IdEquipment	VARCHAR(30)
AS
BEGIN
	IF @Area = 0
		IF @Line = 0
			IF @IdEquipment = '' OR @IdEquipment = '%'
				SELECT
					*
				FROM
					[dbo].[APQ_Equipment] [AV]
					INNER JOIN [dbo].[APQ_Runtime] [RT] ON
						[RT].[IdRuntime] = [AV].[IdRuntime]
				WHERE
					[AV].[IdRuntime] = @IdRuntime
			ELSE
				SELECT
					*
				FROM
					[dbo].[APQ_Equipment] [AV]
					INNER JOIN [dbo].[APQ_Runtime] [RT] ON
						[RT].[IdRuntime] = [AV].[IdRuntime]
				WHERE
						[AV].[IdRuntime]	= @IdRuntime
					AND [AV].[IdEquipment]	= @IdEquipment
		ELSE IF @IdEquipment = '' OR @IdEquipment = '%'
			SELECT
				*
			FROM
				[dbo].[APQ_Equipment] [AV]
				INNER JOIN [dbo].[APQ_Runtime] [RT] ON
					[RT].[IdRuntime] = [AV].[IdRuntime]
			WHERE
					[AV].[IdRuntime]	= @IdRuntime
				AND [AV].[Line]			= @Line
		ELSE
			SELECT
				*
			FROM
				[dbo].[APQ_Equipment] [AV]
				INNER JOIN [dbo].[APQ_Runtime] [RT] ON
					[RT].[IdRuntime] = [AV].[IdRuntime]
			WHERE
					[AV].[IdRuntime]	= @IdRuntime
				AND [AV].[Line]			= @Line
				AND [AV].[IdEquipment]	= @IdEquipment
	ELSE IF @Line = 0
		IF @IdEquipment = '' OR @IdEquipment = '%'
			SELECT
				*
			FROM
				[dbo].[APQ_Equipment] [AV]
				INNER JOIN [dbo].[APQ_Runtime] [RT] ON
					[RT].[IdRuntime] = [AV].[IdRuntime]
			WHERE
					[AV].[IdRuntime]	= @IdRuntime
				AND [AV].[Area]			= @Area
		ELSE
			SELECT
				*
			FROM
				[dbo].[APQ_Equipment] [AV]
				INNER JOIN [dbo].[APQ_Runtime] [RT] ON
					[RT].[IdRuntime] = [AV].[IdRuntime]
			WHERE
					[AV].[IdRuntime]	= @IdRuntime
				AND [AV].[Area]			= @Area
				AND [AV].[IdEquipment]	= @IdEquipment
	ELSE IF @IdEquipment = '' OR @IdEquipment = '%'
		SELECT
			*
		FROM
			[dbo].[APQ_Equipment] [AV]
			INNER JOIN [dbo].[APQ_Runtime] [RT] ON
				[RT].[IdRuntime] = [AV].[IdRuntime]
		WHERE
				[AV].[IdRuntime]	= @IdRuntime
			AND [AV].[Area]			= @Area
			AND [AV].[Line]			= @Line
	ELSE
		SELECT
			*
		FROM
			[dbo].[APQ_Equipment] [AV]
			INNER JOIN [dbo].[APQ_Runtime] [RT] ON
				[RT].[IdRuntime] = [AV].[IdRuntime]
		WHERE
				[AV].[IdRuntime]	= @IdRuntime
			AND [AV].[Area]			= @Area
			AND [AV].[Line]			= @Line
			AND [AV].[IdEquipment]	= @IdEquipment
END
GO
