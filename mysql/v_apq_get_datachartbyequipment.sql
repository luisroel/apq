drop view if exists `v_apq_get_datachartbyequipment`;
create view `v_apq_get_datachartbyequipment`
as
	select
		*
	from (
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, `nd`.`idequipment`
			, '1. Total Time'	as `title`
			, 100.0 			as `value1`
			, 'First'			as `pos`
		from `v_apq_get_indexbyequipment` `nd`
		union all
		select
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, `nd`.`idequipment`
			, '1. Total Time'
			, 0.0
			, 'Second'
		from `v_apq_get_indexbyequipment` `nd`
		union all
		select
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, `nd`.`idequipment`
			, '1. Total Time'
			, 0.0 
			, 'Third'
		from `v_apq_get_indexbyequipment` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, `nd`.`idequipment`
			, '2. Schedule'
			, `nd`.`plannedproductiontime` * 100.0 / `nd`.`totaltime`
			, 'First'
		from `v_apq_get_indexbyequipment` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, `nd`.`idequipment`
			, '2. Schedule'
			, `nd`.`plannedstop` * 100.0 / `nd`.`totaltime`
			, 'Second'
		from `v_apq_get_indexbyequipment` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, `nd`.`idequipment`
			, '2. Schedule'
			, `nd`.`scheduleloss` * 100.0 / `nd`.`totaltime` 
			, 'Third'
		from `v_apq_get_indexbyequipment` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, `nd`.`idequipment`
			, '3. Production'
			, `nd`.`productiontime` * 100.0 / `nd`.`totaltime`
			, 'First'
		from `v_apq_get_indexbyequipment` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, `nd`.`idequipment`
			, '3. Production'
			, `nd`.`stdsetuptime` * 100.0 / `nd`.`totaltime`
			, 'Second'
		from `v_apq_get_indexbyequipment` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, `nd`.`idequipment`
			, '3. Production'
			, `nd`.`stdstarttime` * 100.0 / `nd`.`totaltime` 
			, 'Third'
		from `v_apq_get_indexbyequipment` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, `nd`.`idequipment`
			, '4. Availability'
			, `nd`.`runtime` * 100.0 / `nd`.`totaltime`
			, 'First'
		from `v_apq_get_indexbyequipment` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, `nd`.`idequipment`
			, '4. Availability'
			, `nd`.`stoptime` * 100.0 / `nd`.`totaltime`
			, 'Second'
		from `v_apq_get_indexbyequipment` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, `nd`.`idequipment`
			, '4. Availability'
			, 0.0 
			, 'Third'
		from `v_apq_get_indexbyequipment` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, `nd`.`idequipment`
			, '5. Performance'
			, `nd`.`producedtime` * 100.0 / `nd`.`totaltime`
			, 'First'
		from `v_apq_get_indexbyequipment` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, `nd`.`idequipment`
			, '5. Performance'
			, 0.0
			, 'Second'
		from `v_apq_get_indexbyequipment` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, `nd`.`idequipment`
			, '5. Performance'
			, 0.0 
			, 'Third'
		from `v_apq_get_indexbyequipment` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, `nd`.`idequipment`
			, '6. Quality'
			, `nd`.`goodtime` * 100.0 / `nd`.`totaltime`
			, 'First'
		from `v_apq_get_indexbyequipment` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, `nd`.`idequipment`
			, '6. Quality'
			, 0.0
			, 'Second'
		from `v_apq_get_indexbyequipment` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, `nd`.`idequipment`
			, '6. Quality'
			, 0.0 
			, 'Third'
		from `v_apq_get_indexbyequipment` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, `nd`.`idequipment`
			, '7. Index'
			, `nd`.`indextime` * 100.0 / `nd`.`totaltime`
			, 'First'
		from `v_apq_get_indexbyequipment` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, `nd`.`idequipment`
			, '7. Index'
			, 0.0
			, 'Second'
		from `v_apq_get_indexbyequipment` `nd`
		union all
		select 
			  `nd`.`idruntime`
			, `nd`.`area`
			, `nd`.`line`
			, `nd`.`idequipment`
			, '7. Index'
			, 0.0 
			, 'Third'
		from `v_apq_get_indexbyequipment` `nd`
	) `tt`;