drop procedure if exists `spapq_create_stopsbyline`;
delimiter $$
create procedure `spapq_create_stopsbyline`(
	  idruntime	bigint
)
begin
	if exists(select * from `apq_stopsbyline` `st` where `st`.`idruntime` = idruntime) then
		delete from `apq_stopsbyline` where `idruntime` = idruntime;
	end if;

	insert into `apq_stopsbyline`
	select
	 	  idruntime
		, `eq`.`area`
		, `eq`.`line`
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
		, `eq`.`line`
		, `ss`.`clasification`;
end;
$$
delimiter ;
