
drop procedure if exists `spapq_create_availabilitysummary`;
delimiter $$
create procedure `spapq_create_availabilitysummary`(
	idruntime	bigint
)
begin
	if exists(select * from `apq_availabilitysummary` `as` where `as`.`idruntime` = idruntime) then
		delete from `apq_availabilitysummary` where `idruntime` = idruntime;
	end if;

	select
			count(*)
        into
			@numequipment
	from
		`apq_equipment` `eq`
	where
		`eq`.`idruntime` = idruntime;

	insert into `apq_availabilitysummary`
	select
		  `av`.`idruntime`
		, sum(`av`.`working`) * @numequipment
		, sum(`av`.`off`)  * @numequipment
		, sum(`av`.`break`) * @numequipment
	from
		`apq_availability` `av`
	where
		`av`.`idruntime` = idruntime
	group by
		`av`.`idruntime`;
end;
$$
delimiter ;
