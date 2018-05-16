USE [TIJ]
GO
IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'APQ_Settings') AND TYPE in (N'U'))
    DROP TABLE [dbo].[APQ_Settings]
GO
CREATE TABLE [dbo].[APQ_Settings] (
	[Period]	INT			
)
GO

INSERT INTO [dbo].[APQ_Settings] ([Period] ) VALUES (30)
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'APQ_Runtime') AND TYPE in (N'U'))
    DROP TABLE [dbo].[APQ_Runtime]
GO
CREATE TABLE [dbo].[APQ_Runtime] (
	    [IdRuntime]	BIGINT IDENTITY
	  , [From]		DATETIME
	  , [To]		DATETIME
	  , [Period]	INT
)
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'APQ_DaysOff') AND TYPE in (N'U'))
    DROP TABLE [dbo].[APQ_DaysOff]
GO
CREATE TABLE [dbo].[APQ_DaysOff] (
	    [Date]			DATETIME
	  , [Description]	VARCHAR(100)
)
GO

INSERT INTO [dbo].[APQ_DaysOff] VALUES('1/1/2018', 'Plant shutdown')
GO
INSERT INTO [dbo].[APQ_DaysOff] VALUES('1/2/2018', 'Plant shutdown')
GO
INSERT INTO [dbo].[APQ_DaysOff] VALUES('2/5/2018', 'Constitution Day')
GO
INSERT INTO [dbo].[APQ_DaysOff] VALUES('3/31/2018', 'Holy Saturday')
GO
INSERT INTO [dbo].[APQ_DaysOff] VALUES('4/30/2018', 'Labor Day')
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'APQ_ScheduleTemplate') AND TYPE in (N'U'))
    DROP TABLE [dbo].[APQ_ScheduleTemplate]
GO
CREATE TABLE [dbo].[APQ_ScheduleTemplate] (
	  [DayOfWeek]	INT
	, [Working]		DECIMAL
	, [Break]		DECIMAL
	, [Off]			DECIMAL
)
GO

INSERT INTO [dbo].[APQ_ScheduleTemplate] ([DayOfWeek], [Working], [Off], [Break]) VALUES ( 1, 0, 0, 24)
GO
INSERT INTO [dbo].[APQ_ScheduleTemplate] ([DayOfWeek], [Working], [Off], [Break]) VALUES ( 2, 23, 1, 0)
GO
INSERT INTO [dbo].[APQ_ScheduleTemplate] ([DayOfWeek], [Working], [Off], [Break]) VALUES ( 3, 23, 1, 0)
GO
INSERT INTO [dbo].[APQ_ScheduleTemplate] ([DayOfWeek], [Working], [Off], [Break]) VALUES ( 4, 23, 1, 0)
GO
INSERT INTO [dbo].[APQ_ScheduleTemplate] ([DayOfWeek], [Working], [Off], [Break]) VALUES ( 5, 23, 1, 0)
GO
INSERT INTO [dbo].[APQ_ScheduleTemplate] ([DayOfWeek], [Working], [Off], [Break]) VALUES ( 6, 23, 1, 0)
GO
INSERT INTO [dbo].[APQ_ScheduleTemplate] ([DayOfWeek], [Working], [Off], [Break]) VALUES ( 7, 23, 1, 0)
GO
INSERT INTO [dbo].[APQ_ScheduleTemplate] ([DayOfWeek], [Working], [Off], [Break]) VALUES ( 8, 14, 0, 10)
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'APQ_Availability') AND TYPE in (N'U'))
    DROP TABLE [dbo].[APQ_Availability]
GO
CREATE TABLE [dbo].[APQ_Availability] (
	  [IdRuntime]	BIGINT
	, [Date]		DATETIME
	, [DayOfWeek]	INT
	, [Working]		DECIMAL
	, [Break]		DECIMAL
	, [Off]			DECIMAL
)
GO

-- Raw data
IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'APQ_Equipment') AND TYPE in (N'U'))
    DROP TABLE [dbo].[APQ_Equipment]
