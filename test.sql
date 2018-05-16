
EXECUTE [dbo].[spAPQ_Execute_Runtime] '5/1/2017 00:00'
EXECUTE [dbo].[spAPQ_Execute_Runtime] '5/1/2018 01:00'
EXECUTE [dbo].[spAPQ_Execute_Runtime] '5/1/2018 02:00'
EXECUTE [dbo].[spAPQ_Execute_Runtime] '5/1/2018 03:00'
EXECUTE [dbo].[spAPQ_Execute_Runtime] '5/1/2018 04:00'
EXECUTE [dbo].[spAPQ_Execute_Runtime] '5/1/2018 05:00'
EXECUTE [dbo].[spAPQ_Execute_Runtime] '5/1/2018 06:00'
EXECUTE [dbo].[spAPQ_Execute_Runtime] '5/1/2018 07:00'
EXECUTE [dbo].[spAPQ_Execute_Runtime] '5/1/2018 08:00'
EXECUTE [dbo].[spAPQ_Execute_Runtime] '5/1/2018 09:00'
EXECUTE [dbo].[spAPQ_Execute_Runtime] '5/1/2018 10:00'
EXECUTE [dbo].[spAPQ_Execute_Runtime] '5/1/2018 11:00'
EXECUTE [dbo].[spAPQ_Execute_Runtime] '5/1/2018 12:00'
EXECUTE [dbo].[spAPQ_Execute_Runtime] '5/1/2018 13:00'
EXECUTE [dbo].[spAPQ_Execute_Runtime] '5/1/2018 14:00'
EXECUTE [dbo].[spAPQ_Execute_Runtime] '5/1/2018 15:00'
EXECUTE [dbo].[spAPQ_Execute_Runtime] '5/1/2018 16:00'
EXECUTE [dbo].[spAPQ_Execute_Runtime] '5/1/2018 17:00'
EXECUTE [dbo].[spAPQ_Execute_Runtime] '5/1/2018 18:00'
EXECUTE [dbo].[spAPQ_Execute_Runtime] '5/1/2018 19:00'
EXECUTE [dbo].[spAPQ_Execute_Runtime] '5/1/2018 20:00'
EXECUTE [dbo].[spAPQ_Execute_Runtime] '5/1/2018 21:00'
EXECUTE [dbo].[spAPQ_Execute_Runtime] '5/1/2018 22:00'
EXECUTE [dbo].[spAPQ_Execute_Runtime] '5/1/2018 23:00'

-- Settings (Config)
SELECT * FROM [dbo].[APQ_Settings]
SELECT * FROM [dbo].[APQ_Runtime]
SELECT * FROM [dbo].[APQ_Availability]
SELECT * FROM [dbo].[APQ_Equipment]

-- Raw Data
SELECT * FROM [dbo].[APQ_Stops]
SELECT * FROM [dbo].[APQ_Counts]
SELECT * FROM [dbo].[APQ_SetupAndStart]
SELECT * FROM [dbo].[APQ_ProdTimes]

-- Data Summary
SELECT * FROM [dbo].[APQ_AvailabilitySummary]
SELECT * FROM [dbo].[APQ_EquipmentSummary]
SELECT * FROM [dbo].[APQ_StopsSummary]
SELECT * FROM [dbo].[APQ_CountsSummary]
SELECT * FROM [dbo].[APQ_SetupAndStartSummary]
SELECT * FROM [dbo].[APQ_ProdTimesSummary]

-- Summary Indexes
SELECT * FROM [dbo].[v_APQ_Get_ProductionSchedule]
SELECT * FROM [dbo].[v_APQ_Get_Stops]

SELECT * FROM [dbo].[v_APQ_Get_Counts]
SELECT * FROM [dbo].[v_APQ_Get_Availability]
SELECT * FROM [dbo].[v_APQ_Get_Index]
SELECT * FROM [dbo].[v_APQ_Get_DataChart] ORDER BY [IdRuntime], [Title]

SELECT
	*
FROM
	[dbo].[v_APQ_Get_Index] [ND]
	INNER JOIN [dbo].[v_APQ_Get_DataChart] [DC] ON
		[DC].[IdRuntime] = [ND].[IdRuntime]
WHERE
	[ND].[IdRuntime] IN (
		SELECT TOP 1 [IdRuntime] [RT] FROM [dbo].[APQ_Runtime] [RT] ORDER BY [RT].[IdRuntime] DESC
	)
ORDER BY
	[DC].[Title]

-- Data By Area 
SELECT * FROM [dbo].[APQ_AvailabilityByArea]
SELECT * FROM [dbo].[APQ_EquipmentByArea]
SELECT * FROM [dbo].[APQ_StopsByArea]
SELECT * FROM [dbo].[APQ_CountsByArea]
SELECT * FROM [dbo].[APQ_SetupAndStartByArea]
SELECT * FROM [dbo].[APQ_ProdTimesByArea]

-- Indexes By Area
SELECT * FROM [dbo].[v_APQ_Get_ProductionScheduleByArea]
SELECT * FROM [dbo].[v_APQ_Get_StopsByArea]

