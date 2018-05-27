
drop procedure if exists `spapq_create_equipmentsummary`;
delimiter $$
create procedure `spapq_create_equipmentsummary`(
	  idruntime	bigint
)
begin
	if exists(select * from `apq_equipmentsummary` `eq` where `eq`.`idruntime` = idruntime) then
		delete from `apq_equipmentsummary` where `idruntime` = idruntime;
	end if;

	insert into `apq_equipmentsummary`
	select
		  idruntime
		, `eq`.`power`
		, count(*)
	from
		`apq_equipment` `eq`
	where
		`eq`.`idruntime` = idruntime
	group by
		`eq`.`power`;
end;
$$
delimiter ;

