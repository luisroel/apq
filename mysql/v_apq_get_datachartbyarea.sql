
drop view if exists `v_apq_get_datachartbyarea`;
create view `v_apq_get_datachartbyarea`
as
	select
		*
	from (
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, '1. Total Time'	as `title`
			, 100.0 			as `value1`
			, 'First'			as `pos`
		from `v_apq_get_indexbyarea` `nd`
		union all
		select
			  `nd`.`idruntime`
			, `nd`.`area`
			, '1. Total Time'
			, 0.0
			, 'Second'
		from `v_apq_get_indexbyarea` `nd`
		union all
		select
			  `nd`.`idruntime`
			, `nd`.`area`
			, '1. Total Time'
			, 0.0
			, 'Third'
		from `v_apq_get_indexbyarea` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, '2. Schedule'
			, `nd`.`plannedproductiontime` * 100.0 / `nd`.`totaltime`
			, 'First'
		from `v_apq_get_indexbyarea` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, '2. Schedule'
			, `nd`.`plannedstop` * 100.0 / `nd`.`totaltime`
			, 'Second'
		from `v_apq_get_indexbyarea` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, '2. Schedule'
			, `nd`.`scheduleloss` * 100.0 / `nd`.`totaltime` 
			, 'Third'
		from `v_apq_get_indexbyarea` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, '3. Production'
			, `nd`.`productiontime` * 100.0 / `nd`.`totaltime`
			, 'First'
		from `v_apq_get_indexbyarea` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, '3. Production'
			, `nd`.`stdsetuptime` * 100.0 / `nd`.`totaltime`
			, 'Second'			as `pos`
		from `v_apq_get_indexbyarea` `nd`
		union all
		select
			  `nd`.`idruntime`
			, `nd`.`area`
			, '3. Production'
			, `nd`.`stdstarttime` * 100.0 / `nd`.`totaltime`
			, 'Third'			as `pos`
		from `v_apq_get_indexbyarea` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, '4. Availability'
			, `nd`.`runtime` * 100.0 / `nd`.`totaltime`
			, 'First'			as `pos`
		from `v_apq_get_indexbyarea` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, '4. Availability'
			, `nd`.`stoptime` * 100.0 / `nd`.`totaltime`
			, 'Second'			as `pos`
		from `v_apq_get_indexbyarea` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, '4. Availability'
			, 0.0 
			, 'Third'			as `pos`
		from `v_apq_get_indexbyarea` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, '5. Performance'
			, `nd`.`producedtime` * 100.0 / `nd`.`totaltime`
			, 'First'	as `pos`
		from `v_apq_get_indexbyarea` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, '5. Performance'
			, 0.0
			, 'Second'	as `pos`
		from `v_apq_get_indexbyarea` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, '5. Performance'
			, 0.0 
			, 'Third'	as `pos`
		from `v_apq_get_indexbyarea` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, '6. Quality'
			, `nd`.`goodtime` * 100.0 / `nd`.`totaltime`
			, 'First'	as `pos`
		from `v_apq_get_indexbyarea` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, '6. Quality'
			, 0.0
			, 'Second'	as `pos`
		from `v_apq_get_indexbyarea` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, '6. Quality'
			, 0.0 
			, 'Third'	as `pos`
		from `v_apq_get_indexbyarea` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, '7. Index'
			, `nd`.`indextime` * 100.0 / `nd`.`totaltime`
			, 'First'	as `pos`
		from `v_apq_get_indexbyarea` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, '7. Index'
			, 0.0
			, 'Second'	as `pos`
		from `v_apq_get_indexbyarea` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, '7. Index'
			, 0.0 
			, 'Third'	as `pos`
		from `v_apq_get_indexbyarea` `nd`
	) `tt`;