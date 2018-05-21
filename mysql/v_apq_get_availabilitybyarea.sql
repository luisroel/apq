drop view if exists `v_apq_get_availabilitybyarea`;
create view `v_apq_get_availabilitybyarea`
as
	select
			`ps`.`idruntime`
		  , `ps`.`plannedproductiontime`			-- Workable time
		  , `ps`.`area`
		  , `ps`.`scheduleloss`						-- Off time
		  , `ps`.`plannedstop`						-- Breaks
		  , `ps`.`totaltime`
		  , `st`.`stoptime`	/ 60.0				as `stopTime`	-- Equipment Stop Time
	from
		`v_apq_get_productionschedulebyarea` `ps`
		left join `v_apq_get_stopsbyarea` `st` on
				`st`.`idruntime` 	= `ps`.`idruntime`
			and `st`.`area` 		= `ps`.`area`;


