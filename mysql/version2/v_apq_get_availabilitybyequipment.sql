drop view if exists `v_apq_get_availabilitybyequipment`;
create view `v_apq_get_availabilitybyequipment`
as
	select
			`ps`.`idruntime`
		  , `ps`.`area`
		  , `ps`.`line`
		  , `ps`.`idequipment`
		  , `ps`.`time_for_production`						-- Workable time
		  , `ps`.`schedule_loss`							-- Off time
		  , `ps`.`planned_stop`								-- Breaks
		  , `ps`.`total_time`
		  , ifnull(`st`.`stop_time`,0.0) as `stop_time`		-- Equipment Stop Time
	from
		`v_apq_get_productionschedulebyequipment` `ps`
		left join `v_apq_get_stopsbyequipment` `st` on
				`st`.`idruntime` 	= `ps`.`idruntime`
			and `st`.`area` 		= `ps`.`area`
			and `st`.`line` 		= `ps`.`line`
			and `st`.`idequipment` 	= `ps`.`idequipment`;
