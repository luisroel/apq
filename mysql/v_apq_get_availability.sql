drop view if exists `v_apq_get_availability`;
create view `v_apq_get_availability`
as
	select
			`ps`.`idruntime`
		  , `ps`.`plannedproductiontime`						-- Workable time
		  , `ps`.`scheduleloss`									-- Off time
		  , `ps`.`plannedstop`									-- Breaks
		  , `ps`.`totaltime`
		  , `st`.`stoptime` / 60.0			as `stoptime`		-- Equipment Stop Time
	from
		`v_apq_get_productionschedule` `ps`
		left join `v_apq_get_stops` `st` on
			`st`.`idruntime` = `ps`.`idruntime`;
