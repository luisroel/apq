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
		, `av`.`time_for_production` - `ct`.`nom_prod_time` as `nom_iddle_time`
	from
		`v_apq_get_countsbyarea` `ct`
		inner join `v_apq_get_availabilitybyarea` `av` on
				`av`.`idruntime` 	= `ct`.`idruntime`
			and `av`.`area` 		= `ct`.`area`;
