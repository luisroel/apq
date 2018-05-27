drop view if exists `v_apq_get_productionschedulebyequipment`;
create view `v_apq_get_productionschedulebyequipment`
as
	select
		  `eq`.`idruntime`
		, `eq`.`area`
		, `eq`.`line`
		, `eq`.`idequipment`
		, sum(`as`.`working`)								as `time_for_production`
		, sum(`as`.`off`)									as `schedule_loss`
		, sum(`as`.`break`)									as `planned_stop`
		, sum(`as`.`working` + `as`.`off` + `as`.`break`)	as `total_time`
	from
		`apq_equipment` `eq`
		inner join `apq_availability` `as` on
			`as`.`idruntime` = `eq`.`idruntime`
	group by
		  `eq`.`idruntime`
		, `eq`.`area`
		, `eq`.`line`
		, `eq`.`idequipment`;