GO
CREATE TABLE [dbo].[APQ_Equipment] (
	  [IdRuntime]	BIGINT
	, [IdEquipment]	VARCHAR(20)
	, [Power]		INT
	, [Area]		INT
	, [Line]		INT
)
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'APQ_Stops') AND TYPE in (N'U'))
    DROP TABLE [dbo].[APQ_Stops]
GO
CREATE TABLE [dbo].[APQ_Stops] (
	  [IdRuntime]		BIGINT
	, [IdEquipment]		VARCHAR(20)
	, [Date]			DATETIME
	, [IdParo]			VARCHAR(10)
	, [TipoParo]		VARCHAR(100)
	, [Clasification]	VARCHAR(50)
	, [Time]			DECIMAL
)
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'APQ_ProdTimes') AND TYPE in (N'U'))
    DROP TABLE [dbo].[APQ_ProdTimes]
GO
CREATE TABLE [dbo].[APQ_ProdTimes] (
	  [IdRuntime]		BIGINT
	, [WorkOrder]		VARCHAR(20)
	, [IdEquipment]		VARCHAR(20)
	, [StarTime]		DATETIME
	, [EndTime]			DATETIME
	, [Time]			DECIMAL
)
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'APQ_Counts') AND TYPE in (N'U'))
    DROP TABLE [dbo].[APQ_Counts]
GO
CREATE TABLE [dbo].[APQ_Counts] (
	  [IdRuntime]		BIGINT
	, [ItemId]			VARCHAR(35)
	, [IdEquipment]		VARCHAR(20)
	, [Date]			DATETIME
	, [CycleTime]		DECIMAL
	, [GoodCount]		DECIMAL
	, [BadCount]		DECIMAL
	, [TotalCount]		DECIMAL
	, [GoodTime]		DECIMAL
	, [LossTime]		DECIMAL
	, [TotalTime]		DECIMAL
)
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'APQ_SetupAndStart') AND TYPE in (N'U'))
    DROP TABLE [dbo].[APQ_SetupAndStart]
GO
CREATE TABLE [dbo].[APQ_SetupAndStart] (
	  [IdRuntime]		BIGINT
	, [Workorder]		VARCHAR(35)
	, [IdEquipment]		VARCHAR(20)
	, [Date]			DATETIME
	, [IdUSM]			VARCHAR(15)
	, [StdSetupTime]	DECIMAL
	, [StdStartTime]	DECIMAL
)
GO

-- Summary
IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'APQ_AvailabilitySummary') AND TYPE in (N'U'))
    DROP TABLE [dbo].[APQ_AvailabilitySummary]
GO
CREATE TABLE [dbo].[APQ_AvailabilitySummary] (
	  [IdRuntime]				BIGINT
	, [PlannedProductionTime]	DECIMAL
	, [PlannedStop]				DECIMAL
	, [ScheduleLoss]			DECIMAL
)
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'APQ_EquipmentSummary') AND TYPE in (N'U'))
    DROP TABLE [dbo].[APQ_EquipmentSummary]
GO
CREATE TABLE [dbo].[APQ_EquipmentSummary] (
	  [IdRuntime]	BIGINT
	, [Power]		DECIMAL
	, [Total]		DECIMAL
)
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'APQ_ProdTimesSummary') AND TYPE in (N'U'))
    DROP TABLE [dbo].[APQ_ProdTimesSummary]
GO
CREATE TABLE [dbo].[APQ_ProdTimesSummary] (
	  [IdRuntime]		BIGINT
	, [Time]			DECIMAL
)
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'APQ_StopsSummary') AND TYPE in (N'U'))
    DROP TABLE [dbo].[APQ_StopsSummary]
GO
CREATE TABLE [dbo].[APQ_StopsSummary] (
	  [IdRuntime]		BIGINT
	, [Clasification]	VARCHAR(50)
	, [Time]			DECIMAL
)
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'APQ_CountsSummary') AND TYPE in (N'U'))
    DROP TABLE [dbo].[APQ_CountsSummary]
GO
CREATE TABLE [dbo].[APQ_CountsSummary] (
	  [IdRuntime]		BIGINT
	, [GoodCount]		DECIMAL
	, [BadCount]		DECIMAL
	, [TotalCount]		DECIMAL
	, [GoodTime]		DECIMAL
	, [LossTime]		DECIMAL
	, [TotalTime]		DECIMAL
)
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'APQ_SetupAndStartSummary') AND TYPE in (N'U'))
    DROP TABLE [dbo].[APQ_SetupAndStartSummary]
