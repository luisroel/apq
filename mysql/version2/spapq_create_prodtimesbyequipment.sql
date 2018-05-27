drop procedure if exists `spapq_create_prodtimesbyequipment`;
delimiter $$
create procedure `spapq_create_prodtimesbyequipment`(
	idruntime	bigint
)
begin
	if exists(select * from `apq_prodtimesbyequipment` `st` where `st`.`idruntime` = idruntime) then
		delete from `apq_prodtimesbyequipment` where `idruntime` = idruntime;
	end if;

	insert into `apq_prodtimesbyequipment`
	select
	 	  `ct`.`idruntime`
		, `eq`.`area`
		, `eq`.`line`
		, `eq`.`idequipment`
		, sum(`ct`.`time`)
	from
		`apq_prodtimes` `ct`
		left join `apq_equipment` `eq` on
			`eq`.`idequipment` = `ct`.`idequipment`
	where
		`ct`.`idruntime` = idruntime
	group by
		  `ct`.`idruntime`
		, `eq`.`area`
		, `eq`.`line`
		, `eq`.`idequipment`;
end;
$$
delimiter ;
