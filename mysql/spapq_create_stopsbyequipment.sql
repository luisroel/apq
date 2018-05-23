drop procedure if exists `spapq_create_stopsbyequipment`;
delimiter $$
create procedure `spapq_create_stopsbyequipment`(
	idruntime bigint
)
begin
	if exists(select * from `apq_stopsbyequipment` `st` where `st`.`idruntime` = idruntime) then
		delete from `apq_stopsbyequipment` where `idruntime` = idruntime;
	end if;
    
	insert into `apq_stopsbyequipment`
	select
	 	  idruntime
		, `eq`.`area`
		, `eq`.`line`
		, `eq`.`idequipment`
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
		, `eq`.`idequipment`
		, `ss`.`clasification`;
end;
$$
delimiter ;
