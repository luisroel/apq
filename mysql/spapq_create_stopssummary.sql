drop procedure if exists `spapq_create_stopssummary`;
delimiter $$
create procedure `spapq_create_stopssummary`(
	idruntime	bigint
)
begin
	if exists(select * from `apq_stopssummary` `st` where `st`.`idruntime` = idruntime) then
		delete from `apq_stopssummary` where `idruntime` = idruntime;
	end if;

	insert into `apq_stopssummary`
	select
	 	  idruntime
		, `ss`.`clasification`
		, sum(`ss`.`time`)
	from
		`apq_stops` `ss`
	where
		`ss`.`idruntime` = idruntime
	group by
		`ss`.`clasification`;
end;
$$
delimiter ;

