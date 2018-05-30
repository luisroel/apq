drop view if exists `v_apq_get_countsbyequipment`;
create view `v_apq_get_countsbyequipment`
as
	select
		  `ct`.`idruntime`
		, `ct`.`area`
		, `ct`.`line`
		, `ct`.`idequipment`

        , `ct`.`goodcount`					as `good_count`
		, `ct`.`badcount`					as `bad_count`
		, `ct`.`totalcount`					as `total_count`
        
		, (`ct`.`goodtime` / 60.0)			as `nom_good_count_time`
		, (`ct`.`losstime` / 60.0)			as `nom_bad_count_time`

		, (`ct`.`totaltime` / 60.0)			as `nom_running_time`
		, (`ss`.`stdsetuptime` / 60.0 )		as `nom_setup_time`
		, (`ss`.`stdstarttime` / 60.0 )		as `nom_start_time`
		, (`ct`.`totaltime` / 60.0)
		+ (`ss`.`stdsetuptime` / 60.0 )
		+ (`ss`.`stdstarttime` / 60.0 )		as `nom_production_time`

		, (`ps`.`time` / 60.0)				as `act_total_running`
		, (`ss`.`actsetuptime` / 60.0)		as `act_setup_time`
		, (`ss`.`actstarttime` / 60.0)		as `act_start_time`

		, ((`ss`.`actsetuptime` - `ss`.`stdsetuptime`) / 60.0)	as `setup_time_loss`
        , ((`ss`.`actstarttime` - `ss`.`stdstarttime`) / 60.0)	as `start_time_loss`
		, ((`ps`.`time`  - `ct`.`totaltime`) / 60.0) 			as `production_loss`
	from
		`apq_countsbyequipment` `ct`
		inner join `apq_setupandstartbyequipment` `ss` on
				`ss`.`idruntime` 	= `ct`.`idruntime`
			and `ss`.`area` 		= `ct`.`area`
			and `ss`.`line` 		= `ct`.`line`
			and `ss`.`idequipment` 	= `ct`.`idequipment`
		left join `apq_prodtimesbyequipment` `ps` on
				`ps`.`idruntime` 	= `ct`.`idruntime`
			and `ps`.`area` 		= `ct`.`area`
			and `ps`.`line` 		= `ct`.`line`
			and `ps`.`idequipment` 	= `ct`.`idequipment`;
