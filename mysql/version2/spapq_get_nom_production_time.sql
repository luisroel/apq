drop procedure if exists `spapq_get_nom_production_time`;
delimiter $$
create procedure `spapq_get_nom_production_time`(
	idruntime	bigint
)
begin
	select
		*
	from (
		select
			 `ss`.`idruntime`
			, '1. Std Setup Time'				as `description`
            , 'spAPQ_Rpt_SetupAndStarts'		as `report_name`
			, sum(`ss`.`stdsetuptime`) 			as `time_min`
			, sum(`ss`.`stdsetuptime`) / 60.0	as `time_hrs`
		from
			`apq_setupandstart` `ss`
		group by
			`ss`.`idruntime`
		union all
		select
			 `ss`.`idruntime`
			, '2. Std Start Time'
            , 'spAPQ_Rpt_SetupAndStarts'	-- as `report_name`
			, sum(`ss`.`stdstarttime`)
			, sum(`ss`.`stdstarttime`) / 60.0
		from
			`apq_setupandstart` `ss`
		group by
			`ss`.`idruntime`
		union all
		select
			 `ss`.`idruntime`
			, '3. Ideal Prod. Time'
            , 'spAPQ_Rpt_ProdTimes'	-- as `report_name`
			, sum(`ss`.`totaltime`)
			, sum(`ss`.`totaltime`) / 60.0
		from
			`apq_counts` `ss`
		group by
			`ss`.`idruntime`
		union all
		select
			  `tt`.`idruntime`
			, '4. Total'
			, 'AQP_Global'	-- as `report_name`
			, SUM(`tt`.`time_min`)
			, SUM(`tt`.`time_hrs`)
		from (
			select
				 `ss`.`idruntime`
				, '1. Std Setup Time'					as `description`
				, sum(`ss`.`stdsetuptime`) 			as `time_min`
				, sum(`ss`.`stdsetuptime`) / 60.0	as `time_hrs`
			from
				`apq_setupandstart` `ss`
			group by
				`ss`.`idruntime`
			union all
			select
				 `ss`.`idruntime`
				, '2. Std Start Time'
				, sum(`ss`.`stdstarttime`)
				, sum(`ss`.`stdstarttime`) / 60.0
			from
				`apq_setupandstart` `ss`
			group by
				`ss`.`idruntime`
			union all
			select
				 `ss`.`idruntime`
				, '3. Ideal Prod. Time'
				, sum(`ss`.`totaltime`)
				, sum(`ss`.`totaltime`) / 60.0
			from
				`apq_counts` `ss`
			group by
				`ss`.`idruntime`
		) `tt`
		group by
			`tt`.`idruntime`
	) `ss`
    where
		`ss`.`idruntime` = idruntime
	order by
		`ss`.`description`;
end;
$$
delimiter ;


