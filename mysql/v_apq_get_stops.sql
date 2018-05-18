drop view if exists `v_apq_get_stops`;
create view `v_apq_get_stops`
as
	select
		  `ss`.`idruntime`
		, sum(`ss`.`time`) as `stoptime`
	from
		`apq_stopssummary` `ss`
	group by
		`ss`.`idruntime`;

