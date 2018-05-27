drop view if exists `v_apq_get_stopsbyline`;
create view `v_apq_get_stopsbyline`
as
	select
		  `ss`.`idruntime`
		, `ss`.`area`
		, `ss`.`line`
		, (sum(`ss`.`time`) / 60.0)	as `stop_time`
	from
		`apq_stopsbyline` `ss`
	group by
		  `ss`.`idruntime`
		, `ss`.`area`
		, `ss`.`line`;

