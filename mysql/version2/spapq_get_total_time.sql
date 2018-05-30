drop procedure if exists `spapq_get_total_time`;
delimiter $$
create procedure `spapq_get_total_time`(
	idruntime	bigint
)
begin

	select
		  `tt`.*
		, `tt`.`hours` * `tt`.`no_equipment`			as `total`
	from (
		select
			  `av`.`idruntime`
			, 'Time for Production'						as `description`
            , 'spAPQ_Rpt_Schedule'						as `report_name`
			, sum(`av`.`working`)						as `hours`
			, (select count(*) from `apq_equipment`)	as `no_equipment`
		from
			`apq_availability` `av`
		group by
			`av`.`idruntime`
		union all
		select
			  `av`.`idruntime`
			, 'Planned Stops'
            , 'spAPQ_Rpt_Schedule'
			, sum(`av`.`break`)
			, (select count(*) from `apq_equipment`)
		from
			`apq_availability` `av`
		group by
			`av`.`idruntime`
		union all
		select
			  `av`.`idruntime`
			, 'Plant shutdown'
            , 'spAPQ_Rpt_Schedule'
			, sum(`av`.`off`)
			, (select count(*) from `apq_equipment`)
		from
			`apq_availability` `av`
		group by
			`av`.`idruntime`
	) `tt`
    where
		`tt`.`idruntime` = idruntime;
end;
$$
delimiter ;


