drop procedure if exists `spapq_create_countsbyarea`;
delimiter $$
create procedure `spapq_create_countsbyarea`(
	  idruntime	bigint
)
begin
	if exists(select * from `apq_countsbyarea` `st` where `st`.`idruntime` = idruntime) then
		delete from `apq_countsbyarea` where `idruntime` = idruntime;
	end if;

	insert into `apq_countsbyarea`
	select
	 	  idruntime
		, `eq`.`area`
		, sum(`ct`.`goodcount`)
		, sum(`ct`.`badcount`)
		, sum(`ct`.`totalcount`)
		, sum(`ct`.`goodtime`)
		, sum(`ct`.`losstime`)
		, sum(`ct`.`totaltime`)
	from
		`apq_counts` `ct`
		inner join `apq_equipment` `eq` on
			`eq`.`idequipment` = `ct`.`idequipment`
	where
		`ct`.`idruntime` = idruntime
	group by
		`eq`.`area`;
end;
$$
delimiter ;
