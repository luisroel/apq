drop view if exists `v_apq_get_stopsbyarea`;
create view `v_apq_get_stopsbyarea`
as
	select
		  `ss`.`idruntime`
		, `ss`.`area`
		, (sum(`ss`.`time`) / 60.0)	as `stop_time`
	from
		`apq_stopsbyarea` `ss`
	group by
		  `ss`.`idruntime`
		, `ss`.`area`;
