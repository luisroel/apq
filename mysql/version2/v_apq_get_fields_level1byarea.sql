drop view if exists `v_apq_get_fields_level1byarea`;
create view `v_apq_get_fields_level1byarea`
as
	select
		  `ct`.*

		, `av`.`time_for_production`
		, `av`.`schedule_loss`
		, `av`.`planned_stop`
		, `av`.`total_time`
        , `av`.`stop_time`

		, `av`.`time_for_production` - `ct`.`nom_production_time`	as `nom_iddle_time`
		, `av`.`time_for_production` - `ct`.`act_production_time`	as `act_iddle_time`

		, `av`.`stop_time`											as `availability_time_loss`
		, `ct`.`act_production_time` - `av`.`stop_time` 			as `availability_time`
		, `ct`.`act_production_time`								as `availability_total`

		, (`ct`.`act_production_time` - `ct`.`nom_production_time`) as `performance_time_loss`
		, `ct`.`nom_production_time` 								as `performance_time`
		, `ct`.`act_production_time`								as `performance_total`

		, `ct`.`bad_count` 											as `quality_loss`
		, (`ct`.`bad_count` / `ct`.`total_count`)					as `quality_loss_index`
		, `ct`.`good_count` 										as `quality_good`
		, (`ct`.`good_count` / `ct`.`total_count`)					as `quality_good_index`
		, `ct`.`total_count`										as `quality_total`
	from
		`v_apq_get_countsbyarea` `ct`
		inner join `v_apq_get_availabilitybyarea` `av` on
				`av`.`idruntime` 	= `ct`.`idruntime`
			and `av`.`area` 		= `ct`.`area`;
