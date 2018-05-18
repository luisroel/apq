USE [TIJ]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'spAPQ_Rpt_Availability') AND TYPE in (N'P'))
    DROP PROCEDURE [dbo].[spAPQ_Rpt_Availability]
GO
CREATE    PROCEDURE [dbo].[spAPQ_Rpt_Availability]
	    @IdRuntime		BIGINT
	  , @Area			INT
	  , @Line			INT
	  , @IdEquipment	VARCHAR(30)
AS
BEGIN
	SELECT
		*
	FROM 
		[dbo].[APQ_Availability] [AV]
		INNER JOIN [dbo].[APQ_Runtime] [RT] ON
			[RT].[IdRuntime] = [AV].[IdRuntime]
	WHERE 
		[AV].[IdRuntime] = @IdRuntime 
END
GO


