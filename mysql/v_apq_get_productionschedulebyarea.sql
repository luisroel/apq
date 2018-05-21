drop view if exists `v_apq_get_productionschedulebyarea`;
create view `v_apq_get_productionschedulebyarea`
as
	select
		  `as`.`idruntime`
		, `as`.`area`
		, `as`.`plannedproductiontime`
		, `as`.`scheduleloss`
		, `as`.`plannedstop`
		, (`as`.`plannedproductiontime` + `as`.`scheduleloss` + `as`.`plannedstop`) as `totaltime`
	from
		`apq_availabilitybyarea` `as`;
