drop view if exists `v_apq_get_stops`;
create view `v_apq_get_stops`
as
	select
		  `ss`.`idruntime`
		, (sum(`ss`.`time`) / 60.0)	as `stop_time`
	from
		`apq_stopssummary` `ss`
	group by
		`ss`.`idruntime`;

