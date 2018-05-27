drop view if exists `v_apq_get_stopsbyequipment`;
create view `v_apq_get_stopsbyequipment`
as
	select
		  `ss`.`idruntime`
		, `ss`.`area`
        , `ss`.`line`
        , `ss`.`idequipment`
		, (sum(`ss`.`time`) / 60.0)	as `stop_time`
	from
		`apq_stopsbyequipment` `ss`
	group by
		  `ss`.`idruntime`
		, `ss`.`area`
        , `ss`.`line`
        , `ss`.`idequipment`;

