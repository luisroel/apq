drop view if exists `v_apq_get_productionschedulebyline`;
create view `v_apq_get_productionschedulebyline`
as
	select
		  `as`.`idruntime`
		, `as`.`area`
		, `as`.`line`
		, `as`.`plannedproductiontime` 												as `time_for_production`
		, `as`.`plannedstop`														as `planned_stop`
		, `as`.`scheduleloss`														as `schedule_loss`
		, (`as`.`plannedproductiontime` + `as`.`scheduleloss` + `as`.`plannedstop`) as `total_time`
	from
		`apq_availabilitybyline` `as`;

