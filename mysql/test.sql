
EXECUTE `spapq_execute_runtime` '5/1/2017 00:00'
EXECUTE `spapq_execute_runtime` '5/1/2018 01:00'
EXECUTE `spapq_execute_runtime` '5/1/2018 02:00'
EXECUTE `spapq_execute_runtime` '5/1/2018 03:00'
EXECUTE `spapq_execute_runtime` '5/1/2018 04:00'
EXECUTE `spapq_execute_runtime` '5/1/2018 05:00'
EXECUTE `spapq_execute_runtime` '5/1/2018 06:00'
EXECUTE `spapq_execute_runtime` '5/1/2018 07:00'
EXECUTE `spapq_execute_runtime` '5/1/2018 08:00'
EXECUTE `spapq_execute_runtime` '5/1/2018 09:00'
EXECUTE `spapq_execute_runtime` '5/1/2018 10:00'
EXECUTE `spapq_execute_runtime` '5/1/2018 11:00'
EXECUTE `spapq_execute_runtime` '5/1/2018 12:00'
EXECUTE `spapq_execute_runtime` '5/1/2018 13:00'
EXECUTE `spapq_execute_runtime` '5/1/2018 14:00'
EXECUTE `spapq_execute_runtime` '5/1/2018 15:00'
EXECUTE `spapq_execute_runtime` '5/1/2018 16:00'
EXECUTE `spapq_execute_runtime` '5/1/2018 17:00'
EXECUTE `spapq_execute_runtime` '5/1/2018 18:00'
EXECUTE `spapq_execute_runtime` '5/1/2018 19:00'
EXECUTE `spapq_execute_runtime` '5/1/2018 20:00'
EXECUTE `spapq_execute_runtime` '5/1/2018 21:00'
EXECUTE `spapq_execute_runtime` '5/1/2018 22:00'
EXECUTE `spapq_execute_runtime` '5/1/2018 23:00'

-- Settings (Config)
select * from `apq_settings`
select * from `apq_runtime`
select * from `apq_availability`
select * from `apq_equipment`

-- Raw Data
select * from `apq_stops`
select * from `apq_counts`
select * from `apq_setupandstart`
select * from `apq_prodtimes`

-- Data Summary
select * from `apq_availabilitysummary`
select * from `apq_equipmentsummary`
select * from `apq_stopssummary`
select * from `apq_countssummary`
select * from `apq_setupandstartsummary`
select * from `apq_prodtimessummary`

-- Summary Indexes
select * from `v_apq_get_productionSchedule`
select * from `v_apq_get_stops`

select * from `v_apq_get_counts`
select * from `v_apq_get_availability`
select * from `v_apq_get_index`
select * from `v_apq_get_datachart` order by `idruntime`, `title`

select
	*
from
	`v_apq_get_index` `nd`
	inner join `v_apq_get_datachart` `dc` on
		`dc`.`idruntime` = `nd`.`idruntime`
WHERE
	`nd`.`idruntime` in (
		select max(`rt`.`idruntime`) from `apq_runtime` `rt`
	)
order by
	`dc`.`title`

-- Data By Area 
select * from `apq_AvailabilityByArea`
select * from `apq_EquipmentByArea`
select * from `apq_StopsByArea`
select * from `apq_CountsByArea`
select * from `apq_SetupAndStartByArea`
select * from `apq_ProdTimesByArea`

-- Indexes By Area
select * from `v_apq_get_ProductionScheduleByArea`
select * from `v_apq_get_StopsByArea`

select * from `v_apq_get_CountsByArea`
select * from `v_apq_get_AvailabilityByArea`
select * from `v_apq_get_IndexByArea`
select * from `v_apq_get_DataChartByArea` ORDER BY [IdRuntime`, [Area`, [Title`

EXEC `spapq_Rpt_apqByArea` -1, 0
EXEC `spapq_Rpt_apqByArea` -1, 2
EXEC `spapq_Rpt_apqByArea` 1, 0
EXEC `spapq_Rpt_apqByArea` 1, 2


-- Data By Line 
select * from `apq_AvailabilityByLine`
select * from `apq_EquipmentByLine`
select * from `apq_StopsByLine`
select * from `apq_CountsByLine`
select * from `apq_SetupAndStartByLine`
select * from `apq_ProdTimesByLine`

-- Indexes By Line
select * from `v_apq_get_ProductionScheduleByLine`
select * from `v_apq_get_StopsByLine`

select * from `v_apq_get_CountsByLine`
select * from `v_apq_get_AvailabilityByLine`
select * from `v_apq_get_IndexByLine`
select * from `v_apq_get_DataChartByLine`  ORDER BY [IdRuntime`, [Area`, [Line`, [Title`

EXEC `spapq_Rpt_apqByLine` -1, 0
EXEC `spapq_Rpt_apqByLine` -1, 2
EXEC `spapq_Rpt_apqByLine` 1, 0
EXEC `spapq_Rpt_apqByLine` 1, 2

-- Data By Equipment
select * from `apq_StopsByEquipment`
select * from `apq_CountsByEquipment`
select * from `apq_SetupAndStartByEquipment`
select * from `apq_ProdTimesByEquipment`

-- Indexes By Equipment
select * from `v_apq_get_ProductionScheduleByEquipment`
select * from `v_apq_get_StopsByEquipment`

select * from `v_apq_get_CountsByEquipment`
select * from `v_apq_get_AvailabilityByEquipment`
select * from `v_apq_get_IndexByEquipment`
select * from `v_apq_get_DataChartByEquipment`  ORDER BY [IdRuntime`, [Area`, [Line`, [IdEquipment`, [Title`

EXEC `spapq_Rpt_apqByEquipment` -1, ''
EXEC `spapq_Rpt_apqByEquipment` -1, 'TOYO-14 30T'
EXEC `spapq_Rpt_apqByEquipment` 1, ''
EXEC `spapq_Rpt_apqByEquipment` 1, 'TOYO-14 30T'


-- Additionals
select
	  YEAR([CM`.[FechaCambio`)		AS [Year`
	, MONTH([CM`.[FechaCambio`)		AS [Month`
	, COUNT(*)						AS [Running with No Info`
from
	`CAMBIOMOLDE` [CM`
	LEFT JOIN [MOLDAT03` [M3` ON
		[M3`.[WO` = [CM`.[IdCambioMolde`
WHERE
		[CM`.[Estatus` = 'A'
	AND [CM`.[fechacambio` < '5/1/2018'
	AND [M3`.[HrIniCambio` IS NULL
GROUP BY
	  YEAR([CM`.[FechaCambio`)
	, MONTH([CM`.[FechaCambio`)
ORDER BY
	  YEAR([CM`.[FechaCambio`)
	, MONTH([CM`.[FechaCambio`)

select
	  [CM`.[fechacambio`
	, [CM`.[IdCambioMolde`
	, [M3`.[HrIniCambio`
	, [M3`.[HrFinCambio`
	, [M3`.[HrIniMaq`
	, [M3`.[HrIniProd`
	, [CM`.[FechaParo`
	, DATEDIFF(MINUTE, [M3`.[HrIniProd`, [CM`.[FechaParo`)	AS [Minutes`
from
	`CAMBIOMOLDE` [CM`
	LEFT JOIN [MOLDAT03` [M3` ON
		[M3`.[WO` = [CM`.[IdCambioMolde`
WHERE
		[CM`.[Estatus`	= 'A'
	AND [CM`.[FechaCambio` BETWEEN '1/1/2018' AND '1/31/2018'


select [RT`.[IdRuntime` AS [Value`, CONCAT(FORMAT([RT`.[from`, 'MM/dd/yyyy'), ' - ', FORMAT([RT`.[To`, 'MM/dd/yyyy')) AS [Title` from `apq_Runtime` [RT`
EXEC `spapq_Rpt_Counts` 1, 