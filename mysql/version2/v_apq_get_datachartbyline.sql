
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
		from `v_apq_get_fields_level3byline` `nd`

		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '2. Schedule'
			, `nd`.`nom_production_time_chart`
			, '1'
		from `v_apq_get_fields_level3byline` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '2. Schedule'
			, `nd`.`nom_iddle_time_chart`
			, '2'
		from `v_apq_get_fields_level3byline` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '2. Schedule'
			, `nd`.`planned_stop_chart`
			, '3'
		from `v_apq_get_fields_level3byline` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '2. Schedule'
			, `nd`.`schedule_loss_chart`
			, '4'
		from `v_apq_get_fields_level3byline` `nd`

		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '3. Production'
			, `nd`.`act_production_time_chart` 
			, '1'
		from `v_apq_get_fields_level3byline` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '3. Production'
			, `nd`.`act_iddle_time_chart`
			, '2'
		from `v_apq_get_fields_level3byline` `nd`

		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '4. Availability'
			, `nd`.`availability_chart`
			, '1'
		from `v_apq_get_fields_level3byline` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '4. Availability'
			, `nd`.`availability_loss_chart`
			, '2'
		from `v_apq_get_fields_level3byline` `nd`

		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '5. Performance'
			, `nd`.`performance_chart`
			, '1'
		from `v_apq_get_fields_level3byline` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '5. Performance'
			, `nd`.`performance_loss_chart`
			, '2'
		from `v_apq_get_fields_level3byline` `nd`

		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '6. Quality'
			, `nd`.`quality_good_chart`
			, '1'
		from `v_apq_get_fields_level3byline` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '6. Quality'
			, `nd`.`quality_loss_chart`
			, '2'
		from `v_apq_get_fields_level3byline` `nd`

		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '7. Index'
			, `nd`.`apq_chart`
			, '1'
		from `v_apq_get_fields_level3byline` `nd`
	) `tt`;