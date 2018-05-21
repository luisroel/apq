drop view if exists `v_apq_get_availabilitybyline`;
create view `v_apq_get_availabilitybyline`
as
	select
			`ps`.`idruntime`
		  , `ps`.`area`
		  , `ps`.`line`
		  , `ps`.`plannedproductiontime`												-- Workable time
		  , `ps`.`scheduleloss`															-- Off time
		  , `ps`.`plannedstop`															-- Breaks
		  , `ps`.`totaltime`
		  , ifnull(`st`.`stoptime`,0) / 60.0	as `stoptime`							-- Equipment Stop Time
	from
		`v_apq_get_productionschedulebyline` `ps`
		left join `v_apq_get_stopsbyline` `st` on
				`st`.`idruntime` 	= `ps`.`idruntime`
			and `st`.`area` 		= `ps`.`area`
			and `st`.`line` 		= `ps`.`line`;


