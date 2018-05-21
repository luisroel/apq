drop view if exists `v_apq_get_productionschedulebyequipment`;
create view `v_apq_get_productionschedulebyequipment`
as
	select
		  `eq`.`idruntime`
		, `eq`.`area`
		, `eq`.`line`
		, `eq`.`idequipment`
		, sum(`as`.`working`)								as `plannedproductiontime`
		, sum(`as`.`off`)									as `scheduleloss`
		, sum(`as`.`break`)									as `plannedstop`
		, sum(`as`.`working` + `as`.`off` + `as`.`break`)	as `totaltime`
	from
		`apq_equipment` `eq`
		inner join `apq_availability` `as` on
			`as`.`idruntime` = `eq`.`idruntime`
	group by
		  `eq`.`idruntime`
		, `eq`.`area`
		, `eq`.`line`
		, `eq`.`idequipment`;
