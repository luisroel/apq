drop procedure if exists `spapq_create_equipmentbyarea`;
delimiter $$
create procedure `spapq_create_equipmentbyarea`(
	  idruntime	bigint
)
begin
	if exists(select * from `apq_equipmentbyarea` `eq` where `eq`.`idruntime` = idruntime) then
		delete from `apq_equipmentbyarea` where `idruntime` = idruntime;
	end if;

	insert into `apq_equipmentbyarea`
	select
		  idruntime
		, `eq`.`area`
		, `eq`.`power`
		, count(*)
	from
		`apq_equipment` `eq`
	where
		`eq`.`idruntime` = idruntime
	group by
		  `eq`.`area`
		, `eq`.`power`;
end;
$$
delimiter ;
