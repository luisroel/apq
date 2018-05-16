USE [TIJ]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'spAPQ_Create_Equipment') AND TYPE in (N'P'))
    DROP PROCEDURE [dbo].[spAPQ_Create_Equipment]
GO
CREATE    PROCEDURE [dbo].[spAPQ_Create_Equipment]
	  @IdRuntime	BIGINT
AS
BEGIN
	IF EXISTS(SELECT * FROM [dbo].[APQ_Equipment] [EQ] WHERE [EQ].[IdRuntime] = @IdRuntime)
		DELETE FROM [dbo].[APQ_Equipment] WHERE [IdRuntime] = @IdRuntime

	INSERT INTO [dbo].[APQ_Equipment]
	SELECT
		  @IdRuntime
		, [M2].[Maquina]
		, CAST([M2].[PoderMaq] AS INT)
		, [M2].[Area]
		, [M2].[Linea]
	FROM
		[MACHINES02] [M2]
	WHERE
		[M2].[Estatus] <> 'E'
END
GO


