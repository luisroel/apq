drop view if exists `v_apq_get_availabilitybyarea`;
create view `v_apq_get_availabilitybyarea`
as
	select
			`ps`.`idruntime`
		  , `ps`.`area`
		  , `ps`.`time_for_production`						-- Workable time
		  , `ps`.`schedule_loss`							-- Off time
		  , `ps`.`planned_stop`								-- Breaks
		  , `ps`.`total_time`
		  , ifnull(`st`.`stop_time`,0.0) as `stop_time`		-- Equipment Stop Time
	from
		`v_apq_get_productionschedulebyarea` `ps`
		left join `v_apq_get_stopsbyarea` `st` on
				`st`.`idruntime` 	= `ps`.`idruntime`
			and `st`.`area` 		= `ps`.`area`;
