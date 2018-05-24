drop view if exists `v_apq_get_countsbyline`;
create view `v_apq_get_countsbyline`
as
	select
		  `ct`.`idruntime`
		, `ct`.`area`
		, `ct`.`line`
		, `ct`.`goodcount`
		, `ct`.`badcount`
		, `ct`. `totalcount`
		, (`ct`.`goodtime` / 60.0 / 60.0)		as `goodtime`
		, (`ct`.`losstime` / 60.0 / 60.0)		as `losstime`
		, (`ct`.`totaltime` / 60.0 / 60.0)		as `producedtime`
		, (`ss`.`actsetuptime` / 60.0 / 60.0)	as `actsetuptime`
		, (`ss`.`actstarttime` / 60.0 / 60.0)	as `actstarttime`
		, (`ss`.`stdsetuptime` / 60.0 / 60.0)	as `stdsetuptime`
		, (`ss`.`stdstarttime` / 60.0 / 60.0)	as `stdstarttime`
		, `ps`.`time` / 60.0					as `actualprodtime`
	from
		`apq_countsbyline` `ct`
		inner join `apq_setupandstartbyline` `ss` on
				`ss`.`idruntime`	= `ct`.`idruntime`
			and `ss`.`area`			= `ct`.`area`
			and `ss`.`line`			= `ct`.`line`
		left join `apq_prodtimesbyline` `ps` on
				`ps`.`idruntime`	= `ct`.`idruntime`
			and `ps`.`area`			= `ct`.`area`
			and `ps`.`line`			= `ct`.`line`;

