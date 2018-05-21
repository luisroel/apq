drop view if exists `v_apq_get_countsbyequipment`;
create view `v_apq_get_countsbyequipment`
as
	select
		  `ct`.`idruntime`
		, `ct`.`area`
		, `ct`.`line`
		, `ct`.`idequipment`
		, `ct`.`goodcount`
		, `ct`.`badcount`
		, `ct`.`totalcount`
		, (`ct`.`goodtime` / 60.0 / 60.0)		as `GoodTime`
		, (`ct`.`losstime` / 60.0 / 60.0)		as `LossTime`
		, (`ct`.`totaltime` / 60.0 / 60.0)		as `ProducedTime`
		, (`ss`.`stdsetupTime` / 60.0 / 60.0)	as `StdSetupTime`
		, (`ss`.`stdstartTime` / 60.0 / 60.0)	as `StdStartTime`
		, `ps`.`time` / 60.0					as `ActualProdTime`
	from
		`apq_countsbyequipment` `ct`
		inner join `apq_setupandstartbyequipment` `ss` on
				`ss`.`idruntime`	= `ct`.`idruntime`
			and `ss`.`area`			= `ct`.`area`
			and `ss`.`line`			= `ct`.`line`
			and `ss`.`idequipment`	= `ct`.`idequipment`
		left join `apq_prodtimesbyequipment` `ps` on
				`ps`.`idruntime`	= `ct`.`idruntime`
			and `ps`.`area`			= `ct`.`area`
			and `ps`.`line`			= `ct`.`line`
			and `ps`.`idequipment`	= `ct`.`idequipment`;


