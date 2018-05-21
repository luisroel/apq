drop view if exists `v_apq_get_countsbyarea`;
create view `v_apq_get_countsbyarea`
as
	select
		  `ct`.`idruntime`
		, `ct`.`area`
		, `ct`.`goodcount`
		, `ct`.`badcount`
		, `ct`.`totalcount`
		, (`ct`.`goodtime` / 60.0 / 60.0)		as `goodtime`
		, (`ct`.`losstime` / 60.0 / 60.0)		as `losstime`
		, (`ct`.`totaltime` / 60.0 / 60.0)		as `producedtime`
		, (`ss`.`stdsetuptime` / 60.0 / 60.0)	as `stdsetuptime`
		, (`ss`.`stdstarttime` / 60.0 / 60.0)	as `stdstarttime`
		, `ps`.`time` / 60.0					as `actualprodtime`
	from
		`apq_countsbyarea` `ct`
		inner join `apq_setupandstartbyarea` `ss` on
				`ss`.`idruntime`	= `ct`.`idruntime`
			and `ss`.`area`			= `ct`.`area`
		left join `apq_prodtimesbyarea` `ps` on
				`ps`.`idruntime`	= `ct`.`idruntime`
			and `ps`.`area`			= `ct`.`area`;
