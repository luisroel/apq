drop procedure if exists `spapq_create_setupandstartsummary`;
delimiter $$
create procedure `spapq_create_setupandstartsummary`(
	idruntime	bigint
)
begin
	if exists(select * from `apq_setupandstartsummary` `st` where `st`.`idruntime` = idruntime) then
		delete from `apq_setupandstartsummary` where `idruntime` = idruntime;
	end if;
    
	insert into `apq_setupandstartsummary`
	select
	 	  idruntime
		, sum(`ss`.`actsetuptime`)
		, sum(`ss`.`actstarttime`)
		, sum(`ss`.`stdsetuptime`)
		, sum(`ss`.`stdstarttime`)
	from
		`apq_setupandstart` `ss`
	where
		`ss`.`idruntime` = idruntime;
end;
$$
delimiter ;
