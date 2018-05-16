USE [TIJ]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'spAPQ_Rpt_APQ') AND TYPE in (N'P'))
    DROP PROCEDURE [dbo].[spAPQ_Rpt_APQ]
GO
CREATE PROCEDURE [dbo].[spAPQ_Rpt_APQ]
		@IdRuntime	BIGINT
AS
BEGIN
	IF @IdRuntime = -1			-- Latest run
		SELECT
			*
		FROM
			[dbo].[v_APQ_Get_Index] [ND]
			INNER JOIN [dbo].[v_APQ_Get_DataChart] [DC] ON
					[DC].[IdRuntime]	= [ND].[IdRuntime]
		WHERE
			[ND].[IdRuntime] IN (
				SELECT TOP 1 [IdRuntime] FROM [dbo].[APQ_Runtime] ORDER BY [IdRuntime] DESC
			)
		ORDER BY
			  [DC].[Title]
			, [DC].[Pos]
	ELSE
		SELECT
			*
		FROM
			[dbo].[v_APQ_Get_Index] [ND]
			INNER JOIN [dbo].[v_APQ_Get_DataChart] [DC] ON
					[DC].[IdRuntime]	= [ND].[IdRuntime]
		WHERE
			[ND].[IdRuntime] = @IdRuntime
		ORDER BY
			  [DC].[Title]
			, [DC].[Pos]
END
GO