SELECT * FROM [dbo].[v_APQ_Get_CountsByArea]
SELECT * FROM [dbo].[v_APQ_Get_AvailabilityByArea]
SELECT * FROM [dbo].[v_APQ_Get_IndexByArea]
SELECT * FROM [dbo].[v_APQ_Get_DataChartByArea] ORDER BY [IdRuntime], [Area], [Title]

EXEC [dbo].[spAPQ_Rpt_APQByArea] -1, 0
EXEC [dbo].[spAPQ_Rpt_APQByArea] -1, 2
EXEC [dbo].[spAPQ_Rpt_APQByArea] 1, 0
EXEC [dbo].[spAPQ_Rpt_APQByArea] 1, 2


-- Data By Line 
SELECT * FROM [dbo].[APQ_AvailabilityByLine]
SELECT * FROM [dbo].[APQ_EquipmentByLine]
SELECT * FROM [dbo].[APQ_StopsByLine]
SELECT * FROM [dbo].[APQ_CountsByLine]
SELECT * FROM [dbo].[APQ_SetupAndStartByLine]
SELECT * FROM [dbo].[APQ_ProdTimesByLine]

-- Indexes By Line
SELECT * FROM [dbo].[v_APQ_Get_ProductionScheduleByLine]
SELECT * FROM [dbo].[v_APQ_Get_StopsByLine]

SELECT * FROM [dbo].[v_APQ_Get_CountsByLine]
SELECT * FROM [dbo].[v_APQ_Get_AvailabilityByLine]
SELECT * FROM [dbo].[v_APQ_Get_IndexByLine]
SELECT * FROM [dbo].[v_APQ_Get_DataChartByLine]  ORDER BY [IdRuntime], [Area], [Line], [Title]

EXEC [dbo].[spAPQ_Rpt_APQByLine] -1, 0
EXEC [dbo].[spAPQ_Rpt_APQByLine] -1, 2
EXEC [dbo].[spAPQ_Rpt_APQByLine] 1, 0
EXEC [dbo].[spAPQ_Rpt_APQByLine] 1, 2

-- Data By Equipment
SELECT * FROM [dbo].[APQ_StopsByEquipment]
SELECT * FROM [dbo].[APQ_CountsByEquipment]
SELECT * FROM [dbo].[APQ_SetupAndStartByEquipment]
SELECT * FROM [dbo].[APQ_ProdTimesByEquipment]

-- Indexes By Equipment
SELECT * FROM [dbo].[v_APQ_Get_ProductionScheduleByEquipment]
SELECT * FROM [dbo].[v_APQ_Get_StopsByEquipment]

SELECT * FROM [dbo].[v_APQ_Get_CountsByEquipment]
SELECT * FROM [dbo].[v_APQ_Get_AvailabilityByEquipment]
SELECT * FROM [dbo].[v_APQ_Get_IndexByEquipment]
SELECT * FROM [dbo].[v_APQ_Get_DataChartByEquipment]  ORDER BY [IdRuntime], [Area], [Line], [IdEquipment], [Title]

EXEC [dbo].[spAPQ_Rpt_APQByEquipment] -1, ''
EXEC [dbo].[spAPQ_Rpt_APQByEquipment] -1, 'TOYO-14 30T'
EXEC [dbo].[spAPQ_Rpt_APQByEquipment] 1, ''
EXEC [dbo].[spAPQ_Rpt_APQByEquipment] 1, 'TOYO-14 30T'


-- Additionals
SELECT
	  YEAR([CM].[FechaCambio])		AS [Year]
	, MONTH([CM].[FechaCambio])		AS [Month]
	, COUNT(*)						AS [Running with No Info]
FROM
	[dbo].[CAMBIOMOLDE] [CM]
	LEFT JOIN [MOLDAT03] [M3] ON
		[M3].[WO] = [CM].[IdCambioMolde]
WHERE
		[CM].[Estatus] = 'A'
	AND [CM].[fechacambio] < '5/1/2018'
	AND [M3].[HrIniCambio] IS NULL
GROUP BY
	  YEAR([CM].[FechaCambio])
	, MONTH([CM].[FechaCambio])
ORDER BY
	  YEAR([CM].[FechaCambio])
	, MONTH([CM].[FechaCambio])

SELECT
	  [CM].[fechacambio]
	, [CM].[IdCambioMolde]
	, [M3].[HrIniCambio]
	, [M3].[HrFinCambio]
	, [M3].[HrIniMaq]
	, [M3].[HrIniProd]
	, [CM].[FechaParo]
	, DATEDIFF(MINUTE, [M3].[HrIniProd], [CM].[FechaParo])	AS [Minutes]
FROM
	[dbo].[CAMBIOMOLDE] [CM]
	LEFT JOIN [MOLDAT03] [M3] ON
		[M3].[WO] = [CM].[IdCambioMolde]
WHERE
		[CM].[Estatus]	= 'A'
	AND [CM].[FechaCambio] BETWEEN '1/1/2018' AND '1/31/2018'


SELECT [RT].[IdRuntime] AS [Value], CONCAT(FORMAT([RT].[From], 'MM/dd/yyyy'), ' - ', FORMAT([RT].[To], 'MM/dd/yyyy')) AS [Title] FROM [dbo].[APQ_Runtime] [RT]
EXEC [dbo].[spAPQ_Rpt_Counts] 1, 