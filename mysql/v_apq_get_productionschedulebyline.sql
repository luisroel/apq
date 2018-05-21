drop view if exists `v_apq_get_productionschedulebyline`;
create view `v_apq_get_productionschedulebyline`
as
	select
		  `as`.`idruntime`
		, `as`.`area`
		, `as`.`line`
		, `as`.`plannedproductiontime`
		, `as`.`scheduleloss`
		, `as`.`plannedstop`
		, (`as`.`plannedproductiontime` + `as`.`scheduleloss` + `as`.`plannedstop`) as `totaltime`
	from
		`apq_availabilitybyline` `as`;
