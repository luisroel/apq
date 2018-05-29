drop procedure if exists `spapq_create_setupandstartsummary`;
delimiter $$
create procedure `spapq_create_setupandstartsummary`(
	idruntime	bigint
)
begin
	if exists(select * from `apq_setupandstartsummary` `st` where `st`.`idruntime` = idruntime) then
		delete from `apq_setupandstartsummary` where `idruntime` = idruntime;
	end if;
/*
	insert into `apq_setupandstartsummary`
	select
	 	  idruntime
		, sum(CASE WHEN `ss`.`actsetuptime` > 180 OR `ss`.`actsetuptime` = 0 THEN 90 ELSE `ss`.`actsetuptime` END)
		, sum(CASE WHEN `ss`.`actstarttime` > 180 OR `ss`.`actstarttime` = 0 THEN 30 ELSE `ss`.`actstarttime` END)
		, sum(CASE WHEN `ss`.`stdsetuptime` > 180 OR `ss`.`stdsetuptime` = 0 THEN 90 ELSE `ss`.`stdsetuptime` END)
		, sum(CASE WHEN `ss`.`stdstarttime` > 180 OR `ss`.`stdstarttime` = 0 THEN 30 ELSE `ss`.`stdstarttime` END)
	from
		`apq_setupandstart` `ss`
	where
		`ss`.`idruntime` = idruntime;
*/
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
