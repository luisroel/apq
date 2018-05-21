drop view if exists `v_apq_get_indexbyarea`;
create view `v_apq_get_indexbyarea`
as
	select
		  `rt`.`idruntime`
		, `rt`.`to`																									as `time`
		, `av`.`area`

		, `av`.`totaltime`
		
		, `av`.`plannedproductiontime`				-- Workable time
		, `av`.`plannedproductiontime` / `av`.`totaltime`															as `ppt_porc`

		, `av`.`plannedstop`						-- Breaks
		, `av`.`plannedstop` / `av`.`totaltime`																		as `plannedstop_porc`

		, `av`.`scheduleloss`						-- Off time
		, `av`.`scheduleloss` / `av`.`totaltime`																	as `scheduleloss_porc`

		, (`av`.`plannedproductiontime` - `ct`.`stdsetuptime` - `ct`.`stdstarttime`)								as `productiontime`
		, (`av`.`plannedproductiontime` - `ct`.`stdsetuptime` - `ct`.`stdstarttime`) / `av`.`plannedproductiontime`	as `productiontime_porc`

		, `ct`.`stdsetuptime`
		, `ct`.`stdsetuptime` / `av`.`plannedproductiontime`														as `stdsetuptime_porc`
		, `ct`.`stdstarttime`
		, `ct`.`stdstarttime` / `av`.`plannedproductiontime`														as `stdstarttime_porc`

		, (`av`.`plannedproductiontime` - `ct`.`stdsetuptime` - `ct`.`stdstarttime` - `av`.`stoptime`)				as `runtime`
		, (`av`.`plannedproductiontime` - `ct`.`stdsetuptime` - `ct`.`stdstarttime` - `av`.`stoptime`) 
		/ (`av`.`plannedproductiontime` - `ct`.`stdsetuptime` - `ct`.`stdstarttime`)								as `runtime_porc`

		, `av`.`stoptime`							-- Equipment stop time
		, `av`.`stoptime` / (`av`.`plannedproductiontime` - `ct`.`stdsetuptime` - `ct`.`stdstarttime`)				as `stoptime_porc`

		, `ct`.`totalcount`
		, `ct`.`goodcount`
		, `ct`.`badcount`

		, `ct`.`producedtime`
		, `ct`.`goodtime`
		, `ct`.`losstime`
		, `ct`.`losstime` / `ct`.`goodtime`																			as `losstime_porc`

		, `ct`.`actualprodtime`

		, `ct`.`actualprodtime` - `ct`.`producedtime`																as `performanceloss`
		, (`ct`.`actualprodtime` - `ct`.`producedtime`) / `ct`.`actualprodtime`										as `performanceloss_porc`


		, ((`av`.`plannedproductiontime` - `ct`.`stdsetuptime` - `ct`.`stdstarttime` - `av`.`stoptime`) * 100.0)
		/ (`av`.`plannedproductiontime` - `ct`.`stdsetuptime` - `ct`.`stdstarttime`)								as `ia`

		, ((`av`.`plannedproductiontime` - `ct`.`stdsetuptime` - `ct`.`stdstarttime` - `av`.`stoptime`))
		/ (`av`.`plannedproductiontime` - `ct`.`stdsetuptime` - `ct`.`stdstarttime`)								as `ia_porc`

--		, (`ct`.`producedtime` * 100.0) 
--		/ (`av`.`plannedproductiontime` - `ct`.`stdsetuptime` - `ct`.`stdstarttime` - `av`.`stoptime`)				as `ip`
--		, `ct`.`producedtime`
--		/ (`av`.`plannedproductiontime` - `ct`.`stdsetuptime` - `ct`.`stdstarttime` - `av`.`stoptime`)				as `ip_porc`

		, `ct`.`producedtime` * 100.0 / `ct`.`actualprodtime`														as `ip`
		, `ct`.`producedtime` / `ct`.`actualprodtime`																as `ip_porc`

		, (`ct`.`goodtime` * 100.0) / `ct`.`producedtime`															as `iq`
		, `ct`.`goodtime` / `ct`.`producedtime`																		as `iq_porc`

		, ((`av`.`plannedproductiontime` - `ct`.`stdsetuptime` - `ct`.`stdstarttime` - `av`.`stoptime`)
		/ (`av`.`plannedproductiontime` - `ct`.`stdsetuptime` - `ct`.`stdstarttime`))
		* (`ct`.`producedtime`
		/ (`av`.`plannedproductiontime` - `ct`.`stdsetuptime` - `ct`.`stdstarttime` - `av`.`stoptime`))
		* (`ct`.`goodtime` / `ct`.`producedtime`)
		* 100.0																										as `index`

		, ((`av`.`plannedproductiontime` - `ct`.`stdsetuptime` - `ct`.`stdstarttime` - `av`.`stoptime`)
		/ (`av`.`plannedproductiontime` - `ct`.`stdsetuptime` - `ct`.`stdstarttime`))
		* (`ct`.`producedtime`
		/ (`av`.`plannedproductiontime` - `ct`.`stdsetuptime` - `ct`.`stdstarttime` - `av`.`stoptime`))
		* (`ct`.`goodtime` / `ct`.`producedtime`)																	as `index_porc`

		, ((`av`.`plannedproductiontime` - `ct`.`stdsetuptime` - `ct`.`stdstarttime` - `av`.`stoptime`)
		/ (`av`.`plannedproductiontime` - `ct`.`stdsetuptime` - `ct`.`stdstarttime`))
		* (`ct`.`producedtime`
		/ (`av`.`plannedproductiontime` - `ct`.`stdsetuptime` - `ct`.`stdstarttime` - `av`.`stoptime`))
		* (`ct`.`goodtime` / `ct`.`producedtime`)
		* `av`.`totaltime`																							as `indextime`

	from
		`apq_runtime` `rt`
		inner join `v_apq_get_availabilitybyarea` `av` on
			`av`.`idruntime` = `rt`.`idruntime`
		inner join `v_apq_get_countsbyarea` `ct` on
				`ct`.`idruntime`	= `av`.`idruntime`
            and `ct`.`area`			= `av`.`area`;

