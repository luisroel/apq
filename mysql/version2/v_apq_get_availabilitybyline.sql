drop view if exists `v_apq_get_availabilitybyline`;
create view `v_apq_get_availabilitybyline`
as
	select
			`ps`.`idruntime`
		  , `ps`.`area`
		  , `ps`.`line`
		  , `ps`.`time_for_production`						-- Workable time
		  , `ps`.`schedule_loss`							-- Off time
		  , `ps`.`planned_stop`								-- Breaks
		  , `ps`.`total_time`
		  , ifnull(`st`.`stop_time`,0.0) as `stop_time`		-- Equipment Stop Time
	from
		`v_apq_get_productionschedulebyline` `ps`
		left join `v_apq_get_stopsbyline` `st` on
				`st`.`idruntime` 	= `ps`.`idruntime`
			and `st`.`area` 		= `ps`.`area`
			and `st`.`line` 		= `ps`.`line`;