GO
CREATE TABLE [dbo].[APQ_SetupAndStartSummary] (
	  [IdRuntime]		BIGINT
	, [StdSetupTime]	DECIMAL
	, [StdStartTime]	DECIMAL
)
GO

-- BY AREA
IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'APQ_AvailabilityByArea') AND TYPE in (N'U'))
    DROP TABLE [dbo].[APQ_AvailabilityByArea]
GO
CREATE TABLE [dbo].[APQ_AvailabilityByArea] (
	  [IdRuntime]				BIGINT
	, [Area]					INT
	, [NumEquipments]			DECIMAL
	, [PlannedProductionTime]	DECIMAL
	, [PlannedStop]				DECIMAL
	, [ScheduleLoss]			DECIMAL
)
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'APQ_EquipmentByArea') AND TYPE in (N'U'))
    DROP TABLE [dbo].[APQ_EquipmentByArea]
GO
CREATE TABLE [dbo].[APQ_EquipmentByArea] (
	  [IdRuntime]	BIGINT
	, [Area]		INT
	, [Power]		DECIMAL
	, [Total]		DECIMAL
)
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'APQ_ProdTimesByArea') AND TYPE in (N'U'))
    DROP TABLE [dbo].[APQ_ProdTimesByArea]
GO
CREATE TABLE [dbo].[APQ_ProdTimesByArea] (
	  [IdRuntime]		BIGINT
	, [Area]			INT
	, [Time]			DECIMAL
)
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'APQ_StopsByArea') AND TYPE in (N'U'))
    DROP TABLE [dbo].[APQ_StopsByArea]
GO
CREATE TABLE [dbo].[APQ_StopsByArea] (
	  [IdRuntime]		BIGINT
	, [Area]			INT
	, [Clasification]	VARCHAR(50)
	, [Time]			DECIMAL
)
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'APQ_CountsByArea') AND TYPE in (N'U'))
    DROP TABLE [dbo].[APQ_CountsByArea]
GO
CREATE TABLE [dbo].[APQ_CountsByArea] (
	  [IdRuntime]		BIGINT
	, [Area]			INT
	, [GoodCount]		DECIMAL
	, [BadCount]		DECIMAL
	, [TotalCount]		DECIMAL
	, [GoodTime]	DECIMAL
	, [LossTime]		DECIMAL
	, [TotalTime]		DECIMAL
)
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'APQ_SetupAndStartByArea') AND TYPE in (N'U'))
    DROP TABLE [dbo].[APQ_SetupAndStartByArea]
GO
CREATE TABLE [dbo].[APQ_SetupAndStartByArea] (
	  [IdRuntime]		BIGINT
	, [Area]			INT
	, [StdSetupTime]	DECIMAL
	, [StdStartTime]	DECIMAL
)
GO

-- BY LINE
IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'APQ_AvailabilityByLine') AND TYPE in (N'U'))
    DROP TABLE [dbo].[APQ_AvailabilityByLine]
GO
CREATE TABLE [dbo].[APQ_AvailabilityByLine] (
	  [IdRuntime]				BIGINT
	, [Area]					INT
	, [Line]					INT
	, [NumEquipments]			INT
	, [PlannedProductionTime]	DECIMAL
	, [PlannedStop]				DECIMAL
	, [ScheduleLoss]			DECIMAL
)
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'APQ_EquipmentByLine') AND TYPE in (N'U'))
    DROP TABLE [dbo].[APQ_EquipmentByLine]
GO
CREATE TABLE [dbo].[APQ_EquipmentByLine] (
	  [IdRuntime]	BIGINT
	, [Area]		INT
	, [Line]		INT
	, [Power]		DECIMAL
	, [Total]		DECIMAL
)
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'APQ_ProdTimesByLine') AND TYPE in (N'U'))
    DROP TABLE [dbo].[APQ_ProdTimesByLine]
