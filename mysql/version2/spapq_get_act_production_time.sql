drop procedure if exists `spapq_get_act_production_time`;
delimiter $$
create procedure `spapq_get_act_production_time`(
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
			, sum(`ss`.`actsetuptime`) 			as `time_min`
			, sum(`ss`.`actsetuptime`) / 60.0	as `time_hrs`
		from
			`apq_setupandstart` `ss`
		group by
			`ss`.`idruntime`
		union all
		select
			 `ss`.`idruntime`
			, '2. Std Start Time'
            , 'spAPQ_Rpt_SetupAndStarts'
			, sum(`ss`.`actstarttime`)
			, sum(`ss`.`actstarttime`) / 60.0
		from
			`apq_setupandstart` `ss`
		group by
			`ss`.`idruntime`
		union all
		select
			 `ss`.`idruntime`
			, '3. Actual Run Time'
            , 'spAPQ_Rpt_ProdTimes'
			, sum(`ss`.`time`)
			, sum(`ss`.`time`) / 60.0
		from
			`apq_prodtimes` `ss`
		group by
			`ss`.`idruntime`
		union all
		select
			  `ss`.`idruntime`
			, '4. Stop Time'
            , 'spAPQ_Rpt_Stops'
			, -1.0*sum(`ss`.`time`)
			, -1.0*sum(`ss`.`time`) / 60.0
		from
			`apq_stops` `ss`
		group by
			`ss`.`idruntime`
		union all
		select
			  `tt`.`idruntime`
			, '5. Total'
            , ''
			, SUM(`tt`.`time_min`)
			, SUM(`tt`.`time_hrs`)
		from (
			select
				 `ss`.`idruntime`
				, '1. Std Setup Time'				as `description`
				, sum(`ss`.`actsetuptime`) 			as `time_min`
				, sum(`ss`.`actsetuptime`) / 60.0	as `time_hrs`
			from
				`apq_setupandstart` `ss`
			group by
				`ss`.`idruntime`
			union all
			select
				 `ss`.`idruntime`
				, '2. Std Start Time'
				, sum(`ss`.`actstarttime`)
				, sum(`ss`.`actstarttime`) / 60.0
			from
				`apq_setupandstart` `ss`
			group by
				`ss`.`idruntime`
			union all
			select
				 `ss`.`idruntime`
				, '3. Ideal Prod. Time'
				, sum(`ss`.`time`)
				, sum(`ss`.`time`) / 60.0
			from
				`apq_prodtimes` `ss`
			group by
				`ss`.`idruntime`
			union all
			select
				  `ss`.`idruntime`
				, '4. Stop Time'
				, -1.0 * sum(`ss`.`time`)
				, -1.0 * sum(`ss`.`time`) / 60.0
			from
				`apq_stops` `ss`
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


