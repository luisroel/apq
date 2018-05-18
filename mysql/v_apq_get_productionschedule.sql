drop view if exists `v_apq_get_productionschedule`;
create view `v_apq_get_productionschedule`
as
	select
		  `as`.`idruntime`
		, `as`.`plannedproductiontime`
		, `as`.`plannedstop`
		, `as`.`scheduleloss`
		, (`as`.`plannedproductiontime` + `as`.`scheduleloss` + `as`.`plannedstop`) as `totaltime`
	from
		`apq_availabilitysummary` `as`;


