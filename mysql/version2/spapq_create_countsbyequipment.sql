drop procedure if exists `spapq_create_countsbyequipment`;
delimiter $$
create procedure `spapq_create_countsbyequipment`(
	idruntime bigint
)
begin
	if exists(select * from `apq_countsbyequipment` `st` WHERE `st`.`idruntime` = idruntime) then
		delete from `apq_countsbyequipment` where `idruntime` = idruntime;
	end if;

	insert into `apq_countsbyequipment`
	select
	 	  idruntime
		, `eq`.`area`
		, `eq`.`line`
		, `eq`.`idequipment`
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
		  `eq`.`area`
		, `eq`.`line`
		, `eq`.`idequipment`;
END;
$$
delimiter ;
