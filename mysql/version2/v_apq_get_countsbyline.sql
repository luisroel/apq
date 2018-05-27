drop view if exists `v_apq_get_countsbyline`;
create view `v_apq_get_countsbyline`
as
	select
		  `ct`.`idruntime`
		, `ct`.`area`
		, `ct`.`line`

        , `ct`.`goodcount`				as `good_count`
		, `ct`.`badcount`				as `bad_count`
		, `ct`.`totalcount`				as `total_count`
        
		, (`ct`.`goodtime` / 60.0 )		as `nom_good_count_time`
		, (`ct`.`losstime` / 60.0)		as `nom_bad_count_time`

		, (`ct`.`totaltime` / 60.0)		as `nom_total_count_time`
		, (`ss`.`stdsetuptime` / 60.0)	as `nom_setup_time`
		, (`ss`.`stdstarttime` / 60.0)	as `nom_start_time`
		, (`ct`.`totaltime` / 60.0)
		+ (`ss`.`stdsetuptime` / 60.0)
		+ (`ss`.`stdstarttime` / 60.0)	as `nom_prod_time`

		, (`ps`.`time` / 60.0)			as `act_total_count_time`
		, (`ss`.`actsetuptime` / 60.0)	as `act_setup_time`
		, (`ss`.`actstarttime` / 60.0)	as `act_start_time`
		, (`ps`.`time` / 60.0)
		+ (`ss`.`actsetuptime` / 60.0)
		+ (`ss`.`actstarttime` / 60.0)	as `act_prod_time`

		, ((`ss`.`actsetuptime` - `ss`.`stdsetuptime`) / 60.0)	as `setup_time_loss`
        , ((`ss`.`actstarttime` - `ss`.`stdstarttime`) / 60.0)	as `start_time_loss`
		, ((`ps`.`time` - `ct`.`totaltime`) / 60.0) 			as `production_loss`
	from
		`apq_countsbyline` `ct`
		inner join `apq_setupandstartbyline` `ss` on
				`ss`.`idruntime` 	= `ct`.`idruntime`
			and `ss`.`area` 		= `ct`.`area`
			and `ss`.`line` 		= `ct`.`line`
		left join `apq_prodtimesbyline` `ps` on
				`ps`.`idruntime` 	= `ct`.`idruntime`
			and `ps`.`area` 		= `ct`.`area`
			and `ps`.`line` 		= `ct`.`line`;