drop procedure if exists `spapq_create_setupandstartbyline`;
delimiter $$
create procedure `spapq_create_setupandstartbyline`(
	idruntime	bigint
)
begin
	if exists(select * from `apq_setupandstartbyline` `st` where `st`.`idruntime` = idruntime) then
		delete from `apq_setupandstartbyline` where `idruntime` = idruntime;
	end if;

	insert into `apq_setupandstartbyline`
	select
		  `ss`.`idruntime`
		, `eq`.`area`
		, `eq`.`line`
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
		  `ss`.`idruntime`
		, `eq`.`area`
		, `eq`.`line`;

end;
$$
delimiter ;
