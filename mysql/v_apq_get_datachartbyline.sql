drop view if exists`v_apq_get_datachartbyline`;
create view `v_apq_get_datachartbyline`
as
	select
		*
	from (
		select
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '1. Total Time'	as `title`
			, 100.0 			as `value1`
			, 'First'			as `pos`
		from `v_apq_get_indexbyline` `nd`
		union all
		select
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '1. Total Time'
			, 0.0
			, 'Second'
		from `v_apq_get_indexbyline` `nd`
		union all
		select
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '1. Total Time'
			, 0.0
			, 'Third'
		from `v_apq_get_indexbyline` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '2. Schedule'
			, `nd`.`plannedproductiontime` * 100.0 / `nd`.`totaltime`
			, 'First'
		from `v_apq_get_indexbyline` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '2. Schedule'
			, `nd`.`plannedstop` * 100.0 / `nd`.`totaltime`
			, 'Second'
		from `v_apq_get_indexbyline` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '2. Schedule'
			, `nd`.`scheduleloss` * 100.0 / `nd`.`totaltime` 
			, 'Third'
		from `v_apq_get_indexbyline` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '3. Production'
			, `nd`.`productiontime` * 100.0 / `nd`.`totaltime`
			, 'First'
		from `v_apq_get_indexbyline` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '3. Production'
			, `nd`.`stdsetuptime` * 100.0 / `nd`.`totaltime`
			, 'Second'
		from `v_apq_get_indexbyline` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '3. Production'
			, `nd`.`stdstarttime` * 100.0 / `nd`.`totaltime` 
			, 'Third'
		from `v_apq_get_indexbyline` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '4. Availability'
			, `nd`.`runtime` * 100.0 / `nd`.`totaltime`
			, 'First'
		from `v_apq_get_indexbyline` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '4. Availability'
			, `nd`.`stoptime` * 100.0 / `nd`.`totaltime`
			, 'Second'
		from `v_apq_get_indexbyline` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '4. Availability'
			, 0.0 
			, 'Third'
		from `v_apq_get_indexbyline` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '5. Performance'
			, `nd`.`producedtime` * 100.0 / `nd`.`totaltime`
			, 'First'
		from `v_apq_get_indexbyline` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '5. Performance'
			, 0.0
			, 'Second'
		from `v_apq_get_indexbyline` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '5. Performance'
			, 0.0 
			, 'Third'
		from `v_apq_get_indexbyline` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '6. Quality'
			, `nd`.`goodtime` * 100.0 / `nd`.`totaltime`
			, 'First'
		from `v_apq_get_indexbyline` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '6. Quality'
			, 0.0
			, 'Second'
		from `v_apq_get_indexbyline` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '6. Quality'
			, 0.0 
			, 'Third'
		from `v_apq_get_indexbyline` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '7. Index'
			, `nd`.`IndexTime` * 100.0 / `nd`.`totaltime`
			, 'First'
		from `v_apq_get_indexbyline` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '7. Index'
			, 0.0
			, 'Second'
		from `v_apq_get_indexbyline` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, '7. Index'
			, 0.0 
			, 'Third'
		from `v_apq_get_indexbyline` `nd`
	) `tt`;