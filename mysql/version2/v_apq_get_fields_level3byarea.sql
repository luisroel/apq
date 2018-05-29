drop view if exists `v_apq_get_fields_level3byarea`;
create view `v_apq_get_fields_level3byarea`
as
	select
		  `rt`.`idruntime`
		, `rt`.`to`															as `time`

        , `vl`.`area`														as `area`
        , `vl`.`schedule_loss`												as `schedule_loss`
        , (`vl`.`schedule_loss` * 100.0 / `vl`.`total_time`)				as `schedule_loss_chart`
        , (`vl`.`schedule_loss` / `vl`.`total_time`)						as `schedule_loss_label`
		, `vl`.`planned_stop`												as `planned_stop`
        , (`vl`.`planned_stop` * 100.0 / `vl`.`total_time`)					as `planned_stop_chart`
        , (`vl`.`planned_stop` / `vl`.`total_time`)							as `planned_stop_label`
		, `vl`.`nom_iddle_time`												as `nom_iddle_time`
        , (`vl`.`nom_iddle_time` * 100.0 / `vl`.`total_time`)				as `nom_iddle_time_chart`
        , (`vl`.`nom_iddle_time` / `vl`.`total_time`)						as `nom_iddle_time_label`
		, `vl`.`nom_production_time`										as `nom_production_time`
        , (`vl`.`nom_production_time` * 100.0 / `vl`.`total_time`) 			as `nom_production_time_chart`
        , (`vl`.`nom_production_time` / `vl`.`total_time`) 					as `nom_production_time_label`
		, `vl`.`total_time`													as `total_time`
        , 100.0 															as `total_time_chart`

		, `vl`.`act_iddle_time`						as `act_iddle_time`
        , (`vl`.`act_iddle_time` * 100.0 / `vl`.`total_time`)				as `act_iddle_time_chart`
        , (`vl`.`act_iddle_time` / `vl`.`time_for_production`)				as `act_iddle_time_label`
		, `vl`.`act_production_time`										as `act_production_time`
        , (`vl`.`act_production_time` * 100.0 / `vl`.`total_time`) 			as `act_production_time_chart`
        , (`vl`.`act_production_time` / `vl`.`time_for_production`) 		as `act_production_time_label`
		, `vl`.`time_for_production`										as `time_for_production`

		, `vl`.`availability_time_loss`										as `availability_time_loss`
        , (`vl`.`availability_time_loss` * 100.0 / `vl`.`total_time`) 		as `availability_loss_chart`
        , (`vl`.`availability_time_loss` / `vl`.`availability_total`) 		as `availability_loss_label`
        , `vl`.`availability_time`											as `availability_time`
		, (`vl`.`availability_time` * 100.0 / `vl`.`total_time`) 			as `availability_chart`
        , (`vl`.`availability_time` / `vl`.`availability_total`) 			as `availability_label`
        , `vl`.`availability_total`											as `availability_total`
		, `vl`.`ia_index`													as `ia_index`

		, `vl`.`performance_time_loss`										as `performance_time_loss`
        , (`vl`.`performance_time_loss` * 100.0 / `vl`.`total_time`) 		as `performance_loss_chart`
        , (`vl`.`performance_time_loss` / `vl`.`performance_total`) 		as `performance_loss_label`
        , `vl`.`performance_time`											as `performance_time`
		, (`vl`.`performance_time` * 100.0 / `vl`.`total_time`) 			as `performance_chart`
        , (`vl`.`performance_time` / `vl`.`performance_total`) 				as `performance_label`
        , `vl`.`performance_total`											as `performance_total`
		, `vl`.`ip_index`													as `ip_index`

		, `vl`.`quality_loss`												as `quality_loss`
        , (`vl`.`quality_loss_index` * 100.0) 
		* (`vl`.`act_production_time` / `vl`.`total_time`)					as `quality_loss_chart`
        , `vl`.`quality_loss_index`											as `quality_loss_label`
        , `vl`.`quality_good`												as `quality_good`
        , (`vl`.`quality_good_index` * 100.0 )
		* (`vl`.`act_production_time`/`vl`.`total_time`)					as `quality_good_chart`
		, `vl`.`quality_good_index`											as `quality_good_label`
		, `vl`.`quality_total`												as `quality_total`
		, `vl`.`iq_index`													as `iq_index`

		, `vl`.`ia_index` * `vl`.`ip_index` * `vl`.`iq_index`
			* (`vl`.`performance_total` / `vl`.`total_time`) * 100.0 		as `apq_chart`
		, `vl`.`ia_index` * `vl`.`ip_index` * `vl`.`iq_index`				as `apq_label`
        , (`vl`.`ia_index` * `vl`.`ip_index` * `vl`.`iq_index`) * 100.0		as `apq`
        
        from
                `apq_runtime` `rt`
                inner join `v_apq_get_fields_level2byarea` `vl` on
                        `rt`.`idruntime` = `vl`.`idruntime`;

