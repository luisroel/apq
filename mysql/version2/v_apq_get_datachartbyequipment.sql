
drop view if exists `v_apq_get_datachartbyequipment`;
create  view `v_apq_get_datachartbyequipment`
as   
	select
		*
	from (
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, `nd`.`idequipment`
			, '1. Total Time'			as `title`
			, `nd`.`total_time_chart`	as `value1`
			, '1'						as `pos`
		from `v_apq_get_fields_level4byequipment` `nd`

		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, `nd`.`idequipment`
			, '2. Schedule'
			, `nd`.`nom_production_time_chart`
			, '1'
		from `v_apq_get_fields_level4byequipment` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, `nd`.`idequipment`
			, '2. Schedule'
			, `nd`.`nom_iddle_time_chart`
			, '2'
		from `v_apq_get_fields_level4byequipment` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, `nd`.`idequipment`
			, '2. Schedule'
			, `nd`.`planned_stop_chart`
			, '3'
		from `v_apq_get_fields_level4byequipment` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, `nd`.`idequipment`
			, '2. Schedule'
			, `nd`.`schedule_loss_chart`
			, '4'
		from `v_apq_get_fields_level4byequipment` `nd`

		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, `nd`.`idequipment`
			, '3. Production'
			, `nd`.`act_production_time_chart` 
			, '1'
		from `v_apq_get_fields_level4byequipment` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, `nd`.`idequipment`
			, '3. Production'
			, `nd`.`act_iddle_time_chart`
			, '2'
		from `v_apq_get_fields_level4byequipment` `nd`

		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, `nd`.`idequipment`
			, '4. Availability'
			, `nd`.`availability_chart`
			, '1'
		from `v_apq_get_fields_level4byequipment` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, `nd`.`idequipment`
			, '4. Availability'
			, `nd`.`availability_loss_chart`
			, '2'
		from `v_apq_get_fields_level4byequipment` `nd`

		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, `nd`.`idequipment`
			, '5. Performance'
			, `nd`.`performance_chart`
			, '1'
		from `v_apq_get_fields_level4byequipment` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, `nd`.`idequipment`
			, '5. Performance'
			, `nd`.`performance_loss_chart`
			, '2'
		from `v_apq_get_fields_level4byequipment` `nd`

		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, `nd`.`idequipment`
			, '6. Quality'
			, `nd`.`quality_good_chart`
			, '1'
		from `v_apq_get_fields_level4byequipment` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, `nd`.`idequipment`
			, '6. Quality'
			, `nd`.`quality_loss_chart`
			, '2'
		from `v_apq_get_fields_level4byequipment` `nd`

		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, `nd`.`idequipment`
			, '7. Index'
			, `nd`.`apq_chart`
			, '1'
		from `v_apq_get_fields_level4byequipment` `nd`
	) `tt`;