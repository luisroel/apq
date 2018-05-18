drop view if exists `v_apq_get_index`;
create view `v_apq_get_index`
as
	select
		  `rt`.`idruntime`
		, `rt`.`to`																									AS `time`

		, `av`.`totaltime`
		
		, `av`.`plannedproductiontime`				-- Workable time
		, `av`.`plannedproductiontime` / `av`.`totaltime`															AS `ppt_porc`

		, `av`.`plannedstop`						-- Breaks
		, `av`.`plannedstop` / `av`.`totaltime`																		AS `plannedstop_porc`

		, `av`.`scheduleloss`						-- Off time
		, `av`.`scheduleloss` / `av`.`totaltime`																	AS `scheduleloss_porc`

		, (`av`.`plannedproductiontime` - `ct`.`stdsetuptime` - `ct`.`stdstarttime`)								AS `productiontime`
		, (`av`.`plannedproductiontime` - `ct`.`stdsetuptime` - `ct`.`stdstarttime`) / `av`.`plannedproductiontime`	AS `productiontime_porc`

		, `ct`.`stdsetuptime`
		, `ct`.`stdsetuptime` / `av`.`plannedproductiontime`														AS `stdsetuptime_porc`
		, `ct`.`stdstarttime`
		, `ct`.`stdstarttime` / `av`.`plannedproductiontime`														AS `stdstarttime_porc`

		, (`av`.`plannedproductiontime` - `ct`.`stdsetuptime` - `ct`.`stdstarttime` - `av`.`stoptime`)				AS `runtime`
		, (`av`.`plannedproductiontime` - `ct`.`stdsetuptime` - `ct`.`stdstarttime` - `av`.`stoptime`) 
		/ (`av`.`plannedproductiontime` - `ct`.`stdsetuptime` - `ct`.`stdstarttime`)								AS `runtime_porc`

		, `av`.`stoptime`	-- equipment stop time
		, `av`.`stoptime` / (`av`.`plannedproductiontime` - `ct`.`stdsetuptime` - `ct`.`stdstarttime`)				AS `stoptime_porc`

		, `ct`.`totalcount`
		, `ct`.`goodcount`
		, `ct`.`badcount`

		, `ct`.`producedtime`
		, `ct`.`goodtime`
		, `ct`.`losstime`
		, `ct`.`losstime` / `ct`.`goodtime`																			AS `losstime_porc`

		, `ct`.`actualprodtime`

		, `ct`.`actualprodtime` - `ct`.`producedtime`																AS `performanceloss`
		, (`ct`.`actualprodtime` - `ct`.`producedtime`) / `ct`.`actualprodtime`										AS `performanceloss_porc`


		, ((`av`.`plannedproductiontime` - `ct`.`stdsetuptime` - `ct`.`stdstarttime` - `av`.`stoptime`) * 100.0)
		/ (`av`.`plannedproductiontime` - `ct`.`stdsetuptime` - `ct`.`stdstarttime`)								AS `ia`

		, ((`av`.`plannedproductiontime` - `ct`.`stdsetuptime` - `ct`.`stdstarttime` - `av`.`stoptime`))
		/ (`av`.`plannedproductiontime` - `ct`.`stdsetuptime` - `ct`.`stdstarttime`)								AS `ia_porc`

--		, (`ct`.`producedtime` * 100.0) 
--		/ (`av`.`plannedproductiontime` - `ct`.`stdsetuptime` - `ct`.`stdstarttime` - `av`.`stoptime`)				AS `ip`
--		, `ct`.`producedtime`
--		/ (`av`.`plannedproductiontime` - `ct`.`stdsetuptime` - `ct`.`stdstarttime` - `av`.`stoptime`)				AS `ip_porc`

		, `ct`.`producedtime` * 100.0 / `ct`.`actualprodtime`														AS `ip`
		, `ct`.`producedtime` / `ct`.`actualprodtime`																AS `ip_porc`

		, (`ct`.`goodtime` * 100.0) / `ct`.`producedtime`															AS `iq`
		, `ct`.`goodtime` / `ct`.`producedtime`																		AS `iq_porc`

		, ((`av`.`plannedproductiontime` - `ct`.`stdsetuptime` - `ct`.`stdstarttime` - `av`.`stoptime`)
		/ (`av`.`plannedproductiontime` - `ct`.`stdsetuptime` - `ct`.`stdstarttime`))
		* (`ct`.`producedtime`
		/ (`av`.`plannedproductiontime` - `ct`.`stdsetuptime` - `ct`.`stdstarttime` - `av`.`stoptime`))
		* (`ct`.`goodtime` / `ct`.`producedtime`)
		* 100.0																										AS `index`

		, ((`av`.`plannedproductiontime` - `ct`.`stdsetuptime` - `ct`.`stdstarttime` - `av`.`stoptime`)
		/ (`av`.`plannedproductiontime` - `ct`.`stdsetuptime` - `ct`.`stdstarttime`))
		* (`ct`.`producedtime`
		/ (`av`.`plannedproductiontime` - `ct`.`stdsetuptime` - `ct`.`stdstarttime` - `av`.`stoptime`))
		* (`ct`.`goodtime` / `ct`.`producedtime`)																	AS `index_porc`

		, ((`av`.`plannedproductiontime` - `ct`.`stdsetuptime` - `ct`.`stdstarttime` - `av`.`stoptime`)
		/ (`av`.`plannedproductiontime` - `ct`.`stdsetuptime` - `ct`.`stdstarttime`))
		* (`ct`.`producedtime`
		/ (`av`.`plannedproductiontime` - `ct`.`stdsetuptime` - `ct`.`stdstarttime` - `av`.`stoptime`))
		* (`ct`.`goodtime` / `ct`.`producedtime`)
		* `av`.`totaltime`																							AS `indextime`

	from
		`apq_runtime` `rt`
		inner join `v_apq_get_availability` `av` on
			`av`.`idruntime` = `rt`.`idruntime`
		inner join`v_apq_get_counts` `ct` on
			`ct`.`idruntime` = `rt`.`idruntime`;
