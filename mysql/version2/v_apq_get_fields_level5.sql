drop view if exists `v_apq_get_fields_level5`;
create view `v_apq_get_fields_level5`
as
	select
		  `vl`.`idruntime`
		, `vl`.`schedule_loss`
		, `vl`.`planned_stop`
		, `vl`.`nom_iddle_time`
		, `vl`.`planned_production_time`
		, `vl`.`total_time`

		, `vl`.`time_for_production`

		, `vl`.`stop_time`
		, `vl`.`runtime`
		, `vl`.`ia_index`

		, `vl`.`nom_setup_time`
		, `vl`.`nom_start_time`
		, `vl`.`nom_total_count_time`
		, `vl`.`nom_prod_time`
		, `vl`.`ip_index`

		, `vl`.`bad_count`
		, `vl`.`good_count`
		, `vl`.`total_count`
		, `vl`.`iq_index`

		, `vl`.`ia_index` * `vl`.`ip_index` * `vl`.`iq_index` 	as `apq`
	from
		`v_apq_get_fields_level4` `vl`;
