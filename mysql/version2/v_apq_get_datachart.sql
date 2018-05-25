
drop view if exists `v_apq_get_datachart`;
create  view `v_apq_get_datachart`
as
	select
		*
	from (
		select 
			  `nd`.`idruntime`
			, '1. Total Time'	as `title`
			, 100.0 			as `value1`
			, 'First'			as `pos`
		from `v_apq_get_fields_level5` `nd`
--		union all
--		select
--			  `nd`.`idruntime`
--			, '1. Total Time'
--			, 0.0
--			, 'Second'
--		from `v_apq_get_fields_level5` `nd`
--		union all
--		select
--			  `nd`.`idruntime`
--			, '1. Total Time'
--			, 0.0
--			, 'Third'
--		from `v_apq_get_fields_level5` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, '2. Schedule'
			, `nd`.`schedule_loss` * 100.0 / `nd`.`total_time`
			, 'First'
		from `v_apq_get_fields_level5` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, '2. Schedule'
			, `nd`.`planned_stop` * 100.0 / `nd`.`total_time`
			, 'Second'
		from `v_apq_get_fields_level5` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, '2. Schedule'
			, `nd`.`nom_iddle_time` * 100.0 / `nd`.`total_time` 
			, 'Third'
		from `v_apq_get_fields_level5` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, '2. Schedule'
			, `nd`.`planned_production_time` * 100.0 / `nd`.`total_time`
			, 'First'
		from `v_apq_get_fields_level5` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, '3. Production'
			, `nd`.`nom_iddle_time` * 100.0 / `nd`.`total_time`
			, 'Second'
		from `v_apq_get_fields_level5` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, '3. Production'
			, `nd`.`planned_production_time` * 100.0 / `nd`.`total_time` 
			, 'Third'
		from `v_apq_get_fields_level5` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, '4. Availability'
			, `nd`.`stop_time` * 100.0 / `nd`.`total_time`
			, 'First'
		from `v_apq_get_fields_level5` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, '4. Availability'
			, `nd`.`runtime` * 100.0 / `nd`.`total_time`
			, 'Second'
		from `v_apq_get_fields_level5` `nd`
--		union all
--		select 
--			  `nd`.`idruntime`
--			, '4. Availability'
--			, 0.0 
--			, 'Third'
--		from `v_apq_get_fields_level5` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, '5. Performance'
			, `nd`.`nom_setup_time` * 100.0 / `nd`.`total_time`
			, 'First'
		from `v_apq_get_fields_level5` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, '5. Performance'
			, `nd`.`nom_start_time` * 100.0 / `nd`.`total_time`
			, 'Second'
		from `v_apq_get_fields_level5` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, '5. Performance'
			, `nd`.`nom_total_count_time` * 100.0 / `nd`.`total_time`
			, 'Third'
		from `v_apq_get_fields_level5` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, '5. Performance'
			, `nd`.`nom_prod_time` * 100.0 / `nd`.`total_time`
			, 'Third'
		from `v_apq_get_fields_level5` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, '6. Quality'
			, (`nd`.`bad_count` * 100.0 / `nd`.`total_count`) / `nd`.`total_time`
			, 'First'
		from `v_apq_get_fields_level5` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, '6. Quality'
			, (`nd`.`good_count` * 100.0 / `nd`.`total_count`) / `nd`.`total_time`
			, 'Second'
		from `v_apq_get_fields_level5` `nd`
--		union all
--		select 
--			  `nd`.`idruntime`
--			, '6. Quality'
--			, 0.0 
--			, 'Third'
--		from `v_apq_get_fields_level5` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, '7. Index'
			, `nd`.`apq`  * 100.0 / `nd`.`total_time`
			, 'First'
		from `v_apq_get_fields_level5` `nd`
--		union all
--		select 
--			  `nd`.`idruntime`
--			, '7. Index'
--			, 0.0
--			, 'Second'
--		from `v_apq_get_fields_level5` `nd`
--		union all
--		select 
--			  `nd`.`idruntime`
--			, '7. Index'
--			, 0.0 
--			, 'Third'
--		from `v_apq_get_fields_level5` `nd`
	) `tt`;