GO
CREATE TABLE [dbo].[APQ_ProdTimesByLine] (
	  [IdRuntime]		BIGINT
	, [Area]			INT
	, [Line]			INT
	, [Time]			DECIMAL
)
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'APQ_StopsByLine') AND TYPE in (N'U'))
    DROP TABLE [dbo].[APQ_StopsByLine]
GO
CREATE TABLE [dbo].[APQ_StopsByLine] (
	  [IdRuntime]		BIGINT
	, [Area]			INT
	, [Line]			INT
	, [Clasification]	VARCHAR(50)
	, [Time]			DECIMAL
)
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'APQ_CountsByLine') AND TYPE in (N'U'))
    DROP TABLE [dbo].[APQ_CountsByLine]
GO
CREATE TABLE [dbo].[APQ_CountsByLine] (
	  [IdRuntime]		BIGINT
	, [Area]			INT
	, [Line]			INT
	, [GoodCount]		DECIMAL
	, [BadCount]		DECIMAL
	, [TotalCount]		DECIMAL
	, [GoodTime]		DECIMAL
	, [LossTime]		DECIMAL
	, [TotalTime]		DECIMAL
)
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'APQ_SetupAndStartByLine') AND TYPE in (N'U'))
    DROP TABLE [dbo].[APQ_SetupAndStartByLine]
GO
CREATE TABLE [dbo].[APQ_SetupAndStartByLine] (
	  [IdRuntime]		BIGINT
	, [Area]			INT
	, [Line]			INT
	, [StdSetupTime]	DECIMAL
	, [StdStartTime]	DECIMAL
)
GO

-- BY EQUIPMENT
IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'APQ_AvailabilityByEquipment') AND TYPE in (N'U'))
    DROP TABLE [dbo].[APQ_AvailabilityByEquipment]
GO
CREATE TABLE [dbo].[APQ_AvailabilityByEquipment] (
	  [IdRuntime]				BIGINT
	, [IdEquipment]				VARCHAR(20)
	, [PlannedProductionTime]	DECIMAL
	, [ScheduleLoss]			DECIMAL
	, [PlannedStop]				DECIMAL
)
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'APQ_ProdTimesByEquipment') AND TYPE in (N'U'))
    DROP TABLE [dbo].[APQ_ProdTimesByEquipment]
GO
CREATE TABLE [dbo].[APQ_ProdTimesByEquipment] (
	  [IdRuntime]		BIGINT
	, [Area]			INT
	, [Line]			INT
	, [IdEquipment]		VARCHAR(20)
	, [Time]			DECIMAL
)
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'APQ_StopsByEquipment') AND TYPE in (N'U'))
    DROP TABLE [dbo].[APQ_StopsByEquipment]
GO
CREATE TABLE [dbo].[APQ_StopsByEquipment] (
	  [IdRuntime]		BIGINT
	, [Area]			INT
	, [Line]			INT
	, [IdEquipment]		VARCHAR(20)
	, [Clasification]	VARCHAR(50)
	, [Time]			DECIMAL
)
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'APQ_CountsByEquipment') AND TYPE in (N'U'))
    DROP TABLE [dbo].[APQ_CountsByEquipment]
GO
CREATE TABLE [dbo].[APQ_CountsByEquipment] (
	  [IdRuntime]		BIGINT
	, [Area]			INT
	, [Line]			INT
	, [IdEquipment]		VARCHAR(20)
	, [GoodCount]		DECIMAL
	, [BadCount]		DECIMAL
	, [TotalCount]		DECIMAL
	, [GoodTime]		DECIMAL
	, [LossTime]		DECIMAL
	, [TotalTime]		DECIMAL
)
GO

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE object_id = OBJECT_ID(N'APQ_SetupAndStartByEquipment') AND TYPE in (N'U'))
    DROP TABLE [dbo].[APQ_SetupAndStartByEquipment]
GO
CREATE TABLE [dbo].[APQ_SetupAndStartByEquipment] (
	  [IdRuntime]		BIGINT
	, [Area]			INT
	, [Line]			INT
	, [IdEquipment]		VARCHAR(20)
	, [StdSetupTime]	DECIMAL
	, [StdStartTime]	DECIMAL
)
GO

