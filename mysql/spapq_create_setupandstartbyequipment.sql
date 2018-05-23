drop procedure if exists `spapq_create_setupandstartbyequipment`;
delimiter $$
create procedure `spapq_create_setupandstartbyequipment`(
	idruntime	bigint
)
begin
	if exists(select * from `apq_setupandstartbyequipment` `st` where `st`.`idruntime` = idruntime) then
		delete from `apq_setupandstartbyequipment` where `idruntime` = idruntime;
	end if;

	insert into `apq_setupandstartbyequipment`
	select
		  idruntime
		, `eq`.`area`
		, `eq`.`line`
		, `eq`.`idequipment`
		, sum(`ss`.`actsetuptime`)
		, sum(`ss`.`actstarttime`)
		, sum(`ss`.`stdsetuptime`)
		, sum(`ss`.`stdstarttime`)
	from
		`apq_setupandstart` `ss`
		inner join `apq_equipment` `eq` on
			`eq`.`idequipment` = `ss`.`idequipment`
	where
		`ss`.`idruntime` = idruntime
	group by
		  `eq`.`area`
		, `eq`.`line`
		, `eq`.`idequipment`;
end;
$$
delimiter ;
