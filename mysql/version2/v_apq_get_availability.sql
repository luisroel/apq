drop view if exists `v_apq_get_availability`;
create view `v_apq_get_availability`
as
	select
			`ps`.`idruntime`
		  , `ps`.`time_for_production`						-- Workable time
		  , `ps`.`schedule_loss`							-- Off time
		  , `ps`.`planned_stop`								-- Breaks
		  , `ps`.`total_time`
		  , ifnull(`st`.`stop_time`,0.0) as `stop_time`		-- Equipment Stop Time
	from
		`v_apq_get_productionschedule` `ps`
		left join `v_apq_get_stops` `st` on
			`st`.`idruntime` = `ps`.`idruntime`;
