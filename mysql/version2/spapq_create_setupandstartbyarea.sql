drop procedure if exists `spapq_create_setupandstartbyarea`;
delimiter $$
create procedure `spapq_create_setupandstartbyarea`(
	idruntime	bigint
)
begin
	if exists(select * from `apq_setupandstartbyarea` `st` where `st`.`idruntime` = idruntime) then
		delete from `apq_setupandstartbyarea` where `idruntime` = idruntime;
	end if;

	insert into `apq_setupandstartbyarea`
	select
		  idruntime
		, `eq`.`area`
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
		`eq`.`area`;
end;
$$
delimiter ;
