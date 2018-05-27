drop procedure if exists `spapq_create_equipmentbyline`;
delimiter $$
create procedure `spapq_create_equipmentbyline`(
	idruntime	bigint
)
begin
	if exists(select * from `apq_equipmentbyline` `eq` where `eq`.`idruntime` = idruntime) then
		delete from `apq_equipmentbyline` where `idruntime` = idruntime;
	end if;

	insert into `apq_equipmentbyline`
	select
		  idruntime
		, `eq`.`area`
		, `eq`.`line`
		, `eq`.`power`
		, count(*)
	from
		`apq_equipment` `eq`
	where
		`eq`.`idruntime` = idruntime
	group by
		  `eq`.`area`
		, `eq`.`line`
		, `eq`.`power`;
end;
$$
delimiter $$

