
drop view if exists `v_apq_get_datachart`;
create  view `v_apq_get_datachart`
as
	select
		*
	from (
		select 
			  `nd`.`idruntime`
			, '1. Total Time'			as `title`
			, `nd`.`total_time_chart`	as `value1`
			, '1'						as `pos`
		from `v_apq_get_fields_level4` `nd`

		union all
		select 
			  `nd`.`idruntime`
			, '2. Schedule'
			, `nd`.`nom_production_time_chart`
			, '1'
		from `v_apq_get_fields_level4` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, '2. Schedule'
			, `nd`.`nom_iddle_time_chart`
			, '2'
		from `v_apq_get_fields_level4` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, '2. Schedule'
			, `nd`.`planned_stop_chart`
			, '3'
		from `v_apq_get_fields_level4` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, '2. Schedule'
			, `nd`.`schedule_loss_chart`
			, '4'
		from `v_apq_get_fields_level4` `nd`

		union all
		select 
			  `nd`.`idruntime`
			, '3. Production'
			, `nd`.`act_production_time_chart` 
			, '1'
		from `v_apq_get_fields_level4` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, '3. Production'
			, `nd`.`act_iddle_time_chart`
			, '2'
		from `v_apq_get_fields_level4` `nd`

		union all
		select 
			  `nd`.`idruntime`
			, '4. Availability'
			, `nd`.`availability_chart`
			, '1'
		from `v_apq_get_fields_level4` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, '4. Availability'
			, `nd`.`availability_loss_chart`
			, '2'
		from `v_apq_get_fields_level4` `nd`

		union all
		select 
			  `nd`.`idruntime`
			, '5. Performance'
			, `nd`.`performance_chart`
			, '1'
		from `v_apq_get_fields_level4` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, '5. Performance'
			, `nd`.`performance_loss_chart`
			, '2'
		from `v_apq_get_fields_level4` `nd`

		union all
		select 
			  `nd`.`idruntime`
			, '6. Quality'
			, `nd`.`quality_good_chart`
			, '1'
		from `v_apq_get_fields_level4` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, '6. Quality'
			, `nd`.`quality_loss_chart`
			, '2'
		from `v_apq_get_fields_level4` `nd`

		union all
		select 
			  `nd`.`idruntime`
			, '7. Index'
			, `nd`.`apq_chart`
			, '1'
		from `v_apq_get_fields_level4` `nd`
	) `tt`;