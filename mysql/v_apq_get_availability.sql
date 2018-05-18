drop view if exists `v_apq_get_availability`;
create view `v_apq_get_availability`
as
	select
			`ps`.`IdRuntime`
		  , `ps`.`PlannedProductionTime`						-- Workable time
		  , `ps`.`ScheduleLoss`									-- Off time
		  , `ps`.`PlannedStop`									-- Breaks
		  , `ps`.`TotalTime`
		  , `st`.`stoptime` / 60.0			AS `stoptime`		-- Equipment Stop Time
	from
		`v_apq_get_productionschedule` `ps`
		LEFT JOIN `v_apq_get_stops` `st` on
			`st`.`idruntime` = `ps`.`idruntime`;


