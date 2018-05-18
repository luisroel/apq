
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
		from `v_apq_get_index` `nd`
		union all
		select
			  `nd`.`idruntime`
			, '1. Total Time'	as `title`
			, 0.0 				as `value1`
			, 'Second'			as `pos`
		from `v_apq_get_index` `nd`
		union all
		select
			  `nd`.`idruntime`
			, '1. Total Time'	as `title`
			, 0.0 				as `value1`
			, 'Third'			as `pos`
		from `v_apq_get_index` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, '2. Schedule'
			, `nd`.`plannedproductiontime` * 100.0 / `nd`.`totaltime`
			, 'First'			as `pos`
		from `v_apq_get_index` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, '2. Schedule'
			, `nd`.`plannedstop` * 100.0 / `nd`.`totaltime`
			, 'Second'			as `pos`
		from `v_apq_get_index` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, '2. Schedule'
			, `nd`.`scheduleloss` * 100.0 / `nd`.`totaltime` 
			, 'Third'			as `pos`
		from `v_apq_get_index` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, '3. Production'
			, `nd`.`productiontime` * 100.0 / `nd`.`totalTime`
			, 'First'			as `pos`
		from `v_apq_get_index` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, '3. Production'
			, `nd`.`stdsetuptime` * 100.0 / `nd`.`totaltime`
			, 'Second'			as `pos`
		from `v_apq_get_index` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, '3. Production'
			, `nd`.`stdstarttime` * 100.0 / `nd`.`totaltime` 
			, 'Third'			as `pos`
		from `v_apq_get_index` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, '4. Availability'
			, `nd`.`runtime` * 100.0 / `nd`.`totaltime`
			, 'First'			as `pos`
		from `v_apq_get_index` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, '4. Availability'
			, `nd`.`stoptime` * 100.0 / `nd`.`totaltime`
			, 'Second'			as `pos`
		from `v_apq_get_index` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, '4. Availability'
			, 0.0 
			, 'Third'			as `pos`
		from `v_apq_get_index` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, '5. Performance'
			, `nd`.`producedtime` * 100.0 / `nd`.`totaltime`
			, 'First'			as `pos`
		from `v_apq_get_index` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, '5. Performance'
			, 0.0
			, 'Second'			as `pos`
		from `v_apq_get_index` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, '5. Performance'
			, 0.0 
			, 'Third'			as `pos`
		from `v_apq_get_index` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, '6. Quality'
			, `nd`.`goodtime` * 100.0 / `nd`.`totaltime`
			, 'First'			as `pos`
		from `v_apq_get_index` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, '6. Quality'
			, 0.0
			, 'Second'			as `pos`
		from `v_apq_get_index` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, '6. Quality'
			, 0.0 
			, 'Third'			as `pos`
		from `v_apq_get_index` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, '7. Index'
			, `nd`.`indextime` * 100.0 / `nd`.`totaltime`
			, 'First'			as `pos`
		from `v_apq_get_index` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, '7. Index'
			, 0.0
			, 'Second'			as `pos`
		from `v_apq_get_index` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, '7. Index'
			, 0.0 
			, 'Third'			as `pos`
		from `v_apq_get_index` `nd`
	) `tt`;