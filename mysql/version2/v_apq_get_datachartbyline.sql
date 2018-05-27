
drop view if exists `v_apq_get_datachartbyline`;
create  view `v_apq_get_datachartbyline`
as
	select
		*
	from (
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '1. Total Time'			as `title`
			, `nd`.`total_time_chart`	as `value1`
			, '1'						as `pos`
		from `v_apq_get_fields_level5byline` `nd`

		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '2. Schedule'
			, `nd`.`planned_production_time_chart`
			, '1'
		from `v_apq_get_fields_level5byline` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '2. Schedule'
			, `nd`.`nom_iddle_time_chart`
			, '2'
		from `v_apq_get_fields_level5byline` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '2. Schedule'
			, `nd`.`planned_stop_chart`
			, '3'
		from `v_apq_get_fields_level5byline` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '2. Schedule'
			, `nd`.`schedule_loss_chart`
			, '4'
		from `v_apq_get_fields_level5byline` `nd`

		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '3. Production'
			, `nd`.`planned_production_time_p_chart` 
			, '1'
		from `v_apq_get_fields_level5byline` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '3. Production'
			, `nd`.`nom_iddle_time_p_chart`
			, '2'
		from `v_apq_get_fields_level5byline` `nd`

		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '4. Availability'
			, `nd`.`runtime_chart`
			, '1'
		from `v_apq_get_fields_level5byline` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '4. Availability'
			, `nd`.`stop_time_chart`
			, '2'
		from `v_apq_get_fields_level5byline` `nd`

		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '5. Performance'
			, `nd`.`nom_total_count_time_chart`
			, '1'
		from `v_apq_get_fields_level5byline` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '5. Performance'
			, `nd`.`nom_start_time_chart`
			, '2'
		from `v_apq_get_fields_level5byline` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '5. Performance'
			, `nd`.`nom_setup_time_chart`
			, '3'
		from `v_apq_get_fields_level5byline` `nd`

		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '6. Quality'
			, `nd`.`good_count_chart`
			, '1'
		from `v_apq_get_fields_level5byline` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '6. Quality'
			, `nd`.`bad_count_chart`
			, '2'
		from `v_apq_get_fields_level5byline` `nd`

		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '7. Index'
			, `nd`.`apq_chart`
			, '1'
		from `v_apq_get_fields_level5byline` `nd`

	) `tt`;