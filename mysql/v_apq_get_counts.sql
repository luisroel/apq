drop view if exists `v_apq_get_counts`;
create view `v_apq_get_counts`
as
	select
		  `ct`.`idruntime`
		, `ct`.`goodcount`
		, `ct`.`badcount`
		, `ct`.`totalcount`
		, (`ct`.`goodtime` / 60.0 / 60.0)		as `goodtime`
		, (`ct`.`losstime` / 60.0 / 60.0)		as `losstime`
		, (`ct`.`totaltime` / 60.0 / 60.0)		as `producedtime`
		, (`ss`.`stdsetuptime` / 60.0 / 60.0)	as `stdSetuptime`
		, (`ss`.`stdstarttime` / 60.0 / 60.0)	as `stdStarttime`
		, `ps`.`time` / 60.0					as `actualprodtime`
	from
		`apq_countssummary` `ct`
		inner join `apq_setupandstartsummary` `ss` on
			`ss`.`idruntime` = `ct`.`idruntime`
		left join `apq_prodtimessummary` `ps` on
			`ps`.`idruntime` = `ct`.`idruntime`;
