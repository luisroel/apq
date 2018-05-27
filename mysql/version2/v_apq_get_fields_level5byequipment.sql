drop view if exists `v_apq_get_fields_level5byequipment`;
create view `v_apq_get_fields_level5byequipment`
as
	select
		  `rt`.`idruntime`
		, `rt`.`to`															as `time`
		, `vl`.`area`
		, `vl`.`line`
		, `vl`.`idequipment`

		, `vl`.`schedule_loss`
        , (`vl`.`schedule_loss` * 100.0 / `vl`.`total_time`)				as `schedule_loss_chart`
        , (`vl`.`schedule_loss` / `vl`.`total_time`)						as `schedule_loss_label`
		, `vl`.`planned_stop`
        , (`vl`.`planned_stop` * 100.0 / `vl`.`total_time`)					as `planned_stop_chart`
        , (`vl`.`planned_stop` / `vl`.`total_time`)							as `planned_stop_label`
		, `vl`.`nom_iddle_time`
        , (`vl`.`nom_iddle_time` * 100.0 / `vl`.`total_time`)				as `nom_iddle_time_chart`
        , (`vl`.`nom_iddle_time` / `vl`.`total_time`)						as `nom_iddle_time_label`
		, `vl`.`planned_production_time`
        , (`vl`.`planned_production_time` * 100.0 / `vl`.`total_time`) 		as `planned_production_time_chart`
        , (`vl`.`planned_production_time` / `vl`.`total_time`) 				as `planned_production_time_label`
		, `vl`.`total_time`
        , 100.0 															as `total_time_chart`

		, `vl`.`nom_iddle_time`												as `nom_iddle_time_p`
        , (`vl`.`nom_iddle_time` * 100.0 / `vl`.`total_time`)				as `nom_iddle_time_p_chart`
        , (`vl`.`nom_iddle_time` / `vl`.`time_for_production`)				as `nom_iddle_time_p_label`
		, `vl`.`planned_production_time`									as `planned_production_time_p`
        , (`vl`.`planned_production_time` * 100.0 / `vl`.`total_time`) 		as `planned_production_time_p_chart`
        , (`vl`.`planned_production_time` / `vl`.`time_for_production`) 	as `planned_production_time_p_label`
		, `vl`.`time_for_production`

		, `vl`.`stop_time`
        , (`vl`.`stop_time` * 100.0 / `vl`.`total_time`) 					as `stop_time_chart`
        , (`vl`.`stop_time` / `vl`.`planned_production_time`) 				as `stop_time_label`
        , `vl`.`runtime`
		, (`vl`.`runtime` * 100.0 / `vl`.`total_time`) 						as `runtime_chart`
        , (`vl`.`runtime` / `vl`.`planned_production_time`) 				as `runtime_label`
        , `vl`.`planned_production_time`									as `availability_time`
		, `vl`.`ia_index`

		, `vl`.`nom_setup_time`
        , (`vl`.`nom_setup_time` * 100.0 / `vl`.`total_time`)				as `nom_setup_time_chart`
        , (`vl`.`nom_setup_time` / `vl`.`nom_prod_time`)					as `nom_setup_time_label`
		, `vl`.`nom_start_time`
        , (`vl`.`nom_start_time` * 100.0 / `vl`.`total_time`)				as `nom_start_time_chart`
        , (`vl`.`nom_start_time` / `vl`.`nom_prod_time`)					as `nom_start_time_label`
		, `vl`.`nom_total_count_time`
        , (`vl`.`nom_total_count_time` * 100.0 / `vl`.`total_time`)			as `nom_total_count_time_chart`
        , (`vl`.`nom_total_count_time` / `vl`.`nom_prod_time`)				as `nom_total_count_time_label`
		, `vl`.`nom_prod_time`
		, `vl`.`ip_index`

		, `vl`.`bad_count`
        , (`vl`.`bad_count` * 100.0 / `vl`.`total_count`) 
			*(`vl`.`planned_production_time`/`vl`.`total_time`)				as `bad_count_chart`
        , (`vl`.`bad_count` / `vl`.`total_count`)							as `bad_count_label`
        , `vl`.`good_count`
        , (`vl`.`good_count` * 100.0 / `vl`.`total_count`)
			* (`vl`.`planned_production_time`/`vl`.`total_time`)			as `good_count_chart`
		, (`vl`.`good_count` / `vl`.`total_count`)							as `good_count_label`
		, `vl`.`total_count`
		, `vl`.`iq_index`

		, `vl`.`ia_index` * `vl`.`ip_index` * `vl`.`iq_index`
			* (`vl`.`planned_production_time`/`vl`.`total_time`) * 100.0 	as `apq_chart`
		, `vl`.`ia_index` * `vl`.`ip_index` * `vl`.`iq_index`				as `apq_label`
        , (`vl`.`ia_index` * `vl`.`ip_index` * `vl`.`iq_index`) * 100.0		as `apq`

	from
		`apq_runtime` `rt`
		inner join `v_apq_get_fields_level4byequipment` `vl` on
			`rt`.`idruntime` = `vl`.`idruntime`;
