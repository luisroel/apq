drop procedure if exists `spapq_create_stopsbyarea`;
delimiter $$
create procedure `spapq_create_stopsbyarea`(
	  idruntime	bigint
)
begin
	if exists(select * from `apq_stopsbyarea` `st` where `st`.`idruntime` = idruntime) then
		delete from `apq_stopsbyarea` where `idruntime` = idruntime;
	end if;

	insert into `apq_stopsbyarea`
	select
	 	  idruntime
		, `eq`.`area`
		, `ss`.`clasification`
		, sum(`ss`.`time`)
	from
		`apq_stops` `ss`
		inner join `apq_equipment` `eq` on
			`eq`.`idequipment` = `ss`.`idequipment`
	where
		`ss`.`idruntime` = idruntime
	group by
		  `eq`.`area`
		, `ss`.`clasification`;
end;
$$
delimiter $$